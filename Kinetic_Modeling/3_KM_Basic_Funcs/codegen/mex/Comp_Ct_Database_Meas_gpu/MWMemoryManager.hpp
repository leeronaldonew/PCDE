// Copyright 2021 The MathWorks, Inc.

#ifndef MW_MEMORY_MANAGER_HPP
#define MW_MEMORY_MANAGER_HPP

#include "cuda_runtime.h"

#include <list>
#include <set>
#include <unordered_map>
#include <vector>
#include <array>
#include <ostream>

namespace gcmemory {

class MemoryPool;
class MemoryManager;

enum MallocMode {
    DISCRETE,
    UNIFIED
};

enum ActionType {
    ALLOCATE,
    DEALLOCATE
};

struct Action {
    /**
     * The type of action being performed (allocate or deallocate).
     */
    ActionType type;

    /**
     * The variable this action corresponds to. This is an integer used to
     * uniquely identify different addresses.
     */
    int var;

    /**
     * The size of the allocation. For deallocations this value is 0.
     */
    size_t size;

    /**
     * The malloc mode used during the action.
     */
    MallocMode mode;
};

class Allocator {
  public:
    virtual ~Allocator(){}

    /**
     * Directly allocates linear memory.
     * @param devPtr Pointer to allocated memory.
     * @param size Requested allocation size in bytes.
     * @param mode The kind of GPU memory to allocate.
     */
    virtual cudaError_t rawMalloc(void** devPtr, size_t size, MallocMode mode) = 0;
    
    /**
     * Deallocates the memory pointed to by devPtr.
     */
    virtual cudaError_t rawFree(void* devPtr) = 0;
    
    /**
     * Populates freeMemory and totalMemory with the available memory and total memory
     * of the system, respectively. Both measurements are in bytes.
     */
    virtual cudaError_t getMemInfo(size_t& freeMemory, size_t& totalMemory) const = 0;
    
    /**
     * Returns the memory block size required to contain memory of the given size.
     * @param size The size in bytes of the memory that must be contained.
     * @return A value greater than or equal to size.
     */
    virtual size_t calculateBlockSize(size_t size) const;
    
    /**
     * Returns the memory pool size required to contain memory of the given size.
     * @param size The size in bytes of the memory that must be contained.
     * @return A value greater than or equal to size.
     */
    virtual size_t calculatePoolSize(size_t size, MallocMode mode) const;

    virtual void update(size_t lastPoolSize, MallocMode lastMode);
    
  protected:
    static const size_t MEGA_BYTE;
    static const std::array<size_t, 5> SIZE_LEVELS;

    size_t roundUpPoolSizeWithLevel(size_t size, MallocMode mode) const;

  private:
    size_t fDiscreteSizeLevelIndex = 0;
    size_t fUnifiedSizeLevelIndex = 0;
};

class CudaAllocator : public Allocator {
  public:
    cudaError_t rawMalloc(void** devPtr, size_t size, MallocMode mode);
    cudaError_t rawFree(void* devPtr);
    cudaError_t getMemInfo(size_t& freeMemory, size_t& totalMemory) const;
};

class ActionLogger {
  public:
    static const std::string ALLOCATE_STRING;
    static const std::string DEALLOCATE_STRING;
    static const std::string DISCRETE_STRING;
    static const std::string UNIFIED_STRING;
    static const std::string NA_STRING;
    static const char DELIMITER;

    ActionLogger(const std::string& fileName);

    void logPreAllocate(size_t size, MallocMode mode);
    void logPostAllocate(void* devPtr);
    void logDeallocate(void* devPtr);
    
  private:
    static const std::string& getMallocModeString(MallocMode mode);

    void writeFileHeader();
    void logAction(Action action);
    
    const std::string fLogFileName;
    std::unordered_map<void*, int> fLogVarMap;
    int fCurrentLogVar = 0;
    bool fHeaderWritten = false;
    bool fIsAllocating = false;
};

class MemoryBlock {
  public:
    class PointerCompare {
      public:
        bool operator()(const MemoryBlock* lhs, const MemoryBlock* rhs) const;
    };

    enum ResizeMode {
        /**
         * The data start pointer will be adjusted
         */
        SHIFT_START,
        /**
         * The size will be modified, leaving the data start pointer
         */
        SHIFT_END
    };

    MemoryBlock(MemoryPool* pool, void* data, size_t size, bool loggingEnabled = false);

    bool operator<(const MemoryBlock& rhs) const;

    // Getters
    void* data() const;
    size_t size() const;
    MemoryPool* pool() const;
    bool isAllocated() const;
    MemoryBlock* prev() const;
    MemoryBlock* next() const;

    // Setters
    void setAllocated(bool allocated);

    /**
     * Splits this block into two.
     * Creates a new block with the specified size. Shrinks this block to
     * accomidate the new block. The new block may be inserted before or
     * after this block, depending on the specified size.
     * @return The newly created block.
     */
    MemoryBlock* split(size_t size);

    /**
     * Merges this block with the block before it.
     * This block will be resized to occupy the space taken up by both this
     * block and the block before it. This block will take the previous block's
     * place in order. The previous block will not be changed.
     */
    void mergeWithPrev();

    /**
     * Merges this block with the block after it.
     * This block will be resized to occupy the space taken up by both this
     * block and the block after it. This bloc will take the next block's 
     * place in order. The next block will not be changed.
     */
    void mergeWithNext();

  protected:
    /**
     * Inserts this block before the specfied block. 
     */
    void insertBefore(MemoryBlock* block);

    /**
     * Inserts this block after the specfied block. 
     */
    void insertAfter(MemoryBlock* block);

    /**
     * Resizes this block by either setting the block size or shifting the data pointer.
     */
    void resize(size_t size, ResizeMode mode);
    
  private:
    MemoryPool* const fPool;
    void* fData;
    size_t fSize;
    const bool fLoggingEnabled;
    bool fAllocated = false;
    MemoryBlock* fPrev = NULL;
    MemoryBlock* fNext = NULL;
};

class MemoryPool {
  public:
    typedef std::set<MemoryBlock*, MemoryBlock::PointerCompare> MemoryBlockSet;
    typedef MemoryBlockSet::iterator MemoryBlockIter;
    
    MemoryPool(void* data, size_t size, Allocator& allocator, bool loggingEnabled = false);
    ~MemoryPool();
    
    size_t getLargestFreeBlockSize() const;

    /**
     * Returns true if any block in the pool is allocated.
     */
    bool hasAllocatedBlocks() const;

    /**
     * Alocates a block of at least size bytes.
     */
    MemoryBlock* allocateBlock(size_t size);

    /**
     * Deallocates the specified block and merges it with
     * unallocated adjacent blocks.
     */
    void deallocateBlock(MemoryBlock* block);
    
    bool mustSplitBlock(const MemoryBlock* block, size_t size);
    
    /**
     * Returns the first block in the pool. The first block may change.
     */
    MemoryBlock* firstBlock() const;

    // Getters
    void* data() const;
    size_t size() const;

  protected:
    /**
     *
     */
    void mergeBlock(MemoryBlock* memoryBlock);
    
  private:
    void* const fData;
    const size_t fSize;
    Allocator& fAllocator;
    const bool fLoggingEnabled;
    MemoryBlockSet fFreeBlocks;
    MemoryBlock* fFirstBlock;
};

class MemoryManager {
  public:
    typedef std::unordered_map<void*, MemoryBlock*> BlockMap;
    typedef std::list<MemoryPool*> PoolList;
    
    MemoryManager(Allocator& allocator, bool loggingEnabled);
    ~MemoryManager();
    
    // Logging methods
    void printMemoryMap();
    void printMemoryPools(std::ostream& os, const PoolList& pools);
    void printMemoryPoolBlocks(std::ostream& os, const MemoryPool* memoryPool);

    template<typename T>
    cudaError_t allocate(T** devPtr, size_t size, MallocMode mode) {
        return allocateImpl(static_cast<void**>(static_cast<void*>(devPtr)), size, mode);
    }
    template<typename T>
    cudaError_t deallocate(T* devPtr) {
        return deallocateImpl(static_cast<void*>(devPtr));
    }
    
  protected:
    cudaError_t allocateImpl(void** devPtr, const size_t size, const MallocMode mode);
    cudaError_t deallocateImpl(void* devPtr);
    
    void deletePools();
    void freeEmptyPools();
    MemoryPool* getFirstSuitableMemoryPool(size_t size, MallocMode mode) const;

    cudaError_t allocatePool(size_t size, MallocMode mode, MemoryPool*& pool);

    // Getters
    const BlockMap& dataBlockMap() const;
    const PoolList& discretePools() const;
    const PoolList& unifiedPools() const;

  private:
    static const char* LOG_FILE_NAME;
    
    BlockMap fDataBlockMap;
    PoolList fDiscretePools;
    PoolList fUnifiedPools;
    Allocator& fAllocator;

    // Logging fields
    const bool fLoggingEnabled;
    ActionLogger fActionLogger;
    
};

MemoryManager& getMemoryManager();

} // namespace gcmemory

template<typename T>
cudaError_t mwCudaMalloc(T** devPtr, size_t size) {
    gcmemory::MemoryManager& manager = gcmemory::getMemoryManager();
    return manager.allocate(devPtr, size, gcmemory::DISCRETE);
}

template<typename T>
cudaError_t mwCudaMallocManaged(T** devPtr, size_t size) {
    gcmemory::MemoryManager& manager = gcmemory::getMemoryManager();
    return manager.allocate(devPtr, size, gcmemory::UNIFIED);
}

template<typename T>
cudaError_t mwCudaFree(T* devPtr) {
    gcmemory::MemoryManager& manager = gcmemory::getMemoryManager();
    return manager.deallocate(devPtr);
}

#endif

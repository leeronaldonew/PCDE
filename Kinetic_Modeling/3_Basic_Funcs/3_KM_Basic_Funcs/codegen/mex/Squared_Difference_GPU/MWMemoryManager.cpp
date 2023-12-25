// Copyright 2021 The MathWorks, Inc.

#include "MWMemoryManager.hpp"

#ifdef MATLAB_MEX_FILE
#include "mex.h"
#else
#include <stdexcept>
#include <iostream>
#endif

#ifdef MW_GPUCODER_RUNTIME_LOG
#include "MWRuntimeLogUtility.hpp"
#include <iomanip>
#endif

#ifdef MW_GPU_MEMORY_DEBUG

#define gcassert(condition) internalAssert(condition, #condition, __FILE__, __LINE__, true)
#define gcassertWarning(condition) internalAssert(condition, #condition, __FILE__, __LINE__, false)

#else

#define gcassert(condition) ((void)0)
#define gcassertWarning(condition) ((void)0)

#endif

#include <algorithm>
#include <sstream>
#include <fstream>


namespace {

const char* MESSAGE_ID = "gpucoder:gpucoderMexMemoryError";
const std::string MESSAGE_PREFIX = "GPU Coder Memory Manager: ";

void internalMessage(const std::string& message, const bool isError) {
    const std::string fullMessage = MESSAGE_PREFIX + message;
    if (isError) {
#ifdef MATLAB_MEX_FILE
        mexErrMsgIdAndTxt(MESSAGE_ID, fullMessage.c_str());
#else
        throw std::logic_error(fullMessage);
#endif
    } else {
#ifdef MATLAB_MEX_FILE
        mexWarnMsgIdAndTxt(MESSAGE_ID, fullMessage.c_str());
#else
        std::cout << fullMessage << std::endl;
#endif    
    }
}

void internalAssertionFailed(const char* conditionString,
                             const char* file,
                             const size_t line,
                             const bool isError) {
    std::stringstream ss;
    ss << "Assertion failed at " << file << ":" << line << ": " << conditionString;
    const std::string message = ss.str();
    internalMessage(message, isError);
}

void internalAssert(const bool condition,
                    const char* conditionString,
                    const char* file,
                    const size_t line,
                    const bool isError) {
    if (!condition) {
        internalAssertionFailed(conditionString, file, line, isError);
    }
}

} // namespace

namespace gcmemory {

#ifdef MW_GPUCODER_RUNTIME_LOG
namespace {
std::ostream& operator<<(std::ostream& ss, const MemoryBlock& block);
std::string getSizeString(const size_t size);
}
#endif

const std::string ActionLogger::ALLOCATE_STRING = "allocate";
const std::string ActionLogger::DEALLOCATE_STRING = "deallocate";
const std::string ActionLogger::DISCRETE_STRING = "discrete";
const std::string ActionLogger::UNIFIED_STRING = "unified";
const std::string ActionLogger::NA_STRING = "N/A";
const char ActionLogger::DELIMITER = '\t';

ActionLogger::ActionLogger(const std::string& fileName) : fLogFileName(fileName) {}

void ActionLogger::logPreAllocate(size_t size, MallocMode mode) {
    gcassert(!fIsAllocating);
    fIsAllocating = true;
    fCurrentLogVar++;
    const Action action = {ALLOCATE, fCurrentLogVar, size, mode};
    logAction(action);
}

void ActionLogger::logPostAllocate(void* devPtr) {
    gcassert(fIsAllocating);
    fIsAllocating = false;
    fLogVarMap[devPtr] = fCurrentLogVar;
}

void ActionLogger::logDeallocate(void* devPtr) {
    gcassert(!fIsAllocating);
    const int logVar = fLogVarMap[devPtr];
    const Action action = {DEALLOCATE, logVar, 0, DISCRETE};
    logAction(action);
}

void ActionLogger::logAction(Action action) {
    writeFileHeader();
    
    std::ofstream logFile;
    logFile.open(fLogFileName, std::ios::app);
    gcassert(logFile.is_open());
    
    const std::string& type = action.type == ALLOCATE ? ALLOCATE_STRING : DEALLOCATE_STRING;
    const std::string& mode = action.type == ALLOCATE ? getMallocModeString(action.mode) : NA_STRING;
    logFile << type << DELIMITER
            << action.var << DELIMITER
            << action.size << DELIMITER
            << mode << '\n';
}

void ActionLogger::writeFileHeader() {
    if (!fHeaderWritten) {
        std::ofstream logFile;
        logFile.open(fLogFileName);
        gcassert(logFile.is_open());
        
        // Write header line
        logFile << "Action Type" << DELIMITER
                << "Variable ID" << DELIMITER
                << "Size" << DELIMITER
                << "Malloc Mode" << '\n';
        fHeaderWritten = true;
    }
}

const std::string& ActionLogger::getMallocModeString(MallocMode mode) {
    switch (mode) {
    case DISCRETE:
        return DISCRETE_STRING;
    case UNIFIED:
        return UNIFIED_STRING;
    }
    return NA_STRING;
}

const size_t Allocator::MEGA_BYTE = 1024 * 1024;

const std::array<size_t, 5> Allocator::SIZE_LEVELS = {
    8 * MEGA_BYTE,
    16 * MEGA_BYTE,
    64 * MEGA_BYTE,
    256 * MEGA_BYTE,
    1024 * MEGA_BYTE
};

size_t Allocator::calculateBlockSize(size_t size) const {
    // Round up to multiple of 256
    return (size + 255) & ~(static_cast<size_t>(255));
}

size_t Allocator::calculatePoolSize(size_t size, MallocMode mode) const {
    // Round up to multiple of 1M
    size = (size + MEGA_BYTE - 1) & ~(MEGA_BYTE - 1);
    size_t poolSizeUp = roundUpPoolSizeWithLevel(size, mode);
    return std::max(poolSizeUp, size);
}

void Allocator::update(size_t lastPoolSize, MallocMode lastMode) {
    size_t& sizeLevelIndex = lastMode == DISCRETE ? fDiscreteSizeLevelIndex : fUnifiedSizeLevelIndex;
    for (size_t i = sizeLevelIndex; i < SIZE_LEVELS.size(); ++i) {
        sizeLevelIndex = i;
        if (lastPoolSize == SIZE_LEVELS[i]) {
            break;
        }
    }
    sizeLevelIndex = std::min(sizeLevelIndex + 1, SIZE_LEVELS.size() - 1);
}

size_t Allocator::roundUpPoolSizeWithLevel(size_t size, MallocMode mode) const {
    size_t i;
    const size_t sizeLevelIndex = mode == DISCRETE ? fDiscreteSizeLevelIndex : fUnifiedSizeLevelIndex;
    for (i = sizeLevelIndex; i < SIZE_LEVELS.size(); i++) {
        // Try get a pool size greater than size, not just greater or equal
        if (size < SIZE_LEVELS[i]) {
            break;
        }
    }
    size_t poolSize = std::max(SIZE_LEVELS[std::min(i, SIZE_LEVELS.size() - 1)], size);
    return poolSize;
}

cudaError_t CudaAllocator::rawMalloc(void** devPtr, size_t size, MallocMode mode) {
    cudaError_t status = cudaSuccess;
    switch (mode) {
    case DISCRETE:
        status = cudaMalloc(devPtr, size);
        break;
    case UNIFIED:
        status = cudaMallocManaged(devPtr, size);
        break;
    }
#ifdef MW_GPUCODER_RUNTIME_LOG
    const char* mallocModeStr = mode == DISCRETE ? "discrete" : "unified";
    std::stringstream ss;
    ss << "rawMalloc  CudaAllocator:      "
       << " devPtr: " << std::setw(13) << *devPtr
       << " size: " << getSizeString(size)
       << " mode: " << std::setw(10) << mallocModeStr;
    gcutil::mwGpuCoderRuntimeLog(ss.str());
#endif
    return status;
}

cudaError_t CudaAllocator::rawFree(void* devPtr) {
#ifdef MW_GPUCODER_RUNTIME_LOG
    std::stringstream ss;
    ss << "rawFree    CudaAllocator:      " << " devPtr: " << std::setw(13) << devPtr;
    gcutil::mwGpuCoderRuntimeLog(ss.str());
#endif
    return cudaFree(devPtr);
}

cudaError_t CudaAllocator::getMemInfo(size_t& freeMemory, size_t& totalMemory) const {
    return cudaMemGetInfo(&freeMemory, &totalMemory);
}

MemoryBlock::MemoryBlock(MemoryPool* pool, void* data, size_t size, bool loggingEnabled) :
    fPool(pool),
    fData(data),
    fSize(size),
    fLoggingEnabled(loggingEnabled) {
    
    gcassert(fPool != NULL);
    gcassert(fData != NULL);
    gcassert(fSize > 0);
#ifdef MW_GPUCODER_RUNTIME_LOG
        std::stringstream msgStream2;
        msgStream2 << "new        MemoryBlock:      " << *this;
        gcutil::mwGpuCoderRuntimeLog(msgStream2.str());
#endif
}

MemoryPool* MemoryBlock::pool() const {
    return fPool;
}

void* MemoryBlock::data() const {
    return fData;
}

size_t MemoryBlock::size() const {
    return fSize;
}

bool MemoryBlock::isAllocated() const {
    return fAllocated;
}

MemoryBlock* MemoryBlock::prev() const {
    return fPrev;
}

MemoryBlock* MemoryBlock::next() const {
    return fNext;
}

void MemoryBlock::setAllocated(bool allocated) {
    fAllocated = allocated;
}

MemoryBlock* MemoryBlock::split(size_t size) {
    gcassert(size > 0);
    gcassert(fSize > size);
    gcassert(!fAllocated);
    
    const bool insertAfter = size >= (fSize >> 1);
    const ResizeMode mode = insertAfter ? MemoryBlock::SHIFT_END : MemoryBlock::SHIFT_START;
    const size_t thisNewSize = fSize - size;
    const size_t newBlockDataOffset = insertAfter ? thisNewSize : 0;

    void* newBlockData = static_cast<char*>(fData) + newBlockDataOffset;
    MemoryBlock* newBlock = new MemoryBlock(fPool, newBlockData, size, fLoggingEnabled);
    resize(thisNewSize, mode);
    
    if (insertAfter) {
        newBlock->insertAfter(this);
    } else {
        newBlock->insertBefore(this);
    }
    
    return newBlock;
}

void MemoryBlock::mergeWithPrev() {
    gcassert(fPrev != NULL);
    fData = fPrev->fData;
    fSize += fPrev->fSize;
    if (fPrev->fPrev) {
        fPrev->fPrev->fNext = this;
    }
    fPrev = fPrev->fPrev;
}

void MemoryBlock::mergeWithNext() {
    gcassert(fNext != NULL);
    fSize += fNext->fSize;
    if (fNext->fNext) {
        fNext->fNext->fPrev = this;
    }
    fNext = fNext->fNext;
}

void MemoryBlock::insertBefore(MemoryBlock* block) {
    gcassert(block != NULL);
    gcassert(block != this);
    gcassert(block->pool() == fPool);
    fPrev = block->fPrev;
    fNext = block;
    block->fPrev = this;
    if (fPrev) {
        fPrev->fNext = this;
    }
}

void MemoryBlock::insertAfter(MemoryBlock* block) {
    gcassert(block != NULL);
    gcassert(block != this);
    gcassert(block->pool() == fPool);
    fPrev = block;
    fNext = block->fNext;
    block->fNext = this;
    if (fNext) {
        fNext->fPrev = this;
    }
}

void MemoryBlock::resize(size_t size, ResizeMode mode) {
    gcassert(!fAllocated);
    gcassert(size > 0);

    switch (mode) {
        case SHIFT_START:
            fData = static_cast<char*>(fData) - size + fSize;
            fSize = size;
            break;
        case SHIFT_END:
            fSize = size;
            break;
        default:
            gcassert(false);
    }
}

bool MemoryBlock::operator<(const MemoryBlock& rhs) const {
    if (fSize == rhs.fSize) {
        return fData < rhs.fData;
    } else {
        return fSize < rhs.fSize;
    }
}

bool MemoryBlock::PointerCompare::operator()(const MemoryBlock* lhs, const MemoryBlock* rhs) const {
    if (lhs == NULL && rhs == NULL) {
        return false;
    } else if (lhs == NULL) {
        return true;
    } else if (rhs == NULL) {
        return false;
    } else {
        return *lhs < *rhs;
    }
}

#ifdef MW_GPUCODER_RUNTIME_LOG
namespace {

std::ostream& operator<<(std::ostream& ss, const MemoryBlock& block) {
    ss <<  std::setw(13) << &block
       << " prev: " << std::setw(13) << (void*)(block.prev())
       << " next: " << std::setw(13) << (void*)(block.next())
       << " data: " << block.data()
       << " size: " << getSizeString(block.size())
       << " allocated: " << block.isAllocated()
       << " pool: " << (void*)(block.pool());
    return ss;
}

std::string getSizeString(const size_t size) {
    std::stringstream ss;
    const size_t nMega = size >> 20;
    const size_t nKilo = (size - (nMega << 20)) >> 10;
    const size_t nByte = size & 1023;
    if (nMega != 0) {
        ss << std::setw(4) << nMega << 'M';
    } else {
        ss << std::setw(5) << ' ';
    }
    if (nKilo != 0) {
        ss << std::setw(4) << nKilo << 'K';
    } else {
        ss << std::setw(5) << ' ';
    }
    if (nByte != 0) {
        ss << std::setw(4) << nByte;
    } else {
        ss << std::setw(4) << ' ';
    }
    return ss.str();
}

} // namespace
#endif


MemoryPool::MemoryPool(void* data, size_t size, Allocator& allocator, bool loggingEnabled) :
    fData(data),
    fSize(size),
    fAllocator(allocator),
    fLoggingEnabled(loggingEnabled) {

    MemoryBlock* block = new MemoryBlock(this, fData, size, fLoggingEnabled);
    fFreeBlocks.insert(block);
    fFirstBlock = block;
#ifdef MW_GPUCODER_RUNTIME_LOG
    std::stringstream msgStream;
    msgStream << "new         MemoryPool:      " << data << ":" << getSizeString(size);
    gcutil::mwGpuCoderRuntimeLog(msgStream.str());
#endif
}

MemoryPool::~MemoryPool() {
    gcassertWarning(!hasAllocatedBlocks());
#ifdef MW_GPUCODER_RUNTIME_LOG
    std::stringstream msgStream1;
    msgStream1 << "delete     MemoryBlock:      " << **(fFreeBlocks.begin());
    gcutil::mwGpuCoderRuntimeLog(msgStream1.str());
#endif
    delete (*(fFreeBlocks.begin()));
    fAllocator.rawFree(fData);
}

MemoryBlock* MemoryPool::firstBlock() const {
    return fFirstBlock;
}

void* MemoryPool::data() const {
    return fData;
}

size_t MemoryPool::size() const {
    return fSize;
}

bool MemoryPool::mustSplitBlock(const MemoryBlock* block, size_t size) {
    size_t allowWastedSize = std::min(static_cast<size_t>(1024*512), size >> 4);
    allowWastedSize = fAllocator.calculateBlockSize(allowWastedSize);
    return block->size() > size + allowWastedSize;
}

size_t MemoryPool::getLargestFreeBlockSize() const {
    if (fFreeBlocks.empty()) {
        return 0;
    } else {
        return (*fFreeBlocks.rbegin())->size();
    }
}

bool MemoryPool::hasAllocatedBlocks() const {
    const MemoryBlock* block = *fFreeBlocks.begin();
    bool allFree = fFreeBlocks.size() == 1 &&
        block->data() == fData &&
        block->size() == fSize;
    return !allFree;
}

MemoryBlock* MemoryPool::allocateBlock(size_t size) {
    MemoryBlock tempBlock(this, fData, size);
    MemoryBlockIter iter = fFreeBlocks.lower_bound(&tempBlock);
    gcassert(iter != fFreeBlocks.end());
    MemoryBlock* const freeBlock = *iter;
    MemoryBlock* block = NULL;
    if (mustSplitBlock(freeBlock, size)) {
        fFreeBlocks.erase(freeBlock);
        block = freeBlock->split(size);
        fFreeBlocks.insert(freeBlock);
    } else {
        block = freeBlock;
        fFreeBlocks.erase(iter);
    }
    if (block->prev() == NULL) {
        fFirstBlock = block;
    }
    block->setAllocated(true);

#ifdef MW_GPUCODER_RUNTIME_LOG
    std::stringstream msgStream;
    msgStream << "allocate   MemoryBlock:      " << *block;
    gcutil::mwGpuCoderRuntimeLog(msgStream.str());
#endif
    
    return block;
}

void MemoryPool::deallocateBlock(MemoryBlock* memoryBlock) {
    gcassert(memoryBlock->pool() == this);
    memoryBlock->setAllocated(false);
    
#ifdef MW_GPUCODER_RUNTIME_LOG
    std::stringstream msgStream;
    msgStream << "deallocate MemoryBlock:      " << *memoryBlock;
    gcutil::mwGpuCoderRuntimeLog(msgStream.str());
#endif
    
    mergeBlock(memoryBlock);
    fFreeBlocks.insert(memoryBlock);
}

void MemoryPool::mergeBlock(MemoryBlock* block) {
    gcassert(block->pool() == this);
    gcassert(!block->isAllocated());

    // If the previus block is not allocated, merge them and return
    MemoryBlock* prevBlock = block->prev();
    if (prevBlock != NULL && !prevBlock->isAllocated()) {
        fFreeBlocks.erase(prevBlock);
        block->mergeWithPrev();
#ifdef MW_GPUCODER_RUNTIME_LOG
        std::stringstream msgStream;
        msgStream << "merge      MemoryBlock:      " << *prevBlock;
        gcutil::mwGpuCoderRuntimeLog(msgStream.str());
#endif
        delete prevBlock;
    }
    // If the next block is not allocated, merge thema nd return
    MemoryBlock* nextBlock = block->next();
    if (nextBlock != NULL && !nextBlock->isAllocated()) {
        fFreeBlocks.erase(nextBlock);
        block->mergeWithNext();
#ifdef MW_GPUCODER_RUNTIME_LOG
        std::stringstream msgStream;
        msgStream << "merge      MemoryBlock:      " << *nextBlock;
        gcutil::mwGpuCoderRuntimeLog(msgStream.str());
#endif
        delete nextBlock;
    }
}

const char* MemoryManager::LOG_FILE_NAME = "gpu_memory_log.csv";

MemoryManager::MemoryManager(Allocator& allocator, bool loggingEnabled) :
    fAllocator(allocator),
    fLoggingEnabled(loggingEnabled),
    fActionLogger(LOG_FILE_NAME) {}

MemoryManager::~MemoryManager() {
    if (!fDataBlockMap.empty()) {
        internalMessage("Found allocated GPU memory resources while cleaning up the GPU Coder memory manager. Freeing all associated GPU memory.", false);
    }
    deletePools();
}

void MemoryManager::deletePools() {
    for (PoolList::const_iterator iter = fDiscretePools.begin();
         iter != fDiscretePools.end(); ++iter) {
        MemoryPool* pool = *iter;
#ifdef MW_GPUCODER_RUNTIME_LOG
        std::stringstream msgStream;
        msgStream << "delete      MemoryPool:      " << pool->data()
                  << ":" << getSizeString(pool->size());
        gcutil::mwGpuCoderRuntimeLog(msgStream.str());
        #endif
        delete pool;
    }

    for (PoolList::const_iterator iter = fUnifiedPools.begin();
         iter != fUnifiedPools.end(); ++iter) {
        MemoryPool* pool = *iter;
#ifdef MW_GPUCODER_RUNTIME_LOG
        std::stringstream msgStream;
        msgStream << "delete      MemoryPool:      " << pool->data()
                  << ":" << getSizeString(pool->size());
        gcutil::mwGpuCoderRuntimeLog(msgStream.str());
#endif
        delete pool;
    }
}

cudaError_t MemoryManager::deallocateImpl(void* devPtr) {
    if (devPtr == NULL) {
        return cudaSuccess;
    }

    // Log data if necessary
    if (fLoggingEnabled) {
        fActionLogger.logDeallocate(devPtr);
    }

    // Find the memory block that devPtr occupies
    BlockMap::iterator iter = fDataBlockMap.find(devPtr);
    gcassert(iter != fDataBlockMap.end());

    // Remove devPtr from the map
    MemoryBlock* memoryBlock = iter->second;
    fDataBlockMap.erase(iter);

    // Dealocate the memory block devPtr occupies
    MemoryPool* memoryPool = memoryBlock->pool();
    memoryPool->deallocateBlock(memoryBlock);
    
    return cudaSuccess; // TODO fix 
}

cudaError_t MemoryManager::allocateImpl(void** devPtr, const size_t size, const MallocMode mode) {
    cudaError_t status = cudaSuccess;
    if (size == 0) {
        *devPtr = NULL;
        return status;
    }

    // log data if necessary
    if (fLoggingEnabled) {
        fActionLogger.logPreAllocate(size, mode);
    }

    const size_t blockSize = fAllocator.calculateBlockSize(size);
    MemoryPool* suitablePool = getFirstSuitableMemoryPool(blockSize, mode);
    
    if (suitablePool == NULL) {
        // If no pool could be found, allocate a new pool
        const size_t poolSize = fAllocator.calculatePoolSize(blockSize, mode);
        status = allocatePool(poolSize, mode, suitablePool);
        if (status == cudaErrorMemoryAllocation) {
            // If we are out of GPU memory, free empty pools and try again
            freeEmptyPools();
            status = allocatePool(poolSize, mode, suitablePool);
        }
        if (status != cudaSuccess) {
            // If that doesn't work, return the error
            return status;
        }
        fAllocator.update(poolSize, mode);
    }
    // Reserve a memory block in the pool of the correct size
    MemoryBlock* memoryBlock = suitablePool->allocateBlock(blockSize);

    // Assign the value of the pointer for use by the client
    *devPtr = memoryBlock->data();

    // Store the data pointer in the map for later use
    fDataBlockMap[*devPtr] = memoryBlock;

    if (fLoggingEnabled) {
        fActionLogger.logPostAllocate(*devPtr);
    }
        
    // Free empty pools after each allocate.
    // If after allocate, there is still empty pool, means they are not needed now and in near future.
    // freeEmptyPools(pools);
    return status;
}

cudaError_t MemoryManager::allocatePool(size_t size,
                                        MallocMode mode,
                                        MemoryPool*& pool) {
    // Allocate raw memory
    void* data = NULL;
    cudaError_t status = fAllocator.rawMalloc(&data, size, mode);
    if (status != cudaSuccess) {
        return status;
    }

    pool = new MemoryPool(data, size, fAllocator, fLoggingEnabled);

    // TODO : sort pool by size from small to large
    PoolList& pools = mode == DISCRETE ? fDiscretePools : fUnifiedPools;
    pools.push_back(pool);

    return status;
}

MemoryPool* MemoryManager::getFirstSuitableMemoryPool(size_t size, MallocMode mode) const {
    const PoolList& pools = mode == DISCRETE ? fDiscretePools : fUnifiedPools;
    for (PoolList::const_iterator iter = pools.begin();
        iter != pools.end(); ++iter) {
        MemoryPool* pool = *iter;
        if (pool->getLargestFreeBlockSize() >= size) {
            return pool;
        }
    }
    return NULL;
}

void MemoryManager::freeEmptyPools() {
    for (PoolList::iterator iter = fDiscretePools.begin();
         iter != fDiscretePools.end(); ) {
        MemoryPool* pool = *iter;
        if (!pool->hasAllocatedBlocks()) {
            delete pool;
            iter = fDiscretePools.erase(iter);
        } else {
            ++iter;
        }
    }
    for (PoolList::iterator iter = fUnifiedPools.begin();
         iter != fUnifiedPools.end(); ) {
        MemoryPool* pool = *iter;
        if (!pool->hasAllocatedBlocks()) {
            delete pool;
            iter = fUnifiedPools.erase(iter);
        } else {
            ++iter;
        }
    }
}

const MemoryManager::BlockMap& MemoryManager::dataBlockMap() const {
    return fDataBlockMap;
}

const MemoryManager::PoolList& MemoryManager::discretePools() const {
    return fDiscretePools;
}

const MemoryManager::PoolList& MemoryManager::unifiedPools() const {
    return fUnifiedPools;
}

#ifdef MW_GPUCODER_RUNTIME_LOG
void MemoryManager::printMemoryPoolBlocks(std::ostream& os, MemoryPool const* pool) {
    const std::string indentSpaces(4, ' ');
    MemoryBlock* block = pool->firstBlock();
    gcassert(block != nullptr);
    int index = 0;
    while (block != nullptr) {
        os << indentSpaces << std::setw(3) << index << " Memory Block: " << *block << std::endl;
        block = block->next();
        ++index;
    }
}

void MemoryManager::printMemoryPools(std::ostream& os, const PoolList& pools) {
    const std::string indentSpaces(2, ' ');
    if (pools.empty()) {
        os << indentSpaces << "No Memory Pools." << std::endl;
        return;
    }
    int index = 0;
    for (PoolList::const_iterator iter; iter != pools.end(); ++iter) {
        const MemoryPool* pool = *iter;
        os << indentSpaces << std::setw(3) << index;
        os << " MemoryPool:" << pool->data() << ":" << getSizeString(pool->size()) << std::endl;
        printMemoryPoolBlocks(os, pool);
        ++index;
    }
}

void MemoryManager::printMemoryMap() {
    std::stringstream ss;
    ss << "////////////////////////////////////////////////////////////////////////////////////////////////////";
    ss << "Memory Map: " << std::endl;
    if (!fDiscretePools.empty()) {
        ss << "Discrete Memory Pools:" << std::endl;
        printMemoryPools(ss, fDiscretePools);
    }
    if (!fUnifiedPools.empty()) {
        ss << "Unified Memory Pools:" << std::endl;
        printMemoryPools(ss, fUnifiedPools);
    }
    ss << "////////////////////////////////////////////////////////////////////////////////////////////////////";    
    gcutil::mwGpuCoderRuntimeLog(ss.str());
}
#endif

MemoryManager& getMemoryManager() {
#ifdef MW_GPUCODER_RUNTIME_LOG
    static const bool logActions = true;
#else
    static const bool logActions = false;
#endif
    static CudaAllocator allocator;
    static MemoryManager manager(allocator, logActions);
    return manager;
}

} // namespace gcmemory

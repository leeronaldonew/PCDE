//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Squared_Difference_GPU.cu
//
// Code generation for function 'Squared_Difference_GPU'
//

// Include files
#include "Squared_Difference_GPU.h"
#include "Squared_Difference_GPU_data.h"
#include "Squared_Difference_GPU_emxutil.h"
#include "Squared_Difference_GPU_types.h"
#include "rt_nonfinite.h"
#include "rtwhalf.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Type Definitions
struct emxArray___half {
  __half *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

// Function Declarations
static __global__ void
Squared_Difference_GPU_kernel1(const emxArray_real32_T true_database,
                               const int32_T b_true_database,
                               emxArray___half c_true_database);

static __global__ void
Squared_Difference_GPU_kernel2(const emxArray_real_T Meas_Cts_temp,
                               const int32_T b_Meas_Cts_temp,
                               emxArray___half c_Meas_Cts_temp);

static __global__ void
Squared_Difference_GPU_kernel3(const int32_T true_database,
                               emxArray___half Squ_diff);

static __global__ void Squared_Difference_GPU_kernel4(
    const emxArray___half true_database, const emxArray___half Meas_Cts_temp,
    const int32_T b_true_database, const int32_T i, const int32_T Squ_diff_dim0,
    const int32_T true_database_dim0, emxArray___half Squ_diff);

static void checkCudaError(cudaError_t errCode, const char_T *file,
                           uint32_T line);

static void gpuEmxEnsureCapacity_real16_T(const emxArray_real16_T *cpu,
                                          emxArray___half *gpu);

static void gpuEmxFree_real16_T(emxArray___half *gpu);

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu);

static void gpuEmxFree_real_T(emxArray_real_T *gpu);

static void gpuEmxMemcpyCpuToGpu_real16_T(emxArray___half *gpu,
                                          const emxArray_real16_T *cpu);

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu);

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                        const emxArray_real_T *cpu);

static void gpuEmxMemcpyGpuToCpu_real16_T(emxArray_real16_T *cpu,
                                          emxArray___half *gpu);

static void gpuEmxReset_real16_T(emxArray___half *gpu);

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu);

static void gpuEmxReset_real_T(emxArray_real_T *gpu);

static void raiseCudaError(uint32_T errCode, const char_T *file, uint32_T line,
                           const char_T *errorName, const char_T *errorString);

// Function Definitions
static __global__
    __launch_bounds__(1024, 1) void Squared_Difference_GPU_kernel1(
        const emxArray_real32_T true_database, const int32_T b_true_database,
        emxArray___half c_true_database)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_true_database);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_true_database.data[i] = static_cast<__half>(true_database.data[i]);
  }
}

static __global__
    __launch_bounds__(1024, 1) void Squared_Difference_GPU_kernel2(
        const emxArray_real_T Meas_Cts_temp, const int32_T b_Meas_Cts_temp,
        emxArray___half c_Meas_Cts_temp)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_Meas_Cts_temp);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_Meas_Cts_temp.data[i] = static_cast<__half>(Meas_Cts_temp.data[i]);
  }
}

static __global__ __launch_bounds__(
    1024, 1) void Squared_Difference_GPU_kernel3(const int32_T true_database,
                                                 emxArray___half Squ_diff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(true_database);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Squ_diff.data[i] = __float2half(0.0F);
  }
}

static __global__
    __launch_bounds__(1024, 1) void Squared_Difference_GPU_kernel4(
        const emxArray___half true_database,
        const emxArray___half Meas_Cts_temp, const int32_T b_true_database,
        const int32_T i, const int32_T Squ_diff_dim0,
        const int32_T true_database_dim0, emxArray___half Squ_diff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_true_database) + 1ULL) *
                (static_cast<uint64_T>(i - 1) + 1ULL) -
            1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_i;
    int32_T j;
    __half h;
    j = static_cast<int32_T>(idx %
                             (static_cast<uint64_T>(b_true_database) + 1ULL));
    b_i = static_cast<int32_T>((idx - static_cast<uint64_T>(j)) /
                               (static_cast<uint64_T>(b_true_database) + 1ULL));
    h = Meas_Cts_temp.data[j];
    Squ_diff.data[b_i + Squ_diff_dim0 * j] =
        (true_database.data[b_i + true_database_dim0 * j] - h) *
        (true_database.data[b_i + true_database_dim0 * j] - h);
  }
}

static void checkCudaError(cudaError_t errCode, const char_T *file,
                           uint32_T line)
{
  if (errCode != cudaSuccess) {
    raiseCudaError(errCode, file, line, cudaGetErrorName(errCode),
                   cudaGetErrorString(errCode));
  }
}

static void gpuEmxEnsureCapacity_real16_T(const emxArray_real16_T *cpu,
                                          emxArray___half *gpu)
{
  __half *newData;
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  if (gpu->data == 0) {
    newData = 0ULL;
    mwCudaMalloc(&newData,
                 static_cast<uint64_T>(cpu->allocatedSize * sizeof(__half)));
    CUDACHECK(cudaGetLastError());
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = (int32_T *)emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T));
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      gpu->size[i] = cpu->size[i];
    }
    gpu->allocatedSize = cpu->allocatedSize;
    gpu->canFreeData = true;
    gpu->data = newData;
  } else {
    int32_T actualSizeCpu;
    int32_T actualSizeGpu;
    actualSizeCpu = 1;
    actualSizeGpu = 1;
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      actualSizeGpu *= gpu->size[i];
      actualSizeCpu *= cpu->size[i];
      gpu->size[i] = cpu->size[i];
    }
    if (gpu->allocatedSize < actualSizeCpu) {
      newData = 0ULL;
      mwCudaMalloc(&newData,
                   static_cast<uint64_T>(cpu->allocatedSize * sizeof(__half)));
      CUDACHECK(cudaGetLastError());
      cudaMemcpy(newData, gpu->data, actualSizeGpu * sizeof(__half),
                 cudaMemcpyDeviceToDevice);
      CUDACHECK(cudaGetLastError());
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
        CUDACHECK(cudaGetLastError());
      }
      gpu->canFreeData = true;
      gpu->data = newData;
    }
  }
#undef CUDACHECK
}

static void gpuEmxFree_real16_T(emxArray___half *gpu)
{
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  if (gpu->data != (void *)4207599121ULL) {
    mwCudaFree(gpu->data);
    CUDACHECK(cudaGetLastError());
  }
  emlrtFreeMex(gpu->size);
#undef CUDACHECK
}

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  if (gpu->data != (void *)4207599121ULL) {
    mwCudaFree(gpu->data);
    CUDACHECK(cudaGetLastError());
  }
  emlrtFreeMex(gpu->size);
#undef CUDACHECK
}

static void gpuEmxFree_real_T(emxArray_real_T *gpu)
{
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  if (gpu->data != (void *)4207599121ULL) {
    mwCudaFree(gpu->data);
    CUDACHECK(cudaGetLastError());
  }
  emlrtFreeMex(gpu->size);
#undef CUDACHECK
}

static void gpuEmxMemcpyCpuToGpu_real16_T(emxArray___half *gpu,
                                          const emxArray_real16_T *cpu)
{
  int32_T actualSize;
  int32_T i;
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = (int32_T *)emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T));
  } else {
    gpu->numDimensions = cpu->numDimensions;
  }
  actualSize = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < actualSize) {
    if (gpu->canFreeData) {
      mwCudaFree(gpu->data);
      CUDACHECK(cudaGetLastError());
    }
    i = cpu->allocatedSize;
    if (i < actualSize) {
      i = actualSize;
    }
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
    mwCudaMalloc(&gpu->data,
                 static_cast<uint64_T>(gpu->allocatedSize * sizeof(real16_T)));
    CUDACHECK(cudaGetLastError());
  }
  cudaMemcpy(gpu->data, cpu->data, actualSize * sizeof(real16_T),
             cudaMemcpyHostToDevice);
  CUDACHECK(cudaGetLastError());
#undef CUDACHECK
}

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = (int32_T *)emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T));
  } else {
    gpu->numDimensions = cpu->numDimensions;
  }
  actualSize = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < actualSize) {
    if (gpu->canFreeData) {
      mwCudaFree(gpu->data);
      CUDACHECK(cudaGetLastError());
    }
    i = cpu->allocatedSize;
    if (i < actualSize) {
      i = actualSize;
    }
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
    mwCudaMalloc(&gpu->data,
                 static_cast<uint64_T>(gpu->allocatedSize * sizeof(real32_T)));
    CUDACHECK(cudaGetLastError());
  }
  cudaMemcpy(gpu->data, cpu->data, actualSize * sizeof(real32_T),
             cudaMemcpyHostToDevice);
  CUDACHECK(cudaGetLastError());
#undef CUDACHECK
}

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                        const emxArray_real_T *cpu)
{
  int32_T actualSize;
  int32_T i;
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = (int32_T *)emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T));
  } else {
    gpu->numDimensions = cpu->numDimensions;
  }
  actualSize = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < actualSize) {
    if (gpu->canFreeData) {
      mwCudaFree(gpu->data);
      CUDACHECK(cudaGetLastError());
    }
    i = cpu->allocatedSize;
    if (i < actualSize) {
      i = actualSize;
    }
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
    mwCudaMalloc(&gpu->data,
                 static_cast<uint64_T>(gpu->allocatedSize * sizeof(real_T)));
    CUDACHECK(cudaGetLastError());
  }
  cudaMemcpy(gpu->data, cpu->data, actualSize * sizeof(real_T),
             cudaMemcpyHostToDevice);
  CUDACHECK(cudaGetLastError());
#undef CUDACHECK
}

static void gpuEmxMemcpyGpuToCpu_real16_T(emxArray_real16_T *cpu,
                                          emxArray___half *gpu)
{
  int32_T actualSize;
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  cudaMemcpy(cpu->data, gpu->data, actualSize * sizeof(real16_T),
             cudaMemcpyDeviceToHost);
  CUDACHECK(cudaGetLastError());
#undef CUDACHECK
}

static void gpuEmxReset_real16_T(emxArray___half *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real16_T));
}

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
}

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
}

static void raiseCudaError(uint32_T errCode, const char_T *file, uint32_T line,
                           const char_T *errorName, const char_T *errorString)
{
  emlrtRTEInfo rtInfo;
  uint32_T len;
  char_T *brk;
  char_T *fn;
  char_T *pn;
  len = strlen(file);
  pn = (char_T *)calloc(len + 1U, 1U);
  fn = (char_T *)calloc(len + 1U, 1U);
  memcpy(pn, file, len);
  memcpy(fn, file, len);
  brk = strrchr(fn, '.');
  *brk = '\x00';
  brk = strrchr(fn, '/');
  if (brk == nullptr) {
    brk = strrchr(fn, '\\');
  }
  if (brk == nullptr) {
    brk = fn;
  } else {
    brk++;
  }
  rtInfo.lineNo = static_cast<int32_T>(line);
  rtInfo.colNo = 0;
  rtInfo.fName = brk;
  rtInfo.pName = pn;
  emlrtCUDAError(errCode, (char_T *)errorName, (char_T *)errorString, &rtInfo,
                 emlrtRootTLSGlobal);
}

void Squared_Difference_GPU(const emxArray_real32_T *true_database,
                            const emxArray_real_T *Meas_Cts_temp,
                            emxArray_real16_T *Squ_diff)
{
  dim3 block;
  dim3 grid;
  emxArray___half b_gpu_Meas_Cts_temp;
  emxArray___half b_gpu_true_database;
  emxArray___half gpu_Squ_diff;
  emxArray_real16_T *b_Meas_Cts_temp;
  emxArray_real16_T *b_true_database;
  emxArray_real32_T gpu_true_database;
  emxArray_real_T gpu_Meas_Cts_temp;
  int32_T Squ_diff_dim0;
  int32_T c_true_database;
  int32_T i;
  int32_T true_database_dim0;
  boolean_T Squ_diff_dirtyOnCpu;
  boolean_T Squ_diff_dirtyOnGpu;
  boolean_T validLaunchParams;
#define CUDACHECK(errCall) checkCudaError(errCall, __FILE__, __LINE__)
  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  gpuEmxReset_real16_T(&gpu_Squ_diff);
  gpuEmxReset_real16_T(&b_gpu_Meas_Cts_temp);
  gpuEmxReset_real_T(&gpu_Meas_Cts_temp);
  gpuEmxReset_real16_T(&b_gpu_true_database);
  gpuEmxReset_real32_T(&gpu_true_database);
  Squ_diff_dirtyOnGpu = false;
  Squ_diff_dirtyOnCpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real16_T(&b_true_database, 2, true);
  // true_database=single(ones(100000000,20));
  // Meas_Cts_temp=double(ones(1,20));
  // tic;
  i = b_true_database->size[0] * b_true_database->size[1];
  b_true_database->size[0] = true_database->size[0];
  b_true_database->size[1] = true_database->size[1];
  emxEnsureCapacity_real16_T(b_true_database, i);
  gpuEmxEnsureCapacity_real16_T(b_true_database, &b_gpu_true_database);
  c_true_database = true_database->size[0] * true_database->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(
      static_cast<real_T>(c_true_database + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_true_database, true_database);
    Squared_Difference_GPU_kernel1<<<grid, block>>>(
        gpu_true_database, c_true_database, b_gpu_true_database);
    CUDACHECK(cudaGetLastError());
  }
  emxInit_real16_T(&b_Meas_Cts_temp, 2, true);
  i = b_Meas_Cts_temp->size[0] * b_Meas_Cts_temp->size[1];
  b_Meas_Cts_temp->size[0] = 1;
  b_Meas_Cts_temp->size[1] = Meas_Cts_temp->size[1];
  emxEnsureCapacity_real16_T(b_Meas_Cts_temp, i);
  gpuEmxEnsureCapacity_real16_T(b_Meas_Cts_temp, &b_gpu_Meas_Cts_temp);
  i = Meas_Cts_temp->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1LL),
                                              &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_Meas_Cts_temp, Meas_Cts_temp);
    Squared_Difference_GPU_kernel2<<<grid, block>>>(gpu_Meas_Cts_temp, i,
                                                    b_gpu_Meas_Cts_temp);
    CUDACHECK(cudaGetLastError());
  }
  // toc;
  i = Squ_diff->size[0] * Squ_diff->size[1];
  Squ_diff->size[0] = b_true_database->size[0];
  Squ_diff->size[1] = b_true_database->size[1];
  emxEnsureCapacity_real16_T(Squ_diff, i);
  c_true_database = b_true_database->size[0] * b_true_database->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(
      static_cast<real_T>(c_true_database + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    gpuEmxMemcpyCpuToGpu_real16_T(&gpu_Squ_diff, Squ_diff);
    Squared_Difference_GPU_kernel3<<<grid, block>>>(c_true_database,
                                                    gpu_Squ_diff);
    CUDACHECK(cudaGetLastError());
    Squ_diff_dirtyOnCpu = false;
    Squ_diff_dirtyOnGpu = true;
  }
  i = b_true_database->size[0];
  c_true_database = b_true_database->size[1] - 1;
  Squ_diff_dim0 = Squ_diff->size[0];
  true_database_dim0 = b_true_database->size[0];
  validLaunchParams = mwGetLaunchParameters1D(
      static_cast<real_T>((c_true_database + 1LL) * ((i - 1) + 1LL)), &grid,
      &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (Squ_diff_dirtyOnCpu) {
      gpuEmxMemcpyCpuToGpu_real16_T(&gpu_Squ_diff, Squ_diff);
    }
    Squared_Difference_GPU_kernel4<<<grid, block>>>(
        b_gpu_true_database, b_gpu_Meas_Cts_temp, c_true_database, i,
        Squ_diff_dim0, true_database_dim0, gpu_Squ_diff);
    CUDACHECK(cudaGetLastError());
    Squ_diff_dirtyOnGpu = true;
  }
  emxFree_real16_T(&b_Meas_Cts_temp);
  emxFree_real16_T(&b_true_database);
  // sum_val=sum(diff,2);
  // tic;
  // [sort_val,sort_ind]=sort(gpuArray(sum_val));
  // [sort_val,sort_ind]=mink(sum_val,300);
  // toc;
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (Squ_diff_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real16_T(Squ_diff, &gpu_Squ_diff);
  }
  gpuEmxFree_real32_T(&gpu_true_database);
  gpuEmxFree_real16_T(&b_gpu_true_database);
  gpuEmxFree_real_T(&gpu_Meas_Cts_temp);
  gpuEmxFree_real16_T(&b_gpu_Meas_Cts_temp);
  gpuEmxFree_real16_T(&gpu_Squ_diff);
#undef CUDACHECK
}

// End of code generation (Squared_Difference_GPU.cu)

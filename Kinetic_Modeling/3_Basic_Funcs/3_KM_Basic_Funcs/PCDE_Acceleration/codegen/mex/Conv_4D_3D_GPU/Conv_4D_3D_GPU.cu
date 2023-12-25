//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Conv_4D_3D_GPU.cu
//
// Code generation for function 'Conv_4D_3D_GPU'
//

// Include files
#include "Conv_4D_3D_GPU.h"
#include "Conv_4D_3D_GPU_emxutil.h"
#include "Conv_4D_3D_GPU_types.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cstring>

// Function Declarations
static __global__ void Conv_4D_3D_GPU_kernel1(const int32_T size_WB,
                                              emxArray_real32_T DB_3D);

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu);

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu);

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu);

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void Conv_4D_3D_GPU_kernel1(
    const int32_T size_WB, emxArray_real32_T DB_3D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(size_WB);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    DB_3D.data[i] = 0.0F;
  }
}

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
  if (gpu->data != (void *)4207599121ULL) {
    cudaFree(gpu->data);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
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
      cudaFree(gpu->data);
    }
    i = cpu->allocatedSize;
    if (i < actualSize) {
      i = actualSize;
    }
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
    cudaMalloc(&gpu->data, gpu->allocatedSize * sizeof(real32_T));
  }
  cudaMemcpy(gpu->data, cpu->data, actualSize * sizeof(real32_T),
             cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  cudaMemcpy(cpu->data, gpu->data, actualSize * sizeof(real32_T),
             cudaMemcpyDeviceToHost);
}

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
}

void Conv_4D_3D_GPU(const emxArray_real32_T *kBq, emxArray_real32_T *DB_3D)
{
  dim3 block;
  dim3 grid;
  emxArray_real32_T gpu_DB_3D;
  int32_T b_size_WB;
  int32_T i;
  uint32_T size_WB[4];
  boolean_T DB_3D_dirtyOnGpu;
  boolean_T validLaunchParams;
  gpuEmxReset_real32_T(&gpu_DB_3D);
  DB_3D_dirtyOnGpu = false;
  //  4D array into 3D array
  for (i = 0; i < 4; i++) {
    size_WB[i] = static_cast<uint32_T>(kBq->size[i]);
  }
  i = DB_3D->size[0] * DB_3D->size[1] * DB_3D->size[2];
  DB_3D->size[0] = static_cast<int32_T>(static_cast<real_T>(size_WB[0]) *
                                        static_cast<real_T>(size_WB[1]));
  DB_3D->size[1] = static_cast<int32_T>(size_WB[3]);
  DB_3D->size[2] = static_cast<int32_T>(size_WB[2]);
  emxEnsureCapacity_real32_T(DB_3D, i);
  b_size_WB = static_cast<int32_T>(static_cast<real_T>(size_WB[0]) *
                                   static_cast<real_T>(size_WB[1])) *
                  static_cast<int32_T>(size_WB[3]) *
                  static_cast<int32_T>(size_WB[2]) -
              1;
  validLaunchParams = mwGetLaunchParameters1D(
      static_cast<real_T>(b_size_WB + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_DB_3D, DB_3D);
    Conv_4D_3D_GPU_kernel1<<<grid, block>>>(b_size_WB, gpu_DB_3D);
    DB_3D_dirtyOnGpu = true;
  }
  i = static_cast<int32_T>(size_WB[2]);
  for (int32_T k{0}; k < i; k++) {
    b_size_WB = static_cast<int32_T>(size_WB[1]);
    for (int32_T j{0}; j < b_size_WB; j++) {
      int32_T i2;
      i2 = static_cast<int32_T>(size_WB[0]);
      for (int32_T b_i{0}; b_i < i2; b_i++) {
        int32_T i3;
        i3 = static_cast<int32_T>(size_WB[3]);
        for (int32_T p{0}; p < i3; p++) {
          if (DB_3D_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(DB_3D, &gpu_DB_3D);
          }
          DB_3D->data[((static_cast<int32_T>(
                            (static_cast<real_T>(b_i) + 1.0) +
                            static_cast<real_T>(size_WB[0]) *
                                ((static_cast<real_T>(j) + 1.0) - 1.0)) +
                        DB_3D->size[0] * p) +
                       DB_3D->size[0] * DB_3D->size[1] * k) -
                      1] =
              kBq->data[((b_i + kBq->size[0] * j) +
                         kBq->size[0] * kBq->size[1] * k) +
                        kBq->size[0] * kBq->size[1] * kBq->size[2] * p];
          DB_3D_dirtyOnGpu = false;
        }
      }
    }
  }
  if (DB_3D_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(DB_3D, &gpu_DB_3D);
  }
  gpuEmxFree_real32_T(&gpu_DB_3D);
}

// End of code generation (Conv_4D_3D_GPU.cu)

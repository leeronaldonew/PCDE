//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// PCL_300_GPU.cu
//
// Code generation for function 'PCL_300_GPU'
//

// Include files
#include "PCL_300_GPU.h"
#include "PCL_300_GPU_types.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"
#include "MWShuffleUtility.h"
#include "MWSortFunctors.h"
#include "MWSortWithIndexUtilityHost.h"

// Function Declarations
static __global__ void PCL_300_GPU_kernel1(const real32_T Slice_TACs_data[],
                                           const int32_T Slice_TACs_size[2],
                                           const int32_T v, const int32_T i,
                                           boolean_T x_data[17]);

static __global__ void PCL_300_GPU_kernel10(const int32_T v,
                                            real32_T Ind_300_data[]);

static __global__ void PCL_300_GPU_kernel2(const real32_T Slice_TACs_data[],
                                           const int32_T Slice_TACs_size[2],
                                           const int32_T v,
                                           const real32_T DB_data[],
                                           const int32_T DB_size,
                                           real32_T a_data[8500000]);

static __global__ void PCL_300_GPU_kernel3(const real32_T a_data[8500000],
                                           const int32_T nx,
                                           real32_T y_data[8500000]);

static __global__ void PCL_300_GPU_kernel4(const real32_T y_data[8500000],
                                           real32_T out[500000]);

static __global__ void PCL_300_GPU_kernel5(const real32_T y_data[8500000],
                                           const int32_T xoffset,
                                           real32_T out[500000]);

static __global__ void PCL_300_GPU_kernel6(real32_T out[500000]);

static __global__ void PCL_300_GPU_kernel7(int32_T inDims[2]);

static __global__ void PCL_300_GPU_kernel8(real_T idx[500000]);

static __global__ void PCL_300_GPU_kernel9(const real_T idx[500000],
                                           const int32_T v,
                                           real32_T Ind_300_data[]);

static void binary_expand_op(real32_T a_data[], int32_T a_size[2],
                             const real32_T DB_data[], const int32_T DB_size[2],
                             const real32_T Slice_TACs_data[],
                             const int32_T Slice_TACs_size[2], int32_T v);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void PCL_300_GPU_kernel1(
    const real32_T Slice_TACs_data[], const int32_T Slice_TACs_size[2],
    const int32_T v, const int32_T i, boolean_T x_data[17])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    x_data[k] = (Slice_TACs_data[v + Slice_TACs_size[0] * k] == 0.0F);
  }
}

static __global__
    __launch_bounds__(320, 1) void PCL_300_GPU_kernel10(const int32_T v,
                                                        real32_T Ind_300_data[])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 300) {
    Ind_300_data[k + 300 * v] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void PCL_300_GPU_kernel2(
    const real32_T Slice_TACs_data[], const int32_T Slice_TACs_size[2],
    const int32_T v, const real32_T DB_data[], const int32_T DB_size,
    real32_T a_data[8500000])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = 500000ULL * (static_cast<uint64_T>(DB_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i1;
    int32_T k;
    i1 = static_cast<int32_T>(idx % 500000ULL);
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(i1)) / 500000ULL);
    a_data[i1 + 500000 * k] =
        DB_data[i1 + 500000 * k] - Slice_TACs_data[v + Slice_TACs_size[0] * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void PCL_300_GPU_kernel3(
    const real32_T a_data[8500000], const int32_T nx, real32_T y_data[8500000])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    y_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(512, 1) void PCL_300_GPU_kernel4(
    const real32_T y_data[8500000], real32_T out[500000])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 500000) {
    out[k] = y_data[k];
  }
}

static __global__ __launch_bounds__(512, 1) void PCL_300_GPU_kernel5(
    const real32_T y_data[8500000], const int32_T xoffset, real32_T out[500000])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 500000) {
    out[k] += y_data[xoffset + k];
  }
}

static __global__
    __launch_bounds__(512, 1) void PCL_300_GPU_kernel6(real32_T out[500000])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 500000) {
    out[k] = 0.0F;
  }
}

static __global__
    __launch_bounds__(32, 1) void PCL_300_GPU_kernel7(int32_T inDims[2])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 2) {
    inDims[k] = -499999 * k + 500000;
  }
}

static __global__
    __launch_bounds__(512, 1) void PCL_300_GPU_kernel8(real_T idx[500000])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 500000) {
    idx[k] = 0.0;
  }
}

static __global__ __launch_bounds__(320, 1) void PCL_300_GPU_kernel9(
    const real_T idx[500000], const int32_T v, real32_T Ind_300_data[])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 300) {
    Ind_300_data[k + 300 * v] = static_cast<real32_T>(idx[k]);
  }
}

static void binary_expand_op(real32_T a_data[], int32_T a_size[2],
                             const real32_T DB_data[], const int32_T DB_size[2],
                             const real32_T Slice_TACs_data[],
                             const int32_T Slice_TACs_size[2], int32_T v)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = Slice_TACs_size[1];
  a_size[0] = 500000;
  if (i == 1) {
    a_size[1] = DB_size[1];
  } else {
    a_size[1] = i;
  }
  stride_0_1 = (DB_size[1] != 1);
  stride_1_1 = (i != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (i == 1) {
    i = DB_size[1];
  }
  for (int32_T i1{0}; i1 < i; i1++) {
    for (int32_T i2{0}; i2 < 500000; i2++) {
      a_data[i2 + 500000 * i1] =
          DB_data[i2 + 500000 * aux_0_1] -
          Slice_TACs_data[v + Slice_TACs_size[0] * aux_1_1];
    }
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

void PCL_300_GPU(PCL_300_GPUStackData *SD, const real32_T DB_data[],
                 const int32_T DB_size[2], const real32_T Slice_TACs_data[],
                 const int32_T Slice_TACs_size[2], real32_T Ind_300_data[],
                 int32_T Ind_300_size[2])
{
  dim3 block;
  dim3 grid;
  real_T(*gpu_idx)[500000];
  int32_T a_size[2];
  int32_T inDims[2];
  int32_T x_size[2];
  int32_T(*gpu_Slice_TACs_size)[2];
  int32_T(*gpu_inDims)[2];
  int32_T b_i;
  int32_T i;
  real32_T(*gpu_a_data)[8500000];
  real32_T(*gpu_y_data)[8500000];
  real32_T(*gpu_out)[500000];
  real32_T *gpu_DB_data;
  real32_T *gpu_Ind_300_data;
  real32_T *gpu_Slice_TACs_data;
  boolean_T x_data[17];
  boolean_T(*gpu_x_data)[17];
  boolean_T DB_data_dirtyOnCpu;
  boolean_T Ind_300_data_dirtyOnGpu;
  boolean_T Slice_TACs_data_dirtyOnCpu;
  boolean_T Slice_TACs_size_dirtyOnCpu;
  boolean_T a_data_dirtyOnCpu;
  boolean_T a_data_dirtyOnGpu;
  boolean_T x_data_dirtyOnGpu;
  mwCudaMalloc(&gpu_idx, 4000000ULL);
  mwCudaMalloc(&gpu_inDims, 8ULL);
  mwCudaMalloc(&gpu_out, 2000000ULL);
  mwCudaMalloc(&gpu_y_data, 34000000ULL);
  mwCudaMalloc(&gpu_a_data, 34000000ULL);
  mwCudaMalloc(&gpu_DB_data,
               static_cast<uint64_T>(8500000U * sizeof(real32_T)));
  mwCudaMalloc(&gpu_Ind_300_data,
               static_cast<uint64_T>(19660800U * sizeof(real32_T)));
  mwCudaMalloc(&gpu_x_data, 17ULL);
  mwCudaMalloc(&gpu_Slice_TACs_size, 8ULL);
  mwCudaMalloc(&gpu_Slice_TACs_data,
               static_cast<uint64_T>(1114112U * sizeof(real32_T)));
  a_data_dirtyOnGpu = false;
  Ind_300_data_dirtyOnGpu = false;
  x_data_dirtyOnGpu = false;
  a_data_dirtyOnCpu = false;
  DB_data_dirtyOnCpu = true;
  Slice_TACs_size_dirtyOnCpu = true;
  Slice_TACs_data_dirtyOnCpu = true;
  // PI_Time=[10:5:90];
  // [permutes,true_data]=make_database_NH_FDG_Full(PI_Time); % k1:0.01~1, k2:
  // 0.01~1, k3:0.01~0.5, k4=0
  //  Seclting a 300 Parameter Combination List
  // Num_Vox=size(Slice_TACs,1);
  // Num_Time=size(Slice_Time,2);
  // Num_Comb=size(DB,1);
  // tic;
  // [sort_val,sort_ind]= mink(sum( (DB-Voxel_TAC).^(2),2 ),300);
  // toc;
  Ind_300_size[0] = 300;
  Ind_300_size[1] = Slice_TACs_size[0];
  i = Slice_TACs_size[0];
  if (0 <= Slice_TACs_size[0] - 1) {
    b_i = Slice_TACs_size[1] - 1;
    x_size[1] = Slice_TACs_size[1];
  }
  for (int32_T v{0}; v < i; v++) {
    int32_T k;
    Ind_300_data_dirtyOnGpu = mwGetLaunchParameters1D(
        static_cast<real_T>(b_i + 1LL), &grid, &block, 1024U, 65535U);
    if (Ind_300_data_dirtyOnGpu) {
      if (Slice_TACs_data_dirtyOnCpu) {
        cudaMemcpy(gpu_Slice_TACs_data, Slice_TACs_data,
                   Slice_TACs_size[0] * Slice_TACs_size[1] * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }
      Slice_TACs_data_dirtyOnCpu = false;
      if (Slice_TACs_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_Slice_TACs_size, Slice_TACs_size, 8ULL,
                   cudaMemcpyHostToDevice);
      }
      Slice_TACs_size_dirtyOnCpu = false;
      PCL_300_GPU_kernel1<<<grid, block>>>(
          gpu_Slice_TACs_data, *gpu_Slice_TACs_size, v, b_i, *gpu_x_data);
      x_data_dirtyOnGpu = true;
    }
    Ind_300_data_dirtyOnGpu = (x_size[1] != 0);
    if (Ind_300_data_dirtyOnGpu) {
      boolean_T exitg1;
      k = 1;
      exitg1 = false;
      while ((!exitg1) && (k <= x_size[1])) {
        if (x_data_dirtyOnGpu) {
          cudaMemcpy(x_data, *gpu_x_data, 17ULL, cudaMemcpyDeviceToHost);
        }
        x_data_dirtyOnGpu = false;
        if (!x_data[k - 1]) {
          Ind_300_data_dirtyOnGpu = false;
          exitg1 = true;
        } else {
          k++;
        }
      }
    }
    if (Ind_300_data_dirtyOnGpu) {
      PCL_300_GPU_kernel10<<<dim3(1U, 1U, 1U), dim3(320U, 1U, 1U)>>>(
          v, gpu_Ind_300_data);
      Ind_300_data_dirtyOnGpu = true;
    } else {
      int32_T nx;
      if (DB_size[1] == Slice_TACs_size[1]) {
        a_size[0] = 500000;
        a_size[1] = DB_size[1];
        Ind_300_data_dirtyOnGpu = mwGetLaunchParameters1D(
            static_cast<real_T>(500000LL * ((DB_size[1] - 1) + 1LL)), &grid,
            &block, 1024U, 65535U);
        if (Ind_300_data_dirtyOnGpu) {
          if (Slice_TACs_data_dirtyOnCpu) {
            cudaMemcpy(gpu_Slice_TACs_data, Slice_TACs_data,
                       Slice_TACs_size[0] * Slice_TACs_size[1] *
                           sizeof(real32_T),
                       cudaMemcpyHostToDevice);
          }
          Slice_TACs_data_dirtyOnCpu = false;
          if (Slice_TACs_size_dirtyOnCpu) {
            cudaMemcpy(*gpu_Slice_TACs_size, Slice_TACs_size, 8ULL,
                       cudaMemcpyHostToDevice);
          }
          Slice_TACs_size_dirtyOnCpu = false;
          if (DB_data_dirtyOnCpu) {
            cudaMemcpy(gpu_DB_data, DB_data,
                       500000 * DB_size[1] * sizeof(real32_T),
                       cudaMemcpyHostToDevice);
          }
          DB_data_dirtyOnCpu = false;
          if (a_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_a_data, SD->f0.a_data, 34000000ULL,
                       cudaMemcpyHostToDevice);
          }
          PCL_300_GPU_kernel2<<<grid, block>>>(
              gpu_Slice_TACs_data, *gpu_Slice_TACs_size, v, gpu_DB_data,
              DB_size[1] - 1, *gpu_a_data);
          a_data_dirtyOnCpu = false;
          a_data_dirtyOnGpu = true;
        }
      } else {
        if (a_data_dirtyOnGpu) {
          cudaMemcpy(SD->f0.a_data, *gpu_a_data, 34000000ULL,
                     cudaMemcpyDeviceToHost);
        }
        binary_expand_op(SD->f0.a_data, a_size, DB_data, DB_size,
                         Slice_TACs_data, Slice_TACs_size, v);
        a_data_dirtyOnGpu = false;
        a_data_dirtyOnCpu = true;
      }
      nx = 500000 * a_size[1];
      Ind_300_data_dirtyOnGpu = mwGetLaunchParameters1D(
          static_cast<real_T>((nx - 1) + 1LL), &grid, &block, 1024U, 65535U);
      if (Ind_300_data_dirtyOnGpu) {
        if (a_data_dirtyOnCpu) {
          cudaMemcpy(*gpu_a_data, SD->f0.a_data, 34000000ULL,
                     cudaMemcpyHostToDevice);
        }
        a_data_dirtyOnCpu = false;
        PCL_300_GPU_kernel3<<<grid, block>>>(*gpu_a_data, nx, *gpu_y_data);
      }
      nx = a_size[1];
      if (a_size[1] == 0) {
        PCL_300_GPU_kernel6<<<dim3(977U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
            *gpu_out);
      } else {
        PCL_300_GPU_kernel4<<<dim3(977U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
            *gpu_y_data, *gpu_out);
        for (k = 0; k <= nx - 2; k++) {
          PCL_300_GPU_kernel5<<<dim3(977U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
              *gpu_y_data, (k + 1) * 500000, *gpu_out);
        }
      }
      PCL_300_GPU_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_inDims);
      PCL_300_GPU_kernel8<<<dim3(977U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_idx);
      cudaMemcpy(inDims, *gpu_inDims, 8ULL, cudaMemcpyDeviceToHost);
      thrustSortImplWithIndex(&(*gpu_out)[0], &(*gpu_idx)[0], 2, &inDims[0], 1,
                              'a', false);
      PCL_300_GPU_kernel9<<<dim3(1U, 1U, 1U), dim3(320U, 1U, 1U)>>>(
          *gpu_idx, v, gpu_Ind_300_data);
      Ind_300_data_dirtyOnGpu = true;
    }
  }
  if (Ind_300_data_dirtyOnGpu) {
    cudaMemcpy(Ind_300_data, gpu_Ind_300_data,
               300 * Ind_300_size[1] * sizeof(real32_T),
               cudaMemcpyDeviceToHost);
  }
  mwCudaFree(&gpu_Slice_TACs_data[0]);
  mwCudaFree(&(*gpu_Slice_TACs_size)[0]);
  mwCudaFree(&(*gpu_x_data)[0]);
  mwCudaFree(&gpu_Ind_300_data[0]);
  mwCudaFree(&gpu_DB_data[0]);
  mwCudaFree(&(*gpu_a_data)[0]);
  mwCudaFree(&(*gpu_y_data)[0]);
  mwCudaFree(&(*gpu_out)[0]);
  mwCudaFree(&(*gpu_inDims)[0]);
  mwCudaFree(&(*gpu_idx)[0]);
}

// End of code generation (PCL_300_GPU.cu)

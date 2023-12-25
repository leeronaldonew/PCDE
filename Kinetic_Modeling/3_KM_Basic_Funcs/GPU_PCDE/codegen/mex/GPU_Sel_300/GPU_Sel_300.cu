//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// GPU_Sel_300.cu
//
// Code generation for function 'GPU_Sel_300'
//

// Include files
#include "GPU_Sel_300.h"
#include "rt_nonfinite.h"
#include "rtwhalf.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cmath>

// Function Declarations
static __global__ void GPU_Sel_300_kernel1(const real32_T Gpu_Input_Bed_r[4352],
                                           const int32_T v,
                                           const real32_T true_db_sub_s[17000],
                                           real32_T a[17000]);

static __global__ void GPU_Sel_300_kernel10(const int32_T iwork[1000],
                                            const int32_T j, const int32_T kEnd,
                                            int32_T idx[1000]);

static __global__ void GPU_Sel_300_kernel11(const int32_T idx[1000],
                                            const int32_T q, const int32_T k,
                                            int32_T iwork[1000]);

static __global__ void GPU_Sel_300_kernel12(const int32_T idx[1000],
                                            const int32_T p, const int32_T k,
                                            int32_T iwork[1000]);

static __global__ void GPU_Sel_300_kernel13(const int32_T idx[1000],
                                            const int32_T p, const int32_T k,
                                            int32_T iwork[1000]);

static __global__ void GPU_Sel_300_kernel14(const int32_T idx[1000],
                                            const int32_T q, const int32_T k,
                                            int32_T iwork[1000]);

static __global__ void GPU_Sel_300_kernel2(const real32_T a[17000],
                                           real32_T y[17000]);

static __global__ void GPU_Sel_300_kernel3(const real32_T y[17000],
                                           real32_T sort_val_temp[1000]);

static __global__ void GPU_Sel_300_kernel4(const real32_T y[17000],
                                           const int32_T xoffset,
                                           real32_T sort_val_temp[1000]);

static __global__ void GPU_Sel_300_kernel5(const real32_T sort_val_temp[1000],
                                           int32_T idx[1000]);

static __global__ void GPU_Sel_300_kernel6(const real32_T sort_val_temp[1000],
                                           const int32_T idx[1000],
                                           real32_T ycol[1000]);

static __global__ void GPU_Sel_300_kernel7(const real32_T ycol[1000],
                                           real32_T sort_val_temp[1000]);

static __global__ void GPU_Sel_300_kernel8(const real32_T sort_val_temp[1000],
                                           const real_T s,
                                           const int32_T idx[1000],
                                           real32_T sort_sub[600]);

static __global__ void GPU_Sel_300_kernel9(const real32_T sort_sub[600],
                                           const int32_T v,
                                           __half params_s_sum_GPU[153600]);

// Function Definitions
static __global__ __launch_bounds__(512, 1) void GPU_Sel_300_kernel1(
    const real32_T Gpu_Input_Bed_r[4352], const int32_T v,
    const real32_T true_db_sub_s[17000], real32_T a[17000])
{
  uint64_T threadId;
  int32_T i;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId % 1000ULL);
  i = static_cast<int32_T>((threadId - static_cast<uint64_T>(k)) / 1000ULL);
  if ((static_cast<int32_T>(i < 17)) && (static_cast<int32_T>(k < 1000))) {
    a[k + 1000 * i] =
        true_db_sub_s[k + 1000 * i] - Gpu_Input_Bed_r[v + (i << 8)];
  }
}

static __global__ __launch_bounds__(1024, 1) void GPU_Sel_300_kernel10(
    const int32_T iwork[1000], const int32_T j, const int32_T kEnd,
    int32_T idx[1000])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(kEnd - 1);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(b_idx);
    idx[(j + k) - 1] = iwork[k];
  }
}

static __global__ __launch_bounds__(32, 1) void GPU_Sel_300_kernel11(
    const int32_T idx[1000], const int32_T q, const int32_T k,
    int32_T iwork[1000])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    iwork[k] = idx[q];
  }
}

static __global__ __launch_bounds__(32, 1) void GPU_Sel_300_kernel12(
    const int32_T idx[1000], const int32_T p, const int32_T k,
    int32_T iwork[1000])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    iwork[k] = idx[p];
  }
}

static __global__ __launch_bounds__(32, 1) void GPU_Sel_300_kernel13(
    const int32_T idx[1000], const int32_T p, const int32_T k,
    int32_T iwork[1000])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    iwork[k] = idx[p];
  }
}

static __global__ __launch_bounds__(32, 1) void GPU_Sel_300_kernel14(
    const int32_T idx[1000], const int32_T q, const int32_T k,
    int32_T iwork[1000])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    iwork[k] = idx[q];
  }
}

static __global__
    __launch_bounds__(512, 1) void GPU_Sel_300_kernel2(const real32_T a[17000],
                                                       real32_T y[17000])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 17000) {
    real32_T f;
    f = a[k];
    y[k] = f * f;
  }
}

static __global__ __launch_bounds__(512, 1) void GPU_Sel_300_kernel3(
    const real32_T y[17000], real32_T sort_val_temp[1000])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 1000) {
    sort_val_temp[k] = y[k];
  }
}

static __global__ __launch_bounds__(512, 1) void GPU_Sel_300_kernel4(
    const real32_T y[17000], const int32_T xoffset,
    real32_T sort_val_temp[1000])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 1000) {
    sort_val_temp[k] += y[xoffset + k];
  }
}

static __global__ __launch_bounds__(512, 1) void GPU_Sel_300_kernel5(
    const real32_T sort_val_temp[1000], int32_T idx[1000])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 500) {
    real32_T f;
    real32_T f1;
    k = (k << 1) + 1;
    f = sort_val_temp[k - 1];
    f1 = sort_val_temp[k];
    if ((static_cast<int32_T>(
            (static_cast<int32_T>(
                (static_cast<int32_T>(f == f1)) ||
                (static_cast<int32_T>((static_cast<int32_T>(isnan(f))) &&
                                      (static_cast<int32_T>(isnan(f1))))))) ||
            (static_cast<int32_T>(f <= f1)))) ||
        (static_cast<int32_T>(isnan(f1)))) {
      idx[k - 1] = k;
      idx[k] = k + 1;
    } else {
      idx[k - 1] = k + 1;
      idx[k] = k;
    }
  }
}

static __global__ __launch_bounds__(512, 1) void GPU_Sel_300_kernel6(
    const real32_T sort_val_temp[1000], const int32_T idx[1000],
    real32_T ycol[1000])
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1000) {
    ycol[i] = sort_val_temp[idx[i] - 1];
  }
}

static __global__ __launch_bounds__(512, 1) void GPU_Sel_300_kernel7(
    const real32_T ycol[1000], real32_T sort_val_temp[1000])
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1000) {
    sort_val_temp[i] = ycol[i];
  }
}

static __global__ __launch_bounds__(320, 1) void GPU_Sel_300_kernel8(
    const real32_T sort_val_temp[1000], const real_T s, const int32_T idx[1000],
    real32_T sort_sub[600])
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 300) {
    sort_sub[i] = static_cast<real32_T>(static_cast<real_T>(idx[i]) + s);
    sort_sub[i + 300] = sort_val_temp[i];
  }
}

static __global__ __launch_bounds__(512, 1) void GPU_Sel_300_kernel9(
    const real32_T sort_sub[600], const int32_T v,
    __half params_s_sum_GPU[153600])
{
  uint64_T threadId;
  int32_T i;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId % 2ULL);
  i = static_cast<int32_T>((threadId - static_cast<uint64_T>(k)) / 2ULL);
  if ((static_cast<int32_T>(i < 300)) && (static_cast<int32_T>(k < 2))) {
    params_s_sum_GPU[i + 300 * ((v << 1) + k)] =
        static_cast<__half>(sort_sub[i + 300 * k]);
  }
}

void GPU_Sel_300(const real32_T Gpu_Input_Bed_r[4352],
                 const real32_T true_db_sub_s[17000], real_T s,
                 real16_T params_s_sum_GPU[153600])
{
  dim3 block;
  dim3 grid;
  real_T b_s;
  int32_T idx[1000];
  int32_T(*gpu_idx)[1000];
  int32_T(*gpu_iwork)[1000];
  int32_T qEnd;
  real32_T(*gpu_a)[17000];
  real32_T(*gpu_true_db_sub_s)[17000];
  real32_T(*gpu_y)[17000];
  real32_T(*gpu_Gpu_Input_Bed_r)[4352];
  real32_T sort_val_temp[1000];
  real32_T(*gpu_sort_val_temp)[1000];
  real32_T(*gpu_ycol)[1000];
  real32_T(*gpu_sort_sub)[600];
  __half(*gpu_params_s_sum_GPU)[153600];
  boolean_T Gpu_Input_Bed_r_dirtyOnCpu;
  boolean_T params_s_sum_GPU_dirtyOnGpu;
  boolean_T true_db_sub_s_dirtyOnCpu;
  cudaMalloc(&gpu_iwork, 4000ULL);
  cudaMalloc(&gpu_params_s_sum_GPU, 307200ULL);
  cudaMalloc(&gpu_sort_sub, 2400ULL);
  cudaMalloc(&gpu_ycol, 4000ULL);
  cudaMalloc(&gpu_idx, 4000ULL);
  cudaMalloc(&gpu_sort_val_temp, 4000ULL);
  cudaMalloc(&gpu_y, 68000ULL);
  cudaMalloc(&gpu_a, 68000ULL);
  cudaMalloc(&gpu_true_db_sub_s, 68000ULL);
  cudaMalloc(&gpu_Gpu_Input_Bed_r, 17408ULL);
  params_s_sum_GPU_dirtyOnGpu = false;
  true_db_sub_s_dirtyOnCpu = true;
  Gpu_Input_Bed_r_dirtyOnCpu = true;
  //  # of voxels that you want to calculate simultaneously!
  b_s = (s - 1.0) * 1000.0;
  for (int32_T v{0}; v < 256; v++) {
    int32_T i;
    int32_T k;
    boolean_T idx_dirtyOnGpu;
    if (Gpu_Input_Bed_r_dirtyOnCpu) {
      cudaMemcpy(*gpu_Gpu_Input_Bed_r, Gpu_Input_Bed_r, 17408ULL,
                 cudaMemcpyHostToDevice);
    }
    Gpu_Input_Bed_r_dirtyOnCpu = false;
    if (true_db_sub_s_dirtyOnCpu) {
      cudaMemcpy(*gpu_true_db_sub_s, true_db_sub_s, 68000ULL,
                 cudaMemcpyHostToDevice);
    }
    true_db_sub_s_dirtyOnCpu = false;
    GPU_Sel_300_kernel1<<<dim3(34U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
        *gpu_Gpu_Input_Bed_r, v, *gpu_true_db_sub_s, *gpu_a);
    GPU_Sel_300_kernel2<<<dim3(34U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_a,
                                                                   *gpu_y);
    GPU_Sel_300_kernel3<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
        *gpu_y, *gpu_sort_val_temp);
    params_s_sum_GPU_dirtyOnGpu = true;
    for (k = 0; k < 16; k++) {
      GPU_Sel_300_kernel4<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
          *gpu_y, (k + 1) * 1000, *gpu_sort_val_temp);
    }
    GPU_Sel_300_kernel5<<<dim3(1U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
        *gpu_sort_val_temp, *gpu_idx);
    idx_dirtyOnGpu = true;
    i = 2;
    while (i < 1000) {
      int32_T i2;
      int32_T j;
      i2 = i << 1;
      j = 1;
      for (int32_T xoffset{i + 1}; xoffset < 1001; xoffset = qEnd + i) {
        int32_T kEnd;
        int32_T p;
        int32_T q;
        boolean_T validLaunchParams;
        p = j - 1;
        q = xoffset - 1;
        qEnd = j + i2;
        if (qEnd > 1001) {
          qEnd = 1001;
        }
        k = 0;
        kEnd = qEnd - j;
        while (k + 1 <= kEnd) {
          if (params_s_sum_GPU_dirtyOnGpu) {
            cudaMemcpy(sort_val_temp, *gpu_sort_val_temp, 4000ULL,
                       cudaMemcpyDeviceToHost);
          }
          params_s_sum_GPU_dirtyOnGpu = false;
          if (idx_dirtyOnGpu) {
            cudaMemcpy(idx, *gpu_idx, 4000ULL, cudaMemcpyDeviceToHost);
          }
          idx_dirtyOnGpu = false;
          if ((sort_val_temp[idx[p] - 1] == sort_val_temp[idx[q] - 1]) ||
              (std::isnan(sort_val_temp[idx[p] - 1]) &&
               std::isnan(sort_val_temp[idx[q] - 1])) ||
              (sort_val_temp[idx[p] - 1] <= sort_val_temp[idx[q] - 1]) ||
              std::isnan(sort_val_temp[idx[q] - 1])) {
            GPU_Sel_300_kernel13<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                *gpu_idx, p, k, *gpu_iwork);
            p++;
            if (p + 1 == xoffset) {
              while (q + 1 < qEnd) {
                k++;
                GPU_Sel_300_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                    *gpu_idx, q, k, *gpu_iwork);
                q++;
              }
            }
          } else {
            GPU_Sel_300_kernel11<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                *gpu_idx, q, k, *gpu_iwork);
            q++;
            if (q + 1 == qEnd) {
              while (p + 1 < xoffset) {
                k++;
                GPU_Sel_300_kernel12<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                    *gpu_idx, p, k, *gpu_iwork);
                p++;
              }
            }
          }
          k++;
        }
        validLaunchParams =
            mwGetLaunchParameters1D(static_cast<real_T>((kEnd - 1) + 1LL),
                                    &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          GPU_Sel_300_kernel10<<<grid, block>>>(*gpu_iwork, j, kEnd, *gpu_idx);
          idx_dirtyOnGpu = true;
        }
        j = qEnd;
      }
      i = i2;
    }
    GPU_Sel_300_kernel6<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
        *gpu_sort_val_temp, *gpu_idx, *gpu_ycol);
    GPU_Sel_300_kernel7<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
        *gpu_ycol, *gpu_sort_val_temp);
    GPU_Sel_300_kernel8<<<dim3(1U, 1U, 1U), dim3(320U, 1U, 1U)>>>(
        *gpu_sort_val_temp, b_s, *gpu_idx, *gpu_sort_sub);
    GPU_Sel_300_kernel9<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(
        *gpu_sort_sub, v, *gpu_params_s_sum_GPU);
    params_s_sum_GPU_dirtyOnGpu = true;
  }
  if (params_s_sum_GPU_dirtyOnGpu) {
    cudaMemcpy(params_s_sum_GPU, *gpu_params_s_sum_GPU, 307200ULL,
               cudaMemcpyDeviceToHost);
  }
  cudaFree(*gpu_Gpu_Input_Bed_r);
  cudaFree(*gpu_true_db_sub_s);
  cudaFree(*gpu_a);
  cudaFree(*gpu_y);
  cudaFree(*gpu_sort_val_temp);
  cudaFree(*gpu_idx);
  cudaFree(*gpu_ycol);
  cudaFree(*gpu_sort_sub);
  cudaFree(*gpu_params_s_sum_GPU);
  cudaFree(*gpu_iwork);
}

// End of code generation (GPU_Sel_300.cu)

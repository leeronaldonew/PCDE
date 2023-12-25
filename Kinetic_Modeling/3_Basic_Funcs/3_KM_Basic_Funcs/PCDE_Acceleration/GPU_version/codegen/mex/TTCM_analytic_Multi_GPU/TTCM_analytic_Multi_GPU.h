//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// TTCM_analytic_Multi_GPU.h
//
// Code generation for function 'TTCM_analytic_Multi_GPU'
//

#pragma once

// Include files
#include "TTCM_analytic_Multi_GPU_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Custom Header Code

#ifdef __CUDA_ARCH__
#undef printf
#endif

// Function Declarations
void TTCM_analytic_Multi_GPU(c_TTCM_analytic_Multi_GPUStackD *SD,
                             const real32_T PL_data[], const int32_T PL_size[2],
                             const real32_T PI_Time_fine_data[],
                             const int32_T PI_Time_fine_size[2],
                             const real32_T Local_Estimates[8],
                             real32_T Ct_data[], int32_T Ct_size[2]);

// End of code generation (TTCM_analytic_Multi_GPU.h)

//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// GPU_Sel_300.h
//
// Code generation for function 'GPU_Sel_300'
//

#pragma once

// Include files
#include "rtwhalf.h"
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
void GPU_Sel_300(const real32_T Gpu_Input_Bed_r[4352],
                 const real32_T true_db_sub_s[17000], real_T s,
                 real16_T params_s_sum_GPU[153600]);

// End of code generation (GPU_Sel_300.h)

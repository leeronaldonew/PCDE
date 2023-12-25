//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_TTCM_analytic_Multi_GPU_api.h
//
// Code generation for function '_coder_TTCM_analytic_Multi_GPU_api'
//

#pragma once

// Include files
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

// Type Declarations
struct c_TTCM_analytic_Multi_GPUStackD;

// Function Declarations
void TTCM_analytic_Multi_GPU_api(c_TTCM_analytic_Multi_GPUStackD *SD,
                                 const mxArray *const prhs[3],
                                 const mxArray *plhs[1]);

// End of code generation (_coder_TTCM_analytic_Multi_GPU_api.h)

//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// GPU_Sel_300_terminate.h
//
// Code generation for function 'GPU_Sel_300_terminate'
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

// Function Declarations
void GPU_Sel_300_atexit();

void GPU_Sel_300_terminate();

// End of code generation (GPU_Sel_300_terminate.h)

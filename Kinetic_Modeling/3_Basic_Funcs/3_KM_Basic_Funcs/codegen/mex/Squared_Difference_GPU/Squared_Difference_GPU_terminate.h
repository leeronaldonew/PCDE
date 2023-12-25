//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Squared_Difference_GPU_terminate.h
//
// Code generation for function 'Squared_Difference_GPU_terminate'
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
void Squared_Difference_GPU_atexit();

void Squared_Difference_GPU_terminate();

// End of code generation (Squared_Difference_GPU_terminate.h)

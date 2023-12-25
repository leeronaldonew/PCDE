//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// PCL_300_GPU_types.h
//
// Code generation for function 'PCL_300_GPU'
//

#pragma once

// Include files
#include "rtwtypes.h"
#include "emlrt.h"

// Custom Header Code

#ifdef __CUDA_ARCH__
#undef printf
#endif

// Type Definitions
struct b_PCL_300_GPU {
  real32_T a_data[8500000];
};

struct PCL_300_GPUStackData {
  b_PCL_300_GPU f0;
};

// End of code generation (PCL_300_GPU_types.h)

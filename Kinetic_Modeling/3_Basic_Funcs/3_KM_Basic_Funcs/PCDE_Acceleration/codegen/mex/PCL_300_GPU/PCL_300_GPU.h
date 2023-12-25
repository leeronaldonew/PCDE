//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// PCL_300_GPU.h
//
// Code generation for function 'PCL_300_GPU'
//

#pragma once

// Include files
#include "PCL_300_GPU_types.h"
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
void PCL_300_GPU(PCL_300_GPUStackData *SD, const real32_T DB_data[],
                 const int32_T DB_size[2], const real32_T Slice_TACs_data[],
                 const int32_T Slice_TACs_size[2], real32_T Ind_300_data[],
                 int32_T Ind_300_size[2]);

// End of code generation (PCL_300_GPU.h)

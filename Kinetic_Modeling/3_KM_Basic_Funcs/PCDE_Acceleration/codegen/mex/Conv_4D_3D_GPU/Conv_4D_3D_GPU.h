//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Conv_4D_3D_GPU.h
//
// Code generation for function 'Conv_4D_3D_GPU'
//

#pragma once

// Include files
#include "Conv_4D_3D_GPU_types.h"
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
void Conv_4D_3D_GPU(const emxArray_real32_T *kBq, emxArray_real32_T *DB_3D);

// End of code generation (Conv_4D_3D_GPU.h)

//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Conv_4D_3D_GPU_emxutil.h
//
// Code generation for function 'Conv_4D_3D_GPU_emxutil'
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
void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T oldNumel);

void emxFree_real32_T(emxArray_real32_T **pEmxArray);

void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T numDimensions,
                      boolean_T doPush);

// End of code generation (Conv_4D_3D_GPU_emxutil.h)

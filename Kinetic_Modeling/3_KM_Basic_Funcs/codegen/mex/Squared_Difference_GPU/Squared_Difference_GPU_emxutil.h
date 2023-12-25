//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Squared_Difference_GPU_emxutil.h
//
// Code generation for function 'Squared_Difference_GPU_emxutil'
//

#pragma once

// Include files
#include "Squared_Difference_GPU_types.h"
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
void emxEnsureCapacity_real16_T(emxArray_real16_T *emxArray, int32_T oldNumel);

void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T oldNumel);

void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel);

void emxFree_real16_T(emxArray_real16_T **pEmxArray);

void emxFree_real32_T(emxArray_real32_T **pEmxArray);

void emxFree_real_T(emxArray_real_T **pEmxArray);

void emxInit_real16_T(emxArray_real16_T **pEmxArray, int32_T numDimensions,
                      boolean_T doPush);

void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T numDimensions,
                      boolean_T doPush);

void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
                    boolean_T doPush);

// End of code generation (Squared_Difference_GPU_emxutil.h)

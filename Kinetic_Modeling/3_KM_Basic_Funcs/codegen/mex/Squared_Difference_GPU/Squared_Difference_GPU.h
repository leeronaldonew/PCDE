//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Squared_Difference_GPU.h
//
// Code generation for function 'Squared_Difference_GPU'
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
void Squared_Difference_GPU(const emxArray_real32_T *true_database,
                            const emxArray_real_T *Meas_Cts_temp,
                            emxArray_real16_T *Squ_diff);

// End of code generation (Squared_Difference_GPU.h)

//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// div.h
//
// Code generation for function 'div'
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
void b_binary_expand_op(real32_T fv38_data[], int32_T fv38_size[1],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv1_data[], const int32_T fv1_size[1],
                        const real32_T fv3_data[], const int32_T fv3_size[1],
                        const real32_T fv5_data[], const int32_T fv5_size[1]);

void b_binary_expand_op(real32_T fv68_data[], int32_T fv68_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv62_data[], const int32_T fv62_size[1]);

void binary_expand_op(real32_T fv76_data[], int32_T fv76_size[1],
                      const real32_T Local_Estimates[8],
                      const real32_T PL_data[], const int32_T PL_size[2],
                      const real32_T fv70_data[], const int32_T fv70_size[1]);

void binary_expand_op(real32_T fv77_data[], int32_T fv77_size[1],
                      const real32_T PL_data[], const int32_T PL_size[2],
                      const real32_T fv40_data[], const int32_T fv40_size[1],
                      const real32_T fv42_data[], const int32_T fv42_size[1],
                      const real32_T fv44_data[], const int32_T fv44_size[1]);

void c_binary_expand_op(real32_T fv60_data[], int32_T fv60_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv54_data[], const int32_T fv54_size[1]);

void d_binary_expand_op(real32_T fv52_data[], int32_T fv52_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv46_data[], const int32_T fv46_size[1]);

void e_binary_expand_op(real32_T fv37_data[], int32_T fv37_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv31_data[], const int32_T fv31_size[1]);

void f_binary_expand_op(real32_T fv29_data[], int32_T fv29_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv23_data[], const int32_T fv23_size[1]);

void g_binary_expand_op(real32_T fv21_data[], int32_T fv21_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv15_data[], const int32_T fv15_size[1]);

void h_binary_expand_op(real32_T fv13_data[], int32_T fv13_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv7_data[], const int32_T fv7_size[1]);

// End of code generation (div.h)

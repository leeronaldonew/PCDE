/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * select_min_distance_ind_types.h
 *
 * Code generation for function 'select_min_distance_ind'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "emlrt.h"

/* Type Definitions */
#ifndef struct_emxArray_real32_T
#define struct_emxArray_real32_T
struct emxArray_real32_T {
  real32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};
#endif /* struct_emxArray_real32_T */
#ifndef typedef_emxArray_real32_T
#define typedef_emxArray_real32_T
typedef struct emxArray_real32_T emxArray_real32_T;
#endif /* typedef_emxArray_real32_T */

#ifndef typedef_b_select_min_distance_ind
#define typedef_b_select_min_distance_ind
typedef struct {
  real32_T varargin_1[94109400];
} b_select_min_distance_ind;
#endif /* typedef_b_select_min_distance_ind */

#ifndef typedef_c_select_min_distance_indStackD
#define typedef_c_select_min_distance_indStackD
typedef struct {
  b_select_min_distance_ind f0;
} c_select_min_distance_indStackD;
#endif /* typedef_c_select_min_distance_indStackD */

/* End of code generation (select_min_distance_ind_types.h) */

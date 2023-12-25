/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * select_min_distance_ind_emxutil.h
 *
 * Code generation for function 'select_min_distance_ind_emxutil'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "select_min_distance_ind_types.h"
#include "emlrt.h"
#include "mex.h"
#include "omp.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void emxEnsureCapacity_real32_T(const emlrtStack *sp,
                                emxArray_real32_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation);

void emxFree_real32_T(const emlrtStack *sp, emxArray_real32_T **pEmxArray);

void emxInit_real32_T(const emlrtStack *sp, emxArray_real32_T **pEmxArray,
                      const emlrtRTEInfo *srcLocation);

/* End of code generation (select_min_distance_ind_emxutil.h) */

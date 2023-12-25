/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * extremeKElements.h
 *
 * Code generation for function 'extremeKElements'
 *
 */

#pragma once

/* Include files */
#include "Comp_Ct_Database_Meas_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include "omp.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void exkib(const emlrtStack *sp, const emxArray_real32_T *a, int32_T k,
           int32_T idx_data[], int32_T *idx_size, real32_T b_data[],
           int32_T *b_size);

/* End of code generation (extremeKElements.h) */

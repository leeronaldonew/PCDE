/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * select_min_distance_ind.h
 *
 * Code generation for function 'select_min_distance_ind'
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
emlrtCTX emlrtGetRootTLSGlobal(void);

void emlrtLockerFunction(EmlrtLockeeFunction aLockee, emlrtConstCTX aTLS,
                         void *aData);

void select_min_distance_ind(c_select_min_distance_indStackD *SD,
                             const emlrtStack *sp, const emxArray_real32_T *X,
                             const emxArray_real32_T *Y, real32_T *min_val,
                             real_T *ind);

/* End of code generation (select_min_distance_ind.h) */

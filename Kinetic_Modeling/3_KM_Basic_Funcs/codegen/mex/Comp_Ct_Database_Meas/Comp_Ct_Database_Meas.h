/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Comp_Ct_Database_Meas.h
 *
 * Code generation for function 'Comp_Ct_Database_Meas'
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
void Comp_Ct_Database_Meas(const emlrtStack *sp,
                           const emxArray_real32_T *true_database,
                           const emxArray_real_T *Meas_Cts_temp,
                           real32_T sort_val_data[], int32_T sort_val_size[1],
                           real_T sort_ind_data[], int32_T sort_ind_size[1]);

emlrtCTX emlrtGetRootTLSGlobal(void);

void emlrtLockerFunction(EmlrtLockeeFunction aLockee, emlrtConstCTX aTLS,
                         void *aData);

/* End of code generation (Comp_Ct_Database_Meas.h) */

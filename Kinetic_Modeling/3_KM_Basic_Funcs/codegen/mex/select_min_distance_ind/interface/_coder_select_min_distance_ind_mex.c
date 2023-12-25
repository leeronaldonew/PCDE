/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_select_min_distance_ind_mex.c
 *
 * Code generation for function '_coder_select_min_distance_ind_mex'
 *
 */

/* Include files */
#include "_coder_select_min_distance_ind_mex.h"
#include "_coder_select_min_distance_ind_api.h"
#include "rt_nonfinite.h"
#include "select_min_distance_ind.h"
#include "select_min_distance_ind_data.h"
#include "select_min_distance_ind_initialize.h"
#include "select_min_distance_ind_terminate.h"
#include "select_min_distance_ind_types.h"

/* Function Definitions */
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  static jmp_buf emlrtJBEnviron;
  c_select_min_distance_indStackD *d_select_min_distance_indStackD = NULL;
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  d_select_min_distance_indStackD =
      (c_select_min_distance_indStackD *)emlrtMxCalloc(
          (size_t)1, (size_t)1U * sizeof(c_select_min_distance_indStackD));
  mexAtExit(&select_min_distance_ind_atexit);
  /* Initialize the memory manager. */
  omp_init_lock(&emlrtLockGlobal);
  omp_init_nest_lock(&select_min_distance_ind_nestLockGlobal);
  /* Module initialization. */
  select_min_distance_ind_initialize();
  st.tls = emlrtRootTLSGlobal;
  emlrtSetJmpBuf(&st, &emlrtJBEnviron);
  if (setjmp(emlrtJBEnviron) == 0) {
    /* Dispatch the entry-point. */
    select_min_distance_ind_mexFunction(d_select_min_distance_indStackD, nlhs,
                                        plhs, nrhs, prhs);
    /* Module termination. */
    select_min_distance_ind_terminate();
    omp_destroy_lock(&emlrtLockGlobal);
    omp_destroy_nest_lock(&select_min_distance_ind_nestLockGlobal);
  } else {
    omp_destroy_lock(&emlrtLockGlobal);
    omp_destroy_nest_lock(&select_min_distance_ind_nestLockGlobal);
    emlrtReportParallelRunTimeError(&st);
  }
  emlrtMxFree(d_select_min_distance_indStackD);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2021a(&emlrtRootTLSGlobal, &emlrtContextGlobal,
                           &emlrtLockerFunction, omp_get_num_procs(), NULL);
  return emlrtRootTLSGlobal;
}

void select_min_distance_ind_mexFunction(c_select_min_distance_indStackD *SD,
                                         int32_T nlhs, mxArray *plhs[2],
                                         int32_T nrhs, const mxArray *prhs[2])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *outputs[2];
  int32_T b_nlhs;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 2, 4,
                        23, "select_min_distance_ind");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 23,
                        "select_min_distance_ind");
  }
  /* Call the function. */
  select_min_distance_ind_api(SD, prhs, nlhs, outputs);
  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }
  emlrtReturnArrays(b_nlhs, &plhs[0], &outputs[0]);
}

/* End of code generation (_coder_select_min_distance_ind_mex.c) */

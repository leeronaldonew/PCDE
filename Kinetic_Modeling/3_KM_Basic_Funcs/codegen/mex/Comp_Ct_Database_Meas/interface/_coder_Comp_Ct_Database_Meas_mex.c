/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_Comp_Ct_Database_Meas_mex.c
 *
 * Code generation for function '_coder_Comp_Ct_Database_Meas_mex'
 *
 */

/* Include files */
#include "_coder_Comp_Ct_Database_Meas_mex.h"
#include "Comp_Ct_Database_Meas.h"
#include "Comp_Ct_Database_Meas_data.h"
#include "Comp_Ct_Database_Meas_initialize.h"
#include "Comp_Ct_Database_Meas_terminate.h"
#include "_coder_Comp_Ct_Database_Meas_api.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void Comp_Ct_Database_Meas_mexFunction(int32_T nlhs, mxArray *plhs[2],
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
                        21, "Comp_Ct_Database_Meas");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 21,
                        "Comp_Ct_Database_Meas");
  }
  /* Call the function. */
  Comp_Ct_Database_Meas_api(prhs, nlhs, outputs);
  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }
  emlrtReturnArrays(b_nlhs, &plhs[0], &outputs[0]);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  static jmp_buf emlrtJBEnviron;
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexAtExit(&Comp_Ct_Database_Meas_atexit);
  /* Initialize the memory manager. */
  omp_init_lock(&emlrtLockGlobal);
  omp_init_nest_lock(&Comp_Ct_Database_Meas_nestLockGlobal);
  /* Module initialization. */
  Comp_Ct_Database_Meas_initialize();
  st.tls = emlrtRootTLSGlobal;
  emlrtSetJmpBuf(&st, &emlrtJBEnviron);
  if (setjmp(emlrtJBEnviron) == 0) {
    /* Dispatch the entry-point. */
    Comp_Ct_Database_Meas_mexFunction(nlhs, plhs, nrhs, prhs);
    /* Module termination. */
    Comp_Ct_Database_Meas_terminate();
    omp_destroy_lock(&emlrtLockGlobal);
    omp_destroy_nest_lock(&Comp_Ct_Database_Meas_nestLockGlobal);
  } else {
    omp_destroy_lock(&emlrtLockGlobal);
    omp_destroy_nest_lock(&Comp_Ct_Database_Meas_nestLockGlobal);
    emlrtReportParallelRunTimeError(&st);
  }
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2021a(&emlrtRootTLSGlobal, &emlrtContextGlobal,
                           &emlrtLockerFunction, omp_get_num_procs(), NULL);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_Comp_Ct_Database_Meas_mex.c) */

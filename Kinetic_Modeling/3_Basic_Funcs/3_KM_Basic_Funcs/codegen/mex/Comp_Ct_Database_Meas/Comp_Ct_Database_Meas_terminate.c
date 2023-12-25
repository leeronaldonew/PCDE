/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Comp_Ct_Database_Meas_terminate.c
 *
 * Code generation for function 'Comp_Ct_Database_Meas_terminate'
 *
 */

/* Include files */
#include "Comp_Ct_Database_Meas_terminate.h"
#include "Comp_Ct_Database_Meas_data.h"
#include "_coder_Comp_Ct_Database_Meas_mex.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void Comp_Ct_Database_Meas_atexit(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void Comp_Ct_Database_Meas_terminate(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (Comp_Ct_Database_Meas_terminate.c) */

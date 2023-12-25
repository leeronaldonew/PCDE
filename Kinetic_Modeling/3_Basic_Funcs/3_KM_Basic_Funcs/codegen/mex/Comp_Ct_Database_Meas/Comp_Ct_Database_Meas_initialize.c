/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Comp_Ct_Database_Meas_initialize.c
 *
 * Code generation for function 'Comp_Ct_Database_Meas_initialize'
 *
 */

/* Include files */
#include "Comp_Ct_Database_Meas_initialize.h"
#include "Comp_Ct_Database_Meas_data.h"
#include "_coder_Comp_Ct_Database_Meas_mex.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void Comp_Ct_Database_Meas_initialize(void)
{
  static const volatile char_T *emlrtBreakCheckR2012bFlagVar = NULL;
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (Comp_Ct_Database_Meas_initialize.c) */

//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_TTCM_analytic_Multi_GPU_mex.cu
//
// Code generation for function '_coder_TTCM_analytic_Multi_GPU_mex'
//

// Include files
#include "_coder_TTCM_analytic_Multi_GPU_mex.h"
#include "TTCM_analytic_Multi_GPU_data.h"
#include "TTCM_analytic_Multi_GPU_initialize.h"
#include "TTCM_analytic_Multi_GPU_terminate.h"
#include "TTCM_analytic_Multi_GPU_types.h"
#include "_coder_TTCM_analytic_Multi_GPU_api.h"
#include "rt_nonfinite.h"

// Function Definitions
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  c_TTCM_analytic_Multi_GPUStackD *d_TTCM_analytic_Multi_GPUStackD{nullptr};
  d_TTCM_analytic_Multi_GPUStackD = new c_TTCM_analytic_Multi_GPUStackD;
  mexAtExit(&TTCM_analytic_Multi_GPU_atexit);
  // Module initialization.
  TTCM_analytic_Multi_GPU_initialize();
  // Dispatch the entry-point.
  unsafe_TTCM_analytic_Multi_GPU_mexFunction(d_TTCM_analytic_Multi_GPUStackD,
                                             nlhs, plhs, nrhs, prhs);
  // Module termination.
  TTCM_analytic_Multi_GPU_terminate();
  delete d_TTCM_analytic_Multi_GPUStackD;
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2021a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           nullptr);
  return emlrtRootTLSGlobal;
}

void unsafe_TTCM_analytic_Multi_GPU_mexFunction(
    c_TTCM_analytic_Multi_GPUStackD *SD, int32_T nlhs, mxArray *plhs[1],
    int32_T nrhs, const mxArray *prhs[3])
{
  const mxArray *outputs[1];
  // Check for proper number of arguments.
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 3, 4, 23, "TTCM_analytic_Multi_GPU");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 23,
                        "TTCM_analytic_Multi_GPU");
  }
  // Call the function.
  TTCM_analytic_Multi_GPU_api(SD, prhs, outputs);
  // Copy over outputs to the caller.
  emlrtReturnArrays(1, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_TTCM_analytic_Multi_GPU_mex.cu)

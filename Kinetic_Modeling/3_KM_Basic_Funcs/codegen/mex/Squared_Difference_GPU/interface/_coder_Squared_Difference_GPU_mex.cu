//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_Squared_Difference_GPU_mex.cu
//
// Code generation for function '_coder_Squared_Difference_GPU_mex'
//

// Include files
#include "_coder_Squared_Difference_GPU_mex.h"
#include "Squared_Difference_GPU_data.h"
#include "Squared_Difference_GPU_initialize.h"
#include "Squared_Difference_GPU_terminate.h"
#include "_coder_Squared_Difference_GPU_api.h"
#include "rt_nonfinite.h"

// Function Definitions
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&Squared_Difference_GPU_atexit);
  // Module initialization.
  Squared_Difference_GPU_initialize();
  // Dispatch the entry-point.
  unsafe_Squared_Difference_GPU_mexFunction(nlhs, plhs, nrhs, prhs);
  // Module termination.
  Squared_Difference_GPU_terminate();
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2021a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           nullptr);
  return emlrtRootTLSGlobal;
}

void unsafe_Squared_Difference_GPU_mexFunction(int32_T nlhs, mxArray *plhs[1],
                                               int32_T nrhs,
                                               const mxArray *prhs[2])
{
  const mxArray *outputs[1];
  // Check for proper number of arguments.
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 2, 4, 22, "Squared_Difference_GPU");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 22,
                        "Squared_Difference_GPU");
  }
  // Call the function.
  Squared_Difference_GPU_api(prhs, outputs);
  // Copy over outputs to the caller.
  emlrtReturnArrays(1, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_Squared_Difference_GPU_mex.cu)

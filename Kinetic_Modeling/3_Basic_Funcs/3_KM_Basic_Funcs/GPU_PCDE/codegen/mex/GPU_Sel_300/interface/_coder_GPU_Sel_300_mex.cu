//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_GPU_Sel_300_mex.cu
//
// Code generation for function '_coder_GPU_Sel_300_mex'
//

// Include files
#include "_coder_GPU_Sel_300_mex.h"
#include "GPU_Sel_300_data.h"
#include "GPU_Sel_300_initialize.h"
#include "GPU_Sel_300_terminate.h"
#include "_coder_GPU_Sel_300_api.h"
#include "rt_nonfinite.h"

// Function Definitions
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&GPU_Sel_300_atexit);
  // Module initialization.
  GPU_Sel_300_initialize();
  // Dispatch the entry-point.
  unsafe_GPU_Sel_300_mexFunction(nlhs, plhs, nrhs, prhs);
  // Module termination.
  GPU_Sel_300_terminate();
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2021a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           nullptr);
  return emlrtRootTLSGlobal;
}

void unsafe_GPU_Sel_300_mexFunction(int32_T nlhs, mxArray *plhs[1],
                                    int32_T nrhs, const mxArray *prhs[3])
{
  const mxArray *outputs[1];
  // Check for proper number of arguments.
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 3, 4, 11, "GPU_Sel_300");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 11,
                        "GPU_Sel_300");
  }
  // Call the function.
  GPU_Sel_300_api(prhs, outputs);
  // Copy over outputs to the caller.
  emlrtReturnArrays(1, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_GPU_Sel_300_mex.cu)

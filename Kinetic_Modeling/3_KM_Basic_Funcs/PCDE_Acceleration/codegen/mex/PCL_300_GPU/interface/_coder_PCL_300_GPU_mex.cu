//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_PCL_300_GPU_mex.cu
//
// Code generation for function '_coder_PCL_300_GPU_mex'
//

// Include files
#include "_coder_PCL_300_GPU_mex.h"
#include "PCL_300_GPU_data.h"
#include "PCL_300_GPU_initialize.h"
#include "PCL_300_GPU_terminate.h"
#include "PCL_300_GPU_types.h"
#include "_coder_PCL_300_GPU_api.h"
#include "rt_nonfinite.h"

// Function Definitions
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  PCL_300_GPUStackData *PCL_300_GPUStackDataGlobal{nullptr};
  PCL_300_GPUStackDataGlobal = new PCL_300_GPUStackData;
  mexAtExit(&PCL_300_GPU_atexit);
  // Module initialization.
  PCL_300_GPU_initialize();
  // Dispatch the entry-point.
  unsafe_PCL_300_GPU_mexFunction(PCL_300_GPUStackDataGlobal, nlhs, plhs, nrhs,
                                 prhs);
  // Module termination.
  PCL_300_GPU_terminate();
  delete PCL_300_GPUStackDataGlobal;
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2021a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           nullptr);
  return emlrtRootTLSGlobal;
}

void unsafe_PCL_300_GPU_mexFunction(PCL_300_GPUStackData *SD, int32_T nlhs,
                                    mxArray *plhs[1], int32_T nrhs,
                                    const mxArray *prhs[2])
{
  const mxArray *outputs[1];
  // Check for proper number of arguments.
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 2, 4, 11, "PCL_300_GPU");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 11,
                        "PCL_300_GPU");
  }
  // Call the function.
  PCL_300_GPU_api(SD, prhs, outputs);
  // Copy over outputs to the caller.
  emlrtReturnArrays(1, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_PCL_300_GPU_mex.cu)

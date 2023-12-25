//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// GPU_Sel_300_initialize.cu
//
// Code generation for function 'GPU_Sel_300_initialize'
//

// Include files
#include "GPU_Sel_300_initialize.h"
#include "GPU_Sel_300_data.h"
#include "_coder_GPU_Sel_300_mex.h"
#include "rt_nonfinite.h"

// Function Definitions
void GPU_Sel_300_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2012b(emlrtRootTLSGlobal,
                          (const char_T *)"distrib_computing_toolbox", 2);
  emlrtLicenseCheckR2012b(emlrtRootTLSGlobal,
                          (const char_T *)"matlab_coder or fixed_point_toolbox",
                          1);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
  cudaGetLastError();
}

// End of code generation (GPU_Sel_300_initialize.cu)

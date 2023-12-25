//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Squared_Difference_GPU_initialize.cu
//
// Code generation for function 'Squared_Difference_GPU_initialize'
//

// Include files
#include "Squared_Difference_GPU_initialize.h"
#include "Squared_Difference_GPU_data.h"
#include "_coder_Squared_Difference_GPU_mex.h"
#include "rt_nonfinite.h"

// Function Definitions
void Squared_Difference_GPU_initialize()
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

// End of code generation (Squared_Difference_GPU_initialize.cu)

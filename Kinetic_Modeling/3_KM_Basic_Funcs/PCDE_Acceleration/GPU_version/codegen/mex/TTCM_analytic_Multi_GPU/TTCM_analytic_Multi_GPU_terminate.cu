//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// TTCM_analytic_Multi_GPU_terminate.cu
//
// Code generation for function 'TTCM_analytic_Multi_GPU_terminate'
//

// Include files
#include "TTCM_analytic_Multi_GPU_terminate.h"
#include "TTCM_analytic_Multi_GPU_data.h"
#include "_coder_TTCM_analytic_Multi_GPU_mex.h"
#include "rt_nonfinite.h"

// Function Definitions
void TTCM_analytic_Multi_GPU_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void TTCM_analytic_Multi_GPU_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode),
                       (char_T *)cudaGetErrorName(errCode),
                       (char_T *)cudaGetErrorString(errCode),
                       (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

// End of code generation (TTCM_analytic_Multi_GPU_terminate.cu)

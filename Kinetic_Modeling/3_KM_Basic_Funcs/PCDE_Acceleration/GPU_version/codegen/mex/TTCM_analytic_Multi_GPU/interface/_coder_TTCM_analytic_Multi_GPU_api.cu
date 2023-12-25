//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_TTCM_analytic_Multi_GPU_api.cu
//
// Code generation for function '_coder_TTCM_analytic_Multi_GPU_api'
//

// Include files
#include "_coder_TTCM_analytic_Multi_GPU_api.h"
#include "TTCM_analytic_Multi_GPU.h"
#include "TTCM_analytic_Multi_GPU_data.h"
#include "TTCM_analytic_Multi_GPU_types.h"
#include "rt_nonfinite.h"

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *PI_Time_fine,
                               const char_T *identifier, real32_T **y_data,
                               int32_T y_size[2]);

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T **y_data, int32_T y_size[2]);

static real32_T (*b_emlrt_marshallIn(const mxArray *src,
                                     const emlrtMsgIdentifier *msgId))[8];

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T **ret_data, int32_T ret_size[2]);

static void d_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T **ret_data, int32_T ret_size[2]);

static void emlrt_marshallIn(const mxArray *PL, const char_T *identifier,
                             real32_T **y_data, int32_T y_size[2]);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             real32_T **y_data, int32_T y_size[2]);

static real32_T (*emlrt_marshallIn(const mxArray *Local_Estimates,
                                   const char_T *identifier))[8];

static real32_T (*emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[8];

static const mxArray *emlrt_marshallOut(const real32_T u_data[],
                                        const int32_T u_size[2]);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *PI_Time_fine,
                               const char_T *identifier, real32_T **y_data,
                               int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  real32_T *b;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(PI_Time_fine), &thisId, &b, y_size);
  *y_data = b;
  emlrtDestroyArray(&PI_Time_fine);
}

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T **y_data, int32_T y_size[2])
{
  d_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static real32_T (*b_emlrt_marshallIn(const mxArray *src,
                                     const emlrtMsgIdentifier *msgId))[8]
{
  static const int32_T dims[1]{8};
  real32_T(*ret)[8];
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                          (const char_T *)"single", false, 1U,
                          (void *)&dims[0]);
  ret = (real32_T(*)[8])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T **ret_data, int32_T ret_size[2])
{
  static const int32_T dims[2]{76800, 4};
  int32_T iv[2];
  const boolean_T bv[2]{true, false};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                            (const char_T *)"single", false, 2U,
                            (void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  *ret_data = (real32_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

static void d_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T **ret_data, int32_T ret_size[2])
{
  static const int32_T dims[2]{1, 801};
  int32_T iv[2];
  const boolean_T bv[2]{false, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                            (const char_T *)"single", false, 2U,
                            (void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  *ret_data = (real32_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const mxArray *PL, const char_T *identifier,
                             real32_T **y_data, int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  real32_T *b;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(PL), &thisId, &b, y_size);
  *y_data = b;
  emlrtDestroyArray(&PL);
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             real32_T **y_data, int32_T y_size[2])
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static real32_T (*emlrt_marshallIn(const mxArray *Local_Estimates,
                                   const char_T *identifier))[8]
{
  emlrtMsgIdentifier thisId;
  real32_T(*y)[8];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(Local_Estimates), &thisId);
  emlrtDestroyArray(&Local_Estimates);
  return y;
}

static real32_T (*emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[8]
{
  real32_T(*y)[8];
  y = b_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *emlrt_marshallOut(const real32_T u_data[],
                                        const int32_T u_size[2])
{
  static const int32_T iv[2]{0, 0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m, &u_size[0], 2);
  emlrtAssign(&y, m);
  return y;
}

void TTCM_analytic_Multi_GPU_api(c_TTCM_analytic_Multi_GPUStackD *SD,
                                 const mxArray *const prhs[3],
                                 const mxArray *plhs[1])
{
  int32_T Ct_size[2];
  int32_T PI_Time_fine_size[2];
  int32_T PL_size[2];
  real32_T(*Ct_data)[61516800];
  real32_T(*PL_data)[307200];
  real32_T(*PI_Time_fine_data)[801];
  real32_T(*Local_Estimates)[8];
  Ct_data = (real32_T(*)[61516800])mxMalloc(sizeof(real32_T[61516800]));
  // Marshall function inputs
  emlrt_marshallIn(emlrtAlias(prhs[0]), "PL", (real32_T **)&PL_data, PL_size);
  b_emlrt_marshallIn(emlrtAlias(prhs[1]), "PI_Time_fine",
                     (real32_T **)&PI_Time_fine_data, PI_Time_fine_size);
  Local_Estimates = emlrt_marshallIn(emlrtAlias(prhs[2]), "Local_Estimates");
  // Invoke the target function
  TTCM_analytic_Multi_GPU(SD, *PL_data, PL_size, *PI_Time_fine_data,
                          PI_Time_fine_size, *Local_Estimates, *Ct_data,
                          Ct_size);
  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(*Ct_data, Ct_size);
}

// End of code generation (_coder_TTCM_analytic_Multi_GPU_api.cu)

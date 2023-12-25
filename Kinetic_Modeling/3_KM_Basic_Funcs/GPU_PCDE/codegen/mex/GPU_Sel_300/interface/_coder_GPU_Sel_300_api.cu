//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_GPU_Sel_300_api.cu
//
// Code generation for function '_coder_GPU_Sel_300_api'
//

// Include files
#include "_coder_GPU_Sel_300_api.h"
#include "GPU_Sel_300.h"
#include "GPU_Sel_300_data.h"
#include "rt_nonfinite.h"
#include "rtwhalf.h"

// Function Declarations
static real32_T (*b_emlrt_marshallIn(const mxArray *true_db_sub_s,
                                     const char_T *identifier))[17000];

static real32_T (*b_emlrt_marshallIn(
    const mxArray *u, const emlrtMsgIdentifier *parentId))[17000];

static real_T c_emlrt_marshallIn(const mxArray *s, const char_T *identifier);

static real_T c_emlrt_marshallIn(const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static real32_T (*d_emlrt_marshallIn(const mxArray *src,
                                     const emlrtMsgIdentifier *msgId))[4352];

static real32_T (*e_emlrt_marshallIn(const mxArray *src,
                                     const emlrtMsgIdentifier *msgId))[17000];

static real32_T (*emlrt_marshallIn(const mxArray *Gpu_Input_Bed_r,
                                   const char_T *identifier))[4352];

static real32_T (*emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[4352];

static const mxArray *emlrt_marshallOut(const real16_T u[153600]);

static real_T f_emlrt_marshallIn(const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

// Function Definitions
static real32_T (*b_emlrt_marshallIn(const mxArray *true_db_sub_s,
                                     const char_T *identifier))[17000]
{
  emlrtMsgIdentifier thisId;
  real32_T(*y)[17000];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(true_db_sub_s), &thisId);
  emlrtDestroyArray(&true_db_sub_s);
  return y;
}

static real32_T (*b_emlrt_marshallIn(const mxArray *u,
                                     const emlrtMsgIdentifier *parentId))[17000]
{
  real32_T(*y)[17000];
  y = e_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T c_emlrt_marshallIn(const mxArray *s, const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = c_emlrt_marshallIn(emlrtAlias(s), &thisId);
  emlrtDestroyArray(&s);
  return y;
}

static real_T c_emlrt_marshallIn(const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = f_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real32_T (*d_emlrt_marshallIn(const mxArray *src,
                                     const emlrtMsgIdentifier *msgId))[4352]
{
  static const int32_T dims[2]{256, 17};
  real32_T(*ret)[4352];
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                          (const char_T *)"single", false, 2U,
                          (void *)&dims[0]);
  ret = (real32_T(*)[4352])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real32_T (*e_emlrt_marshallIn(const mxArray *src,
                                     const emlrtMsgIdentifier *msgId))[17000]
{
  static const int32_T dims[2]{1000, 17};
  real32_T(*ret)[17000];
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                          (const char_T *)"single", false, 2U,
                          (void *)&dims[0]);
  ret = (real32_T(*)[17000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real32_T (*emlrt_marshallIn(const mxArray *Gpu_Input_Bed_r,
                                   const char_T *identifier))[4352]
{
  emlrtMsgIdentifier thisId;
  real32_T(*y)[4352];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(Gpu_Input_Bed_r), &thisId);
  emlrtDestroyArray(&Gpu_Input_Bed_r);
  return y;
}

static real32_T (*emlrt_marshallIn(const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[4352]
{
  real32_T(*y)[4352];
  y = d_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *emlrt_marshallOut(const real16_T u[153600])
{
  static const int32_T iv[2]{0, 0};
  static const int32_T iv1[2]{300, 512};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxHALF_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m, &iv1[0], 2);
  emlrtAssign(&y, m);
  return y;
}

static real_T f_emlrt_marshallIn(const mxArray *src,
                                 const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  real_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                          (const char_T *)"double", false, 0U, (void *)&dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void GPU_Sel_300_api(const mxArray *const prhs[3], const mxArray *plhs[1])
{
  real_T s;
  real32_T(*true_db_sub_s)[17000];
  real32_T(*Gpu_Input_Bed_r)[4352];
  real16_T(*params_s_sum_GPU)[153600];
  params_s_sum_GPU = (real16_T(*)[153600])mxMalloc(sizeof(real16_T[153600]));
  // Marshall function inputs
  Gpu_Input_Bed_r = emlrt_marshallIn(emlrtAlias(prhs[0]), "Gpu_Input_Bed_r");
  true_db_sub_s = b_emlrt_marshallIn(emlrtAlias(prhs[1]), "true_db_sub_s");
  s = c_emlrt_marshallIn(emlrtAliasP(prhs[2]), "s");
  // Invoke the target function
  GPU_Sel_300(*Gpu_Input_Bed_r, *true_db_sub_s, s, *params_s_sum_GPU);
  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(*params_s_sum_GPU);
}

// End of code generation (_coder_GPU_Sel_300_api.cu)

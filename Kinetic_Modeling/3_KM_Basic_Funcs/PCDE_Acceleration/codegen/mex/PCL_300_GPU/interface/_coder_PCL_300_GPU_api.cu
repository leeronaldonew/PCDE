//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_PCL_300_GPU_api.cu
//
// Code generation for function '_coder_PCL_300_GPU_api'
//

// Include files
#include "_coder_PCL_300_GPU_api.h"
#include "PCL_300_GPU.h"
#include "PCL_300_GPU_data.h"
#include "PCL_300_GPU_types.h"
#include "rt_nonfinite.h"

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *Slice_TACs,
                               const char_T *identifier, real32_T **y_data,
                               int32_T y_size[2]);

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T **y_data, int32_T y_size[2]);

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T **ret_data, int32_T ret_size[2]);

static void d_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T **ret_data, int32_T ret_size[2]);

static void emlrt_marshallIn(const mxArray *DB, const char_T *identifier,
                             real32_T **y_data, int32_T y_size[2]);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             real32_T **y_data, int32_T y_size[2]);

static const mxArray *emlrt_marshallOut(const real32_T u_data[],
                                        const int32_T u_size[2]);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *Slice_TACs,
                               const char_T *identifier, real32_T **y_data,
                               int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  real32_T *b;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(Slice_TACs), &thisId, &b, y_size);
  *y_data = b;
  emlrtDestroyArray(&Slice_TACs);
}

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T **y_data, int32_T y_size[2])
{
  d_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T **ret_data, int32_T ret_size[2])
{
  static const int32_T dims[2]{500000, 17};
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

static void d_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T **ret_data, int32_T ret_size[2])
{
  static const int32_T dims[2]{65536, 17};
  int32_T iv[2];
  const boolean_T bv[2]{true, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                            (const char_T *)"single", false, 2U,
                            (void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  *ret_data = (real32_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const mxArray *DB, const char_T *identifier,
                             real32_T **y_data, int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  real32_T *b;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(DB), &thisId, &b, y_size);
  *y_data = b;
  emlrtDestroyArray(&DB);
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             real32_T **y_data, int32_T y_size[2])
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
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

void PCL_300_GPU_api(PCL_300_GPUStackData *SD, const mxArray *const prhs[2],
                     const mxArray *plhs[1])
{
  int32_T DB_size[2];
  int32_T Ind_300_size[2];
  int32_T Slice_TACs_size[2];
  real32_T(*Ind_300_data)[19660800];
  real32_T(*DB_data)[8500000];
  real32_T(*Slice_TACs_data)[1114112];
  Ind_300_data = (real32_T(*)[19660800])mxMalloc(sizeof(real32_T[19660800]));
  // Marshall function inputs
  emlrt_marshallIn(emlrtAlias(prhs[0]), "DB", (real32_T **)&DB_data, DB_size);
  b_emlrt_marshallIn(emlrtAlias(prhs[1]), "Slice_TACs",
                     (real32_T **)&Slice_TACs_data, Slice_TACs_size);
  // Invoke the target function
  PCL_300_GPU(SD, *DB_data, DB_size, *Slice_TACs_data, Slice_TACs_size,
              *Ind_300_data, Ind_300_size);
  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(*Ind_300_data, Ind_300_size);
}

// End of code generation (_coder_PCL_300_GPU_api.cu)

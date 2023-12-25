//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_Squared_Difference_GPU_api.cu
//
// Code generation for function '_coder_Squared_Difference_GPU_api'
//

// Include files
#include "_coder_Squared_Difference_GPU_api.h"
#include "Squared_Difference_GPU.h"
#include "Squared_Difference_GPU_data.h"
#include "Squared_Difference_GPU_emxutil.h"
#include "Squared_Difference_GPU_types.h"
#include "rt_nonfinite.h"
#include "rtwhalf.h"

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret);

static void emlrt_marshallIn(const mxArray *true_database,
                             const char_T *identifier, emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *Meas_Cts_temp,
                             const char_T *identifier, emxArray_real_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real_T *y);

static const mxArray *emlrt_marshallOut(const emxArray_real16_T *u);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret)
{
  static const int32_T dims[2]{-1, -1};
  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2]{true, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                            (const char_T *)"single", false, 2U,
                            (void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real32_T(ret, i);
  ret->data = (real32_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret)
{
  static const int32_T dims[2]{1, -1};
  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2]{false, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src,
                            (const char_T *)"double", false, 2U,
                            (void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(ret, i);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const mxArray *true_database,
                             const char_T *identifier, emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(true_database), &thisId, y);
  emlrtDestroyArray(&true_database);
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *Meas_Cts_temp,
                             const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(Meas_Cts_temp), &thisId, y);
  emlrtDestroyArray(&Meas_Cts_temp);
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *emlrt_marshallOut(const emxArray_real16_T *u)
{
  static const int32_T iv[2]{0, 0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxHALF_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 2);
  emlrtAssign(&y, m);
  return y;
}

void Squared_Difference_GPU_api(const mxArray *const prhs[2],
                                const mxArray *plhs[1])
{
  emxArray_real16_T *Squ_diff;
  emxArray_real32_T *true_database;
  emxArray_real_T *Meas_Cts_temp;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real32_T(&true_database, 2, true);
  emxInit_real_T(&Meas_Cts_temp, 2, true);
  emxInit_real16_T(&Squ_diff, 2, true);
  // Marshall function inputs
  true_database->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "true_database", true_database);
  Meas_Cts_temp->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[1]), "Meas_Cts_temp", Meas_Cts_temp);
  // Invoke the target function
  Squared_Difference_GPU(true_database, Meas_Cts_temp, Squ_diff);
  // Marshall function outputs
  Squ_diff->canFreeData = false;
  plhs[0] = emlrt_marshallOut(Squ_diff);
  emxFree_real16_T(&Squ_diff);
  emxFree_real_T(&Meas_Cts_temp);
  emxFree_real32_T(&true_database);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

// End of code generation (_coder_Squared_Difference_GPU_api.cu)

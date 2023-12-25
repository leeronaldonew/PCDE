/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_select_min_distance_ind_api.c
 *
 * Code generation for function '_coder_select_min_distance_ind_api'
 *
 */

/* Include files */
#include "_coder_select_min_distance_ind_api.h"
#include "rt_nonfinite.h"
#include "select_min_distance_ind.h"
#include "select_min_distance_ind_data.h"
#include "select_min_distance_ind_emxutil.h"
#include "select_min_distance_ind_types.h"

/* Variable Definitions */
static emlrtRTEInfo e_emlrtRTEI = {
    1,                                    /* lineNo */
    1,                                    /* colNo */
    "_coder_select_min_distance_ind_api", /* fName */
    ""                                    /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y);

static const mxArray *b_emlrt_marshallOut(const real_T u);

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *X,
                             const char_T *identifier, emxArray_real32_T *y);

static const mxArray *emlrt_marshallOut(const real32_T u);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y)
{
  c_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *b_emlrt_marshallOut(const real_T u)
{
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m);
  return y;
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret)
{
  static const int32_T dims[2] = {94109400, -1};
  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2] = {false, true};
  emlrtCheckVsBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"single",
                            false, 2U, (void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real32_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  ret->data = (real32_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *X,
                             const char_T *identifier, emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(X), &thisId, y);
  emlrtDestroyArray(&X);
}

static const mxArray *emlrt_marshallOut(const real32_T u)
{
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m) = u;
  emlrtAssign(&y, m);
  return y;
}

void select_min_distance_ind_api(c_select_min_distance_indStackD *SD,
                                 const mxArray *const prhs[2], int32_T nlhs,
                                 const mxArray *plhs[2])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  emxArray_real32_T *X;
  emxArray_real32_T *Y;
  real_T ind;
  real32_T min_val;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real32_T(&st, &X, &e_emlrtRTEI);
  emxInit_real32_T(&st, &Y, &e_emlrtRTEI);
  /* Marshall function inputs */
  X->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "X", X);
  Y->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "Y", Y);
  /* Invoke the target function */
  select_min_distance_ind(SD, &st, X, Y, &min_val, &ind);
  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(min_val);
  emxFree_real32_T(&st, &Y);
  emxFree_real32_T(&st, &X);
  if (nlhs > 1) {
    plhs[1] = b_emlrt_marshallOut(ind);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_select_min_distance_ind_api.c) */

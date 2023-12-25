/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_Comp_Ct_Database_Meas_api.c
 *
 * Code generation for function '_coder_Comp_Ct_Database_Meas_api'
 *
 */

/* Include files */
#include "_coder_Comp_Ct_Database_Meas_api.h"
#include "Comp_Ct_Database_Meas.h"
#include "Comp_Ct_Database_Meas_data.h"
#include "Comp_Ct_Database_Meas_emxutil.h"
#include "Comp_Ct_Database_Meas_types.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo l_emlrtRTEI = {
    1,                                  /* lineNo */
    1,                                  /* colNo */
    "_coder_Comp_Ct_Database_Meas_api", /* fName */
    ""                                  /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y);

static const mxArray *b_emlrt_marshallOut(const real_T u_data[],
                                          const int32_T *u_size);

static void c_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *Meas_Cts_temp,
                               const char_T *identifier, emxArray_real_T *y);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real_T *y);

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *true_database,
                             const char_T *identifier, emxArray_real32_T *y);

static const mxArray *emlrt_marshallOut(const real32_T u_data[],
                                        const int32_T *u_size);

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y)
{
  e_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *b_emlrt_marshallOut(const real_T u_data[],
                                          const int32_T *u_size)
{
  static const int32_T i = 0;
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateNumericArray(1, (const void *)&i, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m, u_size, 1);
  emlrtAssign(&y, m);
  return y;
}

static void c_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *Meas_Cts_temp,
                               const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(Meas_Cts_temp), &thisId, y);
  emlrtDestroyArray(&Meas_Cts_temp);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real_T *y)
{
  f_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret)
{
  static const int32_T dims[2] = {-1, -1};
  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2] = {true, true};
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

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *true_database,
                             const char_T *identifier, emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(true_database), &thisId, y);
  emlrtDestroyArray(&true_database);
}

static const mxArray *emlrt_marshallOut(const real32_T u_data[],
                                        const int32_T *u_size)
{
  static const int32_T i = 0;
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateNumericArray(1, (const void *)&i, mxSINGLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m, u_size, 1);
  emlrtAssign(&y, m);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real_T *ret)
{
  static const int32_T dims[2] = {1, -1};
  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2] = {false, true};
  emlrtCheckVsBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                            false, 2U, (void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

void Comp_Ct_Database_Meas_api(const mxArray *const prhs[2], int32_T nlhs,
                               const mxArray *plhs[2])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  emxArray_real32_T *true_database;
  emxArray_real_T *Meas_Cts_temp;
  real_T(*sort_ind_data)[300];
  int32_T sort_ind_size;
  int32_T sort_val_size;
  real32_T(*sort_val_data)[300];
  st.tls = emlrtRootTLSGlobal;
  sort_val_data = (real32_T(*)[300])mxMalloc(sizeof(real32_T[300]));
  sort_ind_data = (real_T(*)[300])mxMalloc(sizeof(real_T[300]));
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real32_T(&st, &true_database, 2, &l_emlrtRTEI);
  emxInit_real_T(&st, &Meas_Cts_temp, &l_emlrtRTEI);
  /* Marshall function inputs */
  true_database->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "true_database", true_database);
  Meas_Cts_temp->canFreeData = false;
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "Meas_Cts_temp", Meas_Cts_temp);
  /* Invoke the target function */
  Comp_Ct_Database_Meas(&st, true_database, Meas_Cts_temp, *sort_val_data,
                        *(int32_T(*)[1]) & sort_val_size, *sort_ind_data,
                        *(int32_T(*)[1]) & sort_ind_size);
  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*sort_val_data, &sort_val_size);
  emxFree_real_T(&st, &Meas_Cts_temp);
  emxFree_real32_T(&st, &true_database);
  if (nlhs > 1) {
    plhs[1] = b_emlrt_marshallOut(*sort_ind_data, &sort_ind_size);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_Comp_Ct_Database_Meas_api.c) */

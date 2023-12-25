/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * select_min_distance_ind.c
 *
 * Code generation for function 'select_min_distance_ind'
 *
 */

/* Include files */
#include "select_min_distance_ind.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"
#include "select_min_distance_ind_data.h"
#include "select_min_distance_ind_emxutil.h"
#include "select_min_distance_ind_types.h"
#include "mwmathutil.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = {
    2,                         /* lineNo */
    "select_min_distance_ind", /* fcnName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\select_min_distance_ind.m" /* pathName */
};

static emlrtRSInfo b_emlrtRSI =
    {
        18,    /* lineNo */
        "abs", /* fcnName */
        "C:\\Program "
        "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\elfun\\abs.m" /* pathName
                                                                          */
};

static emlrtRSInfo c_emlrtRSI = {
    74,                    /* lineNo */
    "applyScalarFunction", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\eml\\+coder\\+"
    "internal\\applyScalarFunction.m" /* pathName */
};

static emlrtRSInfo d_emlrtRSI = {
    21,                               /* lineNo */
    "eml_int_forloop_overflow_check", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\eml\\eml_int_forloop_"
    "overflow_check.m" /* pathName */
};

static emlrtECInfo emlrtECI = {
    2,                         /* nDims */
    2,                         /* lineNo */
    32,                        /* colNo */
    "select_min_distance_ind", /* fName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\select_min_distance_ind.m" /* pName */
};

static emlrtRTEInfo b_emlrtRTEI = {
    2,                         /* lineNo */
    32,                        /* colNo */
    "select_min_distance_ind", /* fName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\select_min_distance_ind.m" /* pName */
};

static emlrtRTEInfo c_emlrtRTEI = {
    30,                    /* lineNo */
    21,                    /* colNo */
    "applyScalarFunction", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\eml\\+coder\\+"
    "internal\\applyScalarFunction.m" /* pName */
};

static emlrtRTEInfo d_emlrtRTEI = {
    2,                         /* lineNo */
    28,                        /* colNo */
    "select_min_distance_ind", /* fName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\select_min_distance_ind.m" /* pName */
};

/* Function Declarations */
static void minus(const emlrtStack *sp, emxArray_real32_T *x,
                  const emxArray_real32_T *X, const emxArray_real32_T *Y);

/* Function Definitions */
static void minus(const emlrtStack *sp, emxArray_real32_T *x,
                  const emxArray_real32_T *X, const emxArray_real32_T *Y)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T i;
  int32_T i1;
  int32_T loop_ub;
  int32_T stride_0_1;
  int32_T stride_1_1;
  const real32_T *X_data;
  const real32_T *Y_data;
  real32_T *x_data;
  Y_data = Y->data;
  X_data = X->data;
  i = x->size[0] * x->size[1];
  x->size[0] = 94109400;
  if (Y->size[1] == 1) {
    x->size[1] = X->size[1];
  } else {
    x->size[1] = Y->size[1];
  }
  emxEnsureCapacity_real32_T(sp, x, i, &b_emlrtRTEI);
  x_data = x->data;
  stride_0_1 = (X->size[1] != 1);
  stride_1_1 = (Y->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (Y->size[1] == 1) {
    loop_ub = X->size[1];
  } else {
    loop_ub = Y->size[1];
  }
  for (i = 0; i < loop_ub; i++) {
    for (i1 = 0; i1 < 94109400; i1++) {
      x_data[i1 + 94109400 * i] =
          X_data[i1 + 94109400 * aux_0_1] - Y_data[i1 + 94109400 * aux_1_1];
    }
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

emlrtCTX emlrtGetRootTLSGlobal(void)
{
  return emlrtRootTLSGlobal;
}

void emlrtLockerFunction(EmlrtLockeeFunction aLockee, emlrtConstCTX aTLS,
                         void *aData)
{
  omp_set_lock(&emlrtLockGlobal);
  emlrtCallLockeeFunction(aLockee, aTLS, aData);
  omp_unset_lock(&emlrtLockGlobal);
}

void select_min_distance_ind(c_select_min_distance_indStackD *SD,
                             const emlrtStack *sp, const emxArray_real32_T *X,
                             const emxArray_real32_T *Y, real32_T *min_val,
                             real_T *ind)
{
  jmp_buf *volatile emlrtJBStack;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack st;
  emxArray_real32_T *x;
  emxArray_real32_T *y;
  int32_T i;
  int32_T k;
  int32_T nx;
  int32_T vlen;
  int32_T xj;
  const real32_T *X_data;
  const real32_T *Y_data;
  real32_T f;
  real32_T *x_data;
  real32_T *y_data;
  boolean_T exitg1;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  Y_data = Y->data;
  X_data = X->data;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtCTX)sp);
  if ((X->size[1] != Y->size[1]) && ((X->size[1] != 1) && (Y->size[1] != 1))) {
    emlrtDimSizeImpxCheckR2021b(X->size[1], Y->size[1], &emlrtECI,
                                (emlrtCTX)sp);
  }
  emxInit_real32_T(sp, &y, &d_emlrtRTEI);
  st.site = &emlrtRSI;
  emxInit_real32_T(&st, &x, &b_emlrtRTEI);
  if (X->size[1] == Y->size[1]) {
    vlen = x->size[0] * x->size[1];
    x->size[0] = 94109400;
    x->size[1] = X->size[1];
    emxEnsureCapacity_real32_T(&st, x, vlen, &b_emlrtRTEI);
    x_data = x->data;
    nx = 94109400 * X->size[1];
    if (nx < 1600) {
      for (i = 0; i < nx; i++) {
        x_data[i] = X_data[i] - Y_data[i];
      }
    } else {
      emlrtEnterParallelRegion(&st, omp_in_parallel());
      emlrtPushJmpBuf(&st, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    st.tls, omp_in_parallel(), omp_get_max_threads(), 16))

      for (i = 0; i < nx; i++) {
        x_data[i] = X_data[i] - Y_data[i];
      }
      emlrtPopJmpBuf(&st, &emlrtJBStack);
      emlrtExitParallelRegion(&st, omp_in_parallel());
    }
  } else {
    b_st.site = &emlrtRSI;
    minus(&b_st, x, X, Y);
    x_data = x->data;
  }
  b_st.site = &b_emlrtRSI;
  nx = 94109400 * x->size[1];
  vlen = y->size[0] * y->size[1];
  y->size[0] = 94109400;
  y->size[1] = x->size[1];
  emxEnsureCapacity_real32_T(&b_st, y, vlen, &c_emlrtRTEI);
  y_data = y->data;
  c_st.site = &c_emlrtRSI;
  if ((1 <= nx) && (nx > 2147483646)) {
    d_st.site = &d_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }
  if (nx < 1600) {
    for (i = 0; i < nx; i++) {
      y_data[i] = muSingleScalarAbs(x_data[i]);
    }
  } else {
    emlrtEnterParallelRegion(&b_st, omp_in_parallel());
    emlrtPushJmpBuf(&b_st, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    b_st.tls, omp_in_parallel(), omp_get_max_threads(), 16))

    for (i = 0; i < nx; i++) {
      y_data[i] = muSingleScalarAbs(x_data[i]);
    }
    emlrtPopJmpBuf(&b_st, &emlrtJBStack);
    emlrtExitParallelRegion(&b_st, omp_in_parallel());
  }
  emxFree_real32_T(&b_st, &x);
  vlen = y->size[1];
  if (y->size[1] == 0) {
    emlrtEnterParallelRegion((emlrtCTX)sp, omp_in_parallel());
    emlrtPushJmpBuf((emlrtCTX)sp, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    sp->tls, omp_in_parallel(), omp_get_max_threads(), 16))

    for (i = 0; i < 94109400; i++) {
      SD->f0.varargin_1[i] = 0.0F;
    }
    emlrtPopJmpBuf((emlrtCTX)sp, &emlrtJBStack);
    emlrtExitParallelRegion((emlrtCTX)sp, omp_in_parallel());
  } else {
    emlrtEnterParallelRegion((emlrtCTX)sp, omp_in_parallel());
    emlrtPushJmpBuf((emlrtCTX)sp, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    sp->tls, omp_in_parallel(), omp_get_max_threads(), 16))

    for (i = 0; i < 94109400; i++) {
      SD->f0.varargin_1[i] = y_data[i];
    }
    emlrtPopJmpBuf((emlrtCTX)sp, &emlrtJBStack);
    emlrtExitParallelRegion((emlrtCTX)sp, omp_in_parallel());
    for (k = 2; k <= vlen; k++) {
      nx = (k - 1) * 94109400;
      for (xj = 0; xj < 94109400; xj++) {
        SD->f0.varargin_1[xj] += y_data[nx + xj];
      }
    }
  }
  emxFree_real32_T(sp, &y);
  if (!muSingleScalarIsNaN(SD->f0.varargin_1[0])) {
    nx = 1;
  } else {
    nx = 0;
    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k < 94109401)) {
      if (!muSingleScalarIsNaN(SD->f0.varargin_1[k - 1])) {
        nx = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }
  if (nx == 0) {
    *min_val = SD->f0.varargin_1[0];
    nx = 1;
  } else {
    *min_val = SD->f0.varargin_1[nx - 1];
    vlen = nx + 1;
    for (k = vlen; k < 94109401; k++) {
      f = SD->f0.varargin_1[k - 1];
      if (*min_val > f) {
        *min_val = f;
        nx = k;
      }
    }
  }
  *ind = nx;
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtCTX)sp);
}

/* End of code generation (select_min_distance_ind.c) */

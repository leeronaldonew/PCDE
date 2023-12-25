/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * extremeKElements.c
 *
 * Code generation for function 'extremeKElements'
 *
 */

/* Include files */
#include "extremeKElements.h"
#include "Comp_Ct_Database_Meas_data.h"
#include "Comp_Ct_Database_Meas_emxutil.h"
#include "Comp_Ct_Database_Meas_types.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"
#include "sortedInsertion.h"
#include "mwmathutil.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo o_emlrtRSI = {
    84,      /* lineNo */
    "exkib", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\extrem"
    "eKElements.m" /* pathName */
};

static emlrtRSInfo p_emlrtRSI = {
    85,      /* lineNo */
    "exkib", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\extrem"
    "eKElements.m" /* pathName */
};

static emlrtRSInfo q_emlrtRSI = {
    92,      /* lineNo */
    "exkib", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\extrem"
    "eKElements.m" /* pathName */
};

static emlrtRSInfo r_emlrtRSI = {
    97,      /* lineNo */
    "exkib", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\extrem"
    "eKElements.m" /* pathName */
};

static emlrtRSInfo
    s_emlrtRSI =
        {
            145,       /* lineNo */
            "sortIdx", /* fcnName */
            "C:\\Program "
            "Files\\MATLAB\\R2021b\\toolbox\\eml\\eml\\+coder\\+"
            "internal\\sortIdx.m" /* pathName */
};

static emlrtRSInfo t_emlrtRSI =
    {
        57,          /* lineNo */
        "mergesort", /* fcnName */
        "C:\\Program "
        "Files\\MATLAB\\R2021b\\toolbox\\eml\\eml\\+coder\\+"
        "internal\\mergesort.m" /* pathName */
};

static emlrtRSInfo u_emlrtRSI =
    {
        113,         /* lineNo */
        "mergesort", /* fcnName */
        "C:\\Program "
        "Files\\MATLAB\\R2021b\\toolbox\\eml\\eml\\+coder\\+"
        "internal\\mergesort.m" /* pathName */
};

static emlrtRTEInfo i_emlrtRTEI = {
    84,                 /* lineNo */
    5,                  /* colNo */
    "extremeKElements", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\extrem"
    "eKElements.m" /* pName */
};

static emlrtRTEInfo j_emlrtRTEI =
    {
        52,          /* lineNo */
        9,           /* colNo */
        "mergesort", /* fName */
        "C:\\Program "
        "Files\\MATLAB\\R2021b\\toolbox\\eml\\eml\\+coder\\+"
        "internal\\mergesort.m" /* pName */
};

static emlrtRTEInfo k_emlrtRTEI =
    {
        52,          /* lineNo */
        1,           /* colNo */
        "mergesort", /* fName */
        "C:\\Program "
        "Files\\MATLAB\\R2021b\\toolbox\\eml\\eml\\+coder\\+"
        "internal\\mergesort.m" /* pName */
};

/* Function Definitions */
void exkib(const emlrtStack *sp, const emxArray_real32_T *a, int32_T k,
           int32_T idx_data[], int32_T *idx_size, real32_T b_data[],
           int32_T *b_size)
{
  jmp_buf *volatile emlrtJBStack;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack st;
  emxArray_int32_T *itmp;
  emxArray_int32_T *iwork;
  int32_T a__2;
  int32_T b_j;
  int32_T b_k;
  int32_T i;
  int32_T i2;
  int32_T j;
  int32_T kEnd;
  int32_T n;
  int32_T p;
  int32_T pEnd;
  int32_T q;
  int32_T qEnd;
  int32_T *itmp_data;
  int32_T *iwork_data;
  const real32_T *a_data;
  real32_T f;
  uint32_T unnamed_idx_0;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  a_data = a->data;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtCTX)sp);
  n = a->size[0];
  *idx_size = k;
  if (k < 1600) {
    if (0 <= k - 1) {
      memset(&idx_data[0], 0, k * sizeof(int32_T));
    }
  } else {
    emlrtEnterParallelRegion((emlrtCTX)sp, omp_in_parallel());
    emlrtPushJmpBuf((emlrtCTX)sp, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    sp->tls, omp_in_parallel(), omp_get_max_threads(), 16))

    for (j = 0; j < k; j++) {
      idx_data[j] = 0;
    }
    emlrtPopJmpBuf((emlrtCTX)sp, &emlrtJBStack);
    emlrtExitParallelRegion((emlrtCTX)sp, omp_in_parallel());
  }
  *b_size = k;
  if (k < 1600) {
    if (0 <= k - 1) {
      memset(&b_data[0], 0, k * sizeof(real32_T));
    }
  } else {
    emlrtEnterParallelRegion((emlrtCTX)sp, omp_in_parallel());
    emlrtPushJmpBuf((emlrtCTX)sp, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    sp->tls, omp_in_parallel(), omp_get_max_threads(), 16))

    for (j = 0; j < k; j++) {
      b_data[j] = 0.0F;
    }
    emlrtPopJmpBuf((emlrtCTX)sp, &emlrtJBStack);
    emlrtExitParallelRegion((emlrtCTX)sp, omp_in_parallel());
  }
  if (k != 0) {
    emxInit_int32_T(sp, &itmp, &i_emlrtRTEI);
    emxInit_int32_T(sp, &iwork, &k_emlrtRTEI);
    if ((k > 64) && (k > (a->size[0] >> 6))) {
      st.site = &o_emlrtRSI;
      n = a->size[0] + 1;
      unnamed_idx_0 = (uint32_T)a->size[0];
      a__2 = itmp->size[0];
      itmp->size[0] = a->size[0];
      emxEnsureCapacity_int32_T(&st, itmp, a__2, &i_emlrtRTEI);
      itmp_data = itmp->data;
      a__2 = a->size[0];
      if (a->size[0] < 1600) {
        for (j = 0; j < a__2; j++) {
          itmp_data[j] = 0;
        }
      } else {
        emlrtEnterParallelRegion(&st, omp_in_parallel());
        emlrtPushJmpBuf(&st, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    st.tls, omp_in_parallel(), omp_get_max_threads(), 16))

        for (j = 0; j < a__2; j++) {
          itmp_data[j] = 0;
        }
        emlrtPopJmpBuf(&st, &emlrtJBStack);
        emlrtExitParallelRegion(&st, omp_in_parallel());
      }
      if (a->size[0] != 0) {
        b_st.site = &s_emlrtRSI;
        a__2 = iwork->size[0];
        iwork->size[0] = (int32_T)unnamed_idx_0;
        emxEnsureCapacity_int32_T(&b_st, iwork, a__2, &j_emlrtRTEI);
        iwork_data = iwork->data;
        a__2 = a->size[0] - 1;
        c_st.site = &t_emlrtRSI;
        if ((1 <= a->size[0] - 1) && (a->size[0] - 1 > 2147483645)) {
          d_st.site = &l_emlrtRSI;
          check_forloop_overflow_error(&d_st);
        }
        for (b_k = 1; b_k <= a__2; b_k += 2) {
          if ((a_data[b_k - 1] <= a_data[b_k]) ||
              muSingleScalarIsNaN(a_data[b_k])) {
            itmp_data[b_k - 1] = b_k;
            itmp_data[b_k] = b_k + 1;
          } else {
            itmp_data[b_k - 1] = b_k + 1;
            itmp_data[b_k] = b_k;
          }
        }
        if ((a->size[0] & 1) != 0) {
          itmp_data[a->size[0] - 1] = a->size[0];
        }
        i = 2;
        while (i < n - 1) {
          i2 = i << 1;
          b_j = 1;
          for (pEnd = i + 1; pEnd < n; pEnd = qEnd + i) {
            p = b_j;
            q = pEnd - 1;
            qEnd = b_j + i2;
            if (qEnd > n) {
              qEnd = n;
            }
            b_k = 0;
            kEnd = qEnd - b_j;
            while (b_k + 1 <= kEnd) {
              f = a_data[itmp_data[q] - 1];
              a__2 = itmp_data[p - 1];
              if ((a_data[a__2 - 1] <= f) || muSingleScalarIsNaN(f)) {
                iwork_data[b_k] = a__2;
                p++;
                if (p == pEnd) {
                  while (q + 1 < qEnd) {
                    b_k++;
                    iwork_data[b_k] = itmp_data[q];
                    q++;
                  }
                }
              } else {
                iwork_data[b_k] = itmp_data[q];
                q++;
                if (q + 1 == qEnd) {
                  while (p < pEnd) {
                    b_k++;
                    iwork_data[b_k] = itmp_data[p - 1];
                    p++;
                  }
                }
              }
              b_k++;
            }
            c_st.site = &u_emlrtRSI;
            for (b_k = 0; b_k < kEnd; b_k++) {
              itmp_data[(b_j + b_k) - 1] = iwork_data[b_k];
            }
            b_j = qEnd;
          }
          i = i2;
        }
      }
      st.site = &p_emlrtRSI;
      if (k > 2147483646) {
        b_st.site = &l_emlrtRSI;
        check_forloop_overflow_error(&b_st);
      }
      if (k < 1600) {
        for (j = 0; j < k; j++) {
          idx_data[j] = itmp_data[j];
          b_data[j] = a_data[itmp_data[j] - 1];
        }
      } else {
        emlrtEnterParallelRegion((emlrtCTX)sp, omp_in_parallel());
        emlrtPushJmpBuf((emlrtCTX)sp, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    sp->tls, omp_in_parallel(), omp_get_max_threads(), 16))

        for (j = 0; j < k; j++) {
          idx_data[j] = itmp_data[j];
          b_data[j] = a_data[itmp_data[j] - 1];
        }
        emlrtPopJmpBuf((emlrtCTX)sp, &emlrtJBStack);
        emlrtExitParallelRegion((emlrtCTX)sp, omp_in_parallel());
      }
    } else {
      st.site = &q_emlrtRSI;
      for (b_j = 0; b_j < k; b_j++) {
        a__2 = b_j;
        sortedInsertion(a_data[b_j], b_j + 1, b_data, &a__2, k, idx_data);
      }
      a__2 = k + 1;
      st.site = &r_emlrtRSI;
      if ((k + 1 <= a->size[0]) && (a->size[0] > 2147483646)) {
        b_st.site = &l_emlrtRSI;
        check_forloop_overflow_error(&b_st);
      }
      for (b_j = a__2; b_j <= n; b_j++) {
        i = k;
        sortedInsertion(a_data[b_j - 1], b_j, b_data, &i, k, idx_data);
      }
    }
    emxFree_int32_T(sp, &iwork);
    emxFree_int32_T(sp, &itmp);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtCTX)sp);
}

/* End of code generation (extremeKElements.c) */

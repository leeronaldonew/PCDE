/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Comp_Ct_Database_Meas.c
 *
 * Code generation for function 'Comp_Ct_Database_Meas'
 *
 */

/* Include files */
#include "Comp_Ct_Database_Meas.h"
#include "Comp_Ct_Database_Meas_data.h"
#include "Comp_Ct_Database_Meas_emxutil.h"
#include "Comp_Ct_Database_Meas_types.h"
#include "eml_int_forloop_overflow_check.h"
#include "extremeKElements.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = {
    19,                      /* lineNo */
    "Comp_Ct_Database_Meas", /* fcnName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\Comp_Ct_Database_Meas.m" /* pathName */
};

static emlrtRSInfo b_emlrtRSI =
    {
        71,      /* lineNo */
        "power", /* fcnName */
        "C:\\Program "
        "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\ops\\power.m" /* pathName
                                                                          */
};

static emlrtRSInfo c_emlrtRSI = {
    20,    /* lineNo */
    "sum", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\sum.m" /* pathName
                                                                        */
};

static emlrtRSInfo d_emlrtRSI = {
    99,        /* lineNo */
    "sumprod", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumpro"
    "d.m" /* pathName */
};

static emlrtRSInfo e_emlrtRSI = {
    74,                      /* lineNo */
    "combineVectorElements", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combin"
    "eVectorElements.m" /* pathName */
};

static emlrtRSInfo f_emlrtRSI = {
    112,                /* lineNo */
    "blockedSummation", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pathName */
};

static emlrtRSInfo g_emlrtRSI = {
    173,                /* lineNo */
    "colMajorFlatIter", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pathName */
};

static emlrtRSInfo h_emlrtRSI = {
    192,                /* lineNo */
    "colMajorFlatIter", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pathName */
};

static emlrtRSInfo i_emlrtRSI = {
    207,                /* lineNo */
    "colMajorFlatIter", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pathName */
};

static emlrtRSInfo j_emlrtRSI = {
    227,                /* lineNo */
    "colMajorFlatIter", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pathName */
};

static emlrtRSInfo k_emlrtRSI = {
    238,                /* lineNo */
    "colMajorFlatIter", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pathName */
};

static emlrtRSInfo m_emlrtRSI = {
    9,      /* lineNo */
    "mink", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\mink.m" /* pathName
                                                                         */
};

static emlrtRSInfo n_emlrtRSI = {
    49,                 /* lineNo */
    "extremeKElements", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\extrem"
    "eKElements.m" /* pathName */
};

static emlrtECInfo emlrtECI = {
    2,                       /* nDims */
    19,                      /* lineNo */
    33,                      /* colNo */
    "Comp_Ct_Database_Meas", /* fName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\Comp_Ct_Database_Meas.m" /* pName */
};

static emlrtRTEInfo c_emlrtRTEI = {
    19,                      /* lineNo */
    33,                      /* colNo */
    "Comp_Ct_Database_Meas", /* fName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\Comp_Ct_Database_Meas.m" /* pName */
};

static emlrtRTEInfo d_emlrtRTEI = {
    19,                      /* lineNo */
    27,                      /* colNo */
    "Comp_Ct_Database_Meas", /* fName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\Comp_Ct_Database_Meas.m" /* pName */
};

static emlrtRTEInfo e_emlrtRTEI = {
    146,                /* lineNo */
    24,                 /* colNo */
    "blockedSummation", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pName */
};

static emlrtRTEInfo f_emlrtRTEI = {
    153,                /* lineNo */
    23,                 /* colNo */
    "blockedSummation", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pName */
};

static emlrtRTEInfo g_emlrtRTEI = {
    19,                      /* lineNo */
    32,                      /* colNo */
    "Comp_Ct_Database_Meas", /* fName */
    "C:\\Users\\LEE\\Documents\\MATLAB\\1_QURIT_Project\\Kinetic_"
    "Modeling\\Comp_Ct_Database_Meas.m" /* pName */
};

static emlrtRTEInfo h_emlrtRTEI = {
    153,                /* lineNo */
    1,                  /* colNo */
    "blockedSummation", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2021b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\blocke"
    "dSummation.m" /* pName */
};

/* Function Declarations */
static void binary_expand_op(const emlrtStack *sp, emxArray_real32_T *y,
                             const emxArray_real32_T *true_database,
                             const emxArray_real_T *Meas_Cts_temp);

/* Function Definitions */
static void binary_expand_op(const emlrtStack *sp, emxArray_real32_T *y,
                             const emxArray_real32_T *true_database,
                             const emxArray_real_T *Meas_Cts_temp)
{
  const real_T *Meas_Cts_temp_data;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b_loop_ub;
  int32_T i;
  int32_T i1;
  int32_T loop_ub;
  int32_T stride_0_1;
  int32_T stride_1_1;
  const real32_T *true_database_data;
  real32_T *y_data;
  Meas_Cts_temp_data = Meas_Cts_temp->data;
  true_database_data = true_database->data;
  i = y->size[0] * y->size[1];
  y->size[0] = true_database->size[0];
  if (Meas_Cts_temp->size[1] == 1) {
    y->size[1] = true_database->size[1];
  } else {
    y->size[1] = Meas_Cts_temp->size[1];
  }
  emxEnsureCapacity_real32_T(sp, y, i, &c_emlrtRTEI);
  y_data = y->data;
  stride_0_1 = (true_database->size[1] != 1);
  stride_1_1 = (Meas_Cts_temp->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (Meas_Cts_temp->size[1] == 1) {
    loop_ub = true_database->size[1];
  } else {
    loop_ub = Meas_Cts_temp->size[1];
  }
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = true_database->size[0];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      y_data[i1 + y->size[0] * i] =
          true_database_data[i1 + true_database->size[0] * aux_0_1] -
          (real32_T)Meas_Cts_temp_data[aux_1_1];
    }
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

void Comp_Ct_Database_Meas(const emlrtStack *sp,
                           const emxArray_real32_T *true_database,
                           const emxArray_real_T *Meas_Cts_temp,
                           real32_T sort_val_data[], int32_T sort_val_size[1],
                           real_T sort_ind_data[], int32_T sort_ind_size[1])
{
  jmp_buf *volatile emlrtJBStack;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
  emlrtStack st;
  emxArray_real32_T *a;
  emxArray_real32_T *bsum;
  emxArray_real32_T *y;
  const real_T *Meas_Cts_temp_data;
  int32_T idx_data[300];
  int32_T b_xj;
  int32_T bvstride;
  int32_T firstBlockLength;
  int32_T hi;
  int32_T i;
  int32_T i1;
  int32_T ib;
  int32_T k;
  int32_T lastBlockLength;
  int32_T nblocks;
  int32_T vstride;
  int32_T xj;
  int32_T xoffset;
  const real32_T *true_database_data;
  real32_T b_varargin_1;
  real32_T varargin_1;
  real32_T *a_data;
  real32_T *bsum_data;
  real32_T *y_data;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  f_st.prev = &e_st;
  f_st.tls = e_st.tls;
  g_st.prev = &f_st;
  g_st.tls = f_st.tls;
  h_st.prev = &g_st;
  h_st.tls = g_st.tls;
  Meas_Cts_temp_data = Meas_Cts_temp->data;
  true_database_data = true_database->data;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtCTX)sp);
  /* coder.gpu.kernelfun(); */
  /* true_database=single(ones(100000000,20)); */
  /* Meas_Cts_temp=double(ones(1,20)); */
  /* tic; */
  /* [sort_val,sort_ind] =
   * sort(sum(abs(gpuArray(true_database)-single(repmat(gpuArray(single(Meas_Cts_temp)),
   * size(true_database,1),1))).^2,2)); */
  /* toc; */
  /* tic; */
  /* [sort_val,sort_ind] =
   * sort(sum(abs(gpuArray(true_database)-single(repmat(gpuArray(Meas_Cts_temp),
   * size(true_database,1),1))).^2,2)); */
  /* toc; */
  /* tic; */
  if ((true_database->size[1] != Meas_Cts_temp->size[1]) &&
      ((true_database->size[1] != 1) && (Meas_Cts_temp->size[1] != 1))) {
    emlrtDimSizeImpxCheckR2021b(true_database->size[1], Meas_Cts_temp->size[1],
                                &emlrtECI, (emlrtCTX)sp);
  }
  emxInit_real32_T(sp, &y, 2, &g_emlrtRTEI);
  st.site = &emlrtRSI;
  b_st.site = &emlrtRSI;
  if (true_database->size[1] == Meas_Cts_temp->size[1]) {
    hi = y->size[0] * y->size[1];
    y->size[0] = true_database->size[0];
    y->size[1] = true_database->size[1];
    emxEnsureCapacity_real32_T(&b_st, y, hi, &c_emlrtRTEI);
    y_data = y->data;
    firstBlockLength = true_database->size[1];
    emlrtEnterParallelRegion(&b_st, omp_in_parallel());
    emlrtPushJmpBuf(&b_st, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    b_st.tls, omp_in_parallel(), omp_get_max_threads(), 16)) private(i1, xj)

    for (i = 0; i < firstBlockLength; i++) {
      xj = true_database->size[0];
      for (i1 = 0; i1 < xj; i1++) {
        y_data[i1 + y->size[0] * i] =
            true_database_data[i1 + true_database->size[0] * i] -
            (real32_T)Meas_Cts_temp_data[i];
      }
    }
    emlrtPopJmpBuf(&b_st, &emlrtJBStack);
    emlrtExitParallelRegion(&b_st, omp_in_parallel());
  } else {
    c_st.site = &emlrtRSI;
    binary_expand_op(&c_st, y, true_database, Meas_Cts_temp);
    y_data = y->data;
  }
  c_st.site = &b_emlrtRSI;
  firstBlockLength = y->size[0] * y->size[1];
  if (firstBlockLength < 1600) {
    for (i = 0; i < firstBlockLength; i++) {
      varargin_1 = y_data[i];
      y_data[i] = varargin_1 * varargin_1;
    }
  } else {
    emlrtEnterParallelRegion(&c_st, omp_in_parallel());
    emlrtPushJmpBuf(&c_st, &emlrtJBStack);
#pragma omp parallel for num_threads(                                          \
    emlrtAllocRegionTLSs(c_st.tls, omp_in_parallel(), omp_get_max_threads(),   \
                         16)) private(b_varargin_1)

    for (i = 0; i < firstBlockLength; i++) {
      b_varargin_1 = y_data[i];
      y_data[i] = b_varargin_1 * b_varargin_1;
    }
    emlrtPopJmpBuf(&c_st, &emlrtJBStack);
    emlrtExitParallelRegion(&c_st, omp_in_parallel());
  }
  b_st.site = &emlrtRSI;
  c_st.site = &c_emlrtRSI;
  d_st.site = &d_emlrtRSI;
  e_st.site = &e_emlrtRSI;
  emxInit_real32_T(&e_st, &a, 1, &d_emlrtRTEI);
  if ((y->size[0] == 0) || (y->size[1] == 0)) {
    hi = a->size[0];
    a->size[0] = y->size[0];
    emxEnsureCapacity_real32_T(&e_st, a, hi, &d_emlrtRTEI);
    a_data = a->data;
    firstBlockLength = y->size[0];
    if (y->size[0] < 1600) {
      for (i = 0; i < firstBlockLength; i++) {
        a_data[i] = 0.0F;
      }
    } else {
      emlrtEnterParallelRegion(&e_st, omp_in_parallel());
      emlrtPushJmpBuf(&e_st, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    e_st.tls, omp_in_parallel(), omp_get_max_threads(), 16))

      for (i = 0; i < firstBlockLength; i++) {
        a_data[i] = 0.0F;
      }
      emlrtPopJmpBuf(&e_st, &emlrtJBStack);
      emlrtExitParallelRegion(&e_st, omp_in_parallel());
    }
  } else {
    emxInit_real32_T(&e_st, &bsum, 1, &h_emlrtRTEI);
    f_st.site = &f_emlrtRSI;
    vstride = y->size[0];
    bvstride = y->size[0] << 10;
    hi = a->size[0];
    a->size[0] = y->size[0];
    emxEnsureCapacity_real32_T(&f_st, a, hi, &e_emlrtRTEI);
    a_data = a->data;
    hi = bsum->size[0];
    bsum->size[0] = y->size[0];
    emxEnsureCapacity_real32_T(&f_st, bsum, hi, &f_emlrtRTEI);
    bsum_data = bsum->data;
    if (y->size[1] <= 1024) {
      firstBlockLength = y->size[1];
      lastBlockLength = 0;
      nblocks = 1;
    } else {
      firstBlockLength = 1024;
      nblocks = y->size[1] / 1024;
      lastBlockLength = y->size[1] - (nblocks << 10);
      if (lastBlockLength > 0) {
        nblocks++;
      } else {
        lastBlockLength = 1024;
      }
    }
    g_st.site = &g_emlrtRSI;
    if (y->size[0] > 2147483646) {
      h_st.site = &l_emlrtRSI;
      check_forloop_overflow_error(&h_st);
    }
    if (y->size[0] < 1600) {
      for (xj = 0; xj < vstride; xj++) {
        a_data[xj] = y_data[xj];
        bsum_data[xj] = 0.0F;
      }
    } else {
      emlrtEnterParallelRegion(&f_st, omp_in_parallel());
      emlrtPushJmpBuf(&f_st, &emlrtJBStack);
#pragma omp parallel for num_threads(emlrtAllocRegionTLSs(                     \
    f_st.tls, omp_in_parallel(), omp_get_max_threads(), 16))

      for (xj = 0; xj < vstride; xj++) {
        a_data[xj] = y_data[xj];
        bsum_data[xj] = 0.0F;
      }
      emlrtPopJmpBuf(&f_st, &emlrtJBStack);
      emlrtExitParallelRegion(&f_st, omp_in_parallel());
    }
    for (k = 2; k <= firstBlockLength; k++) {
      xoffset = (k - 1) * vstride;
      g_st.site = &h_emlrtRSI;
      if (vstride > 2147483646) {
        h_st.site = &l_emlrtRSI;
        check_forloop_overflow_error(&h_st);
      }
      for (b_xj = 0; b_xj < vstride; b_xj++) {
        a_data[b_xj] += y_data[xoffset + b_xj];
      }
    }
    for (ib = 2; ib <= nblocks; ib++) {
      firstBlockLength = (ib - 1) * bvstride;
      g_st.site = &i_emlrtRSI;
      if (vstride > 2147483646) {
        h_st.site = &l_emlrtRSI;
        check_forloop_overflow_error(&h_st);
      }
      for (b_xj = 0; b_xj < vstride; b_xj++) {
        bsum_data[b_xj] = y_data[firstBlockLength + b_xj];
      }
      if (ib == nblocks) {
        hi = lastBlockLength;
      } else {
        hi = 1024;
      }
      for (k = 2; k <= hi; k++) {
        xoffset = firstBlockLength + (k - 1) * vstride;
        g_st.site = &j_emlrtRSI;
        for (b_xj = 0; b_xj < vstride; b_xj++) {
          bsum_data[b_xj] += y_data[xoffset + b_xj];
        }
      }
      g_st.site = &k_emlrtRSI;
      for (b_xj = 0; b_xj < vstride; b_xj++) {
        a_data[b_xj] += bsum_data[b_xj];
      }
    }
    emxFree_real32_T(&f_st, &bsum);
  }
  emxFree_real32_T(&e_st, &y);
  b_st.site = &m_emlrtRSI;
  c_st.site = &n_emlrtRSI;
  exkib(&c_st, a, muIntScalarMin_sint32(300, a->size[0]), idx_data,
        &firstBlockLength, sort_val_data, &sort_val_size[0]);
  sort_ind_size[0] = firstBlockLength;
  emxFree_real32_T(&st, &a);
  for (hi = 0; hi < firstBlockLength; hi++) {
    sort_ind_data[hi] = idx_data[hi];
  }
  /* toc; */
  /* tic; */
  /* size_db=size(true_database); */
  /* db_temp_gpu=gpuArray(single(zeros(size_db(1)/10,size_db(2)))); */
  /* repmat_gpu=gpuArray(repmat(single(Meas_Cts_temp),size_db(1)/10,1)); */
  /* sum_gpu=gpuArray(single(zeros(size_db(1),1))); */
  /* for b=1:1:10 */
  /*     db_temp_gpu=gpuArray(true_database(((b-1)*size_db(1)/10)+1:(size_db(1)/10)*b,:));
   */
  /*     sum_gpu_temp=sum((db_temp_gpu-repmat_gpu).^(2), 2);    */
  /*     if b==1 */
  /*         sum_gpu=sum_gpu_temp; */
  /*     else */
  /*         sum_gpu=cat(1,sum_gpu,sum_gpu_temp); */
  /*     end */
  /* end */
  /* [sort_val,sort_ind]=sort(sum_gpu); */
  /* toc;     */
  /* db_temp=half(zeros(100000,size(true_database,2))); */
  /* ind=half(zeros(size(Meas_Cts_temp,1),1)); */
  /* for i=1:1:size(Meas_Cts_temp,1) */
  /* db_temp=half(true_database( ((b-1)*100000+1):(b*100000),:)); */
  /*     [min_val,min_ind]=min(
   * single(sum((true_database-repmat(Meas_Cts_temp(i,:),
   * size(true_database,1),1)).^2,2)) ); */
  /*     ind(i,1)=half(min_ind+100000); */
  /* end */
  /* toc; */
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtCTX)sp);
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

/* End of code generation (Comp_Ct_Database_Meas.c) */

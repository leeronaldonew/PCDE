/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sortedInsertion.c
 *
 * Code generation for function 'sortedInsertion'
 *
 */

/* Include files */
#include "sortedInsertion.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"

/* Function Definitions */
void sortedInsertion(real32_T x, int32_T ix, real32_T b_data[], int32_T *nb,
                     int32_T blen, int32_T idx_data[])
{
  int32_T ja;
  int32_T jb;
  int32_T jc;
  if (*nb == 0) {
    *nb = 1;
    idx_data[0] = ix;
    b_data[0] = x;
  } else if ((x >= b_data[0]) || muSingleScalarIsNaN(x)) {
    if ((*nb > 1) && (!(x >= b_data[*nb - 1])) && (!muSingleScalarIsNaN(x))) {
      ja = 1;
      jb = *nb;
      while (ja < jb) {
        jc = ja + ((jb - ja) >> 1);
        if (jc == ja) {
          ja = jb;
        } else if ((x >= b_data[jc - 1]) || muSingleScalarIsNaN(x)) {
          ja = jc;
        } else {
          jb = jc;
        }
      }
      if (*nb < blen) {
        (*nb)++;
      }
      jb = ja + 1;
      for (jc = *nb; jc >= jb; jc--) {
        b_data[jc - 1] = b_data[jc - 2];
        idx_data[jc - 1] = idx_data[jc - 2];
      }
      b_data[ja - 1] = x;
      idx_data[ja - 1] = ix;
    } else if (*nb < blen) {
      (*nb)++;
      b_data[*nb - 1] = x;
      idx_data[*nb - 1] = ix;
    }
  } else {
    if (*nb < blen) {
      (*nb)++;
    }
    for (jc = *nb; jc >= 2; jc--) {
      idx_data[jc - 1] = idx_data[jc - 2];
      b_data[jc - 1] = b_data[jc - 2];
    }
    b_data[0] = x;
    idx_data[0] = ix;
  }
}

/* End of code generation (sortedInsertion.c) */

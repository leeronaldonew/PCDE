/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sortedInsertion.h
 *
 * Code generation for function 'sortedInsertion'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include "omp.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void sortedInsertion(real32_T x, int32_T ix, real32_T b_data[], int32_T *nb,
                     int32_T blen, int32_T idx_data[]);

/* End of code generation (sortedInsertion.h) */

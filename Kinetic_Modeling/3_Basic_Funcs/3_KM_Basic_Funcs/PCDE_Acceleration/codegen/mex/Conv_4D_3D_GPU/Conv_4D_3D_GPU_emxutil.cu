//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// Conv_4D_3D_GPU_emxutil.cu
//
// Code generation for function 'Conv_4D_3D_GPU_emxutil'
//

// Include files
#include "Conv_4D_3D_GPU_emxutil.h"
#include "Conv_4D_3D_GPU_data.h"
#include "Conv_4D_3D_GPU_types.h"
#include "rt_nonfinite.h"
#include <algorithm>

// Function Definitions
void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T oldNumel)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel *= emxArray->size[i];
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(real32_T));
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                (real32_T *)newData);
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = (real32_T *)newData;
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

void emxFree_real32_T(emxArray_real32_T **pEmxArray)
{
  if (*pEmxArray != (emxArray_real32_T *)nullptr) {
    if (((*pEmxArray)->data != (real32_T *)nullptr) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = (emxArray_real32_T *)nullptr;
  }
}

void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T numDimensions,
                      boolean_T doPush)
{
  emxArray_real32_T *emxArray;
  *pEmxArray =
      (emxArray_real32_T *)emlrtMallocEmxArray(sizeof(emxArray_real32_T));
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_real32_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = (real32_T *)nullptr;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex(sizeof(int32_T) * numDimensions);
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

// End of code generation (Conv_4D_3D_GPU_emxutil.cu)

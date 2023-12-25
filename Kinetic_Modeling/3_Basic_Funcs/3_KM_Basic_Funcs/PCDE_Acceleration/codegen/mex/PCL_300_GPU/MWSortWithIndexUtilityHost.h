/* Copyright 2018-2019 The MathWorks, Inc. */

#ifndef __MW_SORT_WITH_INDEX_UTIL_HOST_H__
#define __MW_SORT_WITH_INDEX_UTIL_HOST_H__

#ifdef __CUDACC__

#define CUB_IGNORE_DEPRECATED_CPP_DIALECT
#define THRUST_IGNORE_DEPRECATED_CPP_DIALECT

#include <thrust/sort.h>
#include <thrust/execution_policy.h>
#include <thrust/fill.h>
#include "MWSortFunctors.h"
#include "MWShuffleUtility.h"

#define BLOCK_SIZE 512

static __global__ void createSeqEdgeDimWithIndex(int* d_seq, double* d_ind, int s, int nelements);

static __global__ void createSeqOtherDimWithIndex(int* d_seq, double* d_ind, int s, int d, int nelements, int nelem2);

template <class T>
__global__ void shuffleColMajorWithIndex(T* d_key, T* d_key_out, double* d_ind, double* d_ind_out, int* shflStride, int* oldDim, int numDims, int nelements);

template <class T>
__global__ void shuffleRowMajorWithIndex(T* d_key, T* d_key_out, double* d_ind, double* d_ind_out, int* shflStride, int* oldDim, int numDims, int nelements);

template <class T>
void sortAlongEdgeDimWithIndex(T* d_key, double* d_ind, int s, const char dir, int nelements);

template <class T>
void sortAlongOtherDimWithIndex(T* d_key, double* d_ind, int numDims, const int* dims, int sortAlongDim, const char dir, int nelements, bool isRowMajor);

template <class T>
void callThrustSortByKeyWithIndex(T* d_key, double* d_ind, int* d_seq, const char dir, int nelements);

template <class T>
void callThrustSortByKeyWithIndexSimple(T* d_key, double* d_ind, int* d_seq, const char dir, int nelements);

template <class T>
void thrustSortImplWithIndex(T* d_key, double* d_ind, int numDims, const int* dims, int sortAlongDim, const char dir, bool isRowMajor);

static __global__ void createSeqEdgeDimWithIndex(int* d_seq, double* d_ind, int s, int nelements) {

    int ix = threadIdx.x + blockIdx.x * blockDim.x;
    if(ix < nelements) {
        d_seq[ix] = ix/s;
        d_ind[ix] = ix % s + 1;
    }
}

static __global__ void createSeqOtherDimWithIndex(int* d_seq, double* d_ind, int s, int d, int nelements, int nelem2) {

    int ix = threadIdx.x + blockIdx.x * blockDim.x;
    int off = 0;
    
    if(ix < nelements) {
        if(ix >= nelem2) {
            off = (ix/nelem2) * s;
        }
        d_seq[ix] = ix % s + off;
        d_ind[ix] = (ix/s) % d + 1;
    }
}

template <class T>
__global__ void shuffleColMajorWithIndex(T* d_key, T* d_key_out, double* d_ind, double* d_ind_out, int* shflStride, int* oldDim, int numDims, int nelements) {

    int ix = threadIdx.x + blockIdx.x * blockDim.x;
    int i = 0;
    int t = 0;
    int inIdx = ix;
    int outIdx = 0;

    if(ix < nelements) {
        while(i < numDims-1) {
            t = inIdx % oldDim[i];
            outIdx += (t * shflStride[i]);
            inIdx = (inIdx - t)/oldDim[i];
            i++;
        }
        outIdx += (inIdx * shflStride[i]);
        d_key_out[outIdx] = d_key[ix];
        d_ind_out[outIdx] = d_ind[ix];
     }
}

template <class T>
__global__ void shuffleRowMajorWithIndex(T* d_key, T* d_key_out, double* d_ind, double* d_ind_out, int* shflStride, int* oldDim, int numDims, int nelements) {

    int ix = threadIdx.x + blockIdx.x * blockDim.x;
    int i = numDims-1;
    int t = 0;
    int inIdx = ix;
    int outIdx = 0;

    if(ix < nelements) {
        while(i > 0) {
            t = inIdx % oldDim[i];
            outIdx += (t * shflStride[i]);
            inIdx = (inIdx - t)/oldDim[i];
            i--;
        }
        outIdx += (inIdx * shflStride[i]);
        d_key_out[outIdx] = d_key[ix];
        d_ind_out[outIdx] = d_ind[ix];
    }
}

template <class T>
void sortAlongEdgeDimWithIndex(T* d_key, double* d_ind, int s, const char dir, int nelements) {

    int *d_seq;
    cudaMalloc(&d_seq, sizeof(int) * nelements);
    
    dim3 dimBlock(BLOCK_SIZE, 1, 1);
    int numBlocksX = (nelements - 1) / BLOCK_SIZE + 1;
    dim3 dimGrid(numBlocksX, 1, 1);

    createSeqEdgeDimWithIndex<<<dimGrid,dimBlock>>>(d_seq, d_ind, s, nelements);
    cudaDeviceSynchronize();
    
    callThrustSortByKeyWithIndex<T>(d_key, d_ind, d_seq, dir, nelements);
    cudaFree(d_seq);
}

template <class T>
void sortAlongOtherDimWithIndex(T* d_key, double* d_ind, int numDims, const int* dims, int sortAlongDim, const char dir, int nelements, bool isRowMajor) {

    dim3 dimBlock(BLOCK_SIZE, 1, 1);
    int numBlocksX = (nelements - 1) / BLOCK_SIZE + 1;
    dim3 dimGrid(numBlocksX, 1, 1);

    int* oldDim = new int[numDims];
    int* stride = new int[numDims];
    int* shflStride = new int[numDims];
    int *d_seq;    
    T* d_key_out;
    double* d_ind_out;
    int* d_shflStride;
    int* d_oldDim;
    int nelem2;
    int s;
    int d;
    
    cudaMalloc(&d_seq    ,sizeof(int) * nelements);
    cudaMalloc(&d_key_out, sizeof(T)  * nelements);
    cudaMalloc(&d_ind_out, sizeof(double)* nelements);
    cudaMalloc(&d_shflStride, sizeof(int) * numDims);
    cudaMalloc(&d_oldDim, sizeof(int) * numDims);
        
    if(isRowMajor) {
        nelem2 = calcRowMajorStrideAndDim(dims, numDims, sortAlongDim, stride, shflStride, oldDim);
    } else {
        nelem2 = calcColMajorStrideAndDim(dims, numDims, sortAlongDim, stride, shflStride, oldDim);
    }

    s = stride[sortAlongDim];
    d = dims[sortAlongDim];
    createSeqOtherDimWithIndex<<<dimGrid,dimBlock>>>(d_seq, d_ind, s, d, nelements, nelem2);
    cudaDeviceSynchronize();
        
    callThrustSortByKeyWithIndex<T>(d_key, d_ind, d_seq, dir, nelements);
    
    cudaMemcpy(d_shflStride, shflStride, numDims * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_oldDim, oldDim, numDims * sizeof(int), cudaMemcpyHostToDevice);

    if(isRowMajor) {
        shuffleRowMajorWithIndex<T><<<dimGrid,dimBlock>>>(d_key, d_key_out, d_ind, d_ind_out, d_shflStride, d_oldDim, numDims, nelements);
    } else {
        shuffleColMajorWithIndex<T><<<dimGrid,dimBlock>>>(d_key, d_key_out, d_ind, d_ind_out, d_shflStride, d_oldDim, numDims, nelements);
    }
    cudaDeviceSynchronize();
    
    cudaMemcpy(d_key, d_key_out, nelements * sizeof(T), cudaMemcpyDeviceToDevice);
    cudaMemcpy(d_ind, d_ind_out, nelements * sizeof(double), cudaMemcpyDeviceToDevice);
    
    cudaFree(d_key_out);
    cudaFree(d_ind_out);
    cudaFree(d_seq);
    cudaFree(d_shflStride);
    cudaFree(d_oldDim);
    delete[] oldDim;
    delete[] stride;
    delete[] shflStride;
}

template<class T>
void callThrustSortByKeyWithIndex(T* d_key, double* d_ind, int* d_seq, const char dir, int nelements) {
    
    if(dir == 'd') {
        thrust::stable_sort_by_key(thrust::device, d_key, d_key + nelements,
                                   thrust::make_zip_iterator(thrust::make_tuple(d_seq, d_ind)),
                                   customGreater<T>());
    } else if(dir == 'a') {
        thrust::stable_sort_by_key(thrust::device, d_key, d_key + nelements,
                                   thrust::make_zip_iterator(thrust::make_tuple(d_seq, d_ind)),
                                   customLesser<T>());
    }
                               
    thrust::stable_sort_by_key(thrust::device, d_seq, d_seq + nelements,
                               thrust::make_zip_iterator(thrust::make_tuple(d_key, d_ind)));
    cudaDeviceSynchronize();
}

template<class T>
void callThrustSortByKeyWithIndexSimple(T* d_key, double* d_ind, const char dir, int nelements) {

    thrust::sequence(thrust::device, d_ind, d_ind + nelements, 1); //starts at 1
    if(dir == 'd') {
        thrust::stable_sort_by_key(thrust::device, d_key, d_key + nelements, d_ind, customGreater<T>());
    } else if(dir == 'a') {
        thrust::stable_sort_by_key(thrust::device, d_key, d_key + nelements, d_ind, customLesser<T>());
    }
    cudaDeviceSynchronize();
}

template <class T>
void thrustSortImplWithIndex(T* d_key, double* d_ind, int numDims, const int* dims, int sortAlongDim, const char dir, bool isRowMajor) {

    int nelements = 1;
    for(int i=0; i < numDims; i++)
        nelements *= dims[i];

    // 0-based indexing
    sortAlongDim--;

    if(nelements == 1           ||  // Sorting scalar
       sortAlongDim > numDims-1 ||  // Return back the input like matlab does
       dims[sortAlongDim] == 1 ) {  // Sorting along singleton dimension, nothing to be done
        thrust::fill(thrust::device, d_ind, d_ind + nelements, 1); // all elements = 1
        cudaDeviceSynchronize();
        return;
    }
    
    // Sorting row/column vector
    if(numDims == 2 && (dims[0] == 1 || dims[1] == 1)) {
        callThrustSortByKeyWithIndexSimple<T>(d_key, d_ind, dir, nelements);
        return;
    }

    // Sorting 2d, 3d ... nd matrices along "sortAlongDim"
    if((sortAlongDim == 0 && !isRowMajor) || (sortAlongDim == numDims-1 && isRowMajor)) {
        sortAlongEdgeDimWithIndex<T>(d_key, d_ind, dims[sortAlongDim], dir, nelements);
    } else {
        sortAlongOtherDimWithIndex<T>(d_key, d_ind, numDims, dims, sortAlongDim, dir, nelements, isRowMajor);
    }
    
}

#endif

#endif

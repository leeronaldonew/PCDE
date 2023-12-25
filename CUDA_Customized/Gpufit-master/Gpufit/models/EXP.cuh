#ifndef GPUFIT_EXP_CUH_INCLUDED
#define GPUFIT_EXP_CUH_INCLUDED

#include <math.h>

// EXP
__device__ void calculate_EXP(
    REAL const * parameters,
    int const n_fits,
    int const n_points,
    REAL * value,
    REAL * derivative,
    int const point_index,
    int const fit_index,
    int const chunk_index,
    char * user_info,
    std::size_t const user_info_size)
{
    // indices

    REAL * user_info_float = (REAL*) user_info;
    REAL x = 0;
    if (!user_info_float)
    {
        x = point_index;
    }
    else if (user_info_size / sizeof(REAL) == n_points)
    {
        x = user_info_float[point_index];
    }
    else if (user_info_size / sizeof(REAL) > n_points)
    {
        int const chunk_begin = chunk_index * n_fits * n_points;
        int const fit_begin = fit_index * n_points;
        x = user_info_float[chunk_begin + fit_begin + point_index];
    }
    // parameters // Ct=C-A*exp(-B*t)
    REAL const* p = parameters;
    REAL const A = p[0]; // A
    REAL const B = p[1]; // B
    REAL const C = p[2]; // C
    
    // Value of C_t
    value[point_index] = C - A * exp(-B * x);

    // derivatives
    REAL * current_derivatives = derivative + point_index;
    current_derivatives[0 * n_points] = -1*exp(-B * x);
    current_derivatives[1 * n_points] = A * B * exp(-B * x);
    current_derivatives[2 * n_points] = 1;
    
}
#endif



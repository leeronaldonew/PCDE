//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// TTCM_analytic_Multi_GPU.cu
//
// Code generation for function 'TTCM_analytic_Multi_GPU'
//

// Include files
#include "TTCM_analytic_Multi_GPU.h"
#include "TTCM_analytic_Multi_GPU_types.h"
#include "div.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"

// Function Declarations
static __global__ void TTCM_analytic_Multi_GPU_kernel1(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void TTCM_analytic_Multi_GPU_kernel2(const real32_T a_data
  [76800], const int32_T nx, real32_T fv_data[76800]);
static __global__ void TTCM_analytic_Multi_GPU_kernel3(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv_data[76800], const int32_T fv_size,
  real32_T a_data[76800]);
static __global__ void TTCM_analytic_Multi_GPU_kernel4(const real32_T a_data
  [76800], const int32_T nx, real32_T fv1_data[76800]);
static __global__ void TTCM_analytic_Multi_GPU_kernel5(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void TTCM_analytic_Multi_GPU_kernel6(const real32_T a_data
  [76800], const int32_T nx, real32_T fv2_data[76800]);
static __global__ void TTCM_analytic_Multi_GPU_kernel7(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv2_data[76800], const int32_T
  fv2_size, real32_T a_data[76800]);
static __global__ void TTCM_analytic_Multi_GPU_kernel8(const real32_T a_data
  [76800], const int32_T nx, real32_T fv3_data[76800]);
static __global__ void TTCM_analytic_Multi_GPU_kernel9(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void ab_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv17_data[76800]);
static __global__ void ac_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void ad_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv45_data[76800], const int32_T
  fv45_size, real32_T a_data[76800]);
static __global__ void ae_TTCM_analytic_Multi_GPU_kern(const real32_T
  Local_Estimates, const real32_T fv54_data[76800], const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T b_Local_Estimates, const int32_T nx,
  real32_T fv60_data[76800]);
static __global__ void af_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv74_data[801]);
static __global__ void b_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv4_data[76800]);
static void b_binary_expand_op(real32_T a_data[], int32_T a_size[1], const
  real32_T fv71_data[], const int32_T fv71_size[1], const real32_T PL_data[],
  const int32_T PL_size[2]);
static __global__ void bb_TTCM_analytic_Multi_GPU_kern(const real32_T fv17_data
  [76800], const real32_T PL_data[], const int32_T PL_size[2], const int32_T nx,
  real32_T fv18_data[76800]);
static __global__ void bc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv32_data[76800]);
static __global__ void bd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv46_data[76800]);
static __global__ void be_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void bf_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T fv73_data[76800], const int32_T fv75_size
  [2], const int32_T fv10, const int32_T PI_Time_fine_size, real32_T fv75_data
  [61516800]);
static void binary_expand_op(real32_T Ct_data[], int32_T Ct_size[2], const
  real32_T fv38_data[], const int32_T fv38_size[1], const real32_T fv13_data[],
  const int32_T fv13_size[1], const real32_T fv11_data[], const int32_T
  fv11_size[2], const real32_T fv12_data[], const int32_T fv12_size[2], const
  real32_T fv21_data[], const int32_T fv21_size[1], const real32_T fv19_data[],
  const int32_T fv19_size[2], const real32_T fv20_data[], const int32_T
  fv20_size[2], const real32_T fv29_data[], const int32_T fv29_size[1], const
  real32_T fv27_data[], const int32_T fv27_size[2], const real32_T fv28_data[],
  const int32_T fv28_size[2], const real32_T fv37_data[], const int32_T
  fv37_size[1], const real32_T fv35_data[], const int32_T fv35_size[2], const
  real32_T fv36_data[], const int32_T fv36_size[2], const real32_T fv77_data[],
  const int32_T fv77_size[1], const real32_T fv52_data[], const int32_T
  fv52_size[1], const real32_T fv50_data[], const int32_T fv50_size[2], const
  real32_T fv51_data[], const int32_T fv51_size[2], const real32_T fv60_data[],
  const int32_T fv60_size[1], const real32_T fv58_data[], const int32_T
  fv58_size[2], const real32_T fv59_data[], const int32_T fv59_size[2], const
  real32_T fv68_data[], const int32_T fv68_size[1], const real32_T fv66_data[],
  const int32_T fv66_size[2], const real32_T fv67_data[], const int32_T
  fv67_size[2], const real32_T fv76_data[], const int32_T fv76_size[1], const
  real32_T fv74_data[], const int32_T fv74_size[2], const real32_T fv75_data[],
  const int32_T fv75_size[2]);
static void binary_expand_op(real32_T fv73_data[], int32_T fv73_size[1], const
  real32_T PL_data[], const int32_T PL_size[2], const real32_T fv72_data[],
  const int32_T fv72_size[1]);
static __global__ void c_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv4_data[76800], const int32_T
  fv4_size, real32_T a_data[76800]);
static void c_binary_expand_op(real32_T fv34_data[], int32_T fv34_size[1], const
  real32_T PL_data[], const int32_T PL_size[2], const real32_T fv33_data[],
  const int32_T fv33_size[1]);
static __global__ void cb_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T Local_Estimates, const int32_T
  PI_Time_fine_size, real32_T fv19_data[801]);
static __global__ void cc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv32_data[76800], const int32_T
  fv32_size, real32_T a_data[76800]);
static __global__ void cd_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void ce_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv61_data[76800]);
static __global__ void cf_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv75_data[61516800]);
static __global__ void d_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv5_data[76800]);
static __global__ void db_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv19_data[801]);
static __global__ void dc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv33_data[76800]);
static __global__ void dd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv47_data[76800]);
static __global__ void de_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv61_data[76800], const int32_T
  fv61_size, real32_T a_data[76800]);
static __global__ void df_TTCM_analytic_Multi_GPU_kern(const real32_T
  Local_Estimates, const real32_T fv70_data[76800], const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T b_Local_Estimates, const int32_T nx,
  real32_T fv76_data[76800]);
static __global__ void e_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void eb_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T fv18_data[76800], const int32_T fv20_size
  [2], const int32_T fv10, const int32_T PI_Time_fine_size, real32_T fv20_data
  [61516800]);
static __global__ void ec_TTCM_analytic_Multi_GPU_kern(const real32_T fv33_data
  [76800], const real32_T PL_data[], const int32_T PL_size[2], const int32_T nx,
  real32_T fv34_data[76800]);
static __global__ void ed_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv47_data[76800], const int32_T
  fv47_size, real32_T a_data[76800]);
static __global__ void ee_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv62_data[76800]);
static __global__ void ef_TTCM_analytic_Multi_GPU_kern(const real32_T fv44_data
  [76800], const real32_T fv42_data[76800], const real32_T fv40_data[76800],
  const int32_T PL_size[2], const real32_T PL_data[], const int32_T nx, real32_T
  fv77_data[76800]);
static __global__ void f_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv6_data[76800]);
static __global__ void fb_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv20_data[61516800]);
static __global__ void fc_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T Local_Estimates, const int32_T
  PI_Time_fine_size, real32_T fv35_data[801]);
static __global__ void fd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv48_data[76800]);
static __global__ void fe_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void ff_TTCM_analytic_Multi_GPU_kern(const real32_T fv75_data
  [61516800], const int32_T fv75_size[2], const real32_T fv74_data[801], const
  real32_T fv76_data[76800], const real32_T fv67_data[61516800], const int32_T
  fv67_size[2], const real32_T fv66_data[801], const real32_T fv68_data[76800],
  const real32_T fv59_data[61516800], const int32_T fv59_size[2], const real32_T
  fv58_data[801], const real32_T fv60_data[76800], const real32_T fv51_data
  [61516800], const int32_T fv51_size[2], const real32_T fv50_data[801], const
  real32_T fv52_data[76800], const real32_T fv77_data[76800], const real32_T
  fv36_data[61516800], const int32_T fv36_size[2], const real32_T fv35_data[801],
  const real32_T fv37_data[76800], const real32_T fv28_data[61516800], const
  int32_T fv28_size[2], const real32_T fv27_data[801], const real32_T fv29_data
  [76800], const real32_T fv20_data[61516800], const int32_T fv20_size[2], const
  real32_T fv19_data[801], const real32_T fv21_data[76800], const real32_T
  fv12_data[61516800], const int32_T fv12_size[2], const real32_T fv11_data[801],
  const real32_T fv13_data[76800], const real32_T fv38_data[76800], const
  int32_T Ct_size[2], const int32_T fv10, const int32_T fv11_size, real32_T
  Ct_data[]);
static __global__ void g_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv6_data[76800], const int32_T
  fv6_size, real32_T a_data[76800]);
static __global__ void gb_TTCM_analytic_Multi_GPU_kern(const real32_T
  Local_Estimates, const real32_T fv15_data[76800], const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T b_Local_Estimates, const int32_T nx,
  real32_T fv21_data[76800]);
static __global__ void gc_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv35_data[801]);
static __global__ void gd_TTCM_analytic_Multi_GPU_kern(const real32_T fv48_data
  [76800], const real32_T PL_data[], const int32_T PL_size[2], const int32_T nx,
  real32_T fv49_data[76800]);
static __global__ void ge_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv63_data[76800]);
static __global__ void h_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv7_data[76800]);
static __global__ void hb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void hc_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T fv34_data[76800], const int32_T fv36_size
  [2], const int32_T fv10, const int32_T PI_Time_fine_size, real32_T fv36_data
  [61516800]);
static __global__ void hd_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T Local_Estimates, const int32_T
  PI_Time_fine_size, real32_T fv50_data[801]);
static __global__ void he_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv63_data[76800], const int32_T
  fv63_size, real32_T a_data[76800]);
static __global__ void i_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void ib_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv22_data[76800]);
static __global__ void ic_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv36_data[61516800]);
static __global__ void id_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv50_data[801]);
static __global__ void ie_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv64_data[76800]);
static __global__ void j_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv8_data[76800]);
static __global__ void jb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv22_data[76800], const int32_T
  fv22_size, real32_T a_data[76800]);
static __global__ void jc_TTCM_analytic_Multi_GPU_kern(const real32_T
  Local_Estimates, const real32_T fv31_data[76800], const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T b_Local_Estimates, const int32_T nx,
  real32_T fv37_data[76800]);
static __global__ void jd_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T fv49_data[76800], const int32_T fv51_size
  [2], const int32_T fv10, const int32_T PI_Time_fine_size, real32_T fv51_data
  [61516800]);
static __global__ void je_TTCM_analytic_Multi_GPU_kern(const real32_T fv64_data
  [76800], const real32_T PL_data[], const int32_T PL_size[2], const int32_T nx,
  real32_T fv65_data[76800]);
static __global__ void k_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv8_data[76800], const int32_T
  fv8_size, real32_T a_data[76800]);
static __global__ void kb_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv23_data[76800]);
static __global__ void kc_TTCM_analytic_Multi_GPU_kern(const real32_T fv5_data
  [76800], const real32_T fv3_data[76800], const real32_T fv1_data[76800], const
  int32_T PL_size[2], const real32_T PL_data[], const int32_T nx, real32_T
  fv38_data[76800]);
static __global__ void kd_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv51_data[61516800]);
static __global__ void ke_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T Local_Estimates, const int32_T
  PI_Time_fine_size, real32_T fv66_data[801]);
static __global__ void l_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv9_data[76800]);
static __global__ void lb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void lc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void ld_TTCM_analytic_Multi_GPU_kern(const real32_T
  Local_Estimates, const real32_T fv46_data[76800], const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T b_Local_Estimates, const int32_T nx,
  real32_T fv52_data[76800]);
static __global__ void le_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv66_data[801]);
static __global__ void m_TTCM_analytic_Multi_GPU_kerne(const real32_T fv9_data
  [76800], const real32_T PL_data[], const int32_T PL_size[2], const int32_T nx,
  real32_T fv10_data[76800]);
static __global__ void mb_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv24_data[76800]);
static __global__ void mc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv39_data[76800]);
static __global__ void md_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void me_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T fv65_data[76800], const int32_T fv67_size
  [2], const int32_T fv10, const int32_T PI_Time_fine_size, real32_T fv67_data
  [61516800]);
static __global__ void n_TTCM_analytic_Multi_GPU_kerne(const real32_T
  PI_Time_fine_data[], const real32_T Local_Estimates, const int32_T
  PI_Time_fine_size, real32_T fv11_data[801]);
static __global__ void nb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv24_data[76800], const int32_T
  fv24_size, real32_T a_data[76800]);
static __global__ void nc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv39_data[76800], const int32_T
  fv39_size, real32_T a_data[76800]);
static __global__ void nd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv53_data[76800]);
static __global__ void ne_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv67_data[61516800]);
static __global__ void o_TTCM_analytic_Multi_GPU_kerne(const int32_T nx,
  real32_T fv11_data[801]);
static __global__ void ob_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv25_data[76800]);
static __global__ void oc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv40_data[76800]);
static __global__ void od_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv53_data[76800], const int32_T
  fv53_size, real32_T a_data[76800]);
static __global__ void oe_TTCM_analytic_Multi_GPU_kern(const real32_T
  Local_Estimates, const real32_T fv62_data[76800], const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T b_Local_Estimates, const int32_T nx,
  real32_T fv68_data[76800]);
static __global__ void p_TTCM_analytic_Multi_GPU_kerne(const real32_T
  PI_Time_fine_data[], const real32_T fv10_data[76800], const int32_T fv12_size
  [2], const int32_T fv10, const int32_T PI_Time_fine_size, real32_T fv12_data
  [61516800]);
static __global__ void pb_TTCM_analytic_Multi_GPU_kern(const real32_T fv25_data
  [76800], const real32_T PL_data[], const int32_T PL_size[2], const int32_T nx,
  real32_T fv26_data[76800]);
static __global__ void pc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void pd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv54_data[76800]);
static __global__ void pe_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void q_TTCM_analytic_Multi_GPU_kerne(const int32_T nx,
  real32_T fv12_data[61516800]);
static __global__ void qb_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T Local_Estimates, const int32_T
  PI_Time_fine_size, real32_T fv27_data[801]);
static __global__ void qc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv41_data[76800]);
static __global__ void qd_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void qe_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv69_data[76800]);
static __global__ void r_TTCM_analytic_Multi_GPU_kerne(const real32_T
  Local_Estimates, const real32_T fv7_data[76800], const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T b_Local_Estimates, const int32_T nx,
  real32_T fv13_data[76800]);
static __global__ void rb_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv27_data[801]);
static __global__ void rc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv41_data[76800], const int32_T
  fv41_size, real32_T a_data[76800]);
static __global__ void rd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv55_data[76800]);
static __global__ void re_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv69_data[76800], const int32_T
  fv69_size, real32_T a_data[76800]);
static __global__ void s_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void sb_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T fv26_data[76800], const int32_T fv28_size
  [2], const int32_T fv10, const int32_T PI_Time_fine_size, real32_T fv28_data
  [61516800]);
static __global__ void sc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv42_data[76800]);
static __global__ void sd_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv55_data[76800], const int32_T
  fv55_size, real32_T a_data[76800]);
static __global__ void se_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv70_data[76800]);
static __global__ void t_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv14_data[76800]);
static __global__ void tb_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv28_data[61516800]);
static __global__ void tc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void td_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv56_data[76800]);
static __global__ void te_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void u_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv14_data[76800], const int32_T
  fv14_size, real32_T a_data[76800]);
static __global__ void ub_TTCM_analytic_Multi_GPU_kern(const real32_T
  Local_Estimates, const real32_T fv23_data[76800], const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T b_Local_Estimates, const int32_T nx,
  real32_T fv29_data[76800]);
static __global__ void uc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv43_data[76800]);
static __global__ void ud_TTCM_analytic_Multi_GPU_kern(const real32_T fv56_data
  [76800], const real32_T PL_data[], const int32_T PL_size[2], const int32_T nx,
  real32_T fv57_data[76800]);
static __global__ void ue_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv71_data[76800]);
static __global__ void v_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv15_data[76800]);
static __global__ void vb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void vc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv43_data[76800], const int32_T
  fv43_size, real32_T a_data[76800]);
static __global__ void vd_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T Local_Estimates, const int32_T
  PI_Time_fine_size, real32_T fv58_data[801]);
static __global__ void ve_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv71_data[76800], const int32_T
  fv71_size, real32_T a_data[76800]);
static __global__ void w_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void wb_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv30_data[76800]);
static __global__ void wc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv44_data[76800]);
static __global__ void wd_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv58_data[801]);
static __global__ void we_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv72_data[76800]);
static __global__ void x_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data
  [76800], const int32_T nx, real32_T fv16_data[76800]);
static __global__ void xb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv30_data[76800], const int32_T
  fv30_size, real32_T a_data[76800]);
static __global__ void xc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[],
  const int32_T PL_size[2], const int32_T nx, real32_T a_data[76800]);
static __global__ void xd_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T fv57_data[76800], const int32_T fv59_size
  [2], const int32_T fv10, const int32_T PI_Time_fine_size, real32_T fv59_data
  [61516800]);
static __global__ void xe_TTCM_analytic_Multi_GPU_kern(const real32_T fv72_data
  [76800], const real32_T PL_data[], const int32_T PL_size[2], const int32_T nx,
  real32_T fv73_data[76800]);
static __global__ void y_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[],
  const int32_T PL_size[2], const real32_T fv16_data[76800], const int32_T
  fv16_size, real32_T a_data[76800]);
static __global__ void yb_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv31_data[76800]);
static __global__ void yc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data
  [76800], const int32_T nx, real32_T fv45_data[76800]);
static __global__ void yd_TTCM_analytic_Multi_GPU_kern(const int32_T nx,
  real32_T fv59_data[61516800]);
static __global__ void ye_TTCM_analytic_Multi_GPU_kern(const real32_T
  PI_Time_fine_data[], const real32_T Local_Estimates, const int32_T
  PI_Time_fine_size, real32_T fv74_data[801]);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel1(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel2(const real32_T a_data[76800], const int32_T nx,
  real32_T fv_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel3(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv_data[76800], const int32_T fv_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel4(const real32_T a_data[76800], const int32_T nx,
  real32_T fv1_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv1_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel5(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel6(const real32_T a_data[76800], const int32_T nx,
  real32_T fv2_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv2_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel7(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv2_data[76800], const int32_T fv2_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv2_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel8(const real32_T a_data[76800], const int32_T nx,
  real32_T fv3_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv3_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  TTCM_analytic_Multi_GPU_kernel9(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ab_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv17_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv17_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ac_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ad_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv45_data[76800], const int32_T fv45_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv45_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv45_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ae_TTCM_analytic_Multi_GPU_kern(const real32_T Local_Estimates, const real32_T
  fv54_data[76800], const real32_T PL_data[], const int32_T PL_size[2], const
  real32_T b_Local_Estimates, const int32_T nx, real32_T fv60_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv60_data[i] = b_Local_Estimates / ((((PL_data[i + PL_size[0]] + PL_data[i +
      PL_size[0] * 2]) + PL_data[i + PL_size[0] * 3]) - fv54_data[i]) / 2.0F -
      Local_Estimates);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  af_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv74_data[801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv74_data[k] = expf(fv74_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  b_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv4_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv4_data[k] = f * f;
  }
}

static void b_binary_expand_op(real32_T a_data[], int32_T a_size[1], const
  real32_T fv71_data[], const int32_T fv71_size[1], const real32_T PL_data[],
  const int32_T PL_size[2])
{
  int32_T b_i1;
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  i = PL_size[0];
  i1 = PL_size[0];
  if (i1 == 1) {
    b_i1 = i;
  } else {
    b_i1 = i1;
  }

  if (b_i1 == 1) {
    a_size[0] = fv71_size[0];
  } else if (i1 == 1) {
    a_size[0] = i;
  } else {
    a_size[0] = i1;
  }

  stride_0_0 = (fv71_size[0] != 1);
  stride_1_0 = (i != 1);
  stride_2_0 = (i1 != 1);
  if (i1 == 1) {
    b_i1 = i;
  } else {
    b_i1 = i1;
  }

  if (b_i1 == 1) {
    i1 = fv71_size[0];
  } else if (i1 == 1) {
    i1 = i;
  }

  for (i = 0; i < i1; i++) {
    a_data[i] = fv71_data[i * stride_0_0] - 4.0F * PL_data[i * stride_1_0 +
      PL_size[0]] * PL_data[i * stride_2_0 + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  bb_TTCM_analytic_Multi_GPU_kern(const real32_T fv17_data[76800], const
  real32_T PL_data[], const int32_T PL_size[2], const int32_T nx, real32_T
  fv18_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv18_data[i] = -((((PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
                       PL_data[i + PL_size[0] * 3]) + fv17_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  bc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv32_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv32_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  bd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv46_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv46_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  be_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  bf_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T fv73_data[76800], const int32_T fv75_size[2], const int32_T fv10,
  const int32_T PI_Time_fine_size, real32_T fv75_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (PI_Time_fine_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) / (static_cast<
      uint64_T>(fv10) + 1ULL));
    fv75_data[k + fv75_size[0] * i] = fv73_data[k] * PI_Time_fine_data[i];
  }
}

static void binary_expand_op(real32_T Ct_data[], int32_T Ct_size[2], const
  real32_T fv38_data[], const int32_T fv38_size[1], const real32_T fv13_data[],
  const int32_T fv13_size[1], const real32_T fv11_data[], const int32_T
  fv11_size[2], const real32_T fv12_data[], const int32_T fv12_size[2], const
  real32_T fv21_data[], const int32_T fv21_size[1], const real32_T fv19_data[],
  const int32_T fv19_size[2], const real32_T fv20_data[], const int32_T
  fv20_size[2], const real32_T fv29_data[], const int32_T fv29_size[1], const
  real32_T fv27_data[], const int32_T fv27_size[2], const real32_T fv28_data[],
  const int32_T fv28_size[2], const real32_T fv37_data[], const int32_T
  fv37_size[1], const real32_T fv35_data[], const int32_T fv35_size[2], const
  real32_T fv36_data[], const int32_T fv36_size[2], const real32_T fv77_data[],
  const int32_T fv77_size[1], const real32_T fv52_data[], const int32_T
  fv52_size[1], const real32_T fv50_data[], const int32_T fv50_size[2], const
  real32_T fv51_data[], const int32_T fv51_size[2], const real32_T fv60_data[],
  const int32_T fv60_size[1], const real32_T fv58_data[], const int32_T
  fv58_size[2], const real32_T fv59_data[], const int32_T fv59_size[2], const
  real32_T fv68_data[], const int32_T fv68_size[1], const real32_T fv66_data[],
  const int32_T fv66_size[2], const real32_T fv67_data[], const int32_T
  fv67_size[2], const real32_T fv76_data[], const int32_T fv76_size[1], const
  real32_T fv74_data[], const int32_T fv74_size[2], const real32_T fv75_data[],
  const int32_T fv75_size[2])
{
  int32_T aux_11_1;
  int32_T aux_12_1;
  int32_T aux_15_1;
  int32_T aux_16_1;
  int32_T aux_18_1;
  int32_T aux_19_1;
  int32_T aux_21_1;
  int32_T aux_22_1;
  int32_T aux_24_1;
  int32_T aux_25_1;
  int32_T aux_2_1;
  int32_T aux_3_1;
  int32_T aux_5_1;
  int32_T aux_6_1;
  int32_T aux_8_1;
  int32_T aux_9_1;
  int32_T b_fv12_size;
  int32_T b_fv20_size;
  int32_T b_fv28_size;
  int32_T b_fv36_size;
  int32_T b_fv51_size;
  int32_T b_fv59_size;
  int32_T b_fv67_size;
  int32_T b_fv75_size;
  int32_T c_fv20_size;
  int32_T c_fv28_size;
  int32_T c_fv36_size;
  int32_T c_fv59_size;
  int32_T c_fv67_size;
  int32_T c_fv75_size;
  int32_T d_fv36_size;
  int32_T d_fv75_size;
  int32_T e_fv75_size;
  int32_T fv13_idx_0;
  int32_T fv21_idx_0;
  int32_T fv29_idx_0;
  int32_T fv37_idx_0;
  int32_T fv38_idx_0;
  int32_T fv52_idx_0;
  int32_T fv60_idx_0;
  int32_T fv68_idx_0;
  int32_T fv76_idx_0;
  int32_T fv77_idx_0;
  int32_T stride_0_0;
  int32_T stride_10_0;
  int32_T stride_11_1;
  int32_T stride_12_0;
  int32_T stride_12_1;
  int32_T stride_13_0;
  int32_T stride_14_0;
  int32_T stride_15_1;
  int32_T stride_16_0;
  int32_T stride_16_1;
  int32_T stride_17_0;
  int32_T stride_18_1;
  int32_T stride_19_0;
  int32_T stride_19_1;
  int32_T stride_1_0;
  int32_T stride_20_0;
  int32_T stride_21_1;
  int32_T stride_22_0;
  int32_T stride_22_1;
  int32_T stride_23_0;
  int32_T stride_24_1;
  int32_T stride_25_0;
  int32_T stride_25_1;
  int32_T stride_2_1;
  int32_T stride_3_0;
  int32_T stride_3_1;
  int32_T stride_4_0;
  int32_T stride_5_1;
  int32_T stride_6_0;
  int32_T stride_6_1;
  int32_T stride_7_0;
  int32_T stride_8_1;
  int32_T stride_9_0;
  int32_T stride_9_1;
  fv38_idx_0 = fv38_size[0];
  fv13_idx_0 = fv13_size[0];
  fv21_idx_0 = fv21_size[0];
  fv29_idx_0 = fv29_size[0];
  fv37_idx_0 = fv37_size[0];
  fv77_idx_0 = fv77_size[0];
  fv52_idx_0 = fv52_size[0];
  fv60_idx_0 = fv60_size[0];
  fv68_idx_0 = fv68_size[0];
  fv76_idx_0 = fv76_size[0];
  if (fv75_size[0] == 1) {
    b_fv75_size = 1;
  } else {
    b_fv75_size = fv75_size[0];
  }

  if (b_fv75_size == 1) {
    b_fv75_size = fv76_idx_0;
  } else if (fv75_size[0] == 1) {
    b_fv75_size = 1;
  } else {
    b_fv75_size = fv75_size[0];
  }

  if (fv67_size[0] == 1) {
    b_fv67_size = 1;
  } else {
    b_fv67_size = fv67_size[0];
  }

  if (b_fv67_size == 1) {
    b_fv67_size = fv68_idx_0;
  } else if (fv67_size[0] == 1) {
    b_fv67_size = 1;
  } else {
    b_fv67_size = fv67_size[0];
  }

  if (fv59_size[0] == 1) {
    b_fv59_size = 1;
  } else {
    b_fv59_size = fv59_size[0];
  }

  if (b_fv59_size == 1) {
    b_fv59_size = fv60_idx_0;
  } else if (fv59_size[0] == 1) {
    b_fv59_size = 1;
  } else {
    b_fv59_size = fv59_size[0];
  }

  if (fv51_size[0] == 1) {
    b_fv51_size = 1;
  } else {
    b_fv51_size = fv51_size[0];
  }

  if (fv59_size[0] == 1) {
    c_fv59_size = 1;
  } else {
    c_fv59_size = fv59_size[0];
  }

  if (fv67_size[0] == 1) {
    c_fv67_size = 1;
  } else {
    c_fv67_size = fv67_size[0];
  }

  if (fv75_size[0] == 1) {
    c_fv75_size = 1;
  } else {
    c_fv75_size = fv75_size[0];
  }

  if (b_fv75_size == 1) {
    if (b_fv67_size == 1) {
      if (b_fv59_size == 1) {
        if (b_fv51_size == 1) {
          b_fv75_size = fv52_idx_0;
        } else if (fv51_size[0] == 1) {
          b_fv75_size = 1;
        } else {
          b_fv75_size = fv51_size[0];
        }
      } else if (c_fv59_size == 1) {
        b_fv75_size = fv60_idx_0;
      } else if (fv59_size[0] == 1) {
        b_fv75_size = 1;
      } else {
        b_fv75_size = fv59_size[0];
      }
    } else if (c_fv67_size == 1) {
      b_fv75_size = fv68_idx_0;
    } else if (fv67_size[0] == 1) {
      b_fv75_size = 1;
    } else {
      b_fv75_size = fv67_size[0];
    }
  } else if (c_fv75_size == 1) {
    b_fv75_size = fv76_idx_0;
  } else if (fv75_size[0] == 1) {
    b_fv75_size = 1;
  } else {
    b_fv75_size = fv75_size[0];
  }

  if (fv75_size[0] == 1) {
    c_fv75_size = 1;
  } else {
    c_fv75_size = fv75_size[0];
  }

  if (c_fv75_size == 1) {
    c_fv75_size = fv76_idx_0;
  } else if (fv75_size[0] == 1) {
    c_fv75_size = 1;
  } else {
    c_fv75_size = fv75_size[0];
  }

  if (fv67_size[0] == 1) {
    b_fv67_size = 1;
  } else {
    b_fv67_size = fv67_size[0];
  }

  if (b_fv67_size == 1) {
    b_fv67_size = fv68_idx_0;
  } else if (fv67_size[0] == 1) {
    b_fv67_size = 1;
  } else {
    b_fv67_size = fv67_size[0];
  }

  if (fv59_size[0] == 1) {
    b_fv59_size = 1;
  } else {
    b_fv59_size = fv59_size[0];
  }

  if (b_fv59_size == 1) {
    b_fv59_size = fv60_idx_0;
  } else if (fv59_size[0] == 1) {
    b_fv59_size = 1;
  } else {
    b_fv59_size = fv59_size[0];
  }

  if (fv51_size[0] == 1) {
    b_fv51_size = 1;
  } else {
    b_fv51_size = fv51_size[0];
  }

  if (fv59_size[0] == 1) {
    c_fv59_size = 1;
  } else {
    c_fv59_size = fv59_size[0];
  }

  if (fv67_size[0] == 1) {
    c_fv67_size = 1;
  } else {
    c_fv67_size = fv67_size[0];
  }

  if (fv75_size[0] == 1) {
    d_fv75_size = 1;
  } else {
    d_fv75_size = fv75_size[0];
  }

  if (b_fv75_size == 1) {
    b_fv75_size = fv77_idx_0;
  } else if (c_fv75_size == 1) {
    if (b_fv67_size == 1) {
      if (b_fv59_size == 1) {
        if (b_fv51_size == 1) {
          b_fv75_size = fv52_idx_0;
        } else if (fv51_size[0] == 1) {
          b_fv75_size = 1;
        } else {
          b_fv75_size = fv51_size[0];
        }
      } else if (c_fv59_size == 1) {
        b_fv75_size = fv60_idx_0;
      } else if (fv59_size[0] == 1) {
        b_fv75_size = 1;
      } else {
        b_fv75_size = fv59_size[0];
      }
    } else if (c_fv67_size == 1) {
      b_fv75_size = fv68_idx_0;
    } else if (fv67_size[0] == 1) {
      b_fv75_size = 1;
    } else {
      b_fv75_size = fv67_size[0];
    }
  } else if (d_fv75_size == 1) {
    b_fv75_size = fv76_idx_0;
  } else if (fv75_size[0] == 1) {
    b_fv75_size = 1;
  } else {
    b_fv75_size = fv75_size[0];
  }

  if (b_fv75_size == 1) {
    if (fv36_size[0] == 1) {
      b_fv36_size = 1;
    } else {
      b_fv36_size = fv36_size[0];
    }

    if (b_fv36_size == 1) {
      b_fv36_size = fv37_idx_0;
    } else if (fv36_size[0] == 1) {
      b_fv36_size = 1;
    } else {
      b_fv36_size = fv36_size[0];
    }

    if (fv28_size[0] == 1) {
      b_fv28_size = 1;
    } else {
      b_fv28_size = fv28_size[0];
    }

    if (b_fv28_size == 1) {
      b_fv28_size = fv29_idx_0;
    } else if (fv28_size[0] == 1) {
      b_fv28_size = 1;
    } else {
      b_fv28_size = fv28_size[0];
    }

    if (fv20_size[0] == 1) {
      b_fv20_size = 1;
    } else {
      b_fv20_size = fv20_size[0];
    }

    if (b_fv20_size == 1) {
      b_fv20_size = fv21_idx_0;
    } else if (fv20_size[0] == 1) {
      b_fv20_size = 1;
    } else {
      b_fv20_size = fv20_size[0];
    }

    if (fv12_size[0] == 1) {
      b_fv12_size = 1;
    } else {
      b_fv12_size = fv12_size[0];
    }

    if (fv20_size[0] == 1) {
      c_fv20_size = 1;
    } else {
      c_fv20_size = fv20_size[0];
    }

    if (fv28_size[0] == 1) {
      c_fv28_size = 1;
    } else {
      c_fv28_size = fv28_size[0];
    }

    if (fv36_size[0] == 1) {
      c_fv36_size = 1;
    } else {
      c_fv36_size = fv36_size[0];
    }

    if (b_fv36_size == 1) {
      if (b_fv28_size == 1) {
        if (b_fv20_size == 1) {
          if (b_fv12_size == 1) {
            b_fv36_size = fv13_idx_0;
          } else if (fv12_size[0] == 1) {
            b_fv36_size = 1;
          } else {
            b_fv36_size = fv12_size[0];
          }
        } else if (c_fv20_size == 1) {
          b_fv36_size = fv21_idx_0;
        } else if (fv20_size[0] == 1) {
          b_fv36_size = 1;
        } else {
          b_fv36_size = fv20_size[0];
        }
      } else if (c_fv28_size == 1) {
        b_fv36_size = fv29_idx_0;
      } else if (fv28_size[0] == 1) {
        b_fv36_size = 1;
      } else {
        b_fv36_size = fv28_size[0];
      }
    } else if (c_fv36_size == 1) {
      b_fv36_size = fv37_idx_0;
    } else if (fv36_size[0] == 1) {
      b_fv36_size = 1;
    } else {
      b_fv36_size = fv36_size[0];
    }

    if (b_fv36_size == 1) {
      Ct_size[0] = fv38_idx_0;
    } else {
      if (fv36_size[0] == 1) {
        b_fv36_size = 1;
      } else {
        b_fv36_size = fv36_size[0];
      }

      if (b_fv36_size == 1) {
        b_fv36_size = fv37_idx_0;
      } else if (fv36_size[0] == 1) {
        b_fv36_size = 1;
      } else {
        b_fv36_size = fv36_size[0];
      }

      if (b_fv36_size == 1) {
        if (fv28_size[0] == 1) {
          b_fv28_size = 1;
        } else {
          b_fv28_size = fv28_size[0];
        }

        if (b_fv28_size == 1) {
          b_fv28_size = fv29_idx_0;
        } else if (fv28_size[0] == 1) {
          b_fv28_size = 1;
        } else {
          b_fv28_size = fv28_size[0];
        }

        if (b_fv28_size == 1) {
          if (fv20_size[0] == 1) {
            b_fv20_size = 1;
          } else {
            b_fv20_size = fv20_size[0];
          }

          if (b_fv20_size == 1) {
            b_fv20_size = fv21_idx_0;
          } else if (fv20_size[0] == 1) {
            b_fv20_size = 1;
          } else {
            b_fv20_size = fv20_size[0];
          }

          if (b_fv20_size == 1) {
            if (fv12_size[0] == 1) {
              b_fv12_size = 1;
            } else {
              b_fv12_size = fv12_size[0];
            }

            if (b_fv12_size == 1) {
              Ct_size[0] = fv13_idx_0;
            } else if (fv12_size[0] == 1) {
              Ct_size[0] = 1;
            } else {
              Ct_size[0] = fv12_size[0];
            }
          } else {
            if (fv20_size[0] == 1) {
              b_fv20_size = 1;
            } else {
              b_fv20_size = fv20_size[0];
            }

            if (b_fv20_size == 1) {
              Ct_size[0] = fv21_idx_0;
            } else if (fv20_size[0] == 1) {
              Ct_size[0] = 1;
            } else {
              Ct_size[0] = fv20_size[0];
            }
          }
        } else {
          if (fv28_size[0] == 1) {
            b_fv28_size = 1;
          } else {
            b_fv28_size = fv28_size[0];
          }

          if (b_fv28_size == 1) {
            Ct_size[0] = fv29_idx_0;
          } else if (fv28_size[0] == 1) {
            Ct_size[0] = 1;
          } else {
            Ct_size[0] = fv28_size[0];
          }
        }
      } else {
        if (fv36_size[0] == 1) {
          b_fv36_size = 1;
        } else {
          b_fv36_size = fv36_size[0];
        }

        if (b_fv36_size == 1) {
          Ct_size[0] = fv37_idx_0;
        } else if (fv36_size[0] == 1) {
          Ct_size[0] = 1;
        } else {
          Ct_size[0] = fv36_size[0];
        }
      }
    }
  } else {
    if (fv75_size[0] == 1) {
      b_fv75_size = 1;
    } else {
      b_fv75_size = fv75_size[0];
    }

    if (b_fv75_size == 1) {
      b_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      b_fv75_size = 1;
    } else {
      b_fv75_size = fv75_size[0];
    }

    if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (b_fv67_size == 1) {
      b_fv67_size = fv68_idx_0;
    } else if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (b_fv59_size == 1) {
      b_fv59_size = fv60_idx_0;
    } else if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (fv51_size[0] == 1) {
      b_fv51_size = 1;
    } else {
      b_fv51_size = fv51_size[0];
    }

    if (fv59_size[0] == 1) {
      c_fv59_size = 1;
    } else {
      c_fv59_size = fv59_size[0];
    }

    if (fv67_size[0] == 1) {
      c_fv67_size = 1;
    } else {
      c_fv67_size = fv67_size[0];
    }

    if (fv75_size[0] == 1) {
      c_fv75_size = 1;
    } else {
      c_fv75_size = fv75_size[0];
    }

    if (b_fv75_size == 1) {
      if (b_fv67_size == 1) {
        if (b_fv59_size == 1) {
          if (b_fv51_size == 1) {
            b_fv75_size = fv52_idx_0;
          } else if (fv51_size[0] == 1) {
            b_fv75_size = 1;
          } else {
            b_fv75_size = fv51_size[0];
          }
        } else if (c_fv59_size == 1) {
          b_fv75_size = fv60_idx_0;
        } else if (fv59_size[0] == 1) {
          b_fv75_size = 1;
        } else {
          b_fv75_size = fv59_size[0];
        }
      } else if (c_fv67_size == 1) {
        b_fv75_size = fv68_idx_0;
      } else if (fv67_size[0] == 1) {
        b_fv75_size = 1;
      } else {
        b_fv75_size = fv67_size[0];
      }
    } else if (c_fv75_size == 1) {
      b_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      b_fv75_size = 1;
    } else {
      b_fv75_size = fv75_size[0];
    }

    if (b_fv75_size == 1) {
      Ct_size[0] = fv77_idx_0;
    } else {
      if (fv75_size[0] == 1) {
        b_fv75_size = 1;
      } else {
        b_fv75_size = fv75_size[0];
      }

      if (b_fv75_size == 1) {
        b_fv75_size = fv76_idx_0;
      } else if (fv75_size[0] == 1) {
        b_fv75_size = 1;
      } else {
        b_fv75_size = fv75_size[0];
      }

      if (b_fv75_size == 1) {
        if (fv67_size[0] == 1) {
          b_fv67_size = 1;
        } else {
          b_fv67_size = fv67_size[0];
        }

        if (b_fv67_size == 1) {
          b_fv67_size = fv68_idx_0;
        } else if (fv67_size[0] == 1) {
          b_fv67_size = 1;
        } else {
          b_fv67_size = fv67_size[0];
        }

        if (b_fv67_size == 1) {
          if (fv59_size[0] == 1) {
            b_fv59_size = 1;
          } else {
            b_fv59_size = fv59_size[0];
          }

          if (b_fv59_size == 1) {
            b_fv59_size = fv60_idx_0;
          } else if (fv59_size[0] == 1) {
            b_fv59_size = 1;
          } else {
            b_fv59_size = fv59_size[0];
          }

          if (b_fv59_size == 1) {
            if (fv51_size[0] == 1) {
              b_fv51_size = 1;
            } else {
              b_fv51_size = fv51_size[0];
            }

            if (b_fv51_size == 1) {
              Ct_size[0] = fv52_idx_0;
            } else if (fv51_size[0] == 1) {
              Ct_size[0] = 1;
            } else {
              Ct_size[0] = fv51_size[0];
            }
          } else {
            if (fv59_size[0] == 1) {
              b_fv59_size = 1;
            } else {
              b_fv59_size = fv59_size[0];
            }

            if (b_fv59_size == 1) {
              Ct_size[0] = fv60_idx_0;
            } else if (fv59_size[0] == 1) {
              Ct_size[0] = 1;
            } else {
              Ct_size[0] = fv59_size[0];
            }
          }
        } else {
          if (fv67_size[0] == 1) {
            b_fv67_size = 1;
          } else {
            b_fv67_size = fv67_size[0];
          }

          if (b_fv67_size == 1) {
            Ct_size[0] = fv68_idx_0;
          } else if (fv67_size[0] == 1) {
            Ct_size[0] = 1;
          } else {
            Ct_size[0] = fv67_size[0];
          }
        }
      } else {
        if (fv75_size[0] == 1) {
          b_fv75_size = 1;
        } else {
          b_fv75_size = fv75_size[0];
        }

        if (b_fv75_size == 1) {
          Ct_size[0] = fv76_idx_0;
        } else if (fv75_size[0] == 1) {
          Ct_size[0] = 1;
        } else {
          Ct_size[0] = fv75_size[0];
        }
      }
    }
  }

  if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  if (b_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (b_fv67_size == 1) {
    b_fv67_size = 1;
  } else if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (b_fv59_size == 1) {
    b_fv59_size = 1;
  } else if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (fv51_size[1] == 1) {
    b_fv51_size = fv50_size[1];
  } else {
    b_fv51_size = fv51_size[1];
  }

  if (fv59_size[1] == 1) {
    c_fv59_size = fv58_size[1];
  } else {
    c_fv59_size = fv59_size[1];
  }

  if (fv67_size[1] == 1) {
    c_fv67_size = fv66_size[1];
  } else {
    c_fv67_size = fv67_size[1];
  }

  if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (b_fv75_size == 1) {
    if (b_fv67_size == 1) {
      if (b_fv59_size == 1) {
        if (b_fv51_size == 1) {
          b_fv75_size = 1;
        } else if (fv51_size[1] == 1) {
          b_fv75_size = fv50_size[1];
        } else {
          b_fv75_size = fv51_size[1];
        }
      } else if (c_fv59_size == 1) {
        b_fv75_size = 1;
      } else if (fv59_size[1] == 1) {
        b_fv75_size = fv58_size[1];
      } else {
        b_fv75_size = fv59_size[1];
      }
    } else if (c_fv67_size == 1) {
      b_fv75_size = 1;
    } else if (fv67_size[1] == 1) {
      b_fv75_size = fv66_size[1];
    } else {
      b_fv75_size = fv67_size[1];
    }
  } else if (c_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (c_fv75_size == 1) {
    c_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (b_fv67_size == 1) {
    b_fv67_size = 1;
  } else if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (b_fv59_size == 1) {
    b_fv59_size = 1;
  } else if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (fv51_size[1] == 1) {
    b_fv51_size = fv50_size[1];
  } else {
    b_fv51_size = fv51_size[1];
  }

  if (fv59_size[1] == 1) {
    c_fv59_size = fv58_size[1];
  } else {
    c_fv59_size = fv59_size[1];
  }

  if (fv67_size[1] == 1) {
    c_fv67_size = fv66_size[1];
  } else {
    c_fv67_size = fv67_size[1];
  }

  if (fv75_size[1] == 1) {
    d_fv75_size = fv74_size[1];
  } else {
    d_fv75_size = fv75_size[1];
  }

  if (b_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (c_fv75_size == 1) {
    if (b_fv67_size == 1) {
      if (b_fv59_size == 1) {
        if (b_fv51_size == 1) {
          b_fv75_size = 1;
        } else if (fv51_size[1] == 1) {
          b_fv75_size = fv50_size[1];
        } else {
          b_fv75_size = fv51_size[1];
        }
      } else if (c_fv59_size == 1) {
        b_fv75_size = 1;
      } else if (fv59_size[1] == 1) {
        b_fv75_size = fv58_size[1];
      } else {
        b_fv75_size = fv59_size[1];
      }
    } else if (c_fv67_size == 1) {
      b_fv75_size = 1;
    } else if (fv67_size[1] == 1) {
      b_fv75_size = fv66_size[1];
    } else {
      b_fv75_size = fv67_size[1];
    }
  } else if (d_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  if (b_fv75_size == 1) {
    if (fv36_size[1] == 1) {
      b_fv36_size = fv35_size[1];
    } else {
      b_fv36_size = fv36_size[1];
    }

    if (b_fv36_size == 1) {
      b_fv36_size = 1;
    } else if (fv36_size[1] == 1) {
      b_fv36_size = fv35_size[1];
    } else {
      b_fv36_size = fv36_size[1];
    }

    if (fv28_size[1] == 1) {
      b_fv28_size = fv27_size[1];
    } else {
      b_fv28_size = fv28_size[1];
    }

    if (b_fv28_size == 1) {
      b_fv28_size = 1;
    } else if (fv28_size[1] == 1) {
      b_fv28_size = fv27_size[1];
    } else {
      b_fv28_size = fv28_size[1];
    }

    if (fv20_size[1] == 1) {
      b_fv20_size = fv19_size[1];
    } else {
      b_fv20_size = fv20_size[1];
    }

    if (b_fv20_size == 1) {
      b_fv20_size = 1;
    } else if (fv20_size[1] == 1) {
      b_fv20_size = fv19_size[1];
    } else {
      b_fv20_size = fv20_size[1];
    }

    if (fv12_size[1] == 1) {
      b_fv12_size = fv11_size[1];
    } else {
      b_fv12_size = fv12_size[1];
    }

    if (fv20_size[1] == 1) {
      c_fv20_size = fv19_size[1];
    } else {
      c_fv20_size = fv20_size[1];
    }

    if (fv28_size[1] == 1) {
      c_fv28_size = fv27_size[1];
    } else {
      c_fv28_size = fv28_size[1];
    }

    if (fv36_size[1] == 1) {
      c_fv36_size = fv35_size[1];
    } else {
      c_fv36_size = fv36_size[1];
    }

    if (b_fv36_size == 1) {
      if (b_fv28_size == 1) {
        if (b_fv20_size == 1) {
          if (b_fv12_size == 1) {
            b_fv36_size = 1;
          } else if (fv12_size[1] == 1) {
            b_fv36_size = fv11_size[1];
          } else {
            b_fv36_size = fv12_size[1];
          }
        } else if (c_fv20_size == 1) {
          b_fv36_size = 1;
        } else if (fv20_size[1] == 1) {
          b_fv36_size = fv19_size[1];
        } else {
          b_fv36_size = fv20_size[1];
        }
      } else if (c_fv28_size == 1) {
        b_fv36_size = 1;
      } else if (fv28_size[1] == 1) {
        b_fv36_size = fv27_size[1];
      } else {
        b_fv36_size = fv28_size[1];
      }
    } else if (c_fv36_size == 1) {
      b_fv36_size = 1;
    } else if (fv36_size[1] == 1) {
      b_fv36_size = fv35_size[1];
    } else {
      b_fv36_size = fv36_size[1];
    }

    if (b_fv36_size == 1) {
      Ct_size[1] = 1;
    } else {
      if (fv36_size[1] == 1) {
        b_fv36_size = fv35_size[1];
      } else {
        b_fv36_size = fv36_size[1];
      }

      if (b_fv36_size == 1) {
        b_fv36_size = 1;
      } else if (fv36_size[1] == 1) {
        b_fv36_size = fv35_size[1];
      } else {
        b_fv36_size = fv36_size[1];
      }

      if (b_fv36_size == 1) {
        if (fv28_size[1] == 1) {
          b_fv28_size = fv27_size[1];
        } else {
          b_fv28_size = fv28_size[1];
        }

        if (b_fv28_size == 1) {
          b_fv28_size = 1;
        } else if (fv28_size[1] == 1) {
          b_fv28_size = fv27_size[1];
        } else {
          b_fv28_size = fv28_size[1];
        }

        if (b_fv28_size == 1) {
          if (fv20_size[1] == 1) {
            b_fv20_size = fv19_size[1];
          } else {
            b_fv20_size = fv20_size[1];
          }

          if (b_fv20_size == 1) {
            b_fv20_size = 1;
          } else if (fv20_size[1] == 1) {
            b_fv20_size = fv19_size[1];
          } else {
            b_fv20_size = fv20_size[1];
          }

          if (b_fv20_size == 1) {
            if (fv12_size[1] == 1) {
              b_fv12_size = fv11_size[1];
            } else {
              b_fv12_size = fv12_size[1];
            }

            if (b_fv12_size == 1) {
              Ct_size[1] = 1;
            } else if (fv12_size[1] == 1) {
              Ct_size[1] = fv11_size[1];
            } else {
              Ct_size[1] = fv12_size[1];
            }
          } else {
            if (fv20_size[1] == 1) {
              b_fv20_size = fv19_size[1];
            } else {
              b_fv20_size = fv20_size[1];
            }

            if (b_fv20_size == 1) {
              Ct_size[1] = 1;
            } else if (fv20_size[1] == 1) {
              Ct_size[1] = fv19_size[1];
            } else {
              Ct_size[1] = fv20_size[1];
            }
          }
        } else {
          if (fv28_size[1] == 1) {
            b_fv28_size = fv27_size[1];
          } else {
            b_fv28_size = fv28_size[1];
          }

          if (b_fv28_size == 1) {
            Ct_size[1] = 1;
          } else if (fv28_size[1] == 1) {
            Ct_size[1] = fv27_size[1];
          } else {
            Ct_size[1] = fv28_size[1];
          }
        }
      } else {
        if (fv36_size[1] == 1) {
          b_fv36_size = fv35_size[1];
        } else {
          b_fv36_size = fv36_size[1];
        }

        if (b_fv36_size == 1) {
          Ct_size[1] = 1;
        } else if (fv36_size[1] == 1) {
          Ct_size[1] = fv35_size[1];
        } else {
          Ct_size[1] = fv36_size[1];
        }
      }
    }
  } else {
    if (fv75_size[1] == 1) {
      b_fv75_size = fv74_size[1];
    } else {
      b_fv75_size = fv75_size[1];
    }

    if (b_fv75_size == 1) {
      b_fv75_size = 1;
    } else if (fv75_size[1] == 1) {
      b_fv75_size = fv74_size[1];
    } else {
      b_fv75_size = fv75_size[1];
    }

    if (fv67_size[1] == 1) {
      b_fv67_size = fv66_size[1];
    } else {
      b_fv67_size = fv67_size[1];
    }

    if (b_fv67_size == 1) {
      b_fv67_size = 1;
    } else if (fv67_size[1] == 1) {
      b_fv67_size = fv66_size[1];
    } else {
      b_fv67_size = fv67_size[1];
    }

    if (fv59_size[1] == 1) {
      b_fv59_size = fv58_size[1];
    } else {
      b_fv59_size = fv59_size[1];
    }

    if (b_fv59_size == 1) {
      b_fv59_size = 1;
    } else if (fv59_size[1] == 1) {
      b_fv59_size = fv58_size[1];
    } else {
      b_fv59_size = fv59_size[1];
    }

    if (fv51_size[1] == 1) {
      b_fv51_size = fv50_size[1];
    } else {
      b_fv51_size = fv51_size[1];
    }

    if (fv59_size[1] == 1) {
      c_fv59_size = fv58_size[1];
    } else {
      c_fv59_size = fv59_size[1];
    }

    if (fv67_size[1] == 1) {
      c_fv67_size = fv66_size[1];
    } else {
      c_fv67_size = fv67_size[1];
    }

    if (fv75_size[1] == 1) {
      c_fv75_size = fv74_size[1];
    } else {
      c_fv75_size = fv75_size[1];
    }

    if (b_fv75_size == 1) {
      if (b_fv67_size == 1) {
        if (b_fv59_size == 1) {
          if (b_fv51_size == 1) {
            b_fv75_size = 1;
          } else if (fv51_size[1] == 1) {
            b_fv75_size = fv50_size[1];
          } else {
            b_fv75_size = fv51_size[1];
          }
        } else if (c_fv59_size == 1) {
          b_fv75_size = 1;
        } else if (fv59_size[1] == 1) {
          b_fv75_size = fv58_size[1];
        } else {
          b_fv75_size = fv59_size[1];
        }
      } else if (c_fv67_size == 1) {
        b_fv75_size = 1;
      } else if (fv67_size[1] == 1) {
        b_fv75_size = fv66_size[1];
      } else {
        b_fv75_size = fv67_size[1];
      }
    } else if (c_fv75_size == 1) {
      b_fv75_size = 1;
    } else if (fv75_size[1] == 1) {
      b_fv75_size = fv74_size[1];
    } else {
      b_fv75_size = fv75_size[1];
    }

    if (b_fv75_size == 1) {
      Ct_size[1] = 1;
    } else {
      if (fv75_size[1] == 1) {
        b_fv75_size = fv74_size[1];
      } else {
        b_fv75_size = fv75_size[1];
      }

      if (b_fv75_size == 1) {
        b_fv75_size = 1;
      } else if (fv75_size[1] == 1) {
        b_fv75_size = fv74_size[1];
      } else {
        b_fv75_size = fv75_size[1];
      }

      if (b_fv75_size == 1) {
        if (fv67_size[1] == 1) {
          b_fv67_size = fv66_size[1];
        } else {
          b_fv67_size = fv67_size[1];
        }

        if (b_fv67_size == 1) {
          b_fv67_size = 1;
        } else if (fv67_size[1] == 1) {
          b_fv67_size = fv66_size[1];
        } else {
          b_fv67_size = fv67_size[1];
        }

        if (b_fv67_size == 1) {
          if (fv59_size[1] == 1) {
            b_fv59_size = fv58_size[1];
          } else {
            b_fv59_size = fv59_size[1];
          }

          if (b_fv59_size == 1) {
            b_fv59_size = 1;
          } else if (fv59_size[1] == 1) {
            b_fv59_size = fv58_size[1];
          } else {
            b_fv59_size = fv59_size[1];
          }

          if (b_fv59_size == 1) {
            if (fv51_size[1] == 1) {
              b_fv51_size = fv50_size[1];
            } else {
              b_fv51_size = fv51_size[1];
            }

            if (b_fv51_size == 1) {
              Ct_size[1] = 1;
            } else if (fv51_size[1] == 1) {
              Ct_size[1] = fv50_size[1];
            } else {
              Ct_size[1] = fv51_size[1];
            }
          } else {
            if (fv59_size[1] == 1) {
              b_fv59_size = fv58_size[1];
            } else {
              b_fv59_size = fv59_size[1];
            }

            if (b_fv59_size == 1) {
              Ct_size[1] = 1;
            } else if (fv59_size[1] == 1) {
              Ct_size[1] = fv58_size[1];
            } else {
              Ct_size[1] = fv59_size[1];
            }
          }
        } else {
          if (fv67_size[1] == 1) {
            b_fv67_size = fv66_size[1];
          } else {
            b_fv67_size = fv67_size[1];
          }

          if (b_fv67_size == 1) {
            Ct_size[1] = 1;
          } else if (fv67_size[1] == 1) {
            Ct_size[1] = fv66_size[1];
          } else {
            Ct_size[1] = fv67_size[1];
          }
        }
      } else {
        if (fv75_size[1] == 1) {
          b_fv75_size = fv74_size[1];
        } else {
          b_fv75_size = fv75_size[1];
        }

        if (b_fv75_size == 1) {
          Ct_size[1] = 1;
        } else if (fv75_size[1] == 1) {
          Ct_size[1] = fv74_size[1];
        } else {
          Ct_size[1] = fv75_size[1];
        }
      }
    }
  }

  stride_0_0 = (fv38_idx_0 != 1);
  stride_1_0 = (fv13_idx_0 != 1);
  stride_2_1 = (fv11_size[1] != 1);
  stride_3_0 = (fv12_size[0] != 1);
  stride_3_1 = (fv12_size[1] != 1);
  stride_4_0 = (fv21_idx_0 != 1);
  stride_5_1 = (fv19_size[1] != 1);
  stride_6_0 = (fv20_size[0] != 1);
  stride_6_1 = (fv20_size[1] != 1);
  stride_7_0 = (fv29_idx_0 != 1);
  stride_8_1 = (fv27_size[1] != 1);
  stride_9_0 = (fv28_size[0] != 1);
  stride_9_1 = (fv28_size[1] != 1);
  stride_10_0 = (fv37_idx_0 != 1);
  stride_11_1 = (fv35_size[1] != 1);
  stride_12_0 = (fv36_size[0] != 1);
  stride_12_1 = (fv36_size[1] != 1);
  stride_13_0 = (fv77_idx_0 != 1);
  stride_14_0 = (fv52_idx_0 != 1);
  stride_15_1 = (fv50_size[1] != 1);
  stride_16_0 = (fv51_size[0] != 1);
  stride_16_1 = (fv51_size[1] != 1);
  stride_17_0 = (fv60_idx_0 != 1);
  stride_18_1 = (fv58_size[1] != 1);
  stride_19_0 = (fv59_size[0] != 1);
  stride_19_1 = (fv59_size[1] != 1);
  stride_20_0 = (fv68_idx_0 != 1);
  stride_21_1 = (fv66_size[1] != 1);
  stride_22_0 = (fv67_size[0] != 1);
  stride_22_1 = (fv67_size[1] != 1);
  stride_23_0 = (fv76_idx_0 != 1);
  stride_24_1 = (fv74_size[1] != 1);
  stride_25_0 = (fv75_size[0] != 1);
  stride_25_1 = (fv75_size[1] != 1);
  aux_2_1 = 0;
  aux_3_1 = 0;
  aux_5_1 = 0;
  aux_6_1 = 0;
  aux_8_1 = 0;
  aux_9_1 = 0;
  aux_11_1 = 0;
  aux_12_1 = 0;
  aux_15_1 = 0;
  aux_16_1 = 0;
  aux_18_1 = 0;
  aux_19_1 = 0;
  aux_21_1 = 0;
  aux_22_1 = 0;
  aux_24_1 = 0;
  aux_25_1 = 0;
  if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  if (b_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (b_fv67_size == 1) {
    b_fv67_size = 1;
  } else if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (b_fv59_size == 1) {
    b_fv59_size = 1;
  } else if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (fv51_size[1] == 1) {
    b_fv51_size = fv50_size[1];
  } else {
    b_fv51_size = fv51_size[1];
  }

  if (fv59_size[1] == 1) {
    c_fv59_size = fv58_size[1];
  } else {
    c_fv59_size = fv59_size[1];
  }

  if (fv67_size[1] == 1) {
    c_fv67_size = fv66_size[1];
  } else {
    c_fv67_size = fv67_size[1];
  }

  if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (b_fv75_size == 1) {
    if (b_fv67_size == 1) {
      if (b_fv59_size == 1) {
        if (b_fv51_size == 1) {
          b_fv75_size = 1;
        } else if (fv51_size[1] == 1) {
          b_fv75_size = fv50_size[1];
        } else {
          b_fv75_size = fv51_size[1];
        }
      } else if (c_fv59_size == 1) {
        b_fv75_size = 1;
      } else if (fv59_size[1] == 1) {
        b_fv75_size = fv58_size[1];
      } else {
        b_fv75_size = fv59_size[1];
      }
    } else if (c_fv67_size == 1) {
      b_fv75_size = 1;
    } else if (fv67_size[1] == 1) {
      b_fv75_size = fv66_size[1];
    } else {
      b_fv75_size = fv67_size[1];
    }
  } else if (c_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (c_fv75_size == 1) {
    c_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (b_fv67_size == 1) {
    b_fv67_size = 1;
  } else if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (b_fv59_size == 1) {
    b_fv59_size = 1;
  } else if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (fv51_size[1] == 1) {
    b_fv51_size = fv50_size[1];
  } else {
    b_fv51_size = fv51_size[1];
  }

  if (fv59_size[1] == 1) {
    c_fv59_size = fv58_size[1];
  } else {
    c_fv59_size = fv59_size[1];
  }

  if (fv67_size[1] == 1) {
    c_fv67_size = fv66_size[1];
  } else {
    c_fv67_size = fv67_size[1];
  }

  if (fv75_size[1] == 1) {
    d_fv75_size = fv74_size[1];
  } else {
    d_fv75_size = fv75_size[1];
  }

  if (b_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (c_fv75_size == 1) {
    if (b_fv67_size == 1) {
      if (b_fv59_size == 1) {
        if (b_fv51_size == 1) {
          b_fv75_size = 1;
        } else if (fv51_size[1] == 1) {
          b_fv75_size = fv50_size[1];
        } else {
          b_fv75_size = fv51_size[1];
        }
      } else if (c_fv59_size == 1) {
        b_fv75_size = 1;
      } else if (fv59_size[1] == 1) {
        b_fv75_size = fv58_size[1];
      } else {
        b_fv75_size = fv59_size[1];
      }
    } else if (c_fv67_size == 1) {
      b_fv75_size = 1;
    } else if (fv67_size[1] == 1) {
      b_fv75_size = fv66_size[1];
    } else {
      b_fv75_size = fv67_size[1];
    }
  } else if (d_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  if (fv36_size[1] == 1) {
    b_fv36_size = fv35_size[1];
  } else {
    b_fv36_size = fv36_size[1];
  }

  if (b_fv36_size == 1) {
    b_fv36_size = 1;
  } else if (fv36_size[1] == 1) {
    b_fv36_size = fv35_size[1];
  } else {
    b_fv36_size = fv36_size[1];
  }

  if (fv28_size[1] == 1) {
    b_fv28_size = fv27_size[1];
  } else {
    b_fv28_size = fv28_size[1];
  }

  if (b_fv28_size == 1) {
    b_fv28_size = 1;
  } else if (fv28_size[1] == 1) {
    b_fv28_size = fv27_size[1];
  } else {
    b_fv28_size = fv28_size[1];
  }

  if (fv20_size[1] == 1) {
    b_fv20_size = fv19_size[1];
  } else {
    b_fv20_size = fv20_size[1];
  }

  if (b_fv20_size == 1) {
    b_fv20_size = 1;
  } else if (fv20_size[1] == 1) {
    b_fv20_size = fv19_size[1];
  } else {
    b_fv20_size = fv20_size[1];
  }

  if (fv12_size[1] == 1) {
    b_fv12_size = fv11_size[1];
  } else {
    b_fv12_size = fv12_size[1];
  }

  if (fv20_size[1] == 1) {
    c_fv20_size = fv19_size[1];
  } else {
    c_fv20_size = fv20_size[1];
  }

  if (fv28_size[1] == 1) {
    c_fv28_size = fv27_size[1];
  } else {
    c_fv28_size = fv28_size[1];
  }

  if (fv36_size[1] == 1) {
    c_fv36_size = fv35_size[1];
  } else {
    c_fv36_size = fv36_size[1];
  }

  if (b_fv36_size == 1) {
    if (b_fv28_size == 1) {
      if (b_fv20_size == 1) {
        if (b_fv12_size == 1) {
          b_fv36_size = 1;
        } else if (fv12_size[1] == 1) {
          b_fv36_size = fv11_size[1];
        } else {
          b_fv36_size = fv12_size[1];
        }
      } else if (c_fv20_size == 1) {
        b_fv36_size = 1;
      } else if (fv20_size[1] == 1) {
        b_fv36_size = fv19_size[1];
      } else {
        b_fv36_size = fv20_size[1];
      }
    } else if (c_fv28_size == 1) {
      b_fv36_size = 1;
    } else if (fv28_size[1] == 1) {
      b_fv36_size = fv27_size[1];
    } else {
      b_fv36_size = fv28_size[1];
    }
  } else if (c_fv36_size == 1) {
    b_fv36_size = 1;
  } else if (fv36_size[1] == 1) {
    b_fv36_size = fv35_size[1];
  } else {
    b_fv36_size = fv36_size[1];
  }

  if (fv36_size[1] == 1) {
    c_fv36_size = fv35_size[1];
  } else {
    c_fv36_size = fv36_size[1];
  }

  if (c_fv36_size == 1) {
    c_fv36_size = 1;
  } else if (fv36_size[1] == 1) {
    c_fv36_size = fv35_size[1];
  } else {
    c_fv36_size = fv36_size[1];
  }

  if (fv28_size[1] == 1) {
    b_fv28_size = fv27_size[1];
  } else {
    b_fv28_size = fv28_size[1];
  }

  if (b_fv28_size == 1) {
    b_fv28_size = 1;
  } else if (fv28_size[1] == 1) {
    b_fv28_size = fv27_size[1];
  } else {
    b_fv28_size = fv28_size[1];
  }

  if (fv20_size[1] == 1) {
    b_fv20_size = fv19_size[1];
  } else {
    b_fv20_size = fv20_size[1];
  }

  if (b_fv20_size == 1) {
    b_fv20_size = 1;
  } else if (fv20_size[1] == 1) {
    b_fv20_size = fv19_size[1];
  } else {
    b_fv20_size = fv20_size[1];
  }

  if (fv12_size[1] == 1) {
    b_fv12_size = fv11_size[1];
  } else {
    b_fv12_size = fv12_size[1];
  }

  if (fv20_size[1] == 1) {
    c_fv20_size = fv19_size[1];
  } else {
    c_fv20_size = fv20_size[1];
  }

  if (fv28_size[1] == 1) {
    c_fv28_size = fv27_size[1];
  } else {
    c_fv28_size = fv28_size[1];
  }

  if (fv36_size[1] == 1) {
    d_fv36_size = fv35_size[1];
  } else {
    d_fv36_size = fv36_size[1];
  }

  if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (c_fv75_size == 1) {
    c_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (b_fv67_size == 1) {
    b_fv67_size = 1;
  } else if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (b_fv59_size == 1) {
    b_fv59_size = 1;
  } else if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (fv51_size[1] == 1) {
    b_fv51_size = fv50_size[1];
  } else {
    b_fv51_size = fv51_size[1];
  }

  if (fv59_size[1] == 1) {
    c_fv59_size = fv58_size[1];
  } else {
    c_fv59_size = fv59_size[1];
  }

  if (fv67_size[1] == 1) {
    c_fv67_size = fv66_size[1];
  } else {
    c_fv67_size = fv67_size[1];
  }

  if (fv75_size[1] == 1) {
    d_fv75_size = fv74_size[1];
  } else {
    d_fv75_size = fv75_size[1];
  }

  if (c_fv75_size == 1) {
    if (b_fv67_size == 1) {
      if (b_fv59_size == 1) {
        if (b_fv51_size == 1) {
          c_fv75_size = 1;
        } else if (fv51_size[1] == 1) {
          c_fv75_size = fv50_size[1];
        } else {
          c_fv75_size = fv51_size[1];
        }
      } else if (c_fv59_size == 1) {
        c_fv75_size = 1;
      } else if (fv59_size[1] == 1) {
        c_fv75_size = fv58_size[1];
      } else {
        c_fv75_size = fv59_size[1];
      }
    } else if (c_fv67_size == 1) {
      c_fv75_size = 1;
    } else if (fv67_size[1] == 1) {
      c_fv75_size = fv66_size[1];
    } else {
      c_fv75_size = fv67_size[1];
    }
  } else if (d_fv75_size == 1) {
    c_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    c_fv75_size = fv74_size[1];
  } else {
    c_fv75_size = fv75_size[1];
  }

  if (fv75_size[1] == 1) {
    d_fv75_size = fv74_size[1];
  } else {
    d_fv75_size = fv75_size[1];
  }

  if (d_fv75_size == 1) {
    d_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    d_fv75_size = fv74_size[1];
  } else {
    d_fv75_size = fv75_size[1];
  }

  if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (b_fv67_size == 1) {
    b_fv67_size = 1;
  } else if (fv67_size[1] == 1) {
    b_fv67_size = fv66_size[1];
  } else {
    b_fv67_size = fv67_size[1];
  }

  if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (b_fv59_size == 1) {
    b_fv59_size = 1;
  } else if (fv59_size[1] == 1) {
    b_fv59_size = fv58_size[1];
  } else {
    b_fv59_size = fv59_size[1];
  }

  if (fv51_size[1] == 1) {
    b_fv51_size = fv50_size[1];
  } else {
    b_fv51_size = fv51_size[1];
  }

  if (fv59_size[1] == 1) {
    c_fv59_size = fv58_size[1];
  } else {
    c_fv59_size = fv59_size[1];
  }

  if (fv67_size[1] == 1) {
    c_fv67_size = fv66_size[1];
  } else {
    c_fv67_size = fv67_size[1];
  }

  if (fv75_size[1] == 1) {
    e_fv75_size = fv74_size[1];
  } else {
    e_fv75_size = fv75_size[1];
  }

  if (b_fv75_size == 1) {
    if (b_fv36_size == 1) {
      b_fv75_size = 1;
    } else if (c_fv36_size == 1) {
      if (b_fv28_size == 1) {
        if (b_fv20_size == 1) {
          if (b_fv12_size == 1) {
            b_fv75_size = 1;
          } else if (fv12_size[1] == 1) {
            b_fv75_size = fv11_size[1];
          } else {
            b_fv75_size = fv12_size[1];
          }
        } else if (c_fv20_size == 1) {
          b_fv75_size = 1;
        } else if (fv20_size[1] == 1) {
          b_fv75_size = fv19_size[1];
        } else {
          b_fv75_size = fv20_size[1];
        }
      } else if (c_fv28_size == 1) {
        b_fv75_size = 1;
      } else if (fv28_size[1] == 1) {
        b_fv75_size = fv27_size[1];
      } else {
        b_fv75_size = fv28_size[1];
      }
    } else if (d_fv36_size == 1) {
      b_fv75_size = 1;
    } else if (fv36_size[1] == 1) {
      b_fv75_size = fv35_size[1];
    } else {
      b_fv75_size = fv36_size[1];
    }
  } else if (c_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (d_fv75_size == 1) {
    if (b_fv67_size == 1) {
      if (b_fv59_size == 1) {
        if (b_fv51_size == 1) {
          b_fv75_size = 1;
        } else if (fv51_size[1] == 1) {
          b_fv75_size = fv50_size[1];
        } else {
          b_fv75_size = fv51_size[1];
        }
      } else if (c_fv59_size == 1) {
        b_fv75_size = 1;
      } else if (fv59_size[1] == 1) {
        b_fv75_size = fv58_size[1];
      } else {
        b_fv75_size = fv59_size[1];
      }
    } else if (c_fv67_size == 1) {
      b_fv75_size = 1;
    } else if (fv67_size[1] == 1) {
      b_fv75_size = fv66_size[1];
    } else {
      b_fv75_size = fv67_size[1];
    }
  } else if (e_fv75_size == 1) {
    b_fv75_size = 1;
  } else if (fv75_size[1] == 1) {
    b_fv75_size = fv74_size[1];
  } else {
    b_fv75_size = fv75_size[1];
  }

  for (int32_T i{0}; i < b_fv75_size; i++) {
    int32_T f_fv75_size;
    if (fv75_size[0] == 1) {
      c_fv75_size = 1;
    } else {
      c_fv75_size = fv75_size[0];
    }

    if (c_fv75_size == 1) {
      c_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      c_fv75_size = 1;
    } else {
      c_fv75_size = fv75_size[0];
    }

    if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (b_fv67_size == 1) {
      b_fv67_size = fv68_idx_0;
    } else if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (b_fv59_size == 1) {
      b_fv59_size = fv60_idx_0;
    } else if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (fv51_size[0] == 1) {
      b_fv51_size = 1;
    } else {
      b_fv51_size = fv51_size[0];
    }

    if (fv59_size[0] == 1) {
      c_fv59_size = 1;
    } else {
      c_fv59_size = fv59_size[0];
    }

    if (fv67_size[0] == 1) {
      c_fv67_size = 1;
    } else {
      c_fv67_size = fv67_size[0];
    }

    if (fv75_size[0] == 1) {
      d_fv75_size = 1;
    } else {
      d_fv75_size = fv75_size[0];
    }

    if (c_fv75_size == 1) {
      if (b_fv67_size == 1) {
        if (b_fv59_size == 1) {
          if (b_fv51_size == 1) {
            c_fv75_size = fv52_idx_0;
          } else if (fv51_size[0] == 1) {
            c_fv75_size = 1;
          } else {
            c_fv75_size = fv51_size[0];
          }
        } else if (c_fv59_size == 1) {
          c_fv75_size = fv60_idx_0;
        } else if (fv59_size[0] == 1) {
          c_fv75_size = 1;
        } else {
          c_fv75_size = fv59_size[0];
        }
      } else if (c_fv67_size == 1) {
        c_fv75_size = fv68_idx_0;
      } else if (fv67_size[0] == 1) {
        c_fv75_size = 1;
      } else {
        c_fv75_size = fv67_size[0];
      }
    } else if (d_fv75_size == 1) {
      c_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      c_fv75_size = 1;
    } else {
      c_fv75_size = fv75_size[0];
    }

    if (fv75_size[0] == 1) {
      d_fv75_size = 1;
    } else {
      d_fv75_size = fv75_size[0];
    }

    if (d_fv75_size == 1) {
      d_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      d_fv75_size = 1;
    } else {
      d_fv75_size = fv75_size[0];
    }

    if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (b_fv67_size == 1) {
      b_fv67_size = fv68_idx_0;
    } else if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (b_fv59_size == 1) {
      b_fv59_size = fv60_idx_0;
    } else if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (fv51_size[0] == 1) {
      b_fv51_size = 1;
    } else {
      b_fv51_size = fv51_size[0];
    }

    if (fv59_size[0] == 1) {
      c_fv59_size = 1;
    } else {
      c_fv59_size = fv59_size[0];
    }

    if (fv67_size[0] == 1) {
      c_fv67_size = 1;
    } else {
      c_fv67_size = fv67_size[0];
    }

    if (fv75_size[0] == 1) {
      e_fv75_size = 1;
    } else {
      e_fv75_size = fv75_size[0];
    }

    if (c_fv75_size == 1) {
      c_fv75_size = fv77_idx_0;
    } else if (d_fv75_size == 1) {
      if (b_fv67_size == 1) {
        if (b_fv59_size == 1) {
          if (b_fv51_size == 1) {
            c_fv75_size = fv52_idx_0;
          } else if (fv51_size[0] == 1) {
            c_fv75_size = 1;
          } else {
            c_fv75_size = fv51_size[0];
          }
        } else if (c_fv59_size == 1) {
          c_fv75_size = fv60_idx_0;
        } else if (fv59_size[0] == 1) {
          c_fv75_size = 1;
        } else {
          c_fv75_size = fv59_size[0];
        }
      } else if (c_fv67_size == 1) {
        c_fv75_size = fv68_idx_0;
      } else if (fv67_size[0] == 1) {
        c_fv75_size = 1;
      } else {
        c_fv75_size = fv67_size[0];
      }
    } else if (e_fv75_size == 1) {
      c_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      c_fv75_size = 1;
    } else {
      c_fv75_size = fv75_size[0];
    }

    if (fv36_size[0] == 1) {
      b_fv36_size = 1;
    } else {
      b_fv36_size = fv36_size[0];
    }

    if (b_fv36_size == 1) {
      b_fv36_size = fv37_idx_0;
    } else if (fv36_size[0] == 1) {
      b_fv36_size = 1;
    } else {
      b_fv36_size = fv36_size[0];
    }

    if (fv28_size[0] == 1) {
      b_fv28_size = 1;
    } else {
      b_fv28_size = fv28_size[0];
    }

    if (b_fv28_size == 1) {
      b_fv28_size = fv29_idx_0;
    } else if (fv28_size[0] == 1) {
      b_fv28_size = 1;
    } else {
      b_fv28_size = fv28_size[0];
    }

    if (fv20_size[0] == 1) {
      b_fv20_size = 1;
    } else {
      b_fv20_size = fv20_size[0];
    }

    if (b_fv20_size == 1) {
      b_fv20_size = fv21_idx_0;
    } else if (fv20_size[0] == 1) {
      b_fv20_size = 1;
    } else {
      b_fv20_size = fv20_size[0];
    }

    if (fv12_size[0] == 1) {
      b_fv12_size = 1;
    } else {
      b_fv12_size = fv12_size[0];
    }

    if (fv20_size[0] == 1) {
      c_fv20_size = 1;
    } else {
      c_fv20_size = fv20_size[0];
    }

    if (fv28_size[0] == 1) {
      c_fv28_size = 1;
    } else {
      c_fv28_size = fv28_size[0];
    }

    if (fv36_size[0] == 1) {
      c_fv36_size = 1;
    } else {
      c_fv36_size = fv36_size[0];
    }

    if (b_fv36_size == 1) {
      if (b_fv28_size == 1) {
        if (b_fv20_size == 1) {
          if (b_fv12_size == 1) {
            b_fv36_size = fv13_idx_0;
          } else if (fv12_size[0] == 1) {
            b_fv36_size = 1;
          } else {
            b_fv36_size = fv12_size[0];
          }
        } else if (c_fv20_size == 1) {
          b_fv36_size = fv21_idx_0;
        } else if (fv20_size[0] == 1) {
          b_fv36_size = 1;
        } else {
          b_fv36_size = fv20_size[0];
        }
      } else if (c_fv28_size == 1) {
        b_fv36_size = fv29_idx_0;
      } else if (fv28_size[0] == 1) {
        b_fv36_size = 1;
      } else {
        b_fv36_size = fv28_size[0];
      }
    } else if (c_fv36_size == 1) {
      b_fv36_size = fv37_idx_0;
    } else if (fv36_size[0] == 1) {
      b_fv36_size = 1;
    } else {
      b_fv36_size = fv36_size[0];
    }

    if (fv36_size[0] == 1) {
      c_fv36_size = 1;
    } else {
      c_fv36_size = fv36_size[0];
    }

    if (c_fv36_size == 1) {
      c_fv36_size = fv37_idx_0;
    } else if (fv36_size[0] == 1) {
      c_fv36_size = 1;
    } else {
      c_fv36_size = fv36_size[0];
    }

    if (fv28_size[0] == 1) {
      b_fv28_size = 1;
    } else {
      b_fv28_size = fv28_size[0];
    }

    if (b_fv28_size == 1) {
      b_fv28_size = fv29_idx_0;
    } else if (fv28_size[0] == 1) {
      b_fv28_size = 1;
    } else {
      b_fv28_size = fv28_size[0];
    }

    if (fv20_size[0] == 1) {
      b_fv20_size = 1;
    } else {
      b_fv20_size = fv20_size[0];
    }

    if (b_fv20_size == 1) {
      b_fv20_size = fv21_idx_0;
    } else if (fv20_size[0] == 1) {
      b_fv20_size = 1;
    } else {
      b_fv20_size = fv20_size[0];
    }

    if (fv12_size[0] == 1) {
      b_fv12_size = 1;
    } else {
      b_fv12_size = fv12_size[0];
    }

    if (fv20_size[0] == 1) {
      c_fv20_size = 1;
    } else {
      c_fv20_size = fv20_size[0];
    }

    if (fv28_size[0] == 1) {
      c_fv28_size = 1;
    } else {
      c_fv28_size = fv28_size[0];
    }

    if (fv36_size[0] == 1) {
      d_fv36_size = 1;
    } else {
      d_fv36_size = fv36_size[0];
    }

    if (fv75_size[0] == 1) {
      d_fv75_size = 1;
    } else {
      d_fv75_size = fv75_size[0];
    }

    if (d_fv75_size == 1) {
      d_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      d_fv75_size = 1;
    } else {
      d_fv75_size = fv75_size[0];
    }

    if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (b_fv67_size == 1) {
      b_fv67_size = fv68_idx_0;
    } else if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (b_fv59_size == 1) {
      b_fv59_size = fv60_idx_0;
    } else if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (fv51_size[0] == 1) {
      b_fv51_size = 1;
    } else {
      b_fv51_size = fv51_size[0];
    }

    if (fv59_size[0] == 1) {
      c_fv59_size = 1;
    } else {
      c_fv59_size = fv59_size[0];
    }

    if (fv67_size[0] == 1) {
      c_fv67_size = 1;
    } else {
      c_fv67_size = fv67_size[0];
    }

    if (fv75_size[0] == 1) {
      e_fv75_size = 1;
    } else {
      e_fv75_size = fv75_size[0];
    }

    if (d_fv75_size == 1) {
      if (b_fv67_size == 1) {
        if (b_fv59_size == 1) {
          if (b_fv51_size == 1) {
            d_fv75_size = fv52_idx_0;
          } else if (fv51_size[0] == 1) {
            d_fv75_size = 1;
          } else {
            d_fv75_size = fv51_size[0];
          }
        } else if (c_fv59_size == 1) {
          d_fv75_size = fv60_idx_0;
        } else if (fv59_size[0] == 1) {
          d_fv75_size = 1;
        } else {
          d_fv75_size = fv59_size[0];
        }
      } else if (c_fv67_size == 1) {
        d_fv75_size = fv68_idx_0;
      } else if (fv67_size[0] == 1) {
        d_fv75_size = 1;
      } else {
        d_fv75_size = fv67_size[0];
      }
    } else if (e_fv75_size == 1) {
      d_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      d_fv75_size = 1;
    } else {
      d_fv75_size = fv75_size[0];
    }

    if (fv75_size[0] == 1) {
      e_fv75_size = 1;
    } else {
      e_fv75_size = fv75_size[0];
    }

    if (e_fv75_size == 1) {
      e_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      e_fv75_size = 1;
    } else {
      e_fv75_size = fv75_size[0];
    }

    if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (b_fv67_size == 1) {
      b_fv67_size = fv68_idx_0;
    } else if (fv67_size[0] == 1) {
      b_fv67_size = 1;
    } else {
      b_fv67_size = fv67_size[0];
    }

    if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (b_fv59_size == 1) {
      b_fv59_size = fv60_idx_0;
    } else if (fv59_size[0] == 1) {
      b_fv59_size = 1;
    } else {
      b_fv59_size = fv59_size[0];
    }

    if (fv51_size[0] == 1) {
      b_fv51_size = 1;
    } else {
      b_fv51_size = fv51_size[0];
    }

    if (fv59_size[0] == 1) {
      c_fv59_size = 1;
    } else {
      c_fv59_size = fv59_size[0];
    }

    if (fv67_size[0] == 1) {
      c_fv67_size = 1;
    } else {
      c_fv67_size = fv67_size[0];
    }

    if (fv75_size[0] == 1) {
      f_fv75_size = 1;
    } else {
      f_fv75_size = fv75_size[0];
    }

    if (c_fv75_size == 1) {
      if (b_fv36_size == 1) {
        c_fv75_size = fv38_idx_0;
      } else if (c_fv36_size == 1) {
        if (b_fv28_size == 1) {
          if (b_fv20_size == 1) {
            if (b_fv12_size == 1) {
              c_fv75_size = fv13_idx_0;
            } else if (fv12_size[0] == 1) {
              c_fv75_size = 1;
            } else {
              c_fv75_size = fv12_size[0];
            }
          } else if (c_fv20_size == 1) {
            c_fv75_size = fv21_idx_0;
          } else if (fv20_size[0] == 1) {
            c_fv75_size = 1;
          } else {
            c_fv75_size = fv20_size[0];
          }
        } else if (c_fv28_size == 1) {
          c_fv75_size = fv29_idx_0;
        } else if (fv28_size[0] == 1) {
          c_fv75_size = 1;
        } else {
          c_fv75_size = fv28_size[0];
        }
      } else if (d_fv36_size == 1) {
        c_fv75_size = fv37_idx_0;
      } else if (fv36_size[0] == 1) {
        c_fv75_size = 1;
      } else {
        c_fv75_size = fv36_size[0];
      }
    } else if (d_fv75_size == 1) {
      c_fv75_size = fv77_idx_0;
    } else if (e_fv75_size == 1) {
      if (b_fv67_size == 1) {
        if (b_fv59_size == 1) {
          if (b_fv51_size == 1) {
            c_fv75_size = fv52_idx_0;
          } else if (fv51_size[0] == 1) {
            c_fv75_size = 1;
          } else {
            c_fv75_size = fv51_size[0];
          }
        } else if (c_fv59_size == 1) {
          c_fv75_size = fv60_idx_0;
        } else if (fv59_size[0] == 1) {
          c_fv75_size = 1;
        } else {
          c_fv75_size = fv59_size[0];
        }
      } else if (c_fv67_size == 1) {
        c_fv75_size = fv68_idx_0;
      } else if (fv67_size[0] == 1) {
        c_fv75_size = 1;
      } else {
        c_fv75_size = fv67_size[0];
      }
    } else if (f_fv75_size == 1) {
      c_fv75_size = fv76_idx_0;
    } else if (fv75_size[0] == 1) {
      c_fv75_size = 1;
    } else {
      c_fv75_size = fv75_size[0];
    }

    for (b_fv67_size = 0; b_fv67_size < c_fv75_size; b_fv67_size++) {
      Ct_data[b_fv67_size + Ct_size[0] * i] = fv38_data[b_fv67_size * stride_0_0]
        * (((fv13_data[b_fv67_size * stride_1_0] * (fv11_data[aux_2_1] -
              fv12_data[b_fv67_size * stride_3_0 + fv12_size[0] * aux_3_1]) +
             fv21_data[b_fv67_size * stride_4_0] * (fv19_data[aux_5_1] -
              fv20_data[b_fv67_size * stride_6_0 + fv20_size[0] * aux_6_1])) +
            fv29_data[b_fv67_size * stride_7_0] * (fv27_data[aux_8_1] -
             fv28_data[b_fv67_size * stride_9_0 + fv28_size[0] * aux_9_1])) +
           fv37_data[b_fv67_size * stride_10_0] * (fv35_data[aux_11_1] -
            fv36_data[b_fv67_size * stride_12_0 + fv36_size[0] * aux_12_1])) +
        fv77_data[b_fv67_size * stride_13_0] * (((fv52_data[b_fv67_size *
        stride_14_0] * (fv50_data[aux_15_1] - fv51_data[b_fv67_size *
                        stride_16_0 + fv51_size[0] * aux_16_1]) +
        fv60_data[b_fv67_size * stride_17_0] * (fv58_data[aux_18_1] -
        fv59_data[b_fv67_size * stride_19_0 + fv59_size[0] * aux_19_1])) +
        fv68_data[b_fv67_size * stride_20_0] * (fv66_data[aux_21_1] -
        fv67_data[b_fv67_size * stride_22_0 + fv67_size[0] * aux_22_1])) +
        fv76_data[b_fv67_size * stride_23_0] * (fv74_data[aux_24_1] -
        fv75_data[b_fv67_size * stride_25_0 + fv75_size[0] * aux_25_1]));
    }

    aux_25_1 += stride_25_1;
    aux_24_1 += stride_24_1;
    aux_22_1 += stride_22_1;
    aux_21_1 += stride_21_1;
    aux_19_1 += stride_19_1;
    aux_18_1 += stride_18_1;
    aux_16_1 += stride_16_1;
    aux_15_1 += stride_15_1;
    aux_12_1 += stride_12_1;
    aux_11_1 += stride_11_1;
    aux_9_1 += stride_9_1;
    aux_8_1 += stride_8_1;
    aux_6_1 += stride_6_1;
    aux_5_1 += stride_5_1;
    aux_3_1 += stride_3_1;
    aux_2_1 += stride_2_1;
  }
}

static void binary_expand_op(real32_T fv73_data[], int32_T fv73_size[1], const
  real32_T PL_data[], const int32_T PL_size[2], const real32_T fv72_data[],
  const int32_T fv72_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv72_size[0] == 1) {
    if (i1 == 1) {
      fv73_size[0] = i;
    } else {
      fv73_size[0] = i1;
    }
  } else {
    fv73_size[0] = fv72_size[0];
  }

  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv72_size[0] != 1);
  if (fv72_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv72_size[0];
  }

  for (i = 0; i < i1; i++) {
    fv73_data[i] = -((((PL_data[i * stride_0_0 + PL_size[0]] + PL_data[i *
                        stride_0_0 + PL_size[0] * 2]) + PL_data[i * stride_1_0 +
                       PL_size[0] * 3]) - fv72_data[i * stride_2_0]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  c_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv4_data[76800], const int32_T fv4_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv4_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv4_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static void c_binary_expand_op(real32_T fv34_data[], int32_T fv34_size[1], const
  real32_T PL_data[], const int32_T PL_size[2], const real32_T fv33_data[],
  const int32_T fv33_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv33_size[0] == 1) {
    if (i1 == 1) {
      fv34_size[0] = i;
    } else {
      fv34_size[0] = i1;
    }
  } else {
    fv34_size[0] = fv33_size[0];
  }

  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv33_size[0] != 1);
  if (fv33_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv33_size[0];
  }

  for (i = 0; i < i1; i++) {
    fv34_data[i] = -((((PL_data[i * stride_0_0 + PL_size[0]] + PL_data[i *
                        stride_0_0 + PL_size[0] * 2]) + PL_data[i * stride_1_0 +
                       PL_size[0] * 3]) + fv33_data[i * stride_2_0]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  cb_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T Local_Estimates, const int32_T PI_Time_fine_size, real32_T fv19_data
  [801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(PI_Time_fine_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv19_data[i] = Local_Estimates * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  cc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv32_data[76800], const int32_T fv32_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv32_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv32_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  cd_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ce_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv61_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv61_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  cf_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv75_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv75_data[k] = expf(fv75_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  d_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv5_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv5_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  db_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv19_data[801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv19_data[k] = expf(fv19_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  dc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv33_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv33_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  dd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv47_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv47_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  de_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv61_data[76800], const int32_T fv61_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv61_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv61_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  df_TTCM_analytic_Multi_GPU_kern(const real32_T Local_Estimates, const real32_T
  fv70_data[76800], const real32_T PL_data[], const int32_T PL_size[2], const
  real32_T b_Local_Estimates, const int32_T nx, real32_T fv76_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv76_data[i] = b_Local_Estimates / ((((PL_data[i + PL_size[0]] + PL_data[i +
      PL_size[0] * 2]) + PL_data[i + PL_size[0] * 3]) - fv70_data[i]) / 2.0F -
      Local_Estimates);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  e_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  eb_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T fv18_data[76800], const int32_T fv20_size[2], const int32_T fv10,
  const int32_T PI_Time_fine_size, real32_T fv20_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (PI_Time_fine_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) / (static_cast<
      uint64_T>(fv10) + 1ULL));
    fv20_data[k + fv20_size[0] * i] = fv18_data[k] * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ec_TTCM_analytic_Multi_GPU_kern(const real32_T fv33_data[76800], const
  real32_T PL_data[], const int32_T PL_size[2], const int32_T nx, real32_T
  fv34_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv34_data[i] = -((((PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
                       PL_data[i + PL_size[0] * 3]) + fv33_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ed_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv47_data[76800], const int32_T fv47_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv47_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv47_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ee_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv62_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv62_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ef_TTCM_analytic_Multi_GPU_kern(const real32_T fv44_data[76800], const
  real32_T fv42_data[76800], const real32_T fv40_data[76800], const int32_T
  PL_size[2], const real32_T PL_data[], const int32_T nx, real32_T fv77_data
  [76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    real32_T f;
    real32_T f1;
    real32_T f2;
    real32_T f3;
    i = static_cast<int32_T>(idx);
    f = PL_data[i];
    f1 = PL_data[i + PL_size[0] * 2];
    f2 = PL_data[i + PL_size[0]];
    f3 = PL_data[i + PL_size[0] * 3];
    fv77_data[i] = (f * f1 - f * ((((f2 + f1) + f3) - fv40_data[i]) / 2.0F - f3))
      / ((((f2 + f1) + f3) + fv42_data[i]) / 2.0F - (((f2 + f1) + f3) -
          fv44_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  f_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv6_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv6_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  fb_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv20_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv20_data[k] = expf(fv20_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  fc_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T Local_Estimates, const int32_T PI_Time_fine_size, real32_T fv35_data
  [801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(PI_Time_fine_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv35_data[i] = Local_Estimates * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  fd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv48_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv48_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  fe_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ff_TTCM_analytic_Multi_GPU_kern(const real32_T fv75_data[61516800], const
  int32_T fv75_size[2], const real32_T fv74_data[801], const real32_T fv76_data
  [76800], const real32_T fv67_data[61516800], const int32_T fv67_size[2], const
  real32_T fv66_data[801], const real32_T fv68_data[76800], const real32_T
  fv59_data[61516800], const int32_T fv59_size[2], const real32_T fv58_data[801],
  const real32_T fv60_data[76800], const real32_T fv51_data[61516800], const
  int32_T fv51_size[2], const real32_T fv50_data[801], const real32_T fv52_data
  [76800], const real32_T fv77_data[76800], const real32_T fv36_data[61516800],
  const int32_T fv36_size[2], const real32_T fv35_data[801], const real32_T
  fv37_data[76800], const real32_T fv28_data[61516800], const int32_T fv28_size
  [2], const real32_T fv27_data[801], const real32_T fv29_data[76800], const
  real32_T fv20_data[61516800], const int32_T fv20_size[2], const real32_T
  fv19_data[801], const real32_T fv21_data[76800], const real32_T fv12_data
  [61516800], const int32_T fv12_size[2], const real32_T fv11_data[801], const
  real32_T fv13_data[76800], const real32_T fv38_data[76800], const int32_T
  Ct_size[2], const int32_T fv10, const int32_T fv11_size, real32_T Ct_data[])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (fv11_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(fv10) + 1ULL));
    Ct_data[k + Ct_size[0] * i] = fv38_data[k] * (((fv13_data[k] * (fv11_data[i]
      - fv12_data[k + fv12_size[0] * i]) + fv21_data[k] * (fv19_data[i] -
      fv20_data[k + fv20_size[0] * i])) + fv29_data[k] * (fv27_data[i] -
      fv28_data[k + fv28_size[0] * i])) + fv37_data[k] * (fv35_data[i] -
      fv36_data[k + fv36_size[0] * i])) + fv77_data[k] * (((fv52_data[k] *
      (fv50_data[i] - fv51_data[k + fv51_size[0] * i]) + fv60_data[k] *
      (fv58_data[i] - fv59_data[k + fv59_size[0] * i])) + fv68_data[k] *
      (fv66_data[i] - fv67_data[k + fv67_size[0] * i])) + fv76_data[k] *
      (fv74_data[i] - fv75_data[k + fv75_size[0] * i]));
  }
}

static __global__ __launch_bounds__(1024, 1) void
  g_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv6_data[76800], const int32_T fv6_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv6_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv6_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  gb_TTCM_analytic_Multi_GPU_kern(const real32_T Local_Estimates, const real32_T
  fv15_data[76800], const real32_T PL_data[], const int32_T PL_size[2], const
  real32_T b_Local_Estimates, const int32_T nx, real32_T fv21_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv21_data[i] = b_Local_Estimates / ((((PL_data[i + PL_size[0]] + PL_data[i +
      PL_size[0] * 2]) + PL_data[i + PL_size[0] * 3]) + fv15_data[i]) / 2.0F -
      Local_Estimates);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  gc_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv35_data[801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv35_data[k] = expf(fv35_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  gd_TTCM_analytic_Multi_GPU_kern(const real32_T fv48_data[76800], const
  real32_T PL_data[], const int32_T PL_size[2], const int32_T nx, real32_T
  fv49_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv49_data[i] = -((((PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
                       PL_data[i + PL_size[0] * 3]) - fv48_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ge_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv63_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv63_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  h_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv7_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv7_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  hb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  hc_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T fv34_data[76800], const int32_T fv36_size[2], const int32_T fv10,
  const int32_T PI_Time_fine_size, real32_T fv36_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (PI_Time_fine_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) / (static_cast<
      uint64_T>(fv10) + 1ULL));
    fv36_data[k + fv36_size[0] * i] = fv34_data[k] * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  hd_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T Local_Estimates, const int32_T PI_Time_fine_size, real32_T fv50_data
  [801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(PI_Time_fine_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv50_data[i] = Local_Estimates * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  he_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv63_data[76800], const int32_T fv63_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv63_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv63_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  i_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ib_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv22_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv22_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ic_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv36_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv36_data[k] = expf(fv36_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  id_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv50_data[801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv50_data[k] = expf(fv50_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ie_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv64_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv64_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  j_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv8_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv8_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  jb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv22_data[76800], const int32_T fv22_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv22_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv22_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  jc_TTCM_analytic_Multi_GPU_kern(const real32_T Local_Estimates, const real32_T
  fv31_data[76800], const real32_T PL_data[], const int32_T PL_size[2], const
  real32_T b_Local_Estimates, const int32_T nx, real32_T fv37_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv37_data[i] = b_Local_Estimates / ((((PL_data[i + PL_size[0]] + PL_data[i +
      PL_size[0] * 2]) + PL_data[i + PL_size[0] * 3]) + fv31_data[i]) / 2.0F -
      Local_Estimates);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  jd_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T fv49_data[76800], const int32_T fv51_size[2], const int32_T fv10,
  const int32_T PI_Time_fine_size, real32_T fv51_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (PI_Time_fine_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) / (static_cast<
      uint64_T>(fv10) + 1ULL));
    fv51_data[k + fv51_size[0] * i] = fv49_data[k] * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  je_TTCM_analytic_Multi_GPU_kern(const real32_T fv64_data[76800], const
  real32_T PL_data[], const int32_T PL_size[2], const int32_T nx, real32_T
  fv65_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv65_data[i] = -((((PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
                       PL_data[i + PL_size[0] * 3]) - fv64_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  k_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv8_data[76800], const int32_T fv8_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv8_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv8_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  kb_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv23_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv23_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  kc_TTCM_analytic_Multi_GPU_kern(const real32_T fv5_data[76800], const real32_T
  fv3_data[76800], const real32_T fv1_data[76800], const int32_T PL_size[2],
  const real32_T PL_data[], const int32_T nx, real32_T fv38_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    real32_T f;
    real32_T f1;
    real32_T f2;
    real32_T f3;
    i = static_cast<int32_T>(idx);
    f = PL_data[i];
    f1 = PL_data[i + PL_size[0]];
    f2 = PL_data[i + PL_size[0] * 2];
    f3 = PL_data[i + PL_size[0] * 3];
    fv38_data[i] = (f * ((((f1 + f2) + f3) + fv1_data[i]) / 2.0F - f3) - f * f2)
      / ((((f1 + f2) + f3) + fv3_data[i]) / 2.0F - (((f1 + f2) + f3) -
          fv5_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  kd_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv51_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv51_data[k] = expf(fv51_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ke_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T Local_Estimates, const int32_T PI_Time_fine_size, real32_T fv66_data
  [801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(PI_Time_fine_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv66_data[i] = Local_Estimates * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  l_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv9_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv9_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  lb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  lc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ld_TTCM_analytic_Multi_GPU_kern(const real32_T Local_Estimates, const real32_T
  fv46_data[76800], const real32_T PL_data[], const int32_T PL_size[2], const
  real32_T b_Local_Estimates, const int32_T nx, real32_T fv52_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv52_data[i] = b_Local_Estimates / ((((PL_data[i + PL_size[0]] + PL_data[i +
      PL_size[0] * 2]) + PL_data[i + PL_size[0] * 3]) - fv46_data[i]) / 2.0F -
      Local_Estimates);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  le_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv66_data[801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv66_data[k] = expf(fv66_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  m_TTCM_analytic_Multi_GPU_kerne(const real32_T fv9_data[76800], const real32_T
  PL_data[], const int32_T PL_size[2], const int32_T nx, real32_T fv10_data
  [76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv10_data[i] = -((((PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
                       PL_data[i + PL_size[0] * 3]) + fv9_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  mb_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv24_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv24_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  mc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv39_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv39_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  md_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  me_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T fv65_data[76800], const int32_T fv67_size[2], const int32_T fv10,
  const int32_T PI_Time_fine_size, real32_T fv67_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (PI_Time_fine_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) / (static_cast<
      uint64_T>(fv10) + 1ULL));
    fv67_data[k + fv67_size[0] * i] = fv65_data[k] * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  n_TTCM_analytic_Multi_GPU_kerne(const real32_T PI_Time_fine_data[], const
  real32_T Local_Estimates, const int32_T PI_Time_fine_size, real32_T fv11_data
  [801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(PI_Time_fine_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv11_data[i] = Local_Estimates * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  nb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv24_data[76800], const int32_T fv24_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv24_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv24_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  nc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv39_data[76800], const int32_T fv39_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv39_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv39_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  nd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv53_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv53_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ne_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv67_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv67_data[k] = expf(fv67_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  o_TTCM_analytic_Multi_GPU_kerne(const int32_T nx, real32_T fv11_data[801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv11_data[k] = expf(fv11_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ob_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv25_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv25_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  oc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv40_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv40_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  od_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv53_data[76800], const int32_T fv53_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv53_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv53_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  oe_TTCM_analytic_Multi_GPU_kern(const real32_T Local_Estimates, const real32_T
  fv62_data[76800], const real32_T PL_data[], const int32_T PL_size[2], const
  real32_T b_Local_Estimates, const int32_T nx, real32_T fv68_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv68_data[i] = b_Local_Estimates / ((((PL_data[i + PL_size[0]] + PL_data[i +
      PL_size[0] * 2]) + PL_data[i + PL_size[0] * 3]) - fv62_data[i]) / 2.0F -
      Local_Estimates);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  p_TTCM_analytic_Multi_GPU_kerne(const real32_T PI_Time_fine_data[], const
  real32_T fv10_data[76800], const int32_T fv12_size[2], const int32_T fv10,
  const int32_T PI_Time_fine_size, real32_T fv12_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (PI_Time_fine_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) / (static_cast<
      uint64_T>(fv10) + 1ULL));
    fv12_data[k + fv12_size[0] * i] = fv10_data[k] * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  pb_TTCM_analytic_Multi_GPU_kern(const real32_T fv25_data[76800], const
  real32_T PL_data[], const int32_T PL_size[2], const int32_T nx, real32_T
  fv26_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv26_data[i] = -((((PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
                       PL_data[i + PL_size[0] * 3]) + fv25_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  pc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  pd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv54_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv54_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  pe_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  q_TTCM_analytic_Multi_GPU_kerne(const int32_T nx, real32_T fv12_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv12_data[k] = expf(fv12_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  qb_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T Local_Estimates, const int32_T PI_Time_fine_size, real32_T fv27_data
  [801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(PI_Time_fine_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv27_data[i] = Local_Estimates * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  qc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv41_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv41_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  qd_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  qe_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv69_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv69_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  r_TTCM_analytic_Multi_GPU_kerne(const real32_T Local_Estimates, const real32_T
  fv7_data[76800], const real32_T PL_data[], const int32_T PL_size[2], const
  real32_T b_Local_Estimates, const int32_T nx, real32_T fv13_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv13_data[i] = b_Local_Estimates / ((((PL_data[i + PL_size[0]] + PL_data[i +
      PL_size[0] * 2]) + PL_data[i + PL_size[0] * 3]) + fv7_data[i]) / 2.0F -
      Local_Estimates);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  rb_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv27_data[801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv27_data[k] = expf(fv27_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  rc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv41_data[76800], const int32_T fv41_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv41_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv41_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  rd_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv55_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv55_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  re_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv69_data[76800], const int32_T fv69_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv69_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv69_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  s_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  sb_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T fv26_data[76800], const int32_T fv28_size[2], const int32_T fv10,
  const int32_T PI_Time_fine_size, real32_T fv28_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (PI_Time_fine_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) / (static_cast<
      uint64_T>(fv10) + 1ULL));
    fv28_data[k + fv28_size[0] * i] = fv26_data[k] * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  sc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv42_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv42_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  sd_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv55_data[76800], const int32_T fv55_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv55_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv55_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  se_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv70_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv70_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  t_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv14_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv14_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  tb_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv28_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv28_data[k] = expf(fv28_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  tc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  td_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv56_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv56_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  te_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  u_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv14_data[76800], const int32_T fv14_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv14_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv14_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ub_TTCM_analytic_Multi_GPU_kern(const real32_T Local_Estimates, const real32_T
  fv23_data[76800], const real32_T PL_data[], const int32_T PL_size[2], const
  real32_T b_Local_Estimates, const int32_T nx, real32_T fv29_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv29_data[i] = b_Local_Estimates / ((((PL_data[i + PL_size[0]] + PL_data[i +
      PL_size[0] * 2]) + PL_data[i + PL_size[0] * 3]) + fv23_data[i]) / 2.0F -
      Local_Estimates);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  uc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv43_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv43_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ud_TTCM_analytic_Multi_GPU_kern(const real32_T fv56_data[76800], const
  real32_T PL_data[], const int32_T PL_size[2], const int32_T nx, real32_T
  fv57_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv57_data[i] = -((((PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
                       PL_data[i + PL_size[0] * 3]) - fv56_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ue_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv71_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv71_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  v_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv15_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv15_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  vb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  vc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv43_data[76800], const int32_T fv43_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv43_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv43_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  vd_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T Local_Estimates, const int32_T PI_Time_fine_size, real32_T fv58_data
  [801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(PI_Time_fine_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv58_data[i] = Local_Estimates * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ve_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv71_data[76800], const int32_T fv71_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv71_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv71_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  w_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  wb_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv30_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv30_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  wc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv44_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv44_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  wd_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv58_data[801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv58_data[k] = expf(fv58_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  we_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv72_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv72_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  x_TTCM_analytic_Multi_GPU_kerne(const real32_T a_data[76800], const int32_T nx,
  real32_T fv16_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv16_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  xb_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv30_data[76800], const int32_T fv30_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv30_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv30_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  xc_TTCM_analytic_Multi_GPU_kern(const real32_T PL_data[], const int32_T
  PL_size[2], const int32_T nx, real32_T a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = (PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
      PL_data[i + PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  xd_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T fv57_data[76800], const int32_T fv59_size[2], const int32_T fv10,
  const int32_T PI_Time_fine_size, real32_T fv59_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(fv10) + 1ULL) * (static_cast<uint64_T>
    (PI_Time_fine_size) + 1ULL) - 1ULL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(fv10) + 1ULL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) / (static_cast<
      uint64_T>(fv10) + 1ULL));
    fv59_data[k + fv59_size[0] * i] = fv57_data[k] * PI_Time_fine_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  xe_TTCM_analytic_Multi_GPU_kern(const real32_T fv72_data[76800], const
  real32_T PL_data[], const int32_T PL_size[2], const int32_T nx, real32_T
  fv73_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv73_data[i] = -((((PL_data[i + PL_size[0]] + PL_data[i + PL_size[0] * 2]) +
                       PL_data[i + PL_size[0] * 3]) - fv72_data[i]) / 2.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  y_TTCM_analytic_Multi_GPU_kerne(const real32_T PL_data[], const int32_T
  PL_size[2], const real32_T fv16_data[76800], const int32_T fv16_size, real32_T
  a_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv16_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a_data[i] = fv16_data[i] - 4.0F * PL_data[i + PL_size[0]] * PL_data[i +
      PL_size[0] * 3];
  }
}

static __global__ __launch_bounds__(1024, 1) void
  yb_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv31_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv31_data[k] = sqrtf(a_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  yc_TTCM_analytic_Multi_GPU_kern(const real32_T a_data[76800], const int32_T nx,
  real32_T fv45_data[76800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    real32_T f;
    k = static_cast<int32_T>(idx);
    f = a_data[k];
    fv45_data[k] = f * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void
  yd_TTCM_analytic_Multi_GPU_kern(const int32_T nx, real32_T fv59_data[61516800])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv59_data[k] = expf(fv59_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void
  ye_TTCM_analytic_Multi_GPU_kern(const real32_T PI_Time_fine_data[], const
  real32_T Local_Estimates, const int32_T PI_Time_fine_size, real32_T fv74_data
  [801])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(PI_Time_fine_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv74_data[i] = Local_Estimates * PI_Time_fine_data[i];
  }
}

void TTCM_analytic_Multi_GPU(c_TTCM_analytic_Multi_GPUStackD *SD, const real32_T
  PL_data[], const int32_T PL_size[2], const real32_T PI_Time_fine_data[], const
  int32_T PI_Time_fine_size[2], const real32_T Local_Estimates[8], real32_T
  Ct_data[], int32_T Ct_size[2])
{
  dim3 block;
  dim3 grid;
  int32_T fv11_size[2];
  int32_T fv12_size[2];
  int32_T fv19_size[2];
  int32_T fv20_size[2];
  int32_T fv27_size[2];
  int32_T fv28_size[2];
  int32_T fv35_size[2];
  int32_T fv36_size[2];
  int32_T fv50_size[2];
  int32_T fv51_size[2];
  int32_T fv58_size[2];
  int32_T fv59_size[2];
  int32_T fv66_size[2];
  int32_T fv67_size[2];
  int32_T fv74_size[2];
  int32_T fv75_size[2];
  int32_T (*gpu_Ct_size)[2];
  int32_T (*gpu_PL_size)[2];
  int32_T (*gpu_fv12_size)[2];
  int32_T (*gpu_fv20_size)[2];
  int32_T (*gpu_fv28_size)[2];
  int32_T (*gpu_fv36_size)[2];
  int32_T (*gpu_fv51_size)[2];
  int32_T (*gpu_fv59_size)[2];
  int32_T (*gpu_fv67_size)[2];
  int32_T (*gpu_fv75_size)[2];
  int32_T a_size[1];
  int32_T ab_a_size[1];
  int32_T b_a_size[1];
  int32_T bb_a_size[1];
  int32_T c_a_size[1];
  int32_T cb_a_size[1];
  int32_T d_a_size[1];
  int32_T db_a_size[1];
  int32_T e_a_size[1];
  int32_T eb_a_size[1];
  int32_T f_a_size[1];
  int32_T fb_a_size[1];
  int32_T fv10_size[1];
  int32_T fv13_size[1];
  int32_T fv14_size[1];
  int32_T fv15_size[1];
  int32_T fv16_size[1];
  int32_T fv17_size[1];
  int32_T fv18_size[1];
  int32_T fv1_size[1];
  int32_T fv21_size[1];
  int32_T fv22_size[1];
  int32_T fv23_size[1];
  int32_T fv24_size[1];
  int32_T fv25_size[1];
  int32_T fv26_size[1];
  int32_T fv29_size[1];
  int32_T fv2_size[1];
  int32_T fv30_size[1];
  int32_T fv31_size[1];
  int32_T fv32_size[1];
  int32_T fv33_size[1];
  int32_T fv34_size[1];
  int32_T fv37_size[1];
  int32_T fv38_size[1];
  int32_T fv39_size[1];
  int32_T fv3_size[1];
  int32_T fv40_size[1];
  int32_T fv41_size[1];
  int32_T fv42_size[1];
  int32_T fv43_size[1];
  int32_T fv44_size[1];
  int32_T fv45_size[1];
  int32_T fv46_size[1];
  int32_T fv47_size[1];
  int32_T fv48_size[1];
  int32_T fv49_size[1];
  int32_T fv4_size[1];
  int32_T fv52_size[1];
  int32_T fv53_size[1];
  int32_T fv54_size[1];
  int32_T fv55_size[1];
  int32_T fv56_size[1];
  int32_T fv57_size[1];
  int32_T fv5_size[1];
  int32_T fv60_size[1];
  int32_T fv61_size[1];
  int32_T fv62_size[1];
  int32_T fv63_size[1];
  int32_T fv64_size[1];
  int32_T fv65_size[1];
  int32_T fv68_size[1];
  int32_T fv69_size[1];
  int32_T fv6_size[1];
  int32_T fv70_size[1];
  int32_T fv71_size[1];
  int32_T fv72_size[1];
  int32_T fv73_size[1];
  int32_T fv76_size[1];
  int32_T fv77_size[1];
  int32_T fv7_size[1];
  int32_T fv8_size[1];
  int32_T fv9_size[1];
  int32_T fv_size[1];
  int32_T g_a_size[1];
  int32_T gb_a_size[1];
  int32_T h_a_size[1];
  int32_T hb_a_size[1];
  int32_T i_a_size[1];
  int32_T ib_a_size[1];
  int32_T j_a_size[1];
  int32_T jb_a_size[1];
  int32_T k_a_size[1];
  int32_T kb_a_size[1];
  int32_T l_a_size[1];
  int32_T lb_a_size[1];
  int32_T m_a_size[1];
  int32_T mb_a_size[1];
  int32_T n_a_size[1];
  int32_T nb_a_size[1];
  int32_T o_a_size[1];
  int32_T ob_a_size[1];
  int32_T p_a_size[1];
  int32_T pb_a_size[1];
  int32_T q_a_size[1];
  int32_T qb_a_size[1];
  int32_T r_a_size[1];
  int32_T rb_a_size[1];
  int32_T s_a_size[1];
  int32_T sb_a_size[1];
  int32_T t_a_size[1];
  int32_T u_a_size[1];
  int32_T v_a_size[1];
  int32_T w_a_size[1];
  int32_T x_a_size[1];
  int32_T y_a_size[1];
  int32_T b_PI_Time_fine_size;
  int32_T b_PL_size;
  int32_T b_fv13_size;
  int32_T b_fv21_size;
  int32_T b_fv29_size;
  int32_T b_fv37_size;
  int32_T b_fv52_size;
  int32_T b_fv60_size;
  int32_T b_fv68_size;
  int32_T b_fv76_size;
  int32_T c_PI_Time_fine_size;
  int32_T c_PL_size;
  int32_T c_fv13_size;
  int32_T c_fv52_size;
  int32_T d_PI_Time_fine_size;
  int32_T d_PL_size;
  int32_T d_fv13_size;
  int32_T d_fv52_size;
  int32_T e_PI_Time_fine_size;
  int32_T e_PL_size;
  int32_T e_fv52_size;
  int32_T f_PI_Time_fine_size;
  int32_T f_PL_size;
  int32_T g_PI_Time_fine_size;
  int32_T g_PL_size;
  int32_T h_PI_Time_fine_size;
  int32_T i_PI_Time_fine_size;
  int32_T j_PI_Time_fine_size;
  int32_T k_PI_Time_fine_size;
  int32_T l_PI_Time_fine_size;
  int32_T m_PI_Time_fine_size;
  int32_T nx;
  real32_T (*gpu_fv12_data)[61516800];
  real32_T (*gpu_fv20_data)[61516800];
  real32_T (*gpu_fv28_data)[61516800];
  real32_T (*gpu_fv36_data)[61516800];
  real32_T (*gpu_fv51_data)[61516800];
  real32_T (*gpu_fv59_data)[61516800];
  real32_T (*gpu_fv67_data)[61516800];
  real32_T (*gpu_fv75_data)[61516800];
  real32_T (*b_gpu_a_data)[76800];
  real32_T (*c_gpu_a_data)[76800];
  real32_T (*d_gpu_a_data)[76800];
  real32_T (*e_gpu_a_data)[76800];
  real32_T (*f_gpu_a_data)[76800];
  real32_T (*g_gpu_a_data)[76800];
  real32_T (*gpu_a_data)[76800];
  real32_T (*gpu_fv10_data)[76800];
  real32_T (*gpu_fv13_data)[76800];
  real32_T (*gpu_fv14_data)[76800];
  real32_T (*gpu_fv15_data)[76800];
  real32_T (*gpu_fv16_data)[76800];
  real32_T (*gpu_fv17_data)[76800];
  real32_T (*gpu_fv18_data)[76800];
  real32_T (*gpu_fv1_data)[76800];
  real32_T (*gpu_fv21_data)[76800];
  real32_T (*gpu_fv22_data)[76800];
  real32_T (*gpu_fv23_data)[76800];
  real32_T (*gpu_fv24_data)[76800];
  real32_T (*gpu_fv25_data)[76800];
  real32_T (*gpu_fv26_data)[76800];
  real32_T (*gpu_fv29_data)[76800];
  real32_T (*gpu_fv2_data)[76800];
  real32_T (*gpu_fv30_data)[76800];
  real32_T (*gpu_fv31_data)[76800];
  real32_T (*gpu_fv32_data)[76800];
  real32_T (*gpu_fv33_data)[76800];
  real32_T (*gpu_fv34_data)[76800];
  real32_T (*gpu_fv37_data)[76800];
  real32_T (*gpu_fv38_data)[76800];
  real32_T (*gpu_fv39_data)[76800];
  real32_T (*gpu_fv3_data)[76800];
  real32_T (*gpu_fv40_data)[76800];
  real32_T (*gpu_fv41_data)[76800];
  real32_T (*gpu_fv42_data)[76800];
  real32_T (*gpu_fv43_data)[76800];
  real32_T (*gpu_fv44_data)[76800];
  real32_T (*gpu_fv45_data)[76800];
  real32_T (*gpu_fv46_data)[76800];
  real32_T (*gpu_fv47_data)[76800];
  real32_T (*gpu_fv48_data)[76800];
  real32_T (*gpu_fv49_data)[76800];
  real32_T (*gpu_fv4_data)[76800];
  real32_T (*gpu_fv52_data)[76800];
  real32_T (*gpu_fv53_data)[76800];
  real32_T (*gpu_fv54_data)[76800];
  real32_T (*gpu_fv55_data)[76800];
  real32_T (*gpu_fv56_data)[76800];
  real32_T (*gpu_fv57_data)[76800];
  real32_T (*gpu_fv5_data)[76800];
  real32_T (*gpu_fv60_data)[76800];
  real32_T (*gpu_fv61_data)[76800];
  real32_T (*gpu_fv62_data)[76800];
  real32_T (*gpu_fv63_data)[76800];
  real32_T (*gpu_fv64_data)[76800];
  real32_T (*gpu_fv65_data)[76800];
  real32_T (*gpu_fv68_data)[76800];
  real32_T (*gpu_fv69_data)[76800];
  real32_T (*gpu_fv6_data)[76800];
  real32_T (*gpu_fv70_data)[76800];
  real32_T (*gpu_fv71_data)[76800];
  real32_T (*gpu_fv72_data)[76800];
  real32_T (*gpu_fv73_data)[76800];
  real32_T (*gpu_fv76_data)[76800];
  real32_T (*gpu_fv77_data)[76800];
  real32_T (*gpu_fv7_data)[76800];
  real32_T (*gpu_fv8_data)[76800];
  real32_T (*gpu_fv9_data)[76800];
  real32_T (*gpu_fv_data)[76800];
  real32_T (*h_gpu_a_data)[76800];
  real32_T (*i_gpu_a_data)[76800];
  real32_T (*j_gpu_a_data)[76800];
  real32_T (*k_gpu_a_data)[76800];
  real32_T (*l_gpu_a_data)[76800];
  real32_T (*m_gpu_a_data)[76800];
  real32_T (*n_gpu_a_data)[76800];
  real32_T (*o_gpu_a_data)[76800];
  real32_T (*p_gpu_a_data)[76800];
  real32_T (*q_gpu_a_data)[76800];
  real32_T (*r_gpu_a_data)[76800];
  real32_T (*s_gpu_a_data)[76800];
  real32_T (*t_gpu_a_data)[76800];
  real32_T (*u_gpu_a_data)[76800];
  real32_T (*v_gpu_a_data)[76800];
  real32_T (*w_gpu_a_data)[76800];
  real32_T fv11_data[801];
  real32_T fv19_data[801];
  real32_T fv27_data[801];
  real32_T fv35_data[801];
  real32_T fv50_data[801];
  real32_T fv58_data[801];
  real32_T fv66_data[801];
  real32_T fv74_data[801];
  real32_T (*gpu_fv11_data)[801];
  real32_T (*gpu_fv19_data)[801];
  real32_T (*gpu_fv27_data)[801];
  real32_T (*gpu_fv35_data)[801];
  real32_T (*gpu_fv50_data)[801];
  real32_T (*gpu_fv58_data)[801];
  real32_T (*gpu_fv66_data)[801];
  real32_T (*gpu_fv74_data)[801];
  real32_T *gpu_Ct_data;
  real32_T *gpu_PI_Time_fine_data;
  real32_T *gpu_PL_data;
  boolean_T Ct_data_dirtyOnGpu;
  boolean_T PI_Time_fine_data_dirtyOnCpu;
  boolean_T PL_data_dirtyOnCpu;
  boolean_T PL_size_dirtyOnCpu;
  boolean_T a_data_dirtyOnCpu;
  boolean_T b_a_data_dirtyOnCpu;
  boolean_T c_a_data_dirtyOnCpu;
  boolean_T d_a_data_dirtyOnCpu;
  boolean_T e_a_data_dirtyOnCpu;
  boolean_T f_a_data_dirtyOnCpu;
  boolean_T fv10_data_dirtyOnCpu;
  boolean_T fv11_data_dirtyOnGpu;
  boolean_T fv12_data_dirtyOnGpu;
  boolean_T fv13_data_dirtyOnCpu;
  boolean_T fv13_data_dirtyOnGpu;
  boolean_T fv14_data_dirtyOnGpu;
  boolean_T fv15_data_dirtyOnGpu;
  boolean_T fv16_data_dirtyOnGpu;
  boolean_T fv17_data_dirtyOnGpu;
  boolean_T fv18_data_dirtyOnCpu;
  boolean_T fv19_data_dirtyOnGpu;
  boolean_T fv1_data_dirtyOnGpu;
  boolean_T fv20_data_dirtyOnGpu;
  boolean_T fv21_data_dirtyOnCpu;
  boolean_T fv21_data_dirtyOnGpu;
  boolean_T fv22_data_dirtyOnGpu;
  boolean_T fv23_data_dirtyOnGpu;
  boolean_T fv24_data_dirtyOnGpu;
  boolean_T fv25_data_dirtyOnGpu;
  boolean_T fv26_data_dirtyOnCpu;
  boolean_T fv27_data_dirtyOnGpu;
  boolean_T fv28_data_dirtyOnGpu;
  boolean_T fv29_data_dirtyOnCpu;
  boolean_T fv29_data_dirtyOnGpu;
  boolean_T fv2_data_dirtyOnGpu;
  boolean_T fv30_data_dirtyOnGpu;
  boolean_T fv31_data_dirtyOnGpu;
  boolean_T fv32_data_dirtyOnGpu;
  boolean_T fv33_data_dirtyOnGpu;
  boolean_T fv34_data_dirtyOnCpu;
  boolean_T fv35_data_dirtyOnGpu;
  boolean_T fv36_data_dirtyOnGpu;
  boolean_T fv37_data_dirtyOnCpu;
  boolean_T fv37_data_dirtyOnGpu;
  boolean_T fv38_data_dirtyOnCpu;
  boolean_T fv38_data_dirtyOnGpu;
  boolean_T fv39_data_dirtyOnGpu;
  boolean_T fv3_data_dirtyOnGpu;
  boolean_T fv40_data_dirtyOnGpu;
  boolean_T fv41_data_dirtyOnGpu;
  boolean_T fv42_data_dirtyOnGpu;
  boolean_T fv43_data_dirtyOnGpu;
  boolean_T fv44_data_dirtyOnGpu;
  boolean_T fv45_data_dirtyOnGpu;
  boolean_T fv46_data_dirtyOnGpu;
  boolean_T fv47_data_dirtyOnGpu;
  boolean_T fv48_data_dirtyOnGpu;
  boolean_T fv49_data_dirtyOnCpu;
  boolean_T fv4_data_dirtyOnGpu;
  boolean_T fv50_data_dirtyOnGpu;
  boolean_T fv51_data_dirtyOnGpu;
  boolean_T fv52_data_dirtyOnCpu;
  boolean_T fv52_data_dirtyOnGpu;
  boolean_T fv53_data_dirtyOnGpu;
  boolean_T fv54_data_dirtyOnGpu;
  boolean_T fv55_data_dirtyOnGpu;
  boolean_T fv56_data_dirtyOnGpu;
  boolean_T fv57_data_dirtyOnCpu;
  boolean_T fv58_data_dirtyOnGpu;
  boolean_T fv59_data_dirtyOnGpu;
  boolean_T fv5_data_dirtyOnGpu;
  boolean_T fv60_data_dirtyOnCpu;
  boolean_T fv60_data_dirtyOnGpu;
  boolean_T fv61_data_dirtyOnGpu;
  boolean_T fv62_data_dirtyOnGpu;
  boolean_T fv63_data_dirtyOnGpu;
  boolean_T fv64_data_dirtyOnGpu;
  boolean_T fv65_data_dirtyOnCpu;
  boolean_T fv66_data_dirtyOnGpu;
  boolean_T fv67_data_dirtyOnGpu;
  boolean_T fv68_data_dirtyOnCpu;
  boolean_T fv68_data_dirtyOnGpu;
  boolean_T fv69_data_dirtyOnGpu;
  boolean_T fv6_data_dirtyOnGpu;
  boolean_T fv70_data_dirtyOnGpu;
  boolean_T fv71_data_dirtyOnGpu;
  boolean_T fv72_data_dirtyOnGpu;
  boolean_T fv73_data_dirtyOnCpu;
  boolean_T fv74_data_dirtyOnGpu;
  boolean_T fv75_data_dirtyOnGpu;
  boolean_T fv76_data_dirtyOnCpu;
  boolean_T fv76_data_dirtyOnGpu;
  boolean_T fv77_data_dirtyOnCpu;
  boolean_T fv77_data_dirtyOnGpu;
  boolean_T fv7_data_dirtyOnGpu;
  boolean_T fv8_data_dirtyOnGpu;
  boolean_T fv9_data_dirtyOnGpu;
  boolean_T fv_data_dirtyOnGpu;
  boolean_T g_a_data_dirtyOnCpu;
  boolean_T h_a_data_dirtyOnCpu;
  boolean_T i_a_data_dirtyOnCpu;
  boolean_T j_a_data_dirtyOnCpu;
  boolean_T k_a_data_dirtyOnCpu;
  boolean_T l_a_data_dirtyOnCpu;
  boolean_T m_a_data_dirtyOnCpu;
  boolean_T n_a_data_dirtyOnCpu;
  boolean_T o_a_data_dirtyOnCpu;
  boolean_T p_a_data_dirtyOnCpu;
  boolean_T q_a_data_dirtyOnCpu;
  boolean_T r_a_data_dirtyOnCpu;
  boolean_T s_a_data_dirtyOnCpu;
  boolean_T t_a_data_dirtyOnCpu;
  boolean_T u_a_data_dirtyOnCpu;
  boolean_T v_a_data_dirtyOnCpu;
  boolean_T validLaunchParams;
  mwCudaMalloc(&gpu_Ct_data, static_cast<uint64_T>(61516800U * sizeof(real32_T)));
  mwCudaMalloc(&gpu_Ct_size, 8ULL);
  mwCudaMalloc(&gpu_fv77_data, 307200ULL);
  mwCudaMalloc(&gpu_fv76_data, 307200ULL);
  mwCudaMalloc(&gpu_fv75_data, 246067200ULL);
  mwCudaMalloc(&gpu_fv75_size, 8ULL);
  mwCudaMalloc(&gpu_fv74_data, 3204ULL);
  mwCudaMalloc(&gpu_fv73_data, 307200ULL);
  mwCudaMalloc(&gpu_fv72_data, 307200ULL);
  mwCudaMalloc(&w_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv71_data, 307200ULL);
  mwCudaMalloc(&gpu_fv70_data, 307200ULL);
  mwCudaMalloc(&v_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv69_data, 307200ULL);
  mwCudaMalloc(&gpu_fv68_data, 307200ULL);
  mwCudaMalloc(&gpu_fv67_data, 246067200ULL);
  mwCudaMalloc(&gpu_fv67_size, 8ULL);
  mwCudaMalloc(&gpu_fv66_data, 3204ULL);
  mwCudaMalloc(&gpu_fv65_data, 307200ULL);
  mwCudaMalloc(&gpu_fv64_data, 307200ULL);
  mwCudaMalloc(&u_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv63_data, 307200ULL);
  mwCudaMalloc(&gpu_fv62_data, 307200ULL);
  mwCudaMalloc(&t_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv61_data, 307200ULL);
  mwCudaMalloc(&gpu_fv60_data, 307200ULL);
  mwCudaMalloc(&gpu_fv59_data, 246067200ULL);
  mwCudaMalloc(&gpu_fv59_size, 8ULL);
  mwCudaMalloc(&gpu_fv58_data, 3204ULL);
  mwCudaMalloc(&gpu_fv57_data, 307200ULL);
  mwCudaMalloc(&gpu_fv56_data, 307200ULL);
  mwCudaMalloc(&s_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv55_data, 307200ULL);
  mwCudaMalloc(&gpu_fv54_data, 307200ULL);
  mwCudaMalloc(&r_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv53_data, 307200ULL);
  mwCudaMalloc(&gpu_fv52_data, 307200ULL);
  mwCudaMalloc(&gpu_fv51_data, 246067200ULL);
  mwCudaMalloc(&gpu_fv51_size, 8ULL);
  mwCudaMalloc(&gpu_fv50_data, 3204ULL);
  mwCudaMalloc(&gpu_fv49_data, 307200ULL);
  mwCudaMalloc(&gpu_fv48_data, 307200ULL);
  mwCudaMalloc(&q_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv47_data, 307200ULL);
  mwCudaMalloc(&gpu_fv46_data, 307200ULL);
  mwCudaMalloc(&p_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv45_data, 307200ULL);
  mwCudaMalloc(&gpu_fv44_data, 307200ULL);
  mwCudaMalloc(&o_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv43_data, 307200ULL);
  mwCudaMalloc(&gpu_fv42_data, 307200ULL);
  mwCudaMalloc(&n_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv41_data, 307200ULL);
  mwCudaMalloc(&gpu_fv40_data, 307200ULL);
  mwCudaMalloc(&m_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv39_data, 307200ULL);
  mwCudaMalloc(&gpu_fv38_data, 307200ULL);
  mwCudaMalloc(&gpu_fv37_data, 307200ULL);
  mwCudaMalloc(&gpu_fv36_data, 246067200ULL);
  mwCudaMalloc(&gpu_fv36_size, 8ULL);
  mwCudaMalloc(&gpu_fv35_data, 3204ULL);
  mwCudaMalloc(&gpu_fv34_data, 307200ULL);
  mwCudaMalloc(&gpu_fv33_data, 307200ULL);
  mwCudaMalloc(&l_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv32_data, 307200ULL);
  mwCudaMalloc(&gpu_fv31_data, 307200ULL);
  mwCudaMalloc(&k_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv30_data, 307200ULL);
  mwCudaMalloc(&gpu_fv29_data, 307200ULL);
  mwCudaMalloc(&gpu_fv28_data, 246067200ULL);
  mwCudaMalloc(&gpu_fv28_size, 8ULL);
  mwCudaMalloc(&gpu_fv27_data, 3204ULL);
  mwCudaMalloc(&gpu_fv26_data, 307200ULL);
  mwCudaMalloc(&gpu_fv25_data, 307200ULL);
  mwCudaMalloc(&j_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv24_data, 307200ULL);
  mwCudaMalloc(&gpu_fv23_data, 307200ULL);
  mwCudaMalloc(&i_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv22_data, 307200ULL);
  mwCudaMalloc(&gpu_fv21_data, 307200ULL);
  mwCudaMalloc(&gpu_fv20_data, 246067200ULL);
  mwCudaMalloc(&gpu_fv20_size, 8ULL);
  mwCudaMalloc(&gpu_fv19_data, 3204ULL);
  mwCudaMalloc(&gpu_fv18_data, 307200ULL);
  mwCudaMalloc(&gpu_fv17_data, 307200ULL);
  mwCudaMalloc(&h_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv16_data, 307200ULL);
  mwCudaMalloc(&gpu_fv15_data, 307200ULL);
  mwCudaMalloc(&g_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv14_data, 307200ULL);
  mwCudaMalloc(&gpu_fv13_data, 307200ULL);
  mwCudaMalloc(&gpu_fv12_data, 246067200ULL);
  mwCudaMalloc(&gpu_fv12_size, 8ULL);
  mwCudaMalloc(&gpu_fv11_data, 3204ULL);
  mwCudaMalloc(&gpu_PI_Time_fine_data, static_cast<uint64_T>(801U * sizeof
    (real32_T)));
  mwCudaMalloc(&gpu_fv10_data, 307200ULL);
  mwCudaMalloc(&gpu_fv9_data, 307200ULL);
  mwCudaMalloc(&f_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv8_data, 307200ULL);
  mwCudaMalloc(&gpu_fv7_data, 307200ULL);
  mwCudaMalloc(&e_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv6_data, 307200ULL);
  mwCudaMalloc(&gpu_fv5_data, 307200ULL);
  mwCudaMalloc(&d_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv4_data, 307200ULL);
  mwCudaMalloc(&gpu_fv3_data, 307200ULL);
  mwCudaMalloc(&c_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv2_data, 307200ULL);
  mwCudaMalloc(&gpu_fv1_data, 307200ULL);
  mwCudaMalloc(&b_gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_fv_data, 307200ULL);
  mwCudaMalloc(&gpu_a_data, 307200ULL);
  mwCudaMalloc(&gpu_PL_size, 8ULL);
  mwCudaMalloc(&gpu_PL_data, static_cast<uint64_T>(307200U * sizeof(real32_T)));
  Ct_data_dirtyOnGpu = false;
  fv77_data_dirtyOnGpu = false;
  fv76_data_dirtyOnGpu = false;
  fv75_data_dirtyOnGpu = false;
  fv74_data_dirtyOnGpu = false;
  fv72_data_dirtyOnGpu = false;
  fv71_data_dirtyOnGpu = false;
  fv70_data_dirtyOnGpu = false;
  fv69_data_dirtyOnGpu = false;
  fv68_data_dirtyOnGpu = false;
  fv67_data_dirtyOnGpu = false;
  fv66_data_dirtyOnGpu = false;
  fv64_data_dirtyOnGpu = false;
  fv63_data_dirtyOnGpu = false;
  fv62_data_dirtyOnGpu = false;
  fv61_data_dirtyOnGpu = false;
  fv60_data_dirtyOnGpu = false;
  fv59_data_dirtyOnGpu = false;
  fv58_data_dirtyOnGpu = false;
  fv56_data_dirtyOnGpu = false;
  fv55_data_dirtyOnGpu = false;
  fv54_data_dirtyOnGpu = false;
  fv53_data_dirtyOnGpu = false;
  fv52_data_dirtyOnGpu = false;
  fv51_data_dirtyOnGpu = false;
  fv50_data_dirtyOnGpu = false;
  fv48_data_dirtyOnGpu = false;
  fv47_data_dirtyOnGpu = false;
  fv46_data_dirtyOnGpu = false;
  fv45_data_dirtyOnGpu = false;
  fv44_data_dirtyOnGpu = false;
  fv43_data_dirtyOnGpu = false;
  fv42_data_dirtyOnGpu = false;
  fv41_data_dirtyOnGpu = false;
  fv40_data_dirtyOnGpu = false;
  fv39_data_dirtyOnGpu = false;
  fv38_data_dirtyOnGpu = false;
  fv37_data_dirtyOnGpu = false;
  fv36_data_dirtyOnGpu = false;
  fv35_data_dirtyOnGpu = false;
  fv33_data_dirtyOnGpu = false;
  fv32_data_dirtyOnGpu = false;
  fv31_data_dirtyOnGpu = false;
  fv30_data_dirtyOnGpu = false;
  fv29_data_dirtyOnGpu = false;
  fv28_data_dirtyOnGpu = false;
  fv27_data_dirtyOnGpu = false;
  fv25_data_dirtyOnGpu = false;
  fv24_data_dirtyOnGpu = false;
  fv23_data_dirtyOnGpu = false;
  fv22_data_dirtyOnGpu = false;
  fv21_data_dirtyOnGpu = false;
  fv20_data_dirtyOnGpu = false;
  fv19_data_dirtyOnGpu = false;
  fv17_data_dirtyOnGpu = false;
  fv16_data_dirtyOnGpu = false;
  fv15_data_dirtyOnGpu = false;
  fv14_data_dirtyOnGpu = false;
  fv13_data_dirtyOnGpu = false;
  fv12_data_dirtyOnGpu = false;
  fv11_data_dirtyOnGpu = false;
  fv9_data_dirtyOnGpu = false;
  fv8_data_dirtyOnGpu = false;
  fv7_data_dirtyOnGpu = false;
  fv6_data_dirtyOnGpu = false;
  fv5_data_dirtyOnGpu = false;
  fv4_data_dirtyOnGpu = false;
  fv3_data_dirtyOnGpu = false;
  fv2_data_dirtyOnGpu = false;
  fv1_data_dirtyOnGpu = false;
  fv_data_dirtyOnGpu = false;
  fv77_data_dirtyOnCpu = false;
  fv76_data_dirtyOnCpu = false;
  fv73_data_dirtyOnCpu = false;
  v_a_data_dirtyOnCpu = false;
  u_a_data_dirtyOnCpu = false;
  fv68_data_dirtyOnCpu = false;
  fv65_data_dirtyOnCpu = false;
  t_a_data_dirtyOnCpu = false;
  s_a_data_dirtyOnCpu = false;
  fv60_data_dirtyOnCpu = false;
  fv57_data_dirtyOnCpu = false;
  r_a_data_dirtyOnCpu = false;
  q_a_data_dirtyOnCpu = false;
  fv52_data_dirtyOnCpu = false;
  fv49_data_dirtyOnCpu = false;
  p_a_data_dirtyOnCpu = false;
  o_a_data_dirtyOnCpu = false;
  n_a_data_dirtyOnCpu = false;
  m_a_data_dirtyOnCpu = false;
  l_a_data_dirtyOnCpu = false;
  fv38_data_dirtyOnCpu = false;
  fv37_data_dirtyOnCpu = false;
  fv34_data_dirtyOnCpu = false;
  k_a_data_dirtyOnCpu = false;
  j_a_data_dirtyOnCpu = false;
  fv29_data_dirtyOnCpu = false;
  fv26_data_dirtyOnCpu = false;
  i_a_data_dirtyOnCpu = false;
  h_a_data_dirtyOnCpu = false;
  fv21_data_dirtyOnCpu = false;
  fv18_data_dirtyOnCpu = false;
  g_a_data_dirtyOnCpu = false;
  f_a_data_dirtyOnCpu = false;
  fv13_data_dirtyOnCpu = false;
  fv10_data_dirtyOnCpu = false;
  e_a_data_dirtyOnCpu = false;
  d_a_data_dirtyOnCpu = false;
  c_a_data_dirtyOnCpu = false;
  b_a_data_dirtyOnCpu = false;
  a_data_dirtyOnCpu = false;
  PI_Time_fine_data_dirtyOnCpu = true;
  PL_size_dirtyOnCpu = true;
  PL_data_dirtyOnCpu = true;

  //  CPU speed ==> 0.58 [sec] per row ==> 148.48 [sec] per Slice
  //  GPU speed ==> ?
  nx = PL_size[0] - 1;
  a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
               cudaMemcpyHostToDevice);
    PL_data_dirtyOnCpu = false;
    cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    PL_size_dirtyOnCpu = false;
    TTCM_analytic_Multi_GPU_kernel1<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv_size[0] = a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((a_size[0] - 1)
    + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    TTCM_analytic_Multi_GPU_kernel2<<<grid, block>>>(*gpu_a_data, a_size[0],
      *gpu_fv_data);
    fv_data_dirtyOnGpu = true;
  }

  if (a_size[0] == PL_size[0]) {
    b_a_size[0] = a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((a_size[0] -
      1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      TTCM_analytic_Multi_GPU_kernel3<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv_data, a_size[0] - 1, *b_gpu_a_data);
    }
  } else {
    if (fv_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv_data, *gpu_fv_data, 307200ULL, cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.a_data, b_a_size, SD->f0.fv_data, fv_size, PL_data,
                       PL_size);
    a_data_dirtyOnCpu = true;
  }

  fv1_size[0] = b_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (a_data_dirtyOnCpu) {
      cudaMemcpy(*b_gpu_a_data, SD->f0.a_data, 307200ULL, cudaMemcpyHostToDevice);
    }

    TTCM_analytic_Multi_GPU_kernel4<<<grid, block>>>(*b_gpu_a_data, b_a_size[0],
      *gpu_fv1_data);
    fv1_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  c_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    TTCM_analytic_Multi_GPU_kernel5<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv2_size[0] = c_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((c_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    TTCM_analytic_Multi_GPU_kernel6<<<grid, block>>>(*gpu_a_data, c_a_size[0],
      *gpu_fv2_data);
    fv2_data_dirtyOnGpu = true;
  }

  if (c_a_size[0] == PL_size[0]) {
    d_a_size[0] = c_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((c_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      TTCM_analytic_Multi_GPU_kernel7<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv2_data, c_a_size[0] - 1, *c_gpu_a_data);
    }
  } else {
    if (fv2_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv2_data, *gpu_fv2_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.b_a_data, d_a_size, SD->f0.fv2_data, fv2_size,
                       PL_data, PL_size);
    b_a_data_dirtyOnCpu = true;
  }

  fv3_size[0] = d_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((d_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (b_a_data_dirtyOnCpu) {
      cudaMemcpy(*c_gpu_a_data, SD->f0.b_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    TTCM_analytic_Multi_GPU_kernel8<<<grid, block>>>(*c_gpu_a_data, d_a_size[0],
      *gpu_fv3_data);
    fv3_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  e_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    TTCM_analytic_Multi_GPU_kernel9<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv4_size[0] = e_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((e_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    b_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*gpu_a_data, e_a_size[0],
      *gpu_fv4_data);
    fv4_data_dirtyOnGpu = true;
  }

  if (e_a_size[0] == PL_size[0]) {
    f_a_size[0] = e_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((e_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      c_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv4_data, e_a_size[0] - 1, *d_gpu_a_data);
    }
  } else {
    if (fv4_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv4_data, *gpu_fv4_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.c_a_data, f_a_size, SD->f0.fv4_data, fv4_size,
                       PL_data, PL_size);
    c_a_data_dirtyOnCpu = true;
  }

  fv5_size[0] = f_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((f_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (c_a_data_dirtyOnCpu) {
      cudaMemcpy(*d_gpu_a_data, SD->f0.c_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    d_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*d_gpu_a_data, f_a_size[0],
      *gpu_fv5_data);
    fv5_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  g_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    e_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv6_size[0] = g_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((g_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    f_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*gpu_a_data, g_a_size[0],
      *gpu_fv6_data);
    fv6_data_dirtyOnGpu = true;
  }

  if (g_a_size[0] == PL_size[0]) {
    h_a_size[0] = g_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((g_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      g_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv6_data, g_a_size[0] - 1, *e_gpu_a_data);
    }
  } else {
    if (fv6_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv6_data, *gpu_fv6_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.d_a_data, h_a_size, SD->f0.fv6_data, fv6_size,
                       PL_data, PL_size);
    d_a_data_dirtyOnCpu = true;
  }

  fv7_size[0] = h_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((h_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (d_a_data_dirtyOnCpu) {
      cudaMemcpy(*e_gpu_a_data, SD->f0.d_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    h_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*e_gpu_a_data, h_a_size[0],
      *gpu_fv7_data);
    fv7_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  i_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    i_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv8_size[0] = i_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    j_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*gpu_a_data, i_a_size[0],
      *gpu_fv8_data);
    fv8_data_dirtyOnGpu = true;
  }

  if (i_a_size[0] == PL_size[0]) {
    j_a_size[0] = i_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      k_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv8_data, i_a_size[0] - 1, *f_gpu_a_data);
    }
  } else {
    if (fv8_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv8_data, *gpu_fv8_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.e_a_data, j_a_size, SD->f0.fv8_data, fv8_size,
                       PL_data, PL_size);
    e_a_data_dirtyOnCpu = true;
  }

  fv9_size[0] = j_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((j_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (e_a_data_dirtyOnCpu) {
      cudaMemcpy(*f_gpu_a_data, SD->f0.e_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    l_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*f_gpu_a_data, j_a_size[0],
      *gpu_fv9_data);
    fv9_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == j_a_size[0]) {
    nx = PL_size[0] - 1;
    fv10_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      m_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*gpu_fv9_data,
        gpu_PL_data, *gpu_PL_size, nx, *gpu_fv10_data);
    }
  } else {
    if (fv9_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv9_data, *gpu_fv9_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    c_binary_expand_op(SD->f0.fv10_data, fv10_size, PL_data, PL_size,
                       SD->f0.fv9_data, fv9_size);
    fv10_data_dirtyOnCpu = true;
  }

  fv11_size[0] = 1;
  fv11_size[1] = PI_Time_fine_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
               sizeof(real32_T), cudaMemcpyHostToDevice);
    PI_Time_fine_data_dirtyOnCpu = false;
    n_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PI_Time_fine_data,
      -Local_Estimates[1], PI_Time_fine_size[1] - 1, *gpu_fv11_data);
    fv11_data_dirtyOnGpu = true;
  }

  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    o_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(PI_Time_fine_size[1],
      *gpu_fv11_data);
    fv11_data_dirtyOnGpu = true;
  }

  fv12_size[0] = fv10_size[0];
  fv12_size[1] = PI_Time_fine_size[1];
  d_a_data_dirtyOnCpu = true;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv10_size[0]
    - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block, 1024U,
    65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    if (fv10_data_dirtyOnCpu) {
      cudaMemcpy(*gpu_fv10_data, SD->f0.fv10_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    cudaMemcpy(*gpu_fv12_size, fv12_size, 8ULL, cudaMemcpyHostToDevice);
    d_a_data_dirtyOnCpu = false;
    p_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PI_Time_fine_data,
      *gpu_fv10_data, *gpu_fv12_size, fv10_size[0] - 1, PI_Time_fine_size[1] - 1,
      *gpu_fv12_data);
    fv12_data_dirtyOnGpu = true;
  }

  nx = fv12_size[0] * fv12_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx - 1) + 1LL),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    q_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(nx, *gpu_fv12_data);
    fv12_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == h_a_size[0]) {
    nx = PL_size[0] - 1;
    fv13_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      r_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(Local_Estimates[1],
        *gpu_fv7_data, gpu_PL_data, *gpu_PL_size, Local_Estimates[0], nx,
        *gpu_fv13_data);
      fv13_data_dirtyOnGpu = true;
    }
  } else {
    if (fv7_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv7_data, *gpu_fv7_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    h_binary_expand_op(SD->f0.fv13_data, fv13_size, Local_Estimates, PL_data,
                       PL_size, SD->f0.fv7_data, fv7_size);
    fv13_data_dirtyOnCpu = true;
  }

  nx = PL_size[0] - 1;
  k_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    s_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv14_size[0] = k_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    t_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*gpu_a_data, k_a_size[0],
      *gpu_fv14_data);
    fv14_data_dirtyOnGpu = true;
  }

  if (k_a_size[0] == PL_size[0]) {
    l_a_size[0] = k_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      u_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv14_data, k_a_size[0] - 1, *g_gpu_a_data);
    }
  } else {
    if (fv14_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv14_data, *gpu_fv14_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.f_a_data, l_a_size, SD->f0.fv14_data, fv14_size,
                       PL_data, PL_size);
    f_a_data_dirtyOnCpu = true;
  }

  fv15_size[0] = l_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((l_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (f_a_data_dirtyOnCpu) {
      cudaMemcpy(*g_gpu_a_data, SD->f0.f_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    v_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*g_gpu_a_data, l_a_size[0],
      *gpu_fv15_data);
    fv15_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  m_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    w_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv16_size[0] = m_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((m_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    x_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(*gpu_a_data, m_a_size[0],
      *gpu_fv16_data);
    fv16_data_dirtyOnGpu = true;
  }

  if (m_a_size[0] == PL_size[0]) {
    n_a_size[0] = m_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((m_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      y_TTCM_analytic_Multi_GPU_kerne<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv16_data, m_a_size[0] - 1, *h_gpu_a_data);
    }
  } else {
    if (fv16_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv16_data, *gpu_fv16_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.g_a_data, n_a_size, SD->f0.fv16_data, fv16_size,
                       PL_data, PL_size);
    g_a_data_dirtyOnCpu = true;
  }

  fv17_size[0] = n_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((n_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (g_a_data_dirtyOnCpu) {
      cudaMemcpy(*h_gpu_a_data, SD->f0.g_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    ab_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*h_gpu_a_data, n_a_size[0],
      *gpu_fv17_data);
    fv17_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == n_a_size[0]) {
    nx = PL_size[0] - 1;
    fv18_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      bb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv17_data,
        gpu_PL_data, *gpu_PL_size, nx, *gpu_fv18_data);
    }
  } else {
    if (fv17_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv17_data, *gpu_fv17_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    c_binary_expand_op(SD->f0.fv18_data, fv18_size, PL_data, PL_size,
                       SD->f0.fv17_data, fv17_size);
    fv18_data_dirtyOnCpu = true;
  }

  fv19_size[0] = 1;
  fv19_size[1] = PI_Time_fine_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    cb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      -Local_Estimates[3], PI_Time_fine_size[1] - 1, *gpu_fv19_data);
    fv19_data_dirtyOnGpu = true;
  }

  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    db_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(PI_Time_fine_size[1],
      *gpu_fv19_data);
    fv19_data_dirtyOnGpu = true;
  }

  fv20_size[0] = fv18_size[0];
  fv20_size[1] = PI_Time_fine_size[1];
  e_a_data_dirtyOnCpu = true;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv18_size[0]
    - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block, 1024U,
    65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    if (fv18_data_dirtyOnCpu) {
      cudaMemcpy(*gpu_fv18_data, SD->f0.fv18_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    cudaMemcpy(*gpu_fv20_size, fv20_size, 8ULL, cudaMemcpyHostToDevice);
    e_a_data_dirtyOnCpu = false;
    eb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      *gpu_fv18_data, *gpu_fv20_size, fv18_size[0] - 1, PI_Time_fine_size[1] - 1,
      *gpu_fv20_data);
    fv20_data_dirtyOnGpu = true;
  }

  nx = fv20_size[0] * fv20_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx - 1) + 1LL),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    fb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(nx, *gpu_fv20_data);
    fv20_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == l_a_size[0]) {
    nx = PL_size[0] - 1;
    fv21_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      gb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(Local_Estimates[3],
        *gpu_fv15_data, gpu_PL_data, *gpu_PL_size, Local_Estimates[2], nx,
        *gpu_fv21_data);
      fv21_data_dirtyOnGpu = true;
    }
  } else {
    if (fv15_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv15_data, *gpu_fv15_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    g_binary_expand_op(SD->f0.fv21_data, fv21_size, Local_Estimates, PL_data,
                       PL_size, SD->f0.fv15_data, fv15_size);
    fv21_data_dirtyOnCpu = true;
  }

  nx = PL_size[0] - 1;
  o_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    hb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv22_size[0] = o_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((o_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ib_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, o_a_size[0],
      *gpu_fv22_data);
    fv22_data_dirtyOnGpu = true;
  }

  if (o_a_size[0] == PL_size[0]) {
    p_a_size[0] = o_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((o_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      jb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv22_data, o_a_size[0] - 1, *i_gpu_a_data);
    }
  } else {
    if (fv22_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv22_data, *gpu_fv22_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.h_a_data, p_a_size, SD->f0.fv22_data, fv22_size,
                       PL_data, PL_size);
    h_a_data_dirtyOnCpu = true;
  }

  fv23_size[0] = p_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((p_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (h_a_data_dirtyOnCpu) {
      cudaMemcpy(*i_gpu_a_data, SD->f0.h_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    kb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*i_gpu_a_data, p_a_size[0],
      *gpu_fv23_data);
    fv23_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  q_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    lb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv24_size[0] = q_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((q_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    mb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, q_a_size[0],
      *gpu_fv24_data);
    fv24_data_dirtyOnGpu = true;
  }

  if (q_a_size[0] == PL_size[0]) {
    r_a_size[0] = q_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((q_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      nb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv24_data, q_a_size[0] - 1, *j_gpu_a_data);
    }
  } else {
    if (fv24_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv24_data, *gpu_fv24_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.i_a_data, r_a_size, SD->f0.fv24_data, fv24_size,
                       PL_data, PL_size);
    i_a_data_dirtyOnCpu = true;
  }

  fv25_size[0] = r_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((r_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (i_a_data_dirtyOnCpu) {
      cudaMemcpy(*j_gpu_a_data, SD->f0.i_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    ob_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*j_gpu_a_data, r_a_size[0],
      *gpu_fv25_data);
    fv25_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == r_a_size[0]) {
    nx = PL_size[0] - 1;
    fv26_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      pb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv25_data,
        gpu_PL_data, *gpu_PL_size, nx, *gpu_fv26_data);
    }
  } else {
    if (fv25_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv25_data, *gpu_fv25_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    c_binary_expand_op(SD->f0.fv26_data, fv26_size, PL_data, PL_size,
                       SD->f0.fv25_data, fv25_size);
    fv26_data_dirtyOnCpu = true;
  }

  fv27_size[0] = 1;
  fv27_size[1] = PI_Time_fine_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    qb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      -Local_Estimates[5], PI_Time_fine_size[1] - 1, *gpu_fv27_data);
    fv27_data_dirtyOnGpu = true;
  }

  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    rb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(PI_Time_fine_size[1],
      *gpu_fv27_data);
    fv27_data_dirtyOnGpu = true;
  }

  fv28_size[0] = fv26_size[0];
  fv28_size[1] = PI_Time_fine_size[1];
  fv_data_dirtyOnGpu = true;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv26_size[0]
    - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block, 1024U,
    65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    if (fv26_data_dirtyOnCpu) {
      cudaMemcpy(*gpu_fv26_data, SD->f0.fv26_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    cudaMemcpy(*gpu_fv28_size, fv28_size, 8ULL, cudaMemcpyHostToDevice);
    fv_data_dirtyOnGpu = false;
    sb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      *gpu_fv26_data, *gpu_fv28_size, fv26_size[0] - 1, PI_Time_fine_size[1] - 1,
      *gpu_fv28_data);
    fv28_data_dirtyOnGpu = true;
  }

  nx = fv28_size[0] * fv28_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx - 1) + 1LL),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    tb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(nx, *gpu_fv28_data);
    fv28_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == p_a_size[0]) {
    nx = PL_size[0] - 1;
    fv29_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      ub_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(Local_Estimates[5],
        *gpu_fv23_data, gpu_PL_data, *gpu_PL_size, Local_Estimates[4], nx,
        *gpu_fv29_data);
      fv29_data_dirtyOnGpu = true;
    }
  } else {
    if (fv23_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv23_data, *gpu_fv23_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    f_binary_expand_op(SD->f0.fv29_data, fv29_size, Local_Estimates, PL_data,
                       PL_size, SD->f0.fv23_data, fv23_size);
    fv29_data_dirtyOnCpu = true;
  }

  nx = PL_size[0] - 1;
  s_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    vb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv30_size[0] = s_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((s_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    wb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, s_a_size[0],
      *gpu_fv30_data);
    fv30_data_dirtyOnGpu = true;
  }

  if (s_a_size[0] == PL_size[0]) {
    t_a_size[0] = s_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((s_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      xb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv30_data, s_a_size[0] - 1, *k_gpu_a_data);
    }
  } else {
    if (fv30_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv30_data, *gpu_fv30_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.j_a_data, t_a_size, SD->f0.fv30_data, fv30_size,
                       PL_data, PL_size);
    j_a_data_dirtyOnCpu = true;
  }

  fv31_size[0] = t_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((t_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (j_a_data_dirtyOnCpu) {
      cudaMemcpy(*k_gpu_a_data, SD->f0.j_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    yb_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*k_gpu_a_data, t_a_size[0],
      *gpu_fv31_data);
    fv31_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  u_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    ac_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv32_size[0] = u_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((u_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    bc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, u_a_size[0],
      *gpu_fv32_data);
    fv32_data_dirtyOnGpu = true;
  }

  if (u_a_size[0] == PL_size[0]) {
    v_a_size[0] = u_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((u_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      cc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv32_data, u_a_size[0] - 1, *l_gpu_a_data);
    }
  } else {
    if (fv32_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv32_data, *gpu_fv32_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.k_a_data, v_a_size, SD->f0.fv32_data, fv32_size,
                       PL_data, PL_size);
    k_a_data_dirtyOnCpu = true;
  }

  fv33_size[0] = v_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((v_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (k_a_data_dirtyOnCpu) {
      cudaMemcpy(*l_gpu_a_data, SD->f0.k_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    dc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*l_gpu_a_data, v_a_size[0],
      *gpu_fv33_data);
    fv33_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == v_a_size[0]) {
    nx = PL_size[0] - 1;
    fv34_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      ec_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv33_data,
        gpu_PL_data, *gpu_PL_size, nx, *gpu_fv34_data);
    }
  } else {
    if (fv33_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv33_data, *gpu_fv33_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    c_binary_expand_op(SD->f0.fv34_data, fv34_size, PL_data, PL_size,
                       SD->f0.fv33_data, fv33_size);
    fv34_data_dirtyOnCpu = true;
  }

  fv35_size[0] = 1;
  fv35_size[1] = PI_Time_fine_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    fc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      -Local_Estimates[7], PI_Time_fine_size[1] - 1, *gpu_fv35_data);
    fv35_data_dirtyOnGpu = true;
  }

  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    gc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(PI_Time_fine_size[1],
      *gpu_fv35_data);
    fv35_data_dirtyOnGpu = true;
  }

  fv36_size[0] = fv34_size[0];
  fv36_size[1] = PI_Time_fine_size[1];
  fv2_data_dirtyOnGpu = true;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv34_size[0]
    - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block, 1024U,
    65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    if (fv34_data_dirtyOnCpu) {
      cudaMemcpy(*gpu_fv34_data, SD->f0.fv34_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    cudaMemcpy(*gpu_fv36_size, fv36_size, 8ULL, cudaMemcpyHostToDevice);
    fv2_data_dirtyOnGpu = false;
    hc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      *gpu_fv34_data, *gpu_fv36_size, fv34_size[0] - 1, PI_Time_fine_size[1] - 1,
      *gpu_fv36_data);
    fv36_data_dirtyOnGpu = true;
  }

  nx = fv36_size[0] * fv36_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx - 1) + 1LL),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ic_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(nx, *gpu_fv36_data);
    fv36_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == t_a_size[0]) {
    nx = PL_size[0] - 1;
    fv37_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      jc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(Local_Estimates[7],
        *gpu_fv31_data, gpu_PL_data, *gpu_PL_size, Local_Estimates[6], nx,
        *gpu_fv37_data);
      fv37_data_dirtyOnGpu = true;
    }
  } else {
    if (fv31_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv31_data, *gpu_fv31_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    e_binary_expand_op(SD->f0.fv37_data, fv37_size, Local_Estimates, PL_data,
                       PL_size, SD->f0.fv31_data, fv31_size);
    fv37_data_dirtyOnCpu = true;
  }

  if (PL_size[0] == 1) {
    nx = b_a_size[0];
    b_PL_size = b_a_size[0];
  } else {
    nx = PL_size[0];
    b_PL_size = PL_size[0];
  }

  if (b_PL_size == 1) {
    b_PL_size = PL_size[0];
  } else if (PL_size[0] == 1) {
    b_PL_size = b_a_size[0];
  } else {
    b_PL_size = PL_size[0];
  }

  if (PL_size[0] == 1) {
    c_PL_size = b_a_size[0];
    if (c_PL_size == 1) {
      c_PL_size = PL_size[0];
    } else if (PL_size[0] == 1) {
      c_PL_size = b_a_size[0];
    } else {
      c_PL_size = PL_size[0];
    }

    d_PL_size = d_a_size[0];
    e_PL_size = f_a_size[0];
    f_PL_size = b_a_size[0];
    if (f_PL_size == 1) {
      f_PL_size = PL_size[0];
    } else if (PL_size[0] == 1) {
      f_PL_size = b_a_size[0];
    } else {
      f_PL_size = PL_size[0];
    }

    g_PL_size = b_a_size[0];
  } else {
    c_PL_size = PL_size[0];
    d_PL_size = PL_size[0];
    e_PL_size = PL_size[0];
    f_PL_size = PL_size[0];
    g_PL_size = PL_size[0];
  }

  if (f_PL_size == 1) {
    f_PL_size = PL_size[0];
  } else if (PL_size[0] == 1) {
    if (g_PL_size == 1) {
      f_PL_size = PL_size[0];
    } else if (PL_size[0] == 1) {
      f_PL_size = b_a_size[0];
    } else {
      f_PL_size = PL_size[0];
    }
  } else {
    f_PL_size = PL_size[0];
  }

  if (PL_size[0] == 1) {
    g_PL_size = d_a_size[0];
  } else {
    g_PL_size = PL_size[0];
  }

  if (g_PL_size == 1) {
    if (PL_size[0] == 1) {
      g_PL_size = f_a_size[0];
    } else {
      g_PL_size = PL_size[0];
    }
  } else if (PL_size[0] == 1) {
    g_PL_size = d_a_size[0];
  } else {
    g_PL_size = PL_size[0];
  }

  if ((PL_size[0] == b_a_size[0]) && (nx == PL_size[0]) && (PL_size[0] ==
       b_PL_size) && (c_PL_size == PL_size[0]) && (PL_size[0] == d_a_size[0]) &&
      (PL_size[0] == f_a_size[0]) && (d_PL_size == e_PL_size) && (f_PL_size ==
       g_PL_size)) {
    nx = PL_size[0] - 1;
    fv38_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      kc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv5_data,
        *gpu_fv3_data, *gpu_fv1_data, *gpu_PL_size, gpu_PL_data, nx,
        *gpu_fv38_data);
      fv38_data_dirtyOnGpu = true;
    }
  } else {
    if (fv1_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv1_data, *gpu_fv1_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv3_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv3_data, *gpu_fv3_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv5_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv5_data, *gpu_fv5_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.fv38_data, fv38_size, PL_data, PL_size,
                       SD->f0.fv1_data, fv1_size, SD->f0.fv3_data, fv3_size,
                       SD->f0.fv5_data, fv5_size);
    fv38_data_dirtyOnCpu = true;
  }

  nx = PL_size[0] - 1;
  w_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    lc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv39_size[0] = w_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((w_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    mc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, w_a_size[0],
      *gpu_fv39_data);
    fv39_data_dirtyOnGpu = true;
  }

  if (w_a_size[0] == PL_size[0]) {
    x_a_size[0] = w_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((w_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      nc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv39_data, w_a_size[0] - 1, *m_gpu_a_data);
    }
  } else {
    if (fv39_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv39_data, *gpu_fv39_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.l_a_data, x_a_size, SD->f0.fv39_data, fv39_size,
                       PL_data, PL_size);
    l_a_data_dirtyOnCpu = true;
  }

  fv40_size[0] = x_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((x_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (l_a_data_dirtyOnCpu) {
      cudaMemcpy(*m_gpu_a_data, SD->f0.l_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    oc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*m_gpu_a_data, x_a_size[0],
      *gpu_fv40_data);
    fv40_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  y_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    pc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv41_size[0] = y_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((y_a_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    qc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, y_a_size[0],
      *gpu_fv41_data);
    fv41_data_dirtyOnGpu = true;
  }

  if (y_a_size[0] == PL_size[0]) {
    ab_a_size[0] = y_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((y_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      rc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv41_data, y_a_size[0] - 1, *n_gpu_a_data);
    }
  } else {
    if (fv41_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv41_data, *gpu_fv41_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.m_a_data, ab_a_size, SD->f0.fv41_data, fv41_size,
                       PL_data, PL_size);
    m_a_data_dirtyOnCpu = true;
  }

  fv42_size[0] = ab_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ab_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (m_a_data_dirtyOnCpu) {
      cudaMemcpy(*n_gpu_a_data, SD->f0.m_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    sc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*n_gpu_a_data, ab_a_size[0],
      *gpu_fv42_data);
    fv42_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  bb_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    tc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv43_size[0] = bb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((bb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    uc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, bb_a_size[0], *
      gpu_fv43_data);
    fv43_data_dirtyOnGpu = true;
  }

  if (bb_a_size[0] == PL_size[0]) {
    cb_a_size[0] = bb_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((bb_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      vc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv43_data, bb_a_size[0] - 1, *o_gpu_a_data);
    }
  } else {
    if (fv43_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv43_data, *gpu_fv43_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.n_a_data, cb_a_size, SD->f0.fv43_data, fv43_size,
                       PL_data, PL_size);
    n_a_data_dirtyOnCpu = true;
  }

  fv44_size[0] = cb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((cb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (n_a_data_dirtyOnCpu) {
      cudaMemcpy(*o_gpu_a_data, SD->f0.n_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    wc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*o_gpu_a_data, cb_a_size[0],
      *gpu_fv44_data);
    fv44_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  db_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    xc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv45_size[0] = db_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((db_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    yc_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, db_a_size[0], *
      gpu_fv45_data);
    fv45_data_dirtyOnGpu = true;
  }

  if (db_a_size[0] == PL_size[0]) {
    eb_a_size[0] = db_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((db_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      ad_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv45_data, db_a_size[0] - 1, *p_gpu_a_data);
    }
  } else {
    if (fv45_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv45_data, *gpu_fv45_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.o_a_data, eb_a_size, SD->f0.fv45_data, fv45_size,
                       PL_data, PL_size);
    o_a_data_dirtyOnCpu = true;
  }

  fv46_size[0] = eb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((eb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (o_a_data_dirtyOnCpu) {
      cudaMemcpy(*p_gpu_a_data, SD->f0.o_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    bd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*p_gpu_a_data, eb_a_size[0],
      *gpu_fv46_data);
    fv46_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  fb_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    cd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv47_size[0] = fb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((fb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    dd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, fb_a_size[0], *
      gpu_fv47_data);
    fv47_data_dirtyOnGpu = true;
  }

  if (fb_a_size[0] == PL_size[0]) {
    gb_a_size[0] = fb_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((fb_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      ed_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv47_data, fb_a_size[0] - 1, *q_gpu_a_data);
    }
  } else {
    if (fv47_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv47_data, *gpu_fv47_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.p_a_data, gb_a_size, SD->f0.fv47_data, fv47_size,
                       PL_data, PL_size);
    p_a_data_dirtyOnCpu = true;
  }

  fv48_size[0] = gb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((gb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (p_a_data_dirtyOnCpu) {
      cudaMemcpy(*q_gpu_a_data, SD->f0.p_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    fd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*q_gpu_a_data, gb_a_size[0],
      *gpu_fv48_data);
    fv48_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == gb_a_size[0]) {
    nx = PL_size[0] - 1;
    fv49_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      gd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv48_data,
        gpu_PL_data, *gpu_PL_size, nx, *gpu_fv49_data);
    }
  } else {
    if (fv48_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv48_data, *gpu_fv48_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    binary_expand_op(SD->f0.fv49_data, fv49_size, PL_data, PL_size,
                     SD->f0.fv48_data, fv48_size);
    fv49_data_dirtyOnCpu = true;
  }

  fv50_size[0] = 1;
  fv50_size[1] = PI_Time_fine_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    hd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      -Local_Estimates[1], PI_Time_fine_size[1] - 1, *gpu_fv50_data);
    fv50_data_dirtyOnGpu = true;
  }

  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    id_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(PI_Time_fine_size[1],
      *gpu_fv50_data);
    fv50_data_dirtyOnGpu = true;
  }

  fv51_size[0] = fv49_size[0];
  fv51_size[1] = PI_Time_fine_size[1];
  fv4_data_dirtyOnGpu = true;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv49_size[0]
    - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block, 1024U,
    65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    if (fv49_data_dirtyOnCpu) {
      cudaMemcpy(*gpu_fv49_data, SD->f0.fv49_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    cudaMemcpy(*gpu_fv51_size, fv51_size, 8ULL, cudaMemcpyHostToDevice);
    fv4_data_dirtyOnGpu = false;
    jd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      *gpu_fv49_data, *gpu_fv51_size, fv49_size[0] - 1, PI_Time_fine_size[1] - 1,
      *gpu_fv51_data);
    fv51_data_dirtyOnGpu = true;
  }

  nx = fv51_size[0] * fv51_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx - 1) + 1LL),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    kd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(nx, *gpu_fv51_data);
    fv51_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == eb_a_size[0]) {
    nx = PL_size[0] - 1;
    fv52_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      ld_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(Local_Estimates[1],
        *gpu_fv46_data, gpu_PL_data, *gpu_PL_size, Local_Estimates[0], nx,
        *gpu_fv52_data);
      fv52_data_dirtyOnGpu = true;
    }
  } else {
    if (fv46_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv46_data, *gpu_fv46_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    d_binary_expand_op(SD->f0.fv52_data, fv52_size, Local_Estimates, PL_data,
                       PL_size, SD->f0.fv46_data, fv46_size);
    fv52_data_dirtyOnCpu = true;
  }

  nx = PL_size[0] - 1;
  hb_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    md_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv53_size[0] = hb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((hb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    nd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, hb_a_size[0], *
      gpu_fv53_data);
    fv53_data_dirtyOnGpu = true;
  }

  if (hb_a_size[0] == PL_size[0]) {
    ib_a_size[0] = hb_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((hb_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      od_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv53_data, hb_a_size[0] - 1, *r_gpu_a_data);
    }
  } else {
    if (fv53_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv53_data, *gpu_fv53_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.q_a_data, ib_a_size, SD->f0.fv53_data, fv53_size,
                       PL_data, PL_size);
    q_a_data_dirtyOnCpu = true;
  }

  fv54_size[0] = ib_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ib_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (q_a_data_dirtyOnCpu) {
      cudaMemcpy(*r_gpu_a_data, SD->f0.q_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    pd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*r_gpu_a_data, ib_a_size[0],
      *gpu_fv54_data);
    fv54_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  jb_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    qd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv55_size[0] = jb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((jb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    rd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, jb_a_size[0], *
      gpu_fv55_data);
    fv55_data_dirtyOnGpu = true;
  }

  if (jb_a_size[0] == PL_size[0]) {
    kb_a_size[0] = jb_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((jb_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      sd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv55_data, jb_a_size[0] - 1, *s_gpu_a_data);
    }
  } else {
    if (fv55_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv55_data, *gpu_fv55_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.r_a_data, kb_a_size, SD->f0.fv55_data, fv55_size,
                       PL_data, PL_size);
    r_a_data_dirtyOnCpu = true;
  }

  fv56_size[0] = kb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((kb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (r_a_data_dirtyOnCpu) {
      cudaMemcpy(*s_gpu_a_data, SD->f0.r_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    td_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*s_gpu_a_data, kb_a_size[0],
      *gpu_fv56_data);
    fv56_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == kb_a_size[0]) {
    nx = PL_size[0] - 1;
    fv57_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      ud_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv56_data,
        gpu_PL_data, *gpu_PL_size, nx, *gpu_fv57_data);
    }
  } else {
    if (fv56_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv56_data, *gpu_fv56_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    binary_expand_op(SD->f0.fv57_data, fv57_size, PL_data, PL_size,
                     SD->f0.fv56_data, fv56_size);
    fv57_data_dirtyOnCpu = true;
  }

  fv58_size[0] = 1;
  fv58_size[1] = PI_Time_fine_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    vd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      -Local_Estimates[3], PI_Time_fine_size[1] - 1, *gpu_fv58_data);
    fv58_data_dirtyOnGpu = true;
  }

  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    wd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(PI_Time_fine_size[1],
      *gpu_fv58_data);
    fv58_data_dirtyOnGpu = true;
  }

  fv59_size[0] = fv57_size[0];
  fv59_size[1] = PI_Time_fine_size[1];
  fv6_data_dirtyOnGpu = true;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv57_size[0]
    - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block, 1024U,
    65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    if (fv57_data_dirtyOnCpu) {
      cudaMemcpy(*gpu_fv57_data, SD->f0.fv57_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    cudaMemcpy(*gpu_fv59_size, fv59_size, 8ULL, cudaMemcpyHostToDevice);
    fv6_data_dirtyOnGpu = false;
    xd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      *gpu_fv57_data, *gpu_fv59_size, fv57_size[0] - 1, PI_Time_fine_size[1] - 1,
      *gpu_fv59_data);
    fv59_data_dirtyOnGpu = true;
  }

  nx = fv59_size[0] * fv59_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx - 1) + 1LL),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    yd_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(nx, *gpu_fv59_data);
    fv59_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == ib_a_size[0]) {
    nx = PL_size[0] - 1;
    fv60_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      ae_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(Local_Estimates[3],
        *gpu_fv54_data, gpu_PL_data, *gpu_PL_size, Local_Estimates[2], nx,
        *gpu_fv60_data);
      fv60_data_dirtyOnGpu = true;
    }
  } else {
    if (fv54_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv54_data, *gpu_fv54_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    c_binary_expand_op(SD->f0.fv60_data, fv60_size, Local_Estimates, PL_data,
                       PL_size, SD->f0.fv54_data, fv54_size);
    fv60_data_dirtyOnCpu = true;
  }

  nx = PL_size[0] - 1;
  lb_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    be_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv61_size[0] = lb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((lb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ce_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, lb_a_size[0], *
      gpu_fv61_data);
    fv61_data_dirtyOnGpu = true;
  }

  if (lb_a_size[0] == PL_size[0]) {
    mb_a_size[0] = lb_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((lb_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      de_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv61_data, lb_a_size[0] - 1, *t_gpu_a_data);
    }
  } else {
    if (fv61_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv61_data, *gpu_fv61_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.s_a_data, mb_a_size, SD->f0.fv61_data, fv61_size,
                       PL_data, PL_size);
    s_a_data_dirtyOnCpu = true;
  }

  fv62_size[0] = mb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((mb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (s_a_data_dirtyOnCpu) {
      cudaMemcpy(*t_gpu_a_data, SD->f0.s_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    ee_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*t_gpu_a_data, mb_a_size[0],
      *gpu_fv62_data);
    fv62_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  nb_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    fe_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv63_size[0] = nb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ge_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, nb_a_size[0], *
      gpu_fv63_data);
    fv63_data_dirtyOnGpu = true;
  }

  if (nb_a_size[0] == PL_size[0]) {
    ob_a_size[0] = nb_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nb_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      he_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv63_data, nb_a_size[0] - 1, *u_gpu_a_data);
    }
  } else {
    if (fv63_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv63_data, *gpu_fv63_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.t_a_data, ob_a_size, SD->f0.fv63_data, fv63_size,
                       PL_data, PL_size);
    t_a_data_dirtyOnCpu = true;
  }

  fv64_size[0] = ob_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ob_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (t_a_data_dirtyOnCpu) {
      cudaMemcpy(*u_gpu_a_data, SD->f0.t_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    ie_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*u_gpu_a_data, ob_a_size[0],
      *gpu_fv64_data);
    fv64_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == ob_a_size[0]) {
    nx = PL_size[0] - 1;
    fv65_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      je_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv64_data,
        gpu_PL_data, *gpu_PL_size, nx, *gpu_fv65_data);
    }
  } else {
    if (fv64_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv64_data, *gpu_fv64_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    binary_expand_op(SD->f0.fv65_data, fv65_size, PL_data, PL_size,
                     SD->f0.fv64_data, fv64_size);
    fv65_data_dirtyOnCpu = true;
  }

  fv66_size[0] = 1;
  fv66_size[1] = PI_Time_fine_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    ke_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      -Local_Estimates[5], PI_Time_fine_size[1] - 1, *gpu_fv66_data);
    fv66_data_dirtyOnGpu = true;
  }

  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    le_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(PI_Time_fine_size[1],
      *gpu_fv66_data);
    fv66_data_dirtyOnGpu = true;
  }

  fv67_size[0] = fv65_size[0];
  fv67_size[1] = PI_Time_fine_size[1];
  fv8_data_dirtyOnGpu = true;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv65_size[0]
    - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block, 1024U,
    65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    if (fv65_data_dirtyOnCpu) {
      cudaMemcpy(*gpu_fv65_data, SD->f0.fv65_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    cudaMemcpy(*gpu_fv67_size, fv67_size, 8ULL, cudaMemcpyHostToDevice);
    fv8_data_dirtyOnGpu = false;
    me_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      *gpu_fv65_data, *gpu_fv67_size, fv65_size[0] - 1, PI_Time_fine_size[1] - 1,
      *gpu_fv67_data);
    fv67_data_dirtyOnGpu = true;
  }

  nx = fv67_size[0] * fv67_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx - 1) + 1LL),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ne_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(nx, *gpu_fv67_data);
    fv67_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == mb_a_size[0]) {
    nx = PL_size[0] - 1;
    fv68_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      oe_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(Local_Estimates[5],
        *gpu_fv62_data, gpu_PL_data, *gpu_PL_size, Local_Estimates[4], nx,
        *gpu_fv68_data);
      fv68_data_dirtyOnGpu = true;
    }
  } else {
    if (fv62_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv62_data, *gpu_fv62_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.fv68_data, fv68_size, Local_Estimates, PL_data,
                       PL_size, SD->f0.fv62_data, fv62_size);
    fv68_data_dirtyOnCpu = true;
  }

  nx = PL_size[0] - 1;
  pb_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    pe_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv69_size[0] = pb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((pb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    qe_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, pb_a_size[0], *
      gpu_fv69_data);
    fv69_data_dirtyOnGpu = true;
  }

  if (pb_a_size[0] == PL_size[0]) {
    qb_a_size[0] = pb_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((pb_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      re_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv69_data, pb_a_size[0] - 1, *v_gpu_a_data);
    }
  } else {
    if (fv69_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv69_data, *gpu_fv69_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.u_a_data, qb_a_size, SD->f0.fv69_data, fv69_size,
                       PL_data, PL_size);
    u_a_data_dirtyOnCpu = true;
  }

  fv70_size[0] = qb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((qb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (u_a_data_dirtyOnCpu) {
      cudaMemcpy(*v_gpu_a_data, SD->f0.u_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    se_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*v_gpu_a_data, qb_a_size[0],
      *gpu_fv70_data);
    fv70_data_dirtyOnGpu = true;
  }

  nx = PL_size[0] - 1;
  rb_a_size[0] = PL_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0] -
    1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PL_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                 cudaMemcpyHostToDevice);
    }

    PL_data_dirtyOnCpu = false;
    if (PL_size_dirtyOnCpu) {
      cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
    }

    PL_size_dirtyOnCpu = false;
    te_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
      nx, *gpu_a_data);
  }

  fv71_size[0] = rb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((rb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ue_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_a_data, rb_a_size[0], *
      gpu_fv71_data);
    fv71_data_dirtyOnGpu = true;
  }

  if (rb_a_size[0] == PL_size[0]) {
    sb_a_size[0] = rb_a_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((rb_a_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      ve_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PL_data, *gpu_PL_size,
        *gpu_fv71_data, rb_a_size[0] - 1, *w_gpu_a_data);
    }
  } else {
    if (fv71_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv71_data, *gpu_fv71_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    b_binary_expand_op(SD->f0.v_a_data, sb_a_size, SD->f0.fv71_data, fv71_size,
                       PL_data, PL_size);
    v_a_data_dirtyOnCpu = true;
  }

  fv72_size[0] = sb_a_size[0];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((sb_a_size[0]
    - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (v_a_data_dirtyOnCpu) {
      cudaMemcpy(*w_gpu_a_data, SD->f0.v_a_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    we_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*w_gpu_a_data, sb_a_size[0],
      *gpu_fv72_data);
    fv72_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == sb_a_size[0]) {
    nx = PL_size[0] - 1;
    fv73_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      xe_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv72_data,
        gpu_PL_data, *gpu_PL_size, nx, *gpu_fv73_data);
    }
  } else {
    if (fv72_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv72_data, *gpu_fv72_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    binary_expand_op(SD->f0.fv73_data, fv73_size, PL_data, PL_size,
                     SD->f0.fv72_data, fv72_size);
    fv73_data_dirtyOnCpu = true;
  }

  fv74_size[0] = 1;
  fv74_size[1] = PI_Time_fine_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    PI_Time_fine_data_dirtyOnCpu = false;
    ye_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      -Local_Estimates[7], PI_Time_fine_size[1] - 1, *gpu_fv74_data);
    fv74_data_dirtyOnGpu = true;
  }

  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
    ((PI_Time_fine_size[1] - 1) + 1LL), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    af_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(PI_Time_fine_size[1],
      *gpu_fv74_data);
    fv74_data_dirtyOnGpu = true;
  }

  fv75_size[0] = fv73_size[0];
  fv75_size[1] = PI_Time_fine_size[1];
  fv9_data_dirtyOnGpu = true;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv73_size[0]
    - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block, 1024U,
    65535U);
  if (validLaunchParams) {
    if (PI_Time_fine_data_dirtyOnCpu) {
      cudaMemcpy(gpu_PI_Time_fine_data, PI_Time_fine_data, PI_Time_fine_size[1] *
                 sizeof(real32_T), cudaMemcpyHostToDevice);
    }

    if (fv73_data_dirtyOnCpu) {
      cudaMemcpy(*gpu_fv73_data, SD->f0.fv73_data, 307200ULL,
                 cudaMemcpyHostToDevice);
    }

    cudaMemcpy(*gpu_fv75_size, fv75_size, 8ULL, cudaMemcpyHostToDevice);
    fv9_data_dirtyOnGpu = false;
    bf_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(gpu_PI_Time_fine_data,
      *gpu_fv73_data, *gpu_fv75_size, fv73_size[0] - 1, PI_Time_fine_size[1] - 1,
      *gpu_fv75_data);
    fv75_data_dirtyOnGpu = true;
  }

  nx = fv75_size[0] * fv75_size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx - 1) + 1LL),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    cf_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(nx, *gpu_fv75_data);
    fv75_data_dirtyOnGpu = true;
  }

  if (PL_size[0] == qb_a_size[0]) {
    nx = PL_size[0] - 1;
    fv76_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      PL_data_dirtyOnCpu = false;
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      PL_size_dirtyOnCpu = false;
      df_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(Local_Estimates[7],
        *gpu_fv70_data, gpu_PL_data, *gpu_PL_size, Local_Estimates[6], nx,
        *gpu_fv76_data);
      fv76_data_dirtyOnGpu = true;
    }
  } else {
    if (fv70_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv70_data, *gpu_fv70_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    binary_expand_op(SD->f0.fv76_data, fv76_size, Local_Estimates, PL_data,
                     PL_size, SD->f0.fv70_data, fv70_size);
    fv76_data_dirtyOnCpu = true;
  }

  if (PL_size[0] == 1) {
    nx = x_a_size[0];
    b_PL_size = x_a_size[0];
  } else {
    nx = PL_size[0];
    b_PL_size = PL_size[0];
  }

  if (b_PL_size == 1) {
    b_PL_size = PL_size[0];
  } else if (PL_size[0] == 1) {
    b_PL_size = x_a_size[0];
  } else {
    b_PL_size = PL_size[0];
  }

  if (PL_size[0] == 1) {
    c_PL_size = x_a_size[0];
    if (c_PL_size == 1) {
      c_PL_size = PL_size[0];
    } else if (PL_size[0] == 1) {
      c_PL_size = x_a_size[0];
    } else {
      c_PL_size = PL_size[0];
    }

    d_PL_size = ab_a_size[0];
    e_PL_size = cb_a_size[0];
    f_PL_size = x_a_size[0];
    if (PL_size[0] == 1) {
      if (f_PL_size == 1) {
        f_PL_size = PL_size[0];
      } else if (PL_size[0] == 1) {
        f_PL_size = x_a_size[0];
      } else {
        f_PL_size = PL_size[0];
      }
    } else {
      f_PL_size = PL_size[0];
    }

    g_PL_size = ab_a_size[0];
  } else {
    c_PL_size = PL_size[0];
    d_PL_size = PL_size[0];
    e_PL_size = PL_size[0];
    f_PL_size = PL_size[0];
    g_PL_size = PL_size[0];
  }

  if (g_PL_size == 1) {
    if (PL_size[0] == 1) {
      g_PL_size = cb_a_size[0];
    } else {
      g_PL_size = PL_size[0];
    }
  } else if (PL_size[0] == 1) {
    g_PL_size = ab_a_size[0];
  } else {
    g_PL_size = PL_size[0];
  }

  if ((PL_size[0] == x_a_size[0]) && (nx == PL_size[0]) && (PL_size[0] ==
       b_PL_size) && (PL_size[0] == c_PL_size) && (PL_size[0] == ab_a_size[0]) &&
      (PL_size[0] == cb_a_size[0]) && (d_PL_size == e_PL_size) && (f_PL_size ==
       g_PL_size)) {
    nx = PL_size[0] - 1;
    fv77_size[0] = PL_size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((PL_size[0]
      - 1) + 1LL), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (PL_size_dirtyOnCpu) {
        cudaMemcpy(*gpu_PL_size, PL_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (PL_data_dirtyOnCpu) {
        cudaMemcpy(gpu_PL_data, PL_data, PL_size[0] * 4 * sizeof(real32_T),
                   cudaMemcpyHostToDevice);
      }

      ef_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv44_data,
        *gpu_fv42_data, *gpu_fv40_data, *gpu_PL_size, gpu_PL_data, nx,
        *gpu_fv77_data);
      fv77_data_dirtyOnGpu = true;
    }
  } else {
    if (fv40_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv40_data, *gpu_fv40_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv42_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv42_data, *gpu_fv42_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv44_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv44_data, *gpu_fv44_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    binary_expand_op(SD->f0.fv77_data, fv77_size, PL_data, PL_size,
                     SD->f0.fv40_data, fv40_size, SD->f0.fv42_data, fv42_size,
                     SD->f0.fv44_data, fv44_size);
    fv77_data_dirtyOnCpu = true;
  }

  if (fv13_size[0] == 1) {
    g_PL_size = fv12_size[0];
  } else {
    g_PL_size = fv13_size[0];
  }

  if (fv21_size[0] == 1) {
    b_fv21_size = fv20_size[0];
  } else {
    b_fv21_size = fv21_size[0];
  }

  if (PI_Time_fine_size[1] == 1) {
    b_PI_Time_fine_size = fv12_size[1];
    c_PI_Time_fine_size = fv20_size[1];
  } else {
    b_PI_Time_fine_size = PI_Time_fine_size[1];
    c_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (fv13_size[0] == 1) {
    b_fv13_size = fv12_size[0];
  } else {
    b_fv13_size = fv13_size[0];
  }

  if (b_fv13_size == 1) {
    if (fv21_size[0] == 1) {
      b_fv13_size = fv20_size[0];
    } else {
      b_fv13_size = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    b_fv13_size = fv12_size[0];
  } else {
    b_fv13_size = fv13_size[0];
  }

  if (fv29_size[0] == 1) {
    b_fv29_size = fv28_size[0];
  } else {
    b_fv29_size = fv29_size[0];
  }

  if (PI_Time_fine_size[1] == 1) {
    d_PI_Time_fine_size = fv12_size[1];
  } else {
    d_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (d_PI_Time_fine_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      d_PI_Time_fine_size = fv20_size[1];
    } else {
      d_PI_Time_fine_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    d_PI_Time_fine_size = fv12_size[1];
  } else {
    d_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    e_PI_Time_fine_size = fv28_size[1];
  } else {
    e_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (fv13_size[0] == 1) {
    c_fv13_size = fv12_size[0];
  } else {
    c_fv13_size = fv13_size[0];
  }

  if (c_fv13_size == 1) {
    if (fv21_size[0] == 1) {
      c_fv13_size = fv20_size[0];
    } else {
      c_fv13_size = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    c_fv13_size = fv12_size[0];
  } else {
    c_fv13_size = fv13_size[0];
  }

  if (fv13_size[0] == 1) {
    d_fv13_size = fv12_size[0];
  } else {
    d_fv13_size = fv13_size[0];
  }

  if (c_fv13_size == 1) {
    if (fv29_size[0] == 1) {
      c_fv13_size = fv28_size[0];
    } else {
      c_fv13_size = fv29_size[0];
    }
  } else if (d_fv13_size == 1) {
    if (fv21_size[0] == 1) {
      c_fv13_size = fv20_size[0];
    } else {
      c_fv13_size = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    c_fv13_size = fv12_size[0];
  } else {
    c_fv13_size = fv13_size[0];
  }

  if (fv37_size[0] == 1) {
    b_fv37_size = fv36_size[0];
  } else {
    b_fv37_size = fv37_size[0];
  }

  if (PI_Time_fine_size[1] == 1) {
    f_PI_Time_fine_size = fv12_size[1];
  } else {
    f_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (f_PI_Time_fine_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      f_PI_Time_fine_size = fv20_size[1];
    } else {
      f_PI_Time_fine_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    f_PI_Time_fine_size = fv12_size[1];
  } else {
    f_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    g_PI_Time_fine_size = fv12_size[1];
  } else {
    g_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (f_PI_Time_fine_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      f_PI_Time_fine_size = fv28_size[1];
    } else {
      f_PI_Time_fine_size = PI_Time_fine_size[1];
    }
  } else if (g_PI_Time_fine_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      f_PI_Time_fine_size = fv20_size[1];
    } else {
      f_PI_Time_fine_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    f_PI_Time_fine_size = fv12_size[1];
  } else {
    f_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    g_PI_Time_fine_size = fv36_size[1];
  } else {
    g_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (fv13_size[0] == 1) {
    d_fv13_size = fv12_size[0];
  } else {
    d_fv13_size = fv13_size[0];
  }

  if (d_fv13_size == 1) {
    if (fv21_size[0] == 1) {
      d_fv13_size = fv20_size[0];
    } else {
      d_fv13_size = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    d_fv13_size = fv12_size[0];
  } else {
    d_fv13_size = fv13_size[0];
  }

  if (fv13_size[0] == 1) {
    nx = fv12_size[0];
  } else {
    nx = fv13_size[0];
  }

  if (d_fv13_size == 1) {
    if (fv29_size[0] == 1) {
      d_fv13_size = fv28_size[0];
    } else {
      d_fv13_size = fv29_size[0];
    }
  } else if (nx == 1) {
    if (fv21_size[0] == 1) {
      d_fv13_size = fv20_size[0];
    } else {
      d_fv13_size = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    d_fv13_size = fv12_size[0];
  } else {
    d_fv13_size = fv13_size[0];
  }

  if (fv13_size[0] == 1) {
    nx = fv12_size[0];
  } else {
    nx = fv13_size[0];
  }

  if (nx == 1) {
    if (fv21_size[0] == 1) {
      nx = fv20_size[0];
    } else {
      nx = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    nx = fv12_size[0];
  } else {
    nx = fv13_size[0];
  }

  if (fv13_size[0] == 1) {
    b_PL_size = fv12_size[0];
  } else {
    b_PL_size = fv13_size[0];
  }

  if (d_fv13_size == 1) {
    if (fv37_size[0] == 1) {
      d_fv13_size = fv36_size[0];
    } else {
      d_fv13_size = fv37_size[0];
    }
  } else if (nx == 1) {
    if (fv29_size[0] == 1) {
      d_fv13_size = fv28_size[0];
    } else {
      d_fv13_size = fv29_size[0];
    }
  } else if (b_PL_size == 1) {
    if (fv21_size[0] == 1) {
      d_fv13_size = fv20_size[0];
    } else {
      d_fv13_size = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    d_fv13_size = fv12_size[0];
  } else {
    d_fv13_size = fv13_size[0];
  }

  if (fv52_size[0] == 1) {
    b_fv52_size = fv51_size[0];
  } else {
    b_fv52_size = fv52_size[0];
  }

  if (fv60_size[0] == 1) {
    b_fv60_size = fv59_size[0];
  } else {
    b_fv60_size = fv60_size[0];
  }

  if (PI_Time_fine_size[1] == 1) {
    h_PI_Time_fine_size = fv51_size[1];
    i_PI_Time_fine_size = fv59_size[1];
  } else {
    h_PI_Time_fine_size = PI_Time_fine_size[1];
    i_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (fv52_size[0] == 1) {
    c_fv52_size = fv51_size[0];
  } else {
    c_fv52_size = fv52_size[0];
  }

  if (c_fv52_size == 1) {
    if (fv60_size[0] == 1) {
      c_fv52_size = fv59_size[0];
    } else {
      c_fv52_size = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    c_fv52_size = fv51_size[0];
  } else {
    c_fv52_size = fv52_size[0];
  }

  if (fv68_size[0] == 1) {
    b_fv68_size = fv67_size[0];
  } else {
    b_fv68_size = fv68_size[0];
  }

  if (PI_Time_fine_size[1] == 1) {
    j_PI_Time_fine_size = fv51_size[1];
  } else {
    j_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (j_PI_Time_fine_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      j_PI_Time_fine_size = fv59_size[1];
    } else {
      j_PI_Time_fine_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    j_PI_Time_fine_size = fv51_size[1];
  } else {
    j_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    k_PI_Time_fine_size = fv67_size[1];
  } else {
    k_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (fv52_size[0] == 1) {
    d_fv52_size = fv51_size[0];
  } else {
    d_fv52_size = fv52_size[0];
  }

  if (d_fv52_size == 1) {
    if (fv60_size[0] == 1) {
      d_fv52_size = fv59_size[0];
    } else {
      d_fv52_size = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    d_fv52_size = fv51_size[0];
  } else {
    d_fv52_size = fv52_size[0];
  }

  if (fv52_size[0] == 1) {
    e_fv52_size = fv51_size[0];
  } else {
    e_fv52_size = fv52_size[0];
  }

  if (d_fv52_size == 1) {
    if (fv68_size[0] == 1) {
      d_fv52_size = fv67_size[0];
    } else {
      d_fv52_size = fv68_size[0];
    }
  } else if (e_fv52_size == 1) {
    if (fv60_size[0] == 1) {
      d_fv52_size = fv59_size[0];
    } else {
      d_fv52_size = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    d_fv52_size = fv51_size[0];
  } else {
    d_fv52_size = fv52_size[0];
  }

  if (fv76_size[0] == 1) {
    b_fv76_size = fv75_size[0];
  } else {
    b_fv76_size = fv76_size[0];
  }

  if (PI_Time_fine_size[1] == 1) {
    l_PI_Time_fine_size = fv51_size[1];
  } else {
    l_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (l_PI_Time_fine_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      l_PI_Time_fine_size = fv59_size[1];
    } else {
      l_PI_Time_fine_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    l_PI_Time_fine_size = fv51_size[1];
  } else {
    l_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    m_PI_Time_fine_size = fv51_size[1];
  } else {
    m_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (l_PI_Time_fine_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      l_PI_Time_fine_size = fv67_size[1];
    } else {
      l_PI_Time_fine_size = PI_Time_fine_size[1];
    }
  } else if (m_PI_Time_fine_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      l_PI_Time_fine_size = fv59_size[1];
    } else {
      l_PI_Time_fine_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    l_PI_Time_fine_size = fv51_size[1];
  } else {
    l_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    m_PI_Time_fine_size = fv75_size[1];
  } else {
    m_PI_Time_fine_size = PI_Time_fine_size[1];
  }

  if (fv52_size[0] == 1) {
    e_fv52_size = fv51_size[0];
  } else {
    e_fv52_size = fv52_size[0];
  }

  if (e_fv52_size == 1) {
    if (fv60_size[0] == 1) {
      e_fv52_size = fv59_size[0];
    } else {
      e_fv52_size = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    e_fv52_size = fv51_size[0];
  } else {
    e_fv52_size = fv52_size[0];
  }

  if (fv52_size[0] == 1) {
    nx = fv51_size[0];
  } else {
    nx = fv52_size[0];
  }

  if (e_fv52_size == 1) {
    if (fv68_size[0] == 1) {
      e_fv52_size = fv67_size[0];
    } else {
      e_fv52_size = fv68_size[0];
    }
  } else if (nx == 1) {
    if (fv60_size[0] == 1) {
      e_fv52_size = fv59_size[0];
    } else {
      e_fv52_size = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    e_fv52_size = fv51_size[0];
  } else {
    e_fv52_size = fv52_size[0];
  }

  if (fv52_size[0] == 1) {
    nx = fv51_size[0];
  } else {
    nx = fv52_size[0];
  }

  if (nx == 1) {
    if (fv60_size[0] == 1) {
      nx = fv59_size[0];
    } else {
      nx = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    nx = fv51_size[0];
  } else {
    nx = fv52_size[0];
  }

  if (fv52_size[0] == 1) {
    b_PL_size = fv51_size[0];
  } else {
    b_PL_size = fv52_size[0];
  }

  if (e_fv52_size == 1) {
    if (fv76_size[0] == 1) {
      e_fv52_size = fv75_size[0];
    } else {
      e_fv52_size = fv76_size[0];
    }
  } else if (nx == 1) {
    if (fv68_size[0] == 1) {
      e_fv52_size = fv67_size[0];
    } else {
      e_fv52_size = fv68_size[0];
    }
  } else if (b_PL_size == 1) {
    if (fv60_size[0] == 1) {
      e_fv52_size = fv59_size[0];
    } else {
      e_fv52_size = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    e_fv52_size = fv51_size[0];
  } else {
    e_fv52_size = fv52_size[0];
  }

  if (fv13_size[0] == 1) {
    nx = fv12_size[0];
  } else {
    nx = fv13_size[0];
  }

  if (nx == 1) {
    if (fv21_size[0] == 1) {
      nx = fv20_size[0];
    } else {
      nx = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    nx = fv12_size[0];
  } else {
    nx = fv13_size[0];
  }

  if (fv13_size[0] == 1) {
    b_PL_size = fv12_size[0];
  } else {
    b_PL_size = fv13_size[0];
  }

  if (nx == 1) {
    if (fv29_size[0] == 1) {
      nx = fv28_size[0];
    } else {
      nx = fv29_size[0];
    }
  } else if (b_PL_size == 1) {
    if (fv21_size[0] == 1) {
      nx = fv20_size[0];
    } else {
      nx = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    nx = fv12_size[0];
  } else {
    nx = fv13_size[0];
  }

  if (fv13_size[0] == 1) {
    b_PL_size = fv12_size[0];
  } else {
    b_PL_size = fv13_size[0];
  }

  if (b_PL_size == 1) {
    if (fv21_size[0] == 1) {
      b_PL_size = fv20_size[0];
    } else {
      b_PL_size = fv21_size[0];
    }
  } else if (fv13_size[0] == 1) {
    b_PL_size = fv12_size[0];
  } else {
    b_PL_size = fv13_size[0];
  }

  if (fv13_size[0] == 1) {
    c_PL_size = fv12_size[0];
  } else {
    c_PL_size = fv13_size[0];
  }

  if (fv38_size[0] == 1) {
    if (nx == 1) {
      if (fv37_size[0] == 1) {
        f_PL_size = fv36_size[0];
      } else {
        f_PL_size = fv37_size[0];
      }
    } else if (b_PL_size == 1) {
      if (fv29_size[0] == 1) {
        f_PL_size = fv28_size[0];
      } else {
        f_PL_size = fv29_size[0];
      }
    } else if (c_PL_size == 1) {
      if (fv21_size[0] == 1) {
        f_PL_size = fv20_size[0];
      } else {
        f_PL_size = fv21_size[0];
      }
    } else if (fv13_size[0] == 1) {
      f_PL_size = fv12_size[0];
    } else {
      f_PL_size = fv13_size[0];
    }
  } else {
    f_PL_size = fv38_size[0];
  }

  if (fv52_size[0] == 1) {
    nx = fv51_size[0];
  } else {
    nx = fv52_size[0];
  }

  if (nx == 1) {
    if (fv60_size[0] == 1) {
      nx = fv59_size[0];
    } else {
      nx = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    nx = fv51_size[0];
  } else {
    nx = fv52_size[0];
  }

  if (fv52_size[0] == 1) {
    b_PL_size = fv51_size[0];
  } else {
    b_PL_size = fv52_size[0];
  }

  if (nx == 1) {
    if (fv68_size[0] == 1) {
      nx = fv67_size[0];
    } else {
      nx = fv68_size[0];
    }
  } else if (b_PL_size == 1) {
    if (fv60_size[0] == 1) {
      nx = fv59_size[0];
    } else {
      nx = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    nx = fv51_size[0];
  } else {
    nx = fv52_size[0];
  }

  if (fv52_size[0] == 1) {
    b_PL_size = fv51_size[0];
  } else {
    b_PL_size = fv52_size[0];
  }

  if (b_PL_size == 1) {
    if (fv60_size[0] == 1) {
      b_PL_size = fv59_size[0];
    } else {
      b_PL_size = fv60_size[0];
    }
  } else if (fv52_size[0] == 1) {
    b_PL_size = fv51_size[0];
  } else {
    b_PL_size = fv52_size[0];
  }

  if (fv52_size[0] == 1) {
    c_PL_size = fv51_size[0];
  } else {
    c_PL_size = fv52_size[0];
  }

  if (fv77_size[0] == 1) {
    if (nx == 1) {
      if (fv76_size[0] == 1) {
        nx = fv75_size[0];
      } else {
        nx = fv76_size[0];
      }
    } else if (b_PL_size == 1) {
      if (fv68_size[0] == 1) {
        nx = fv67_size[0];
      } else {
        nx = fv68_size[0];
      }
    } else if (c_PL_size == 1) {
      if (fv60_size[0] == 1) {
        nx = fv59_size[0];
      } else {
        nx = fv60_size[0];
      }
    } else if (fv52_size[0] == 1) {
      nx = fv51_size[0];
    } else {
      nx = fv52_size[0];
    }
  } else {
    nx = fv77_size[0];
  }

  if (PI_Time_fine_size[1] == 1) {
    b_PL_size = fv12_size[1];
  } else {
    b_PL_size = PI_Time_fine_size[1];
  }

  if (b_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      b_PL_size = fv20_size[1];
    } else {
      b_PL_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    b_PL_size = fv12_size[1];
  } else {
    b_PL_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    c_PL_size = fv12_size[1];
  } else {
    c_PL_size = PI_Time_fine_size[1];
  }

  if (b_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      b_PL_size = fv28_size[1];
    } else {
      b_PL_size = PI_Time_fine_size[1];
    }
  } else if (c_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      b_PL_size = fv20_size[1];
    } else {
      b_PL_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    b_PL_size = fv12_size[1];
  } else {
    b_PL_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    c_PL_size = fv12_size[1];
  } else {
    c_PL_size = PI_Time_fine_size[1];
  }

  if (c_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      c_PL_size = fv20_size[1];
    } else {
      c_PL_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    c_PL_size = fv12_size[1];
  } else {
    c_PL_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    d_PL_size = fv12_size[1];
  } else {
    d_PL_size = PI_Time_fine_size[1];
  }

  if (b_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      b_PL_size = fv36_size[1];
    } else {
      b_PL_size = PI_Time_fine_size[1];
    }
  } else if (c_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      b_PL_size = fv28_size[1];
    } else {
      b_PL_size = PI_Time_fine_size[1];
    }
  } else if (d_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      b_PL_size = fv20_size[1];
    } else {
      b_PL_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    b_PL_size = fv12_size[1];
  } else {
    b_PL_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    c_PL_size = fv51_size[1];
  } else {
    c_PL_size = PI_Time_fine_size[1];
  }

  if (c_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      c_PL_size = fv59_size[1];
    } else {
      c_PL_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    c_PL_size = fv51_size[1];
  } else {
    c_PL_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    d_PL_size = fv51_size[1];
  } else {
    d_PL_size = PI_Time_fine_size[1];
  }

  if (c_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      c_PL_size = fv67_size[1];
    } else {
      c_PL_size = PI_Time_fine_size[1];
    }
  } else if (d_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      c_PL_size = fv59_size[1];
    } else {
      c_PL_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    c_PL_size = fv51_size[1];
  } else {
    c_PL_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    d_PL_size = fv51_size[1];
  } else {
    d_PL_size = PI_Time_fine_size[1];
  }

  if (d_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      d_PL_size = fv59_size[1];
    } else {
      d_PL_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    d_PL_size = fv51_size[1];
  } else {
    d_PL_size = PI_Time_fine_size[1];
  }

  if (PI_Time_fine_size[1] == 1) {
    e_PL_size = fv51_size[1];
  } else {
    e_PL_size = PI_Time_fine_size[1];
  }

  if (c_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      c_PL_size = fv75_size[1];
    } else {
      c_PL_size = PI_Time_fine_size[1];
    }
  } else if (d_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      c_PL_size = fv67_size[1];
    } else {
      c_PL_size = PI_Time_fine_size[1];
    }
  } else if (e_PL_size == 1) {
    if (PI_Time_fine_size[1] == 1) {
      c_PL_size = fv59_size[1];
    } else {
      c_PL_size = PI_Time_fine_size[1];
    }
  } else if (PI_Time_fine_size[1] == 1) {
    c_PL_size = fv51_size[1];
  } else {
    c_PL_size = PI_Time_fine_size[1];
  }

  if ((PI_Time_fine_size[1] == fv12_size[1]) && (fv13_size[0] == fv12_size[0]) &&
      (PI_Time_fine_size[1] == fv20_size[1]) && (fv21_size[0] == fv20_size[0]) &&
      (g_PL_size == b_fv21_size) && (b_PI_Time_fine_size == c_PI_Time_fine_size)
      && (PI_Time_fine_size[1] == fv28_size[1]) && (fv29_size[0] == fv28_size[0])
      && (b_fv13_size == b_fv29_size) && (d_PI_Time_fine_size ==
       e_PI_Time_fine_size) && (PI_Time_fine_size[1] == fv36_size[1]) &&
      (fv37_size[0] == fv36_size[0]) && (c_fv13_size == b_fv37_size) &&
      (f_PI_Time_fine_size == g_PI_Time_fine_size) && (fv38_size[0] ==
       d_fv13_size) && (PI_Time_fine_size[1] == fv51_size[1]) && (fv52_size[0] ==
       fv51_size[0]) && (PI_Time_fine_size[1] == fv59_size[1]) && (fv60_size[0] ==
       fv59_size[0]) && (b_fv52_size == b_fv60_size) && (h_PI_Time_fine_size ==
       i_PI_Time_fine_size) && (PI_Time_fine_size[1] == fv67_size[1]) &&
      (fv68_size[0] == fv67_size[0]) && (c_fv52_size == b_fv68_size) &&
      (j_PI_Time_fine_size == k_PI_Time_fine_size) && (PI_Time_fine_size[1] ==
       fv75_size[1]) && (fv76_size[0] == fv75_size[0]) && (d_fv52_size ==
       b_fv76_size) && (l_PI_Time_fine_size == m_PI_Time_fine_size) &&
      (fv77_size[0] == e_fv52_size) && (f_PL_size == nx) && (b_PL_size ==
       c_PL_size)) {
    Ct_size[0] = fv38_size[0];
    Ct_size[1] = PI_Time_fine_size[1];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((fv38_size
      [0] - 1) + 1LL) * ((PI_Time_fine_size[1] - 1) + 1LL)), &grid, &block,
      1024U, 65535U);
    if (validLaunchParams) {
      if (fv9_data_dirtyOnGpu) {
        cudaMemcpy(*gpu_fv75_size, fv75_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (fv76_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv76_data, SD->f0.fv76_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (fv8_data_dirtyOnGpu) {
        cudaMemcpy(*gpu_fv67_size, fv67_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (fv68_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv68_data, SD->f0.fv68_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (fv6_data_dirtyOnGpu) {
        cudaMemcpy(*gpu_fv59_size, fv59_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (fv60_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv60_data, SD->f0.fv60_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (fv4_data_dirtyOnGpu) {
        cudaMemcpy(*gpu_fv51_size, fv51_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (fv52_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv52_data, SD->f0.fv52_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (fv77_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv77_data, SD->f0.fv77_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (fv2_data_dirtyOnGpu) {
        cudaMemcpy(*gpu_fv36_size, fv36_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (fv37_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv37_data, SD->f0.fv37_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (fv_data_dirtyOnGpu) {
        cudaMemcpy(*gpu_fv28_size, fv28_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (fv29_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv29_data, SD->f0.fv29_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (e_a_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv20_size, fv20_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (fv21_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv21_data, SD->f0.fv21_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (d_a_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv12_size, fv12_size, 8ULL, cudaMemcpyHostToDevice);
      }

      if (fv13_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv13_data, SD->f0.fv13_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      if (fv38_data_dirtyOnCpu) {
        cudaMemcpy(*gpu_fv38_data, SD->f0.fv38_data, 307200ULL,
                   cudaMemcpyHostToDevice);
      }

      cudaMemcpy(*gpu_Ct_size, Ct_size, 8ULL, cudaMemcpyHostToDevice);
      ff_TTCM_analytic_Multi_GPU_kern<<<grid, block>>>(*gpu_fv75_data,
        *gpu_fv75_size, *gpu_fv74_data, *gpu_fv76_data, *gpu_fv67_data,
        *gpu_fv67_size, *gpu_fv66_data, *gpu_fv68_data, *gpu_fv59_data,
        *gpu_fv59_size, *gpu_fv58_data, *gpu_fv60_data, *gpu_fv51_data,
        *gpu_fv51_size, *gpu_fv50_data, *gpu_fv52_data, *gpu_fv77_data,
        *gpu_fv36_data, *gpu_fv36_size, *gpu_fv35_data, *gpu_fv37_data,
        *gpu_fv28_data, *gpu_fv28_size, *gpu_fv27_data, *gpu_fv29_data,
        *gpu_fv20_data, *gpu_fv20_size, *gpu_fv19_data, *gpu_fv21_data,
        *gpu_fv12_data, *gpu_fv12_size, *gpu_fv11_data, *gpu_fv13_data,
        *gpu_fv38_data, *gpu_Ct_size, fv38_size[0] - 1, PI_Time_fine_size[1] - 1,
        gpu_Ct_data);
      Ct_data_dirtyOnGpu = true;
    }
  } else {
    if (fv38_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv38_data, *gpu_fv38_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv13_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv13_data, *gpu_fv13_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv11_data_dirtyOnGpu) {
      cudaMemcpy(fv11_data, *gpu_fv11_data, 3204ULL, cudaMemcpyDeviceToHost);
    }

    if (fv12_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv12_data, *gpu_fv12_data, 246067200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv21_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv21_data, *gpu_fv21_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv19_data_dirtyOnGpu) {
      cudaMemcpy(fv19_data, *gpu_fv19_data, 3204ULL, cudaMemcpyDeviceToHost);
    }

    if (fv20_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv20_data, *gpu_fv20_data, 246067200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv29_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv29_data, *gpu_fv29_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv27_data_dirtyOnGpu) {
      cudaMemcpy(fv27_data, *gpu_fv27_data, 3204ULL, cudaMemcpyDeviceToHost);
    }

    if (fv28_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv28_data, *gpu_fv28_data, 246067200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv37_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv37_data, *gpu_fv37_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv35_data_dirtyOnGpu) {
      cudaMemcpy(fv35_data, *gpu_fv35_data, 3204ULL, cudaMemcpyDeviceToHost);
    }

    if (fv36_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv36_data, *gpu_fv36_data, 246067200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv77_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv77_data, *gpu_fv77_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv52_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv52_data, *gpu_fv52_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv50_data_dirtyOnGpu) {
      cudaMemcpy(fv50_data, *gpu_fv50_data, 3204ULL, cudaMemcpyDeviceToHost);
    }

    if (fv51_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv51_data, *gpu_fv51_data, 246067200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv60_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv60_data, *gpu_fv60_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv58_data_dirtyOnGpu) {
      cudaMemcpy(fv58_data, *gpu_fv58_data, 3204ULL, cudaMemcpyDeviceToHost);
    }

    if (fv59_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv59_data, *gpu_fv59_data, 246067200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv68_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv68_data, *gpu_fv68_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv66_data_dirtyOnGpu) {
      cudaMemcpy(fv66_data, *gpu_fv66_data, 3204ULL, cudaMemcpyDeviceToHost);
    }

    if (fv67_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv67_data, *gpu_fv67_data, 246067200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv76_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv76_data, *gpu_fv76_data, 307200ULL,
                 cudaMemcpyDeviceToHost);
    }

    if (fv74_data_dirtyOnGpu) {
      cudaMemcpy(fv74_data, *gpu_fv74_data, 3204ULL, cudaMemcpyDeviceToHost);
    }

    if (fv75_data_dirtyOnGpu) {
      cudaMemcpy(SD->f0.fv75_data, *gpu_fv75_data, 246067200ULL,
                 cudaMemcpyDeviceToHost);
    }

    binary_expand_op(Ct_data, Ct_size, SD->f0.fv38_data, fv38_size,
                     SD->f0.fv13_data, fv13_size, fv11_data, fv11_size,
                     SD->f0.fv12_data, fv12_size, SD->f0.fv21_data, fv21_size,
                     fv19_data, fv19_size, SD->f0.fv20_data, fv20_size,
                     SD->f0.fv29_data, fv29_size, fv27_data, fv27_size,
                     SD->f0.fv28_data, fv28_size, SD->f0.fv37_data, fv37_size,
                     fv35_data, fv35_size, SD->f0.fv36_data, fv36_size,
                     SD->f0.fv77_data, fv77_size, SD->f0.fv52_data, fv52_size,
                     fv50_data, fv50_size, SD->f0.fv51_data, fv51_size,
                     SD->f0.fv60_data, fv60_size, fv58_data, fv58_size,
                     SD->f0.fv59_data, fv59_size, SD->f0.fv68_data, fv68_size,
                     fv66_data, fv66_size, SD->f0.fv67_data, fv67_size,
                     SD->f0.fv76_data, fv76_size, fv74_data, fv74_size,
                     SD->f0.fv75_data, fv75_size);
  }

  // Ct(isnan(Ct))=0; % removing NaN
  if (Ct_data_dirtyOnGpu) {
    cudaMemcpy(Ct_data, gpu_Ct_data, Ct_size[0] * Ct_size[1] * sizeof(real32_T),
               cudaMemcpyDeviceToHost);
  }

  mwCudaFree(&gpu_PL_data[0]);
  mwCudaFree(&(*gpu_PL_size)[0]);
  mwCudaFree(&(*gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv_data)[0]);
  mwCudaFree(&(*b_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv1_data)[0]);
  mwCudaFree(&(*gpu_fv2_data)[0]);
  mwCudaFree(&(*c_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv3_data)[0]);
  mwCudaFree(&(*gpu_fv4_data)[0]);
  mwCudaFree(&(*d_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv5_data)[0]);
  mwCudaFree(&(*gpu_fv6_data)[0]);
  mwCudaFree(&(*e_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv7_data)[0]);
  mwCudaFree(&(*gpu_fv8_data)[0]);
  mwCudaFree(&(*f_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv9_data)[0]);
  mwCudaFree(&(*gpu_fv10_data)[0]);
  mwCudaFree(&gpu_PI_Time_fine_data[0]);
  mwCudaFree(&(*gpu_fv11_data)[0]);
  mwCudaFree(&(*gpu_fv12_size)[0]);
  mwCudaFree(&(*gpu_fv12_data)[0]);
  mwCudaFree(&(*gpu_fv13_data)[0]);
  mwCudaFree(&(*gpu_fv14_data)[0]);
  mwCudaFree(&(*g_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv15_data)[0]);
  mwCudaFree(&(*gpu_fv16_data)[0]);
  mwCudaFree(&(*h_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv17_data)[0]);
  mwCudaFree(&(*gpu_fv18_data)[0]);
  mwCudaFree(&(*gpu_fv19_data)[0]);
  mwCudaFree(&(*gpu_fv20_size)[0]);
  mwCudaFree(&(*gpu_fv20_data)[0]);
  mwCudaFree(&(*gpu_fv21_data)[0]);
  mwCudaFree(&(*gpu_fv22_data)[0]);
  mwCudaFree(&(*i_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv23_data)[0]);
  mwCudaFree(&(*gpu_fv24_data)[0]);
  mwCudaFree(&(*j_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv25_data)[0]);
  mwCudaFree(&(*gpu_fv26_data)[0]);
  mwCudaFree(&(*gpu_fv27_data)[0]);
  mwCudaFree(&(*gpu_fv28_size)[0]);
  mwCudaFree(&(*gpu_fv28_data)[0]);
  mwCudaFree(&(*gpu_fv29_data)[0]);
  mwCudaFree(&(*gpu_fv30_data)[0]);
  mwCudaFree(&(*k_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv31_data)[0]);
  mwCudaFree(&(*gpu_fv32_data)[0]);
  mwCudaFree(&(*l_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv33_data)[0]);
  mwCudaFree(&(*gpu_fv34_data)[0]);
  mwCudaFree(&(*gpu_fv35_data)[0]);
  mwCudaFree(&(*gpu_fv36_size)[0]);
  mwCudaFree(&(*gpu_fv36_data)[0]);
  mwCudaFree(&(*gpu_fv37_data)[0]);
  mwCudaFree(&(*gpu_fv38_data)[0]);
  mwCudaFree(&(*gpu_fv39_data)[0]);
  mwCudaFree(&(*m_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv40_data)[0]);
  mwCudaFree(&(*gpu_fv41_data)[0]);
  mwCudaFree(&(*n_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv42_data)[0]);
  mwCudaFree(&(*gpu_fv43_data)[0]);
  mwCudaFree(&(*o_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv44_data)[0]);
  mwCudaFree(&(*gpu_fv45_data)[0]);
  mwCudaFree(&(*p_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv46_data)[0]);
  mwCudaFree(&(*gpu_fv47_data)[0]);
  mwCudaFree(&(*q_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv48_data)[0]);
  mwCudaFree(&(*gpu_fv49_data)[0]);
  mwCudaFree(&(*gpu_fv50_data)[0]);
  mwCudaFree(&(*gpu_fv51_size)[0]);
  mwCudaFree(&(*gpu_fv51_data)[0]);
  mwCudaFree(&(*gpu_fv52_data)[0]);
  mwCudaFree(&(*gpu_fv53_data)[0]);
  mwCudaFree(&(*r_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv54_data)[0]);
  mwCudaFree(&(*gpu_fv55_data)[0]);
  mwCudaFree(&(*s_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv56_data)[0]);
  mwCudaFree(&(*gpu_fv57_data)[0]);
  mwCudaFree(&(*gpu_fv58_data)[0]);
  mwCudaFree(&(*gpu_fv59_size)[0]);
  mwCudaFree(&(*gpu_fv59_data)[0]);
  mwCudaFree(&(*gpu_fv60_data)[0]);
  mwCudaFree(&(*gpu_fv61_data)[0]);
  mwCudaFree(&(*t_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv62_data)[0]);
  mwCudaFree(&(*gpu_fv63_data)[0]);
  mwCudaFree(&(*u_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv64_data)[0]);
  mwCudaFree(&(*gpu_fv65_data)[0]);
  mwCudaFree(&(*gpu_fv66_data)[0]);
  mwCudaFree(&(*gpu_fv67_size)[0]);
  mwCudaFree(&(*gpu_fv67_data)[0]);
  mwCudaFree(&(*gpu_fv68_data)[0]);
  mwCudaFree(&(*gpu_fv69_data)[0]);
  mwCudaFree(&(*v_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv70_data)[0]);
  mwCudaFree(&(*gpu_fv71_data)[0]);
  mwCudaFree(&(*w_gpu_a_data)[0]);
  mwCudaFree(&(*gpu_fv72_data)[0]);
  mwCudaFree(&(*gpu_fv73_data)[0]);
  mwCudaFree(&(*gpu_fv74_data)[0]);
  mwCudaFree(&(*gpu_fv75_size)[0]);
  mwCudaFree(&(*gpu_fv75_data)[0]);
  mwCudaFree(&(*gpu_fv76_data)[0]);
  mwCudaFree(&(*gpu_fv77_data)[0]);
  mwCudaFree(&(*gpu_Ct_size)[0]);
  mwCudaFree(&gpu_Ct_data[0]);
}

// End of code generation (TTCM_analytic_Multi_GPU.cu)

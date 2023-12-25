//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// div.cu
//
// Code generation for function 'div'
//

// Include files
#include "div.h"
#include "rt_nonfinite.h"

// Function Definitions
void b_binary_expand_op(real32_T fv38_data[], int32_T fv38_size[1],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv1_data[], const int32_T fv1_size[1],
                        const real32_T fv3_data[], const int32_T fv3_size[1],
                        const real32_T fv5_data[], const int32_T fv5_size[1])
{
  int32_T b_fv5_size;
  int32_T b_i3;
  int32_T c_fv5_size;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T i5;
  int32_T i6;
  int32_T i7;
  int32_T i8;
  int32_T stride_0_0;
  int32_T stride_10_0;
  int32_T stride_11_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  int32_T stride_3_0;
  int32_T stride_4_0;
  int32_T stride_5_0;
  int32_T stride_6_0;
  int32_T stride_7_0;
  int32_T stride_8_0;
  int32_T stride_9_0;
  i = PL_size[0];
  i1 = PL_size[0];
  i2 = PL_size[0];
  i3 = PL_size[0];
  i4 = PL_size[0];
  i5 = PL_size[0];
  i6 = PL_size[0];
  i7 = PL_size[0];
  i8 = PL_size[0];
  if (fv5_size[0] == 1) {
    if (i8 == 1) {
      b_fv5_size = i7;
    } else {
      b_fv5_size = i8;
    }
  } else {
    b_fv5_size = fv5_size[0];
  }
  if (b_fv5_size == 1) {
    if (fv3_size[0] == 1) {
      if (i6 == 1) {
        b_fv5_size = i5;
      } else {
        b_fv5_size = i6;
      }
    } else {
      b_fv5_size = fv3_size[0];
    }
  } else if (fv5_size[0] == 1) {
    if (i8 == 1) {
      b_fv5_size = i7;
    } else {
      b_fv5_size = i8;
    }
  } else {
    b_fv5_size = fv5_size[0];
  }
  if (b_fv5_size == 1) {
    if (i4 == 1) {
      if (i3 == 1) {
        if (fv1_size[0] == 1) {
          if (i2 == 1) {
            b_i3 = i1;
          } else {
            b_i3 = i2;
          }
        } else {
          b_i3 = fv1_size[0];
        }
      } else {
        b_i3 = i3;
      }
      if (b_i3 == 1) {
        fv38_size[0] = i;
      } else if (i3 == 1) {
        if (fv1_size[0] == 1) {
          if (i2 == 1) {
            fv38_size[0] = i1;
          } else {
            fv38_size[0] = i2;
          }
        } else {
          fv38_size[0] = fv1_size[0];
        }
      } else {
        fv38_size[0] = i3;
      }
    } else {
      fv38_size[0] = i4;
    }
  } else {
    if (fv5_size[0] == 1) {
      if (i8 == 1) {
        b_fv5_size = i7;
      } else {
        b_fv5_size = i8;
      }
    } else {
      b_fv5_size = fv5_size[0];
    }
    if (b_fv5_size == 1) {
      if (fv3_size[0] == 1) {
        if (i6 == 1) {
          fv38_size[0] = i5;
        } else {
          fv38_size[0] = i6;
        }
      } else {
        fv38_size[0] = fv3_size[0];
      }
    } else if (fv5_size[0] == 1) {
      if (i8 == 1) {
        fv38_size[0] = i7;
      } else {
        fv38_size[0] = i8;
      }
    } else {
      fv38_size[0] = fv5_size[0];
    }
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (i2 != 1);
  stride_3_0 = (fv1_size[0] != 1);
  stride_4_0 = (i3 != 1);
  stride_5_0 = (i4 != 1);
  stride_6_0 = (i5 != 1);
  stride_7_0 = (i6 != 1);
  stride_8_0 = (fv3_size[0] != 1);
  stride_9_0 = (i7 != 1);
  stride_10_0 = (i8 != 1);
  stride_11_0 = (fv5_size[0] != 1);
  if (fv5_size[0] == 1) {
    if (i8 == 1) {
      b_fv5_size = i7;
    } else {
      b_fv5_size = i8;
    }
  } else {
    b_fv5_size = fv5_size[0];
  }
  if (b_fv5_size == 1) {
    if (fv3_size[0] == 1) {
      if (i6 == 1) {
        b_fv5_size = i5;
      } else {
        b_fv5_size = i6;
      }
    } else {
      b_fv5_size = fv3_size[0];
    }
  } else if (fv5_size[0] == 1) {
    if (i8 == 1) {
      b_fv5_size = i7;
    } else {
      b_fv5_size = i8;
    }
  } else {
    b_fv5_size = fv5_size[0];
  }
  if (i3 == 1) {
    if (fv1_size[0] == 1) {
      if (i2 == 1) {
        b_i3 = i1;
      } else {
        b_i3 = i2;
      }
    } else {
      b_i3 = fv1_size[0];
    }
  } else {
    b_i3 = i3;
  }
  if (fv5_size[0] == 1) {
    if (i8 == 1) {
      c_fv5_size = i7;
    } else {
      c_fv5_size = i8;
    }
  } else {
    c_fv5_size = fv5_size[0];
  }
  if (b_fv5_size == 1) {
    if (i4 == 1) {
      if (b_i3 == 1) {
        i8 = i;
      } else if (i3 == 1) {
        if (fv1_size[0] == 1) {
          if (i2 == 1) {
            i8 = i1;
          } else {
            i8 = i2;
          }
        } else {
          i8 = fv1_size[0];
        }
      } else {
        i8 = i3;
      }
    } else {
      i8 = i4;
    }
  } else if (c_fv5_size == 1) {
    if (fv3_size[0] == 1) {
      if (i6 == 1) {
        i8 = i5;
      } else {
        i8 = i6;
      }
    } else {
      i8 = fv3_size[0];
    }
  } else if (fv5_size[0] == 1) {
    if (i8 == 1) {
      i8 = i7;
    }
  } else {
    i8 = fv5_size[0];
  }
  for (i = 0; i < i8; i++) {
    fv38_data[i] =
        (PL_data[i * stride_0_0] *
             ((((PL_data[i * stride_1_0 + PL_size[0]] +
                 PL_data[i * stride_1_0 + PL_size[0] * 2]) +
                PL_data[i * stride_2_0 + PL_size[0] * 3]) +
               fv1_data[i * stride_3_0]) /
                  2.0F -
              PL_data[i * stride_4_0 + PL_size[0] * 3]) -
         PL_data[i * stride_5_0] * PL_data[i * stride_5_0 + PL_size[0] * 2]) /
        ((((PL_data[i * stride_6_0 + PL_size[0]] +
            PL_data[i * stride_6_0 + PL_size[0] * 2]) +
           PL_data[i * stride_7_0 + PL_size[0] * 3]) +
          fv3_data[i * stride_8_0]) /
             2.0F -
         (((PL_data[i * stride_9_0 + PL_size[0]] +
            PL_data[i * stride_9_0 + PL_size[0] * 2]) +
           PL_data[i * stride_10_0 + PL_size[0] * 3]) -
          fv5_data[i * stride_11_0]) /
             2.0F);
  }
}

void b_binary_expand_op(real32_T fv68_data[], int32_T fv68_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv62_data[], const int32_T fv62_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  real32_T b_Local_Estimates;
  real32_T c_Local_Estimates;
  b_Local_Estimates = Local_Estimates[4];
  c_Local_Estimates = Local_Estimates[5];
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv62_size[0] == 1) {
    if (i1 == 1) {
      fv68_size[0] = i;
    } else {
      fv68_size[0] = i1;
    }
  } else {
    fv68_size[0] = fv62_size[0];
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv62_size[0] != 1);
  if (fv62_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv62_size[0];
  }
  for (i = 0; i < i1; i++) {
    fv68_data[i] =
        b_Local_Estimates / ((((PL_data[i * stride_0_0 + PL_size[0]] +
                                PL_data[i * stride_0_0 + PL_size[0] * 2]) +
                               PL_data[i * stride_1_0 + PL_size[0] * 3]) -
                              fv62_data[i * stride_2_0]) /
                                 2.0F -
                             c_Local_Estimates);
  }
}

void binary_expand_op(real32_T fv76_data[], int32_T fv76_size[1],
                      const real32_T Local_Estimates[8],
                      const real32_T PL_data[], const int32_T PL_size[2],
                      const real32_T fv70_data[], const int32_T fv70_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  real32_T b_Local_Estimates;
  real32_T c_Local_Estimates;
  b_Local_Estimates = Local_Estimates[6];
  c_Local_Estimates = Local_Estimates[7];
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv70_size[0] == 1) {
    if (i1 == 1) {
      fv76_size[0] = i;
    } else {
      fv76_size[0] = i1;
    }
  } else {
    fv76_size[0] = fv70_size[0];
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv70_size[0] != 1);
  if (fv70_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv70_size[0];
  }
  for (i = 0; i < i1; i++) {
    fv76_data[i] =
        b_Local_Estimates / ((((PL_data[i * stride_0_0 + PL_size[0]] +
                                PL_data[i * stride_0_0 + PL_size[0] * 2]) +
                               PL_data[i * stride_1_0 + PL_size[0] * 3]) -
                              fv70_data[i * stride_2_0]) /
                                 2.0F -
                             c_Local_Estimates);
  }
}

void binary_expand_op(real32_T fv77_data[], int32_T fv77_size[1],
                      const real32_T PL_data[], const int32_T PL_size[2],
                      const real32_T fv40_data[], const int32_T fv40_size[1],
                      const real32_T fv42_data[], const int32_T fv42_size[1],
                      const real32_T fv44_data[], const int32_T fv44_size[1])
{
  int32_T b_fv44_size;
  int32_T b_i4;
  int32_T c_fv44_size;
  int32_T c_i4;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  int32_T i5;
  int32_T i6;
  int32_T i7;
  int32_T i8;
  int32_T stride_0_0;
  int32_T stride_10_0;
  int32_T stride_11_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  int32_T stride_3_0;
  int32_T stride_4_0;
  int32_T stride_5_0;
  int32_T stride_6_0;
  int32_T stride_7_0;
  int32_T stride_8_0;
  int32_T stride_9_0;
  i = PL_size[0];
  i1 = PL_size[0];
  i2 = PL_size[0];
  i3 = PL_size[0];
  i4 = PL_size[0];
  i5 = PL_size[0];
  i6 = PL_size[0];
  i7 = PL_size[0];
  i8 = PL_size[0];
  if (fv44_size[0] == 1) {
    if (i8 == 1) {
      b_fv44_size = i7;
    } else {
      b_fv44_size = i8;
    }
  } else {
    b_fv44_size = fv44_size[0];
  }
  if (b_fv44_size == 1) {
    if (fv42_size[0] == 1) {
      if (i6 == 1) {
        b_fv44_size = i5;
      } else {
        b_fv44_size = i6;
      }
    } else {
      b_fv44_size = fv42_size[0];
    }
  } else if (fv44_size[0] == 1) {
    if (i8 == 1) {
      b_fv44_size = i7;
    } else {
      b_fv44_size = i8;
    }
  } else {
    b_fv44_size = fv44_size[0];
  }
  if (b_fv44_size == 1) {
    if (i4 == 1) {
      if (fv40_size[0] == 1) {
        if (i3 == 1) {
          b_i4 = i2;
        } else {
          b_i4 = i3;
        }
      } else {
        b_i4 = fv40_size[0];
      }
    } else {
      b_i4 = i4;
    }
    if (b_i4 == 1) {
      b_i4 = i1;
    } else if (i4 == 1) {
      if (fv40_size[0] == 1) {
        if (i3 == 1) {
          b_i4 = i2;
        } else {
          b_i4 = i3;
        }
      } else {
        b_i4 = fv40_size[0];
      }
    } else {
      b_i4 = i4;
    }
    if (b_i4 == 1) {
      fv77_size[0] = i;
    } else {
      if (i4 == 1) {
        if (fv40_size[0] == 1) {
          if (i3 == 1) {
            b_i4 = i2;
          } else {
            b_i4 = i3;
          }
        } else {
          b_i4 = fv40_size[0];
        }
      } else {
        b_i4 = i4;
      }
      if (b_i4 == 1) {
        fv77_size[0] = i1;
      } else if (i4 == 1) {
        if (fv40_size[0] == 1) {
          if (i3 == 1) {
            fv77_size[0] = i2;
          } else {
            fv77_size[0] = i3;
          }
        } else {
          fv77_size[0] = fv40_size[0];
        }
      } else {
        fv77_size[0] = i4;
      }
    }
  } else {
    if (fv44_size[0] == 1) {
      if (i8 == 1) {
        b_fv44_size = i7;
      } else {
        b_fv44_size = i8;
      }
    } else {
      b_fv44_size = fv44_size[0];
    }
    if (b_fv44_size == 1) {
      if (fv42_size[0] == 1) {
        if (i6 == 1) {
          fv77_size[0] = i5;
        } else {
          fv77_size[0] = i6;
        }
      } else {
        fv77_size[0] = fv42_size[0];
      }
    } else if (fv44_size[0] == 1) {
      if (i8 == 1) {
        fv77_size[0] = i7;
      } else {
        fv77_size[0] = i8;
      }
    } else {
      fv77_size[0] = fv44_size[0];
    }
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (i2 != 1);
  stride_3_0 = (i3 != 1);
  stride_4_0 = (fv40_size[0] != 1);
  stride_5_0 = (i4 != 1);
  stride_6_0 = (i5 != 1);
  stride_7_0 = (i6 != 1);
  stride_8_0 = (fv42_size[0] != 1);
  stride_9_0 = (i7 != 1);
  stride_10_0 = (i8 != 1);
  stride_11_0 = (fv44_size[0] != 1);
  if (fv44_size[0] == 1) {
    if (i8 == 1) {
      b_fv44_size = i7;
    } else {
      b_fv44_size = i8;
    }
  } else {
    b_fv44_size = fv44_size[0];
  }
  if (b_fv44_size == 1) {
    if (fv42_size[0] == 1) {
      if (i6 == 1) {
        b_fv44_size = i5;
      } else {
        b_fv44_size = i6;
      }
    } else {
      b_fv44_size = fv42_size[0];
    }
  } else if (fv44_size[0] == 1) {
    if (i8 == 1) {
      b_fv44_size = i7;
    } else {
      b_fv44_size = i8;
    }
  } else {
    b_fv44_size = fv44_size[0];
  }
  if (i4 == 1) {
    if (fv40_size[0] == 1) {
      if (i3 == 1) {
        b_i4 = i2;
      } else {
        b_i4 = i3;
      }
    } else {
      b_i4 = fv40_size[0];
    }
  } else {
    b_i4 = i4;
  }
  if (b_i4 == 1) {
    b_i4 = i1;
  } else if (i4 == 1) {
    if (fv40_size[0] == 1) {
      if (i3 == 1) {
        b_i4 = i2;
      } else {
        b_i4 = i3;
      }
    } else {
      b_i4 = fv40_size[0];
    }
  } else {
    b_i4 = i4;
  }
  if (i4 == 1) {
    if (fv40_size[0] == 1) {
      if (i3 == 1) {
        c_i4 = i2;
      } else {
        c_i4 = i3;
      }
    } else {
      c_i4 = fv40_size[0];
    }
  } else {
    c_i4 = i4;
  }
  if (fv44_size[0] == 1) {
    if (i8 == 1) {
      c_fv44_size = i7;
    } else {
      c_fv44_size = i8;
    }
  } else {
    c_fv44_size = fv44_size[0];
  }
  if (b_fv44_size == 1) {
    if (b_i4 == 1) {
      i8 = i;
    } else if (c_i4 == 1) {
      i8 = i1;
    } else if (i4 == 1) {
      if (fv40_size[0] == 1) {
        if (i3 == 1) {
          i8 = i2;
        } else {
          i8 = i3;
        }
      } else {
        i8 = fv40_size[0];
      }
    } else {
      i8 = i4;
    }
  } else if (c_fv44_size == 1) {
    if (fv42_size[0] == 1) {
      if (i6 == 1) {
        i8 = i5;
      } else {
        i8 = i6;
      }
    } else {
      i8 = fv42_size[0];
    }
  } else if (fv44_size[0] == 1) {
    if (i8 == 1) {
      i8 = i7;
    }
  } else {
    i8 = fv44_size[0];
  }
  for (i = 0; i < i8; i++) {
    fv77_data[i] =
        (PL_data[i * stride_0_0] * PL_data[i * stride_0_0 + PL_size[0] * 2] -
         PL_data[i * stride_1_0] *
             ((((PL_data[i * stride_2_0 + PL_size[0]] +
                 PL_data[i * stride_2_0 + PL_size[0] * 2]) +
                PL_data[i * stride_3_0 + PL_size[0] * 3]) -
               fv40_data[i * stride_4_0]) /
                  2.0F -
              PL_data[i * stride_5_0 + PL_size[0] * 3])) /
        ((((PL_data[i * stride_6_0 + PL_size[0]] +
            PL_data[i * stride_6_0 + PL_size[0] * 2]) +
           PL_data[i * stride_7_0 + PL_size[0] * 3]) +
          fv42_data[i * stride_8_0]) /
             2.0F -
         (((PL_data[i * stride_9_0 + PL_size[0]] +
            PL_data[i * stride_9_0 + PL_size[0] * 2]) +
           PL_data[i * stride_10_0 + PL_size[0] * 3]) -
          fv44_data[i * stride_11_0]) /
             2.0F);
  }
}

void c_binary_expand_op(real32_T fv60_data[], int32_T fv60_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv54_data[], const int32_T fv54_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  real32_T b_Local_Estimates;
  real32_T c_Local_Estimates;
  b_Local_Estimates = Local_Estimates[2];
  c_Local_Estimates = Local_Estimates[3];
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv54_size[0] == 1) {
    if (i1 == 1) {
      fv60_size[0] = i;
    } else {
      fv60_size[0] = i1;
    }
  } else {
    fv60_size[0] = fv54_size[0];
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv54_size[0] != 1);
  if (fv54_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv54_size[0];
  }
  for (i = 0; i < i1; i++) {
    fv60_data[i] =
        b_Local_Estimates / ((((PL_data[i * stride_0_0 + PL_size[0]] +
                                PL_data[i * stride_0_0 + PL_size[0] * 2]) +
                               PL_data[i * stride_1_0 + PL_size[0] * 3]) -
                              fv54_data[i * stride_2_0]) /
                                 2.0F -
                             c_Local_Estimates);
  }
}

void d_binary_expand_op(real32_T fv52_data[], int32_T fv52_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv46_data[], const int32_T fv46_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  real32_T b_Local_Estimates;
  real32_T c_Local_Estimates;
  b_Local_Estimates = Local_Estimates[0];
  c_Local_Estimates = Local_Estimates[1];
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv46_size[0] == 1) {
    if (i1 == 1) {
      fv52_size[0] = i;
    } else {
      fv52_size[0] = i1;
    }
  } else {
    fv52_size[0] = fv46_size[0];
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv46_size[0] != 1);
  if (fv46_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv46_size[0];
  }
  for (i = 0; i < i1; i++) {
    fv52_data[i] =
        b_Local_Estimates / ((((PL_data[i * stride_0_0 + PL_size[0]] +
                                PL_data[i * stride_0_0 + PL_size[0] * 2]) +
                               PL_data[i * stride_1_0 + PL_size[0] * 3]) -
                              fv46_data[i * stride_2_0]) /
                                 2.0F -
                             c_Local_Estimates);
  }
}

void e_binary_expand_op(real32_T fv37_data[], int32_T fv37_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv31_data[], const int32_T fv31_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  real32_T b_Local_Estimates;
  real32_T c_Local_Estimates;
  b_Local_Estimates = Local_Estimates[6];
  c_Local_Estimates = Local_Estimates[7];
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv31_size[0] == 1) {
    if (i1 == 1) {
      fv37_size[0] = i;
    } else {
      fv37_size[0] = i1;
    }
  } else {
    fv37_size[0] = fv31_size[0];
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv31_size[0] != 1);
  if (fv31_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv31_size[0];
  }
  for (i = 0; i < i1; i++) {
    fv37_data[i] =
        b_Local_Estimates / ((((PL_data[i * stride_0_0 + PL_size[0]] +
                                PL_data[i * stride_0_0 + PL_size[0] * 2]) +
                               PL_data[i * stride_1_0 + PL_size[0] * 3]) +
                              fv31_data[i * stride_2_0]) /
                                 2.0F -
                             c_Local_Estimates);
  }
}

void f_binary_expand_op(real32_T fv29_data[], int32_T fv29_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv23_data[], const int32_T fv23_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  real32_T b_Local_Estimates;
  real32_T c_Local_Estimates;
  b_Local_Estimates = Local_Estimates[4];
  c_Local_Estimates = Local_Estimates[5];
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv23_size[0] == 1) {
    if (i1 == 1) {
      fv29_size[0] = i;
    } else {
      fv29_size[0] = i1;
    }
  } else {
    fv29_size[0] = fv23_size[0];
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv23_size[0] != 1);
  if (fv23_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv23_size[0];
  }
  for (i = 0; i < i1; i++) {
    fv29_data[i] =
        b_Local_Estimates / ((((PL_data[i * stride_0_0 + PL_size[0]] +
                                PL_data[i * stride_0_0 + PL_size[0] * 2]) +
                               PL_data[i * stride_1_0 + PL_size[0] * 3]) +
                              fv23_data[i * stride_2_0]) /
                                 2.0F -
                             c_Local_Estimates);
  }
}

void g_binary_expand_op(real32_T fv21_data[], int32_T fv21_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv15_data[], const int32_T fv15_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  real32_T b_Local_Estimates;
  real32_T c_Local_Estimates;
  b_Local_Estimates = Local_Estimates[2];
  c_Local_Estimates = Local_Estimates[3];
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv15_size[0] == 1) {
    if (i1 == 1) {
      fv21_size[0] = i;
    } else {
      fv21_size[0] = i1;
    }
  } else {
    fv21_size[0] = fv15_size[0];
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv15_size[0] != 1);
  if (fv15_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv15_size[0];
  }
  for (i = 0; i < i1; i++) {
    fv21_data[i] =
        b_Local_Estimates / ((((PL_data[i * stride_0_0 + PL_size[0]] +
                                PL_data[i * stride_0_0 + PL_size[0] * 2]) +
                               PL_data[i * stride_1_0 + PL_size[0] * 3]) +
                              fv15_data[i * stride_2_0]) /
                                 2.0F -
                             c_Local_Estimates);
  }
}

void h_binary_expand_op(real32_T fv13_data[], int32_T fv13_size[1],
                        const real32_T Local_Estimates[8],
                        const real32_T PL_data[], const int32_T PL_size[2],
                        const real32_T fv7_data[], const int32_T fv7_size[1])
{
  int32_T i;
  int32_T i1;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  real32_T b_Local_Estimates;
  real32_T c_Local_Estimates;
  b_Local_Estimates = Local_Estimates[0];
  c_Local_Estimates = Local_Estimates[1];
  i = PL_size[0];
  i1 = PL_size[0];
  if (fv7_size[0] == 1) {
    if (i1 == 1) {
      fv13_size[0] = i;
    } else {
      fv13_size[0] = i1;
    }
  } else {
    fv13_size[0] = fv7_size[0];
  }
  stride_0_0 = (i != 1);
  stride_1_0 = (i1 != 1);
  stride_2_0 = (fv7_size[0] != 1);
  if (fv7_size[0] == 1) {
    if (i1 == 1) {
      i1 = i;
    }
  } else {
    i1 = fv7_size[0];
  }
  for (i = 0; i < i1; i++) {
    fv13_data[i] =
        b_Local_Estimates / ((((PL_data[i * stride_0_0 + PL_size[0]] +
                                PL_data[i * stride_0_0 + PL_size[0] * 2]) +
                               PL_data[i * stride_1_0 + PL_size[0] * 3]) +
                              fv7_data[i * stride_2_0]) /
                                 2.0F -
                             c_Local_Estimates);
  }
}

// End of code generation (div.cu)

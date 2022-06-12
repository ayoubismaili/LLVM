; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

; RUN: llc -verify-machineinstrs -csky-no-aliases < %s -mtriple=csky -float-abi=hard -mattr=+hard-float -mattr=+2e3 -mattr=+fpuv2_sf -mattr=+fpuv2_df | FileCheck %s --check-prefix=CHECK-DF
; RUN: llc -verify-machineinstrs -csky-no-aliases < %s -mtriple=csky -float-abi=hard -mattr=+hard-float -mattr=+2e3 -mattr=+fpuv3_sf -mattr=+fpuv3_df | FileCheck %s --check-prefix=CHECK-DF2

define double @FADD_DOUBLE(double %x, double %y) {
; CHECK-DF-LABEL: FADD_DOUBLE:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    faddd vr0, vr1, vr0
; CHECK-DF-NEXT:    rts16
;
; CHECK-DF2-LABEL: FADD_DOUBLE:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    fadd.64 vr0, vr1, vr0
; CHECK-DF2-NEXT:    rts16
entry:
  %fadd = fadd  double %y, %x
  ret double %fadd
}

define double @FADD_DOUBLE_I(double %x) {
; CHECK-DF-LABEL: FADD_DOUBLE_I:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    grs32 a0, .LCPI1_0
; CHECK-DF-NEXT:    fldd vr1, (a0, 0)
; CHECK-DF-NEXT:    faddd vr0, vr0, vr1
; CHECK-DF-NEXT:    rts16
; CHECK-DF-NEXT:    .p2align 1
; CHECK-DF-NEXT:  # %bb.1:
; CHECK-DF-NEXT:    .p2align 2
; CHECK-DF-NEXT:  .LCPI1_0:
; CHECK-DF-NEXT:    .quad 0xbff0000000000000 # double -1
;
; CHECK-DF2-LABEL: FADD_DOUBLE_I:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    flrw.64 vr1, [.LCPI1_0]
; CHECK-DF2-NEXT:    fadd.64 vr0, vr0, vr1
; CHECK-DF2-NEXT:    rts16
; CHECK-DF2-NEXT:    .p2align 1
; CHECK-DF2-NEXT:  # %bb.1:
; CHECK-DF2-NEXT:    .p2align 2
; CHECK-DF2-NEXT:  .LCPI1_0:
; CHECK-DF2-NEXT:    .quad 0xbff0000000000000 # double -1
entry:
  %fadd = fadd  double %x, -1.0
  ret double %fadd
}

define double @FSUB_DOUBLE(double %x, double %y) {
; CHECK-DF-LABEL: FSUB_DOUBLE:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    fsubd vr0, vr1, vr0
; CHECK-DF-NEXT:    rts16
;
; CHECK-DF2-LABEL: FSUB_DOUBLE:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    fsub.64 vr0, vr1, vr0
; CHECK-DF2-NEXT:    rts16

entry:
  %fsub = fsub  double %y, %x
  ret double %fsub
}

define double @FSUB_DOUBLE_I(double %x) {
;
; CHECK-DF-LABEL: FSUB_DOUBLE_I:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    grs32 a0, .LCPI3_0
; CHECK-DF-NEXT:    fldd vr1, (a0, 0)
; CHECK-DF-NEXT:    faddd vr0, vr0, vr1
; CHECK-DF-NEXT:    rts16
; CHECK-DF-NEXT:    .p2align 1
; CHECK-DF-NEXT:  # %bb.1:
; CHECK-DF-NEXT:    .p2align 2
; CHECK-DF-NEXT:  .LCPI3_0:
; CHECK-DF-NEXT:    .quad 0x3ff0000000000000 # double 1
;
; CHECK-DF2-LABEL: FSUB_DOUBLE_I:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    flrw.64 vr1, [.LCPI3_0]
; CHECK-DF2-NEXT:    fadd.64 vr0, vr0, vr1
; CHECK-DF2-NEXT:    rts16
; CHECK-DF2-NEXT:    .p2align 1
; CHECK-DF2-NEXT:  # %bb.1:
; CHECK-DF2-NEXT:    .p2align 2
; CHECK-DF2-NEXT:  .LCPI3_0:
; CHECK-DF2-NEXT:    .quad 0x3ff0000000000000 # double 1

entry:
  %fsub = fsub  double %x, -1.0
  ret double %fsub
}

define double @FMUL_DOUBLE(double %x, double %y) {
;
; CHECK-DF-LABEL: FMUL_DOUBLE:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    fmuld vr0, vr1, vr0
; CHECK-DF-NEXT:    rts16
;
; CHECK-DF2-LABEL: FMUL_DOUBLE:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    fmul.64 vr0, vr1, vr0
; CHECK-DF2-NEXT:    rts16
entry:
  %fmul = fmul  double %y, %x
  ret double %fmul
}

define double @FMUL_DOUBLE_I(double %x) {
;
; CHECK-DF-LABEL: FMUL_DOUBLE_I:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    grs32 a0, .LCPI5_0
; CHECK-DF-NEXT:    fldd vr1, (a0, 0)
; CHECK-DF-NEXT:    fmuld vr0, vr0, vr1
; CHECK-DF-NEXT:    rts16
; CHECK-DF-NEXT:    .p2align 1
; CHECK-DF-NEXT:  # %bb.1:
; CHECK-DF-NEXT:    .p2align 2
; CHECK-DF-NEXT:  .LCPI5_0:
; CHECK-DF-NEXT:    .quad 0xc01c000000000000 # double -7
;
; CHECK-DF2-LABEL: FMUL_DOUBLE_I:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    flrw.64 vr1, [.LCPI5_0]
; CHECK-DF2-NEXT:    fmul.64 vr0, vr0, vr1
; CHECK-DF2-NEXT:    rts16
; CHECK-DF2-NEXT:    .p2align 1
; CHECK-DF2-NEXT:  # %bb.1:
; CHECK-DF2-NEXT:    .p2align 2
; CHECK-DF2-NEXT:  .LCPI5_0:
; CHECK-DF2-NEXT:    .quad 0xc01c000000000000 # double -7
entry:
  %fmul = fmul  double %x, -7.0
  ret double %fmul
}

define double @FDIV_DOUBLE(double %x, double %y) {
;
;
; CHECK-DF-LABEL: FDIV_DOUBLE:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    fdivd vr0, vr1, vr0
; CHECK-DF-NEXT:    rts16
;
; CHECK-DF2-LABEL: FDIV_DOUBLE:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    fdiv.64 vr0, vr1, vr0
; CHECK-DF2-NEXT:    rts16

entry:
  %fdiv = fdiv  double %y, %x
  ret double %fdiv
}

define double @FDIV_DOUBLE_I(double %x) {
;
; CHECK-DF-LABEL: FDIV_DOUBLE_I:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    grs32 a0, .LCPI7_0
; CHECK-DF-NEXT:    fldd vr1, (a0, 0)
; CHECK-DF-NEXT:    fdivd vr0, vr0, vr1
; CHECK-DF-NEXT:    rts16
; CHECK-DF-NEXT:    .p2align 1
; CHECK-DF-NEXT:  # %bb.1:
; CHECK-DF-NEXT:    .p2align 2
; CHECK-DF-NEXT:  .LCPI7_0:
; CHECK-DF-NEXT:    .quad 0xc01c000000000000 # double -7
;
; CHECK-DF2-LABEL: FDIV_DOUBLE_I:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    flrw.64 vr1, [.LCPI7_0]
; CHECK-DF2-NEXT:    fdiv.64 vr0, vr0, vr1
; CHECK-DF2-NEXT:    rts16
; CHECK-DF2-NEXT:    .p2align 1
; CHECK-DF2-NEXT:  # %bb.1:
; CHECK-DF2-NEXT:    .p2align 2
; CHECK-DF2-NEXT:  .LCPI7_0:
; CHECK-DF2-NEXT:    .quad 0xc01c000000000000 # double -7
entry:
  %fdiv = fdiv  double %x, -7.0
  ret double %fdiv
}

define double @FNEG_DOUBLE(double %x) {
;
; CHECK-DF-LABEL: FNEG_DOUBLE:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    fnegd vr0, vr0
; CHECK-DF-NEXT:    rts16
;
; CHECK-DF2-LABEL: FNEG_DOUBLE:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    fneg.64 vr0, vr0
; CHECK-DF2-NEXT:    rts16
entry:
  %fneg = fneg  double  %x
  ret double %fneg
}

; double --> float
define float @fptruncR_double_0(double %x) {
;
; CHECK-DF-LABEL: fptruncR_double_0:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    fdtos vr0, vr0
; CHECK-DF-NEXT:    rts16
;
; CHECK-DF2-LABEL: fptruncR_double_0:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    fdtos vr0, vr0
; CHECK-DF2-NEXT:    rts16
entry:
  %fptrunc = fptrunc double %x to float
  ret float %fptrunc
}

define double @fpextR_double_0(float %x) {
;
; CHECK-DF-LABEL: fpextR_double_0:
; CHECK-DF:       # %bb.0: # %entry
; CHECK-DF-NEXT:    fstod vr0, vr0
; CHECK-DF-NEXT:    rts16
;
; CHECK-DF2-LABEL: fpextR_double_0:
; CHECK-DF2:       # %bb.0: # %entry
; CHECK-DF2-NEXT:    fstod vr0, vr0
; CHECK-DF2-NEXT:    rts16
entry:
  %fpext = fpext float %x to double
  ret double %fpext
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- -mattr=avx2  | FileCheck %s

; The broadcast node takes a vector operand as input and changes its length.

define <4 x double> @PR43402(i64 %x) {
; CHECK-LABEL: PR43402:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    vunpcklps {{.*#+}} xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; CHECK-NEXT:    vsubpd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0, %xmm0
; CHECK-NEXT:    vpermilpd {{.*#+}} xmm1 = xmm0[1,0]
; CHECK-NEXT:    vaddsd %xmm0, %xmm1, %xmm0
; CHECK-NEXT:    vbroadcastsd %xmm0, %ymm0
; CHECK-NEXT:    retl
  %conv = uitofp i64 %x to double
  %t2 = insertelement <4 x double> undef, double %conv, i32 0
  %t3 = shufflevector <4 x double> %t2, <4 x double> undef, <4 x i32> zeroinitializer
  ret <4 x double> %t3
}


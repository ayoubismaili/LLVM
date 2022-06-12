; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

declare i4 @llvm.ssub.sat.i4(i4, i4)
declare i8 @llvm.ssub.sat.i8(i8, i8)
declare i16 @llvm.ssub.sat.i16(i16, i16)
declare i32 @llvm.ssub.sat.i32(i32, i32)
declare i64 @llvm.ssub.sat.i64(i64, i64)

define i32 @func32(i32 %x, i32 %y, i32 %z) nounwind {
; CHECK-LABEL: func32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul w8, w1, w2
; CHECK-NEXT:    subs w8, w0, w8
; CHECK-NEXT:    asr w9, w8, #31
; CHECK-NEXT:    eor w9, w9, #0x80000000
; CHECK-NEXT:    csel w0, w9, w8, vs
; CHECK-NEXT:    ret
  %a = mul i32 %y, %z
  %tmp = call i32 @llvm.ssub.sat.i32(i32 %x, i32 %a)
  ret i32 %tmp
}

define i64 @func64(i64 %x, i64 %y, i64 %z) nounwind {
; CHECK-LABEL: func64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    subs x8, x0, x2
; CHECK-NEXT:    asr x9, x8, #63
; CHECK-NEXT:    eor x9, x9, #0x8000000000000000
; CHECK-NEXT:    csel x0, x9, x8, vs
; CHECK-NEXT:    ret
  %a = mul i64 %y, %z
  %tmp = call i64 @llvm.ssub.sat.i64(i64 %x, i64 %z)
  ret i64 %tmp
}

define i16 @func16(i16 %x, i16 %y, i16 %z) nounwind {
; CHECK-LABEL: func16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul w9, w1, w2
; CHECK-NEXT:    sxth w10, w0
; CHECK-NEXT:    mov w8, #32767
; CHECK-NEXT:    sub w9, w10, w9, sxth
; CHECK-NEXT:    cmp w9, w8
; CHECK-NEXT:    csel w8, w9, w8, lt
; CHECK-NEXT:    mov w9, #-32768
; CHECK-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-NEXT:    csel w0, w8, w9, gt
; CHECK-NEXT:    ret
  %a = mul i16 %y, %z
  %tmp = call i16 @llvm.ssub.sat.i16(i16 %x, i16 %a)
  ret i16 %tmp
}

define i8 @func8(i8 %x, i8 %y, i8 %z) nounwind {
; CHECK-LABEL: func8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul w9, w1, w2
; CHECK-NEXT:    sxtb w10, w0
; CHECK-NEXT:    mov w8, #127
; CHECK-NEXT:    sub w9, w10, w9, sxtb
; CHECK-NEXT:    cmp w9, #127
; CHECK-NEXT:    csel w8, w9, w8, lt
; CHECK-NEXT:    mov w9, #-128
; CHECK-NEXT:    cmn w8, #128
; CHECK-NEXT:    csel w0, w8, w9, gt
; CHECK-NEXT:    ret
  %a = mul i8 %y, %z
  %tmp = call i8 @llvm.ssub.sat.i8(i8 %x, i8 %a)
  ret i8 %tmp
}

define i4 @func4(i4 %x, i4 %y, i4 %z) nounwind {
; CHECK-LABEL: func4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mul w9, w1, w2
; CHECK-NEXT:    sbfx w10, w0, #0, #4
; CHECK-NEXT:    mov w8, #7
; CHECK-NEXT:    lsl w9, w9, #28
; CHECK-NEXT:    sub w9, w10, w9, asr #28
; CHECK-NEXT:    cmp w9, #7
; CHECK-NEXT:    csel w8, w9, w8, lt
; CHECK-NEXT:    mov w9, #-8
; CHECK-NEXT:    cmn w8, #8
; CHECK-NEXT:    csel w0, w8, w9, gt
; CHECK-NEXT:    ret
  %a = mul i4 %y, %z
  %tmp = call i4 @llvm.ssub.sat.i4(i4 %x, i4 %a)
  ret i4 %tmp
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

; RUN: llc %s -o - -mtriple=aarch64-arm-none-eabi -O2 -mattr=+mops       | FileCheck %s --check-prefix=CHECK-MOPS

declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg)

declare void @fn(i8*, i8*)

define void @consecutive() {
; CHECK-MOPS-LABEL: consecutive:
; CHECK-MOPS:       // %bb.0: // %entry
; CHECK-MOPS-NEXT:    stp	x29, x30, [sp, #-16]!           // 16-byte Folded Spill
; CHECK-MOPS-NEXT:    sub	sp, sp, #2016
; CHECK-MOPS-NEXT:    .cfi_def_cfa_offset 2032
; CHECK-MOPS-NEXT:    .cfi_offset w30, -8
; CHECK-MOPS-NEXT:    .cfi_offset w29, -16
; CHECK-MOPS-NEXT:    mov	w8, #1000
; CHECK-MOPS-NEXT:    add	x9, sp, #8
; CHECK-MOPS-NEXT:    adrp	x10, .LCPI0_0
; CHECK-MOPS-NEXT:    adrp	x11, .LCPI0_1
; CHECK-MOPS-NEXT:    mov	w12, #6424
; CHECK-MOPS-NEXT:    mov	w13, #7452
; CHECK-MOPS-NEXT:    setp	[x9]!, x8!, xzr
; CHECK-MOPS-NEXT:    setm	[x9]!, x8!, xzr
; CHECK-MOPS-NEXT:    sete	[x9]!, x8!, xzr
; CHECK-MOPS-NEXT:    movk	w12, #6938, lsl #16
; CHECK-MOPS-NEXT:    ldr	q0, [x10, :lo12:.LCPI0_0]
; CHECK-MOPS-NEXT:    mov	w8, #30
; CHECK-MOPS-NEXT:    ldr	d1, [x11, :lo12:.LCPI0_1]
; CHECK-MOPS-NEXT:    add	x0, sp, #1008
; CHECK-MOPS-NEXT:    add	x1, sp, #8
; CHECK-MOPS-NEXT:    str	w12, [sp, #1032]
; CHECK-MOPS-NEXT:    strh	w13, [sp, #1036]
; CHECK-MOPS-NEXT:    str	q0, [sp, #1008]
; CHECK-MOPS-NEXT:    str	d1, [sp, #1024]
; CHECK-MOPS-NEXT:    strb	w8, [sp, #1038]
; CHECK-MOPS-NEXT:    bl	fn
; CHECK-MOPS-NEXT:    add	sp, sp, #2016
; CHECK-MOPS-NEXT:    ldp	x29, x30, [sp], #16             // 16-byte Folded Reload
; CHECK-MOPS-NEXT:    ret
entry:
  %buf_from = alloca [1000 x i8], align 16
  %buf_to = alloca [1000 x i8], align 1
  %0 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 0
  %1 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_to, i64 0, i64 0
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(1000) %1, i8 0, i64 1000, i1 false)
  %2 = bitcast [1000 x i8]* %buf_from to <16 x i8>*
  store <16 x i8> <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15>, <16 x i8>* %2, align 16
  %arrayidx.16 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 16
  %3 = bitcast i8* %arrayidx.16 to <8 x i8>*
  store <8 x i8> <i8 16, i8 17, i8 18, i8 19, i8 20, i8 21, i8 22, i8 23>, <8 x i8>* %3, align 16
  %arrayidx.24 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 24
  store i8 24, i8* %arrayidx.24, align 8
  %arrayidx.25 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 25
  store i8 25, i8* %arrayidx.25, align 1
  %arrayidx.26 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 26
  store i8 26, i8* %arrayidx.26, align 2
  %arrayidx.27 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 27
  store i8 27, i8* %arrayidx.27, align 1
  %arrayidx.28 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 28
  store i8 28, i8* %arrayidx.28, align 4
  %arrayidx.29 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 29
  store i8 29, i8* %arrayidx.29, align 1
  %arrayidx.30 = getelementptr inbounds [1000 x i8], [1000 x i8]* %buf_from, i64 0, i64 30
  store i8 30, i8* %arrayidx.30, align 2
  call void @fn(i8* nonnull %0, i8* nonnull %1)
  ret void
}

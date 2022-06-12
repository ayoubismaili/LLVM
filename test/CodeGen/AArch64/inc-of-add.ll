; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-unknown | FileCheck %s

; These two forms are equivalent:
;   sub %y, (xor %x, -1)
;   add (add %x, 1), %y
; Some targets may prefer one to the other.

define i8 @scalar_i8(i8 %x, i8 %y) nounwind {
; CHECK-LABEL: scalar_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    add w0, w8, #1
; CHECK-NEXT:    ret
  %t0 = add i8 %x, 1
  %t1 = add i8 %y, %t0
  ret i8 %t1
}

define i16 @scalar_i16(i16 %x, i16 %y) nounwind {
; CHECK-LABEL: scalar_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    add w0, w8, #1
; CHECK-NEXT:    ret
  %t0 = add i16 %x, 1
  %t1 = add i16 %y, %t0
  ret i16 %t1
}

define i32 @scalar_i32(i32 %x, i32 %y) nounwind {
; CHECK-LABEL: scalar_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add w8, w0, w1
; CHECK-NEXT:    add w0, w8, #1
; CHECK-NEXT:    ret
  %t0 = add i32 %x, 1
  %t1 = add i32 %y, %t0
  ret i32 %t1
}

define i64 @scalar_i64(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: scalar_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add x8, x0, x1
; CHECK-NEXT:    add x0, x8, #1
; CHECK-NEXT:    ret
  %t0 = add i64 %x, 1
  %t1 = add i64 %y, %t0
  ret i64 %t1
}

define <16 x i8> @vector_i128_i8(<16 x i8> %x, <16 x i8> %y) nounwind {
; CHECK-LABEL: vector_i128_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn v0.16b, v0.16b
; CHECK-NEXT:    sub v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ret
  %t0 = add <16 x i8> %x, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %t1 = add <16 x i8> %y, %t0
  ret <16 x i8> %t1
}

define <8 x i16> @vector_i128_i16(<8 x i16> %x, <8 x i16> %y) nounwind {
; CHECK-LABEL: vector_i128_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn v0.16b, v0.16b
; CHECK-NEXT:    sub v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    ret
  %t0 = add <8 x i16> %x, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %t1 = add <8 x i16> %y, %t0
  ret <8 x i16> %t1
}

define <4 x i32> @vector_i128_i32(<4 x i32> %x, <4 x i32> %y) nounwind {
; CHECK-LABEL: vector_i128_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn v0.16b, v0.16b
; CHECK-NEXT:    sub v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ret
  %t0 = add <4 x i32> %x, <i32 1, i32 1, i32 1, i32 1>
  %t1 = add <4 x i32> %y, %t0
  ret <4 x i32> %t1
}

define <2 x i64> @vector_i128_i64(<2 x i64> %x, <2 x i64> %y) nounwind {
; CHECK-LABEL: vector_i128_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn v0.16b, v0.16b
; CHECK-NEXT:    sub v0.2d, v1.2d, v0.2d
; CHECK-NEXT:    ret
  %t0 = add <2 x i64> %x, <i64 1, i64 1>
  %t1 = add <2 x i64> %y, %t0
  ret <2 x i64> %t1
}

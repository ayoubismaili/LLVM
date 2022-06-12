; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=SSE
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7-avx -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=core-avx2 -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=bdver2 -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=XOP
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=bdver4 -basic-aa -slp-vectorizer -S | FileCheck %s --check-prefix=CHECK --check-prefix=XOP

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

@src64 = common global [4 x i64] zeroinitializer, align 32
@dst64 = common global [4 x i64] zeroinitializer, align 32
@src32 = common global [8 x i32] zeroinitializer, align 32
@dst32 = common global [8 x i32] zeroinitializer, align 32
@src16 = common global [16 x i16] zeroinitializer, align 32
@dst16 = common global [16 x i16] zeroinitializer, align 32
@src8  = common global [32 x i8] zeroinitializer, align 32
@dst8  = common global [32 x i8] zeroinitializer, align 32

declare i64 @llvm.bitreverse.i64(i64)
declare i32 @llvm.bitreverse.i32(i32)
declare i16 @llvm.bitreverse.i16(i16)
declare  i8 @llvm.bitreverse.i8(i8)

define void @bitreverse_2i64() #0 {
; CHECK-LABEL: @bitreverse_2i64(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([4 x i64]* @src64 to <2 x i64>*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i64> @llvm.bitreverse.v2i64(<2 x i64> [[TMP1]])
; CHECK-NEXT:    store <2 x i64> [[TMP2]], <2 x i64>* bitcast ([4 x i64]* @dst64 to <2 x i64>*), align 8
; CHECK-NEXT:    ret void
;
  %ld0 = load i64, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @src64, i32 0, i64 0), align 8
  %ld1 = load i64, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @src64, i32 0, i64 1), align 8
  %bitreverse0 = call i64 @llvm.bitreverse.i64(i64 %ld0)
  %bitreverse1 = call i64 @llvm.bitreverse.i64(i64 %ld1)
  store i64 %bitreverse0, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @dst64, i32 0, i64 0), align 8
  store i64 %bitreverse1, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @dst64, i32 0, i64 1), align 8
  ret void
}

define void @bitreverse_4i64() #0 {
; SSE-LABEL: @bitreverse_4i64(
; SSE-NEXT:    [[TMP1:%.*]] = load <2 x i64>, <2 x i64>* bitcast ([4 x i64]* @src64 to <2 x i64>*), align 4
; SSE-NEXT:    [[TMP2:%.*]] = load <2 x i64>, <2 x i64>* bitcast (i64* getelementptr inbounds ([4 x i64], [4 x i64]* @src64, i64 0, i64 2) to <2 x i64>*), align 4
; SSE-NEXT:    [[TMP3:%.*]] = call <2 x i64> @llvm.bitreverse.v2i64(<2 x i64> [[TMP1]])
; SSE-NEXT:    [[TMP4:%.*]] = call <2 x i64> @llvm.bitreverse.v2i64(<2 x i64> [[TMP2]])
; SSE-NEXT:    store <2 x i64> [[TMP3]], <2 x i64>* bitcast ([4 x i64]* @dst64 to <2 x i64>*), align 4
; SSE-NEXT:    store <2 x i64> [[TMP4]], <2 x i64>* bitcast (i64* getelementptr inbounds ([4 x i64], [4 x i64]* @dst64, i64 0, i64 2) to <2 x i64>*), align 4
; SSE-NEXT:    ret void
;
; AVX-LABEL: @bitreverse_4i64(
; AVX-NEXT:    [[TMP1:%.*]] = load <4 x i64>, <4 x i64>* bitcast ([4 x i64]* @src64 to <4 x i64>*), align 4
; AVX-NEXT:    [[TMP2:%.*]] = call <4 x i64> @llvm.bitreverse.v4i64(<4 x i64> [[TMP1]])
; AVX-NEXT:    store <4 x i64> [[TMP2]], <4 x i64>* bitcast ([4 x i64]* @dst64 to <4 x i64>*), align 4
; AVX-NEXT:    ret void
;
; XOP-LABEL: @bitreverse_4i64(
; XOP-NEXT:    [[TMP1:%.*]] = load <4 x i64>, <4 x i64>* bitcast ([4 x i64]* @src64 to <4 x i64>*), align 4
; XOP-NEXT:    [[TMP2:%.*]] = call <4 x i64> @llvm.bitreverse.v4i64(<4 x i64> [[TMP1]])
; XOP-NEXT:    store <4 x i64> [[TMP2]], <4 x i64>* bitcast ([4 x i64]* @dst64 to <4 x i64>*), align 4
; XOP-NEXT:    ret void
;
  %ld0 = load i64, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @src64, i64 0, i64 0), align 4
  %ld1 = load i64, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @src64, i64 0, i64 1), align 4
  %ld2 = load i64, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @src64, i64 0, i64 2), align 4
  %ld3 = load i64, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @src64, i64 0, i64 3), align 4
  %bitreverse0 = call i64 @llvm.bitreverse.i64(i64 %ld0)
  %bitreverse1 = call i64 @llvm.bitreverse.i64(i64 %ld1)
  %bitreverse2 = call i64 @llvm.bitreverse.i64(i64 %ld2)
  %bitreverse3 = call i64 @llvm.bitreverse.i64(i64 %ld3)
  store i64 %bitreverse0, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @dst64, i64 0, i64 0), align 4
  store i64 %bitreverse1, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @dst64, i64 0, i64 1), align 4
  store i64 %bitreverse2, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @dst64, i64 0, i64 2), align 4
  store i64 %bitreverse3, i64* getelementptr inbounds ([4 x i64], [4 x i64]* @dst64, i64 0, i64 3), align 4
  ret void
}

define void @bitreverse_4i32() #0 {
; CHECK-LABEL: @bitreverse_4i32(
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([8 x i32]* @src32 to <4 x i32>*), align 4
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.bitreverse.v4i32(<4 x i32> [[TMP1]])
; CHECK-NEXT:    store <4 x i32> [[TMP2]], <4 x i32>* bitcast ([8 x i32]* @dst32 to <4 x i32>*), align 4
; CHECK-NEXT:    ret void
;
  %ld0 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 0), align 4
  %ld1 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 1), align 4
  %ld2 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 2), align 4
  %ld3 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 3), align 4
  %bitreverse0 = call i32 @llvm.bitreverse.i32(i32 %ld0)
  %bitreverse1 = call i32 @llvm.bitreverse.i32(i32 %ld1)
  %bitreverse2 = call i32 @llvm.bitreverse.i32(i32 %ld2)
  %bitreverse3 = call i32 @llvm.bitreverse.i32(i32 %ld3)
  store i32 %bitreverse0, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 0), align 4
  store i32 %bitreverse1, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 1), align 4
  store i32 %bitreverse2, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 2), align 4
  store i32 %bitreverse3, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 3), align 4
  ret void
}

define void @bitreverse_8i32() #0 {
; SSE-LABEL: @bitreverse_8i32(
; SSE-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([8 x i32]* @src32 to <4 x i32>*), align 2
; SSE-NEXT:    [[TMP2:%.*]] = load <4 x i32>, <4 x i32>* bitcast (i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 4) to <4 x i32>*), align 2
; SSE-NEXT:    [[TMP3:%.*]] = call <4 x i32> @llvm.bitreverse.v4i32(<4 x i32> [[TMP1]])
; SSE-NEXT:    [[TMP4:%.*]] = call <4 x i32> @llvm.bitreverse.v4i32(<4 x i32> [[TMP2]])
; SSE-NEXT:    store <4 x i32> [[TMP3]], <4 x i32>* bitcast ([8 x i32]* @dst32 to <4 x i32>*), align 2
; SSE-NEXT:    store <4 x i32> [[TMP4]], <4 x i32>* bitcast (i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 4) to <4 x i32>*), align 2
; SSE-NEXT:    ret void
;
; AVX-LABEL: @bitreverse_8i32(
; AVX-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* bitcast ([8 x i32]* @src32 to <8 x i32>*), align 2
; AVX-NEXT:    [[TMP2:%.*]] = call <8 x i32> @llvm.bitreverse.v8i32(<8 x i32> [[TMP1]])
; AVX-NEXT:    store <8 x i32> [[TMP2]], <8 x i32>* bitcast ([8 x i32]* @dst32 to <8 x i32>*), align 2
; AVX-NEXT:    ret void
;
; XOP-LABEL: @bitreverse_8i32(
; XOP-NEXT:    [[TMP1:%.*]] = load <8 x i32>, <8 x i32>* bitcast ([8 x i32]* @src32 to <8 x i32>*), align 2
; XOP-NEXT:    [[TMP2:%.*]] = call <8 x i32> @llvm.bitreverse.v8i32(<8 x i32> [[TMP1]])
; XOP-NEXT:    store <8 x i32> [[TMP2]], <8 x i32>* bitcast ([8 x i32]* @dst32 to <8 x i32>*), align 2
; XOP-NEXT:    ret void
;
  %ld0 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 0), align 2
  %ld1 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 1), align 2
  %ld2 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 2), align 2
  %ld3 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 3), align 2
  %ld4 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 4), align 2
  %ld5 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 5), align 2
  %ld6 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 6), align 2
  %ld7 = load i32, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @src32, i32 0, i64 7), align 2
  %bitreverse0 = call i32 @llvm.bitreverse.i32(i32 %ld0)
  %bitreverse1 = call i32 @llvm.bitreverse.i32(i32 %ld1)
  %bitreverse2 = call i32 @llvm.bitreverse.i32(i32 %ld2)
  %bitreverse3 = call i32 @llvm.bitreverse.i32(i32 %ld3)
  %bitreverse4 = call i32 @llvm.bitreverse.i32(i32 %ld4)
  %bitreverse5 = call i32 @llvm.bitreverse.i32(i32 %ld5)
  %bitreverse6 = call i32 @llvm.bitreverse.i32(i32 %ld6)
  %bitreverse7 = call i32 @llvm.bitreverse.i32(i32 %ld7)
  store i32 %bitreverse0, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 0), align 2
  store i32 %bitreverse1, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 1), align 2
  store i32 %bitreverse2, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 2), align 2
  store i32 %bitreverse3, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 3), align 2
  store i32 %bitreverse4, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 4), align 2
  store i32 %bitreverse5, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 5), align 2
  store i32 %bitreverse6, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 6), align 2
  store i32 %bitreverse7, i32* getelementptr inbounds ([8 x i32], [8 x i32]* @dst32, i32 0, i64 7), align 2
  ret void
}

define void @bitreverse_8i16() #0 {
; CHECK-LABEL: @bitreverse_8i16(
; CHECK-NEXT:    [[TMP1:%.*]] = load <8 x i16>, <8 x i16>* bitcast ([16 x i16]* @src16 to <8 x i16>*), align 2
; CHECK-NEXT:    [[TMP2:%.*]] = call <8 x i16> @llvm.bitreverse.v8i16(<8 x i16> [[TMP1]])
; CHECK-NEXT:    store <8 x i16> [[TMP2]], <8 x i16>* bitcast ([16 x i16]* @dst16 to <8 x i16>*), align 2
; CHECK-NEXT:    ret void
;
  %ld0 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 0), align 2
  %ld1 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 1), align 2
  %ld2 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 2), align 2
  %ld3 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 3), align 2
  %ld4 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 4), align 2
  %ld5 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 5), align 2
  %ld6 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 6), align 2
  %ld7 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 7), align 2
  %bitreverse0 = call i16 @llvm.bitreverse.i16(i16 %ld0)
  %bitreverse1 = call i16 @llvm.bitreverse.i16(i16 %ld1)
  %bitreverse2 = call i16 @llvm.bitreverse.i16(i16 %ld2)
  %bitreverse3 = call i16 @llvm.bitreverse.i16(i16 %ld3)
  %bitreverse4 = call i16 @llvm.bitreverse.i16(i16 %ld4)
  %bitreverse5 = call i16 @llvm.bitreverse.i16(i16 %ld5)
  %bitreverse6 = call i16 @llvm.bitreverse.i16(i16 %ld6)
  %bitreverse7 = call i16 @llvm.bitreverse.i16(i16 %ld7)
  store i16 %bitreverse0, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 0), align 2
  store i16 %bitreverse1, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 1), align 2
  store i16 %bitreverse2, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 2), align 2
  store i16 %bitreverse3, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 3), align 2
  store i16 %bitreverse4, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 4), align 2
  store i16 %bitreverse5, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 5), align 2
  store i16 %bitreverse6, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 6), align 2
  store i16 %bitreverse7, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 7), align 2
  ret void
}

define void @bitreverse_16i16() #0 {
; SSE-LABEL: @bitreverse_16i16(
; SSE-NEXT:    [[TMP1:%.*]] = load <8 x i16>, <8 x i16>* bitcast ([16 x i16]* @src16 to <8 x i16>*), align 2
; SSE-NEXT:    [[TMP2:%.*]] = load <8 x i16>, <8 x i16>* bitcast (i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 8) to <8 x i16>*), align 2
; SSE-NEXT:    [[TMP3:%.*]] = call <8 x i16> @llvm.bitreverse.v8i16(<8 x i16> [[TMP1]])
; SSE-NEXT:    [[TMP4:%.*]] = call <8 x i16> @llvm.bitreverse.v8i16(<8 x i16> [[TMP2]])
; SSE-NEXT:    store <8 x i16> [[TMP3]], <8 x i16>* bitcast ([16 x i16]* @dst16 to <8 x i16>*), align 2
; SSE-NEXT:    store <8 x i16> [[TMP4]], <8 x i16>* bitcast (i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 8) to <8 x i16>*), align 2
; SSE-NEXT:    ret void
;
; AVX-LABEL: @bitreverse_16i16(
; AVX-NEXT:    [[TMP1:%.*]] = load <16 x i16>, <16 x i16>* bitcast ([16 x i16]* @src16 to <16 x i16>*), align 2
; AVX-NEXT:    [[TMP2:%.*]] = call <16 x i16> @llvm.bitreverse.v16i16(<16 x i16> [[TMP1]])
; AVX-NEXT:    store <16 x i16> [[TMP2]], <16 x i16>* bitcast ([16 x i16]* @dst16 to <16 x i16>*), align 2
; AVX-NEXT:    ret void
;
; XOP-LABEL: @bitreverse_16i16(
; XOP-NEXT:    [[TMP1:%.*]] = load <16 x i16>, <16 x i16>* bitcast ([16 x i16]* @src16 to <16 x i16>*), align 2
; XOP-NEXT:    [[TMP2:%.*]] = call <16 x i16> @llvm.bitreverse.v16i16(<16 x i16> [[TMP1]])
; XOP-NEXT:    store <16 x i16> [[TMP2]], <16 x i16>* bitcast ([16 x i16]* @dst16 to <16 x i16>*), align 2
; XOP-NEXT:    ret void
;
  %ld0  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  0), align 2
  %ld1  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  1), align 2
  %ld2  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  2), align 2
  %ld3  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  3), align 2
  %ld4  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  4), align 2
  %ld5  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  5), align 2
  %ld6  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  6), align 2
  %ld7  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  7), align 2
  %ld8  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  8), align 2
  %ld9  = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64  9), align 2
  %ld10 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 10), align 2
  %ld11 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 11), align 2
  %ld12 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 12), align 2
  %ld13 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 13), align 2
  %ld14 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 14), align 2
  %ld15 = load i16, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @src16, i16 0, i64 15), align 2
  %bitreverse0  = call i16 @llvm.bitreverse.i16(i16 %ld0)
  %bitreverse1  = call i16 @llvm.bitreverse.i16(i16 %ld1)
  %bitreverse2  = call i16 @llvm.bitreverse.i16(i16 %ld2)
  %bitreverse3  = call i16 @llvm.bitreverse.i16(i16 %ld3)
  %bitreverse4  = call i16 @llvm.bitreverse.i16(i16 %ld4)
  %bitreverse5  = call i16 @llvm.bitreverse.i16(i16 %ld5)
  %bitreverse6  = call i16 @llvm.bitreverse.i16(i16 %ld6)
  %bitreverse7  = call i16 @llvm.bitreverse.i16(i16 %ld7)
  %bitreverse8  = call i16 @llvm.bitreverse.i16(i16 %ld8)
  %bitreverse9  = call i16 @llvm.bitreverse.i16(i16 %ld9)
  %bitreverse10 = call i16 @llvm.bitreverse.i16(i16 %ld10)
  %bitreverse11 = call i16 @llvm.bitreverse.i16(i16 %ld11)
  %bitreverse12 = call i16 @llvm.bitreverse.i16(i16 %ld12)
  %bitreverse13 = call i16 @llvm.bitreverse.i16(i16 %ld13)
  %bitreverse14 = call i16 @llvm.bitreverse.i16(i16 %ld14)
  %bitreverse15 = call i16 @llvm.bitreverse.i16(i16 %ld15)
  store i16 %bitreverse0 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  0), align 2
  store i16 %bitreverse1 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  1), align 2
  store i16 %bitreverse2 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  2), align 2
  store i16 %bitreverse3 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  3), align 2
  store i16 %bitreverse4 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  4), align 2
  store i16 %bitreverse5 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  5), align 2
  store i16 %bitreverse6 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  6), align 2
  store i16 %bitreverse7 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  7), align 2
  store i16 %bitreverse8 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  8), align 2
  store i16 %bitreverse9 , i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64  9), align 2
  store i16 %bitreverse10, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 10), align 2
  store i16 %bitreverse11, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 11), align 2
  store i16 %bitreverse12, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 12), align 2
  store i16 %bitreverse13, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 13), align 2
  store i16 %bitreverse14, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 14), align 2
  store i16 %bitreverse15, i16* getelementptr inbounds ([16 x i16], [16 x i16]* @dst16, i16 0, i64 15), align 2
  ret void
}

define void @bitreverse_16i8() #0 {
; CHECK-LABEL: @bitreverse_16i8(
; CHECK-NEXT:    [[TMP1:%.*]] = load <16 x i8>, <16 x i8>* bitcast ([32 x i8]* @src8 to <16 x i8>*), align 1
; CHECK-NEXT:    [[TMP2:%.*]] = call <16 x i8> @llvm.bitreverse.v16i8(<16 x i8> [[TMP1]])
; CHECK-NEXT:    store <16 x i8> [[TMP2]], <16 x i8>* bitcast ([32 x i8]* @dst8 to <16 x i8>*), align 1
; CHECK-NEXT:    ret void
;
  %ld0  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  0), align 1
  %ld1  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  1), align 1
  %ld2  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  2), align 1
  %ld3  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  3), align 1
  %ld4  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  4), align 1
  %ld5  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  5), align 1
  %ld6  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  6), align 1
  %ld7  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  7), align 1
  %ld8  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  8), align 1
  %ld9  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  9), align 1
  %ld10 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 10), align 1
  %ld11 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 11), align 1
  %ld12 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 12), align 1
  %ld13 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 13), align 1
  %ld14 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 14), align 1
  %ld15 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 15), align 1
  %bitreverse0  = call i8 @llvm.bitreverse.i8(i8 %ld0)
  %bitreverse1  = call i8 @llvm.bitreverse.i8(i8 %ld1)
  %bitreverse2  = call i8 @llvm.bitreverse.i8(i8 %ld2)
  %bitreverse3  = call i8 @llvm.bitreverse.i8(i8 %ld3)
  %bitreverse4  = call i8 @llvm.bitreverse.i8(i8 %ld4)
  %bitreverse5  = call i8 @llvm.bitreverse.i8(i8 %ld5)
  %bitreverse6  = call i8 @llvm.bitreverse.i8(i8 %ld6)
  %bitreverse7  = call i8 @llvm.bitreverse.i8(i8 %ld7)
  %bitreverse8  = call i8 @llvm.bitreverse.i8(i8 %ld8)
  %bitreverse9  = call i8 @llvm.bitreverse.i8(i8 %ld9)
  %bitreverse10 = call i8 @llvm.bitreverse.i8(i8 %ld10)
  %bitreverse11 = call i8 @llvm.bitreverse.i8(i8 %ld11)
  %bitreverse12 = call i8 @llvm.bitreverse.i8(i8 %ld12)
  %bitreverse13 = call i8 @llvm.bitreverse.i8(i8 %ld13)
  %bitreverse14 = call i8 @llvm.bitreverse.i8(i8 %ld14)
  %bitreverse15 = call i8 @llvm.bitreverse.i8(i8 %ld15)
  store i8 %bitreverse0 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  0), align 1
  store i8 %bitreverse1 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  1), align 1
  store i8 %bitreverse2 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  2), align 1
  store i8 %bitreverse3 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  3), align 1
  store i8 %bitreverse4 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  4), align 1
  store i8 %bitreverse5 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  5), align 1
  store i8 %bitreverse6 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  6), align 1
  store i8 %bitreverse7 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  7), align 1
  store i8 %bitreverse8 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  8), align 1
  store i8 %bitreverse9 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  9), align 1
  store i8 %bitreverse10, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 10), align 1
  store i8 %bitreverse11, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 11), align 1
  store i8 %bitreverse12, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 12), align 1
  store i8 %bitreverse13, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 13), align 1
  store i8 %bitreverse14, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 14), align 1
  store i8 %bitreverse15, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 15), align 1
  ret void
}

define void @bitreverse_32i8() #0 {
; SSE-LABEL: @bitreverse_32i8(
; SSE-NEXT:    [[TMP1:%.*]] = load <16 x i8>, <16 x i8>* bitcast ([32 x i8]* @src8 to <16 x i8>*), align 1
; SSE-NEXT:    [[TMP2:%.*]] = load <16 x i8>, <16 x i8>* bitcast (i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 16) to <16 x i8>*), align 1
; SSE-NEXT:    [[TMP3:%.*]] = call <16 x i8> @llvm.bitreverse.v16i8(<16 x i8> [[TMP1]])
; SSE-NEXT:    [[TMP4:%.*]] = call <16 x i8> @llvm.bitreverse.v16i8(<16 x i8> [[TMP2]])
; SSE-NEXT:    store <16 x i8> [[TMP3]], <16 x i8>* bitcast ([32 x i8]* @dst8 to <16 x i8>*), align 1
; SSE-NEXT:    store <16 x i8> [[TMP4]], <16 x i8>* bitcast (i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 16) to <16 x i8>*), align 1
; SSE-NEXT:    ret void
;
; AVX-LABEL: @bitreverse_32i8(
; AVX-NEXT:    [[TMP1:%.*]] = load <32 x i8>, <32 x i8>* bitcast ([32 x i8]* @src8 to <32 x i8>*), align 1
; AVX-NEXT:    [[TMP2:%.*]] = call <32 x i8> @llvm.bitreverse.v32i8(<32 x i8> [[TMP1]])
; AVX-NEXT:    store <32 x i8> [[TMP2]], <32 x i8>* bitcast ([32 x i8]* @dst8 to <32 x i8>*), align 1
; AVX-NEXT:    ret void
;
; XOP-LABEL: @bitreverse_32i8(
; XOP-NEXT:    [[TMP1:%.*]] = load <32 x i8>, <32 x i8>* bitcast ([32 x i8]* @src8 to <32 x i8>*), align 1
; XOP-NEXT:    [[TMP2:%.*]] = call <32 x i8> @llvm.bitreverse.v32i8(<32 x i8> [[TMP1]])
; XOP-NEXT:    store <32 x i8> [[TMP2]], <32 x i8>* bitcast ([32 x i8]* @dst8 to <32 x i8>*), align 1
; XOP-NEXT:    ret void
;
  %ld0  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  0), align 1
  %ld1  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  1), align 1
  %ld2  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  2), align 1
  %ld3  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  3), align 1
  %ld4  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  4), align 1
  %ld5  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  5), align 1
  %ld6  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  6), align 1
  %ld7  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  7), align 1
  %ld8  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  8), align 1
  %ld9  = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64  9), align 1
  %ld10 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 10), align 1
  %ld11 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 11), align 1
  %ld12 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 12), align 1
  %ld13 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 13), align 1
  %ld14 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 14), align 1
  %ld15 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 15), align 1
  %ld16 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 16), align 1
  %ld17 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 17), align 1
  %ld18 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 18), align 1
  %ld19 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 19), align 1
  %ld20 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 20), align 1
  %ld21 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 21), align 1
  %ld22 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 22), align 1
  %ld23 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 23), align 1
  %ld24 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 24), align 1
  %ld25 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 25), align 1
  %ld26 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 26), align 1
  %ld27 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 27), align 1
  %ld28 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 28), align 1
  %ld29 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 29), align 1
  %ld30 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 30), align 1
  %ld31 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @src8, i8 0, i64 31), align 1
  %bitreverse0  = call i8 @llvm.bitreverse.i8(i8 %ld0)
  %bitreverse1  = call i8 @llvm.bitreverse.i8(i8 %ld1)
  %bitreverse2  = call i8 @llvm.bitreverse.i8(i8 %ld2)
  %bitreverse3  = call i8 @llvm.bitreverse.i8(i8 %ld3)
  %bitreverse4  = call i8 @llvm.bitreverse.i8(i8 %ld4)
  %bitreverse5  = call i8 @llvm.bitreverse.i8(i8 %ld5)
  %bitreverse6  = call i8 @llvm.bitreverse.i8(i8 %ld6)
  %bitreverse7  = call i8 @llvm.bitreverse.i8(i8 %ld7)
  %bitreverse8  = call i8 @llvm.bitreverse.i8(i8 %ld8)
  %bitreverse9  = call i8 @llvm.bitreverse.i8(i8 %ld9)
  %bitreverse10 = call i8 @llvm.bitreverse.i8(i8 %ld10)
  %bitreverse11 = call i8 @llvm.bitreverse.i8(i8 %ld11)
  %bitreverse12 = call i8 @llvm.bitreverse.i8(i8 %ld12)
  %bitreverse13 = call i8 @llvm.bitreverse.i8(i8 %ld13)
  %bitreverse14 = call i8 @llvm.bitreverse.i8(i8 %ld14)
  %bitreverse15 = call i8 @llvm.bitreverse.i8(i8 %ld15)
  %bitreverse16 = call i8 @llvm.bitreverse.i8(i8 %ld16)
  %bitreverse17 = call i8 @llvm.bitreverse.i8(i8 %ld17)
  %bitreverse18 = call i8 @llvm.bitreverse.i8(i8 %ld18)
  %bitreverse19 = call i8 @llvm.bitreverse.i8(i8 %ld19)
  %bitreverse20 = call i8 @llvm.bitreverse.i8(i8 %ld20)
  %bitreverse21 = call i8 @llvm.bitreverse.i8(i8 %ld21)
  %bitreverse22 = call i8 @llvm.bitreverse.i8(i8 %ld22)
  %bitreverse23 = call i8 @llvm.bitreverse.i8(i8 %ld23)
  %bitreverse24 = call i8 @llvm.bitreverse.i8(i8 %ld24)
  %bitreverse25 = call i8 @llvm.bitreverse.i8(i8 %ld25)
  %bitreverse26 = call i8 @llvm.bitreverse.i8(i8 %ld26)
  %bitreverse27 = call i8 @llvm.bitreverse.i8(i8 %ld27)
  %bitreverse28 = call i8 @llvm.bitreverse.i8(i8 %ld28)
  %bitreverse29 = call i8 @llvm.bitreverse.i8(i8 %ld29)
  %bitreverse30 = call i8 @llvm.bitreverse.i8(i8 %ld30)
  %bitreverse31 = call i8 @llvm.bitreverse.i8(i8 %ld31)
  store i8 %bitreverse0 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  0), align 1
  store i8 %bitreverse1 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  1), align 1
  store i8 %bitreverse2 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  2), align 1
  store i8 %bitreverse3 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  3), align 1
  store i8 %bitreverse4 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  4), align 1
  store i8 %bitreverse5 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  5), align 1
  store i8 %bitreverse6 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  6), align 1
  store i8 %bitreverse7 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  7), align 1
  store i8 %bitreverse8 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  8), align 1
  store i8 %bitreverse9 , i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64  9), align 1
  store i8 %bitreverse10, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 10), align 1
  store i8 %bitreverse11, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 11), align 1
  store i8 %bitreverse12, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 12), align 1
  store i8 %bitreverse13, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 13), align 1
  store i8 %bitreverse14, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 14), align 1
  store i8 %bitreverse15, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 15), align 1
  store i8 %bitreverse16, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 16), align 1
  store i8 %bitreverse17, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 17), align 1
  store i8 %bitreverse18, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 18), align 1
  store i8 %bitreverse19, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 19), align 1
  store i8 %bitreverse20, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 20), align 1
  store i8 %bitreverse21, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 21), align 1
  store i8 %bitreverse22, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 22), align 1
  store i8 %bitreverse23, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 23), align 1
  store i8 %bitreverse24, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 24), align 1
  store i8 %bitreverse25, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 25), align 1
  store i8 %bitreverse26, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 26), align 1
  store i8 %bitreverse27, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 27), align 1
  store i8 %bitreverse28, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 28), align 1
  store i8 %bitreverse29, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 29), align 1
  store i8 %bitreverse30, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 30), align 1
  store i8 %bitreverse31, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @dst8, i8 0, i64 31), align 1
  ret void
}

attributes #0 = { nounwind }


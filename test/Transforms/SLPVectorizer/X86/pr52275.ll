; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-- | FileCheck %s

define  <4 x i8> @test(<4 x i8> %v, i8* %x) {
  %x0 = load i8, i8* %x, align 4
  %g1 = getelementptr inbounds i8, i8* %x, i64 1
  %x1 = load i8, i8* %g1, align 4
  %v0 = insertelement <4 x i8> %v, i8 %x0, i64 0
  %v1 = insertelement <4 x i8> %v0, i8 %x1, i64 1
  %v2 = add <4 x i8> %v0, %v1
  ret <4 x i8> %v2
}

define  <2 x i8> @test2(<2 x i8> %t6, i32* %t1) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[T3:%.*]] = load i32, i32* [[T1:%.*]], align 4
; CHECK-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, i32* [[T1]], i64 1
; CHECK-NEXT:    [[T5:%.*]] = load i32, i32* [[T4]], align 4
; CHECK-NEXT:    [[T7:%.*]] = trunc i32 [[T3]] to i8
; CHECK-NEXT:    [[T8:%.*]] = insertelement <2 x i8> [[T6:%.*]], i8 [[T7]], i64 0
; CHECK-NEXT:    [[T9:%.*]] = trunc i32 [[T5]] to i8
; CHECK-NEXT:    [[T10:%.*]] = insertelement <2 x i8> [[T8]], i8 [[T9]], i64 1
; CHECK-NEXT:    [[T11:%.*]] = add <2 x i8> [[T10]], [[T8]]
; CHECK-NEXT:    ret <2 x i8> [[T11]]
;
; FORCE_SLP-LABEL: @test2(
; FORCE_SLP-NEXT:    [[T3:%.*]] = load i32, i32* [[T1:%.*]], align 4
; FORCE_SLP-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, i32* [[T1]], i64 1
; FORCE_SLP-NEXT:    [[T5:%.*]] = load i32, i32* [[T4]], align 4
; FORCE_SLP-NEXT:    [[T7:%.*]] = trunc i32 [[T3]] to i8
; FORCE_SLP-NEXT:    [[T8:%.*]] = insertelement <2 x i8> [[T6:%.*]], i8 [[T7]], i64 0
; FORCE_SLP-NEXT:    [[T9:%.*]] = trunc i32 [[T5]] to i8
; FORCE_SLP-NEXT:    [[T10:%.*]] = insertelement <2 x i8> [[T8]], i8 [[T9]], i64 1
; FORCE_SLP-NEXT:    [[T11:%.*]] = add <2 x i8> [[T10]], [[T8]]
; FORCE_SLP-NEXT:    ret <2 x i8> [[T11]]
;
  %t3 = load i32, i32* %t1, align 4
  %t4 = getelementptr inbounds i32, i32* %t1, i64 1
  %t5 = load i32, i32* %t4, align 4
  %t7 = trunc i32 %t3 to i8
  %t8 = insertelement <2 x i8> %t6, i8 %t7, i64 0
  %t9 = trunc i32 %t5 to i8
  %t10 = insertelement <2 x i8> %t8, i8 %t9, i64 1
  %t11 = add <2 x i8> %t10, %t8
  ret <2 x i8> %t11
}

define  <2 x i8> @test_reorder(<2 x i8> %t6, i32* %t1) {
; CHECK-LABEL: @test_reorder(
; CHECK-NEXT:    [[T3:%.*]] = load i32, i32* [[T1:%.*]], align 4
; CHECK-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, i32* [[T1]], i64 1
; CHECK-NEXT:    [[T5:%.*]] = load i32, i32* [[T4]], align 4
; CHECK-NEXT:    [[T7:%.*]] = trunc i32 [[T3]] to i8
; CHECK-NEXT:    [[T8:%.*]] = insertelement <2 x i8> [[T6:%.*]], i8 [[T7]], i64 1
; CHECK-NEXT:    [[T9:%.*]] = trunc i32 [[T5]] to i8
; CHECK-NEXT:    [[T10:%.*]] = insertelement <2 x i8> [[T8]], i8 [[T9]], i64 0
; CHECK-NEXT:    [[T11:%.*]] = add <2 x i8> [[T10]], [[T8]]
; CHECK-NEXT:    ret <2 x i8> [[T11]]
;
; FORCE_SLP-LABEL: @test_reorder(
; FORCE_SLP-NEXT:    [[T3:%.*]] = load i32, i32* [[T1:%.*]], align 4
; FORCE_SLP-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, i32* [[T1]], i64 1
; FORCE_SLP-NEXT:    [[T5:%.*]] = load i32, i32* [[T4]], align 4
; FORCE_SLP-NEXT:    [[T7:%.*]] = trunc i32 [[T3]] to i8
; FORCE_SLP-NEXT:    [[T8:%.*]] = insertelement <2 x i8> [[T6:%.*]], i8 [[T7]], i64 1
; FORCE_SLP-NEXT:    [[T9:%.*]] = trunc i32 [[T5]] to i8
; FORCE_SLP-NEXT:    [[T10:%.*]] = insertelement <2 x i8> [[T8]], i8 [[T9]], i64 0
; FORCE_SLP-NEXT:    [[T11:%.*]] = add <2 x i8> [[T10]], [[T8]]
; FORCE_SLP-NEXT:    ret <2 x i8> [[T11]]
;
  %t3 = load i32, i32* %t1, align 4
  %t4 = getelementptr inbounds i32, i32* %t1, i64 1
  %t5 = load i32, i32* %t4, align 4
  %t7 = trunc i32 %t3 to i8
  %t8 = insertelement <2 x i8> %t6, i8 %t7, i64 1
  %t9 = trunc i32 %t5 to i8
  %t10 = insertelement <2 x i8> %t8, i8 %t9, i64 0
  %t11 = add <2 x i8> %t10, %t8
  ret <2 x i8> %t11
}

define  <4 x i8> @test_subvector(<4 x i8> %t6, i32* %t1) {
; CHECK-LABEL: @test_subvector(
; CHECK-NEXT:    [[T3:%.*]] = load i32, i32* [[T1:%.*]], align 4
; CHECK-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, i32* [[T1]], i64 1
; CHECK-NEXT:    [[T5:%.*]] = load i32, i32* [[T4]], align 4
; CHECK-NEXT:    [[T7:%.*]] = trunc i32 [[T3]] to i8
; CHECK-NEXT:    [[T8:%.*]] = insertelement <4 x i8> [[T6:%.*]], i8 [[T7]], i64 0
; CHECK-NEXT:    [[T9:%.*]] = trunc i32 [[T5]] to i8
; CHECK-NEXT:    [[T10:%.*]] = insertelement <4 x i8> [[T8]], i8 [[T9]], i64 1
; CHECK-NEXT:    [[T11:%.*]] = add <4 x i8> [[T10]], [[T8]]
; CHECK-NEXT:    ret <4 x i8> [[T11]]
;
; FORCE_SLP-LABEL: @test_subvector(
; FORCE_SLP-NEXT:    [[T3:%.*]] = load i32, i32* [[T1:%.*]], align 4
; FORCE_SLP-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, i32* [[T1]], i64 1
; FORCE_SLP-NEXT:    [[T5:%.*]] = load i32, i32* [[T4]], align 4
; FORCE_SLP-NEXT:    [[T7:%.*]] = trunc i32 [[T3]] to i8
; FORCE_SLP-NEXT:    [[T8:%.*]] = insertelement <4 x i8> [[T6:%.*]], i8 [[T7]], i64 0
; FORCE_SLP-NEXT:    [[T9:%.*]] = trunc i32 [[T5]] to i8
; FORCE_SLP-NEXT:    [[T10:%.*]] = insertelement <4 x i8> [[T8]], i8 [[T9]], i64 1
; FORCE_SLP-NEXT:    [[T11:%.*]] = add <4 x i8> [[T10]], [[T8]]
; FORCE_SLP-NEXT:    ret <4 x i8> [[T11]]
;
  %t3 = load i32, i32* %t1, align 4
  %t4 = getelementptr inbounds i32, i32* %t1, i64 1
  %t5 = load i32, i32* %t4, align 4
  %t7 = trunc i32 %t3 to i8
  %t8 = insertelement <4 x i8> %t6, i8 %t7, i64 0
  %t9 = trunc i32 %t5 to i8
  %t10 = insertelement <4 x i8> %t8, i8 %t9, i64 1
  %t11 = add <4 x i8> %t10, %t8
  ret <4 x i8> %t11
}

define  <4 x i8> @test_subvector_reorder(<4 x i8> %t6, i32* %t1) {
; CHECK-LABEL: @test_subvector_reorder(
; CHECK-NEXT:    [[T3:%.*]] = load i32, i32* [[T1:%.*]], align 4
; CHECK-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, i32* [[T1]], i64 1
; CHECK-NEXT:    [[T5:%.*]] = load i32, i32* [[T4]], align 4
; CHECK-NEXT:    [[T7:%.*]] = trunc i32 [[T3]] to i8
; CHECK-NEXT:    [[T8:%.*]] = insertelement <4 x i8> [[T6:%.*]], i8 [[T7]], i64 3
; CHECK-NEXT:    [[T9:%.*]] = trunc i32 [[T5]] to i8
; CHECK-NEXT:    [[T10:%.*]] = insertelement <4 x i8> [[T8]], i8 [[T9]], i64 2
; CHECK-NEXT:    [[T11:%.*]] = add <4 x i8> [[T10]], [[T8]]
; CHECK-NEXT:    ret <4 x i8> [[T11]]
;
; FORCE_SLP-LABEL: @test_subvector_reorder(
; FORCE_SLP-NEXT:    [[T3:%.*]] = load i32, i32* [[T1:%.*]], align 4
; FORCE_SLP-NEXT:    [[T4:%.*]] = getelementptr inbounds i32, i32* [[T1]], i64 1
; FORCE_SLP-NEXT:    [[T5:%.*]] = load i32, i32* [[T4]], align 4
; FORCE_SLP-NEXT:    [[T7:%.*]] = trunc i32 [[T3]] to i8
; FORCE_SLP-NEXT:    [[T8:%.*]] = insertelement <4 x i8> [[T6:%.*]], i8 [[T7]], i64 3
; FORCE_SLP-NEXT:    [[T9:%.*]] = trunc i32 [[T5]] to i8
; FORCE_SLP-NEXT:    [[T10:%.*]] = insertelement <4 x i8> [[T8]], i8 [[T9]], i64 2
; FORCE_SLP-NEXT:    [[T11:%.*]] = add <4 x i8> [[T10]], [[T8]]
; FORCE_SLP-NEXT:    ret <4 x i8> [[T11]]
;
  %t3 = load i32, i32* %t1, align 4
  %t4 = getelementptr inbounds i32, i32* %t1, i64 1
  %t5 = load i32, i32* %t4, align 4
  %t7 = trunc i32 %t3 to i8
  %t8 = insertelement <4 x i8> %t6, i8 %t7, i64 3
  %t9 = trunc i32 %t5 to i8
  %t10 = insertelement <4 x i8> %t8, i8 %t9, i64 2
  %t11 = add <4 x i8> %t10, %t8
  ret <4 x i8> %t11
}

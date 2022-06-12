; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"

declare void @use(i32)
declare void @use16(i16)
declare void @use1(i1)

define i8 @testi16i8(i16 %add) {
; CHECK-LABEL: @testi16i8(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i16 [[ADD:%.*]], -128
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i16 [[ADD]], i16 -128
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i16 [[TMP2]], 127
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i16 [[TMP2]], i16 127
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i16 [[TMP4]] to i8
; CHECK-NEXT:    ret i8 [[TMP5]]
;
  %sh = lshr i16 %add, 8
  %conv.i = trunc i16 %sh to i8
  %conv1.i = trunc i16 %add to i8
  %shr2.i = ashr i8 %conv1.i, 7
  %cmp.not.i = icmp eq i8 %shr2.i, %conv.i
  %shr4.i = ashr i16 %add, 15
  %conv5.i = trunc i16 %shr4.i to i8
  %xor.i = xor i8 %conv5.i, 127
  %cond.i = select i1 %cmp.not.i, i8 %conv1.i, i8 %xor.i
  ret i8 %cond.i
}

define i32 @testi64i32(i64 %add) {
; CHECK-LABEL: @testi64i32(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i64 [[ADD:%.*]], -2147483648
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i64 [[ADD]], i64 -2147483648
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i64 [[TMP2]], 2147483647
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i64 [[TMP2]], i64 2147483647
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i64 [[TMP4]] to i32
; CHECK-NEXT:    ret i32 [[TMP5]]
;
  %sh = lshr i64 %add, 32
  %conv.i = trunc i64 %sh to i32
  %conv1.i = trunc i64 %add to i32
  %shr2.i = ashr i32 %conv1.i, 31
  %cmp.not.i = icmp eq i32 %shr2.i, %conv.i
  %shr4.i = ashr i64 %add, 63
  %conv5.i = trunc i64 %shr4.i to i32
  %xor.i = xor i32 %conv5.i, 2147483647
  %cond.i = select i1 %cmp.not.i, i32 %conv1.i, i32 %xor.i
  ret i32 %cond.i
}

define i16 @testi32i16i8(i32 %add) {
; CHECK-LABEL: @testi32i16i8(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i32 [[ADD:%.*]], -128
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i32 [[ADD]], i32 -128
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i32 [[TMP2]], 127
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i32 [[TMP2]], i32 127
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i32 [[TMP4]] to i16
; CHECK-NEXT:    ret i16 [[TMP5]]
;
  %a = add i32 %add, 128
  %cmp = icmp ult i32 %a, 256
  %t = trunc i32 %add to i16
  %c = icmp sgt i32 %add, -1
  %f = select i1 %c, i16 127, i16 -128
  %r = select i1 %cmp, i16 %t, i16 %f
  ret i16 %r
}

define <4 x i16> @testv4i32i16i8(<4 x i32> %add) {
; CHECK-LABEL: @testv4i32i16i8(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt <4 x i32> [[ADD:%.*]], <i32 -128, i32 -128, i32 -128, i32 -128>
; CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> [[ADD]], <4 x i32> <i32 -128, i32 -128, i32 -128, i32 -128>
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt <4 x i32> [[TMP2]], <i32 127, i32 127, i32 127, i32 127>
; CHECK-NEXT:    [[TMP4:%.*]] = select <4 x i1> [[TMP3]], <4 x i32> [[TMP2]], <4 x i32> <i32 127, i32 127, i32 127, i32 127>
; CHECK-NEXT:    [[TMP5:%.*]] = trunc <4 x i32> [[TMP4]] to <4 x i16>
; CHECK-NEXT:    ret <4 x i16> [[TMP5]]
;
  %a = add <4 x i32> %add, <i32 128, i32 128, i32 128, i32 128>
  %cmp = icmp ult <4 x i32> %a, <i32 256, i32 256, i32 256, i32 256>
  %t = trunc <4 x i32> %add to <4 x i16>
  %c = icmp sgt <4 x i32> %add, <i32 -1, i32 -1, i32 -1, i32 -1>
  %f = select <4 x i1> %c, <4 x i16> <i16 127, i16 127, i16 127, i16 127>, <4 x i16> <i16 -128, i16 -128, i16 -128, i16 -128>
  %r = select <4 x i1> %cmp, <4 x i16> %t, <4 x i16> %f
  ret <4 x i16> %r
}

define i32 @testi32i32i8(i32 %add) {
; CHECK-LABEL: @testi32i32i8(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i32 [[ADD:%.*]], -128
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i32 [[ADD]], i32 -128
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i32 [[TMP2]], 127
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i32 [[TMP2]], i32 127
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %a = add i32 %add, 128
  %cmp = icmp ult i32 %a, 256
  %c = icmp sgt i32 %add, -1
  %f = select i1 %c, i32 127, i32 -128
  %r = select i1 %cmp, i32 %add, i32 %f
  ret i32 %r
}

define i16 @test_truncfirst(i32 %add) {
; CHECK-LABEL: @test_truncfirst(
; CHECK-NEXT:    [[T:%.*]] = trunc i32 [[ADD:%.*]] to i16
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i16 [[T]], -128
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i16 [[T]], i16 -128
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i16 [[TMP2]], 127
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i16 [[TMP2]], i16 127
; CHECK-NEXT:    ret i16 [[TMP4]]
;
  %t = trunc i32 %add to i16
  %a = add i16 %t, 128
  %cmp = icmp ult i16 %a, 256
  %c = icmp sgt i16 %t, -1
  %f = select i1 %c, i16 127, i16 -128
  %r = select i1 %cmp, i16 %t, i16 %f
  ret i16 %r
}

define i16 @testtrunclowhigh(i32 %add, i16 %low, i16 %high) {
; CHECK-LABEL: @testtrunclowhigh(
; CHECK-NEXT:    [[A:%.*]] = add i32 [[ADD:%.*]], 128
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[A]], 256
; CHECK-NEXT:    [[T:%.*]] = trunc i32 [[ADD]] to i16
; CHECK-NEXT:    [[C:%.*]] = icmp sgt i32 [[ADD]], -1
; CHECK-NEXT:    [[F:%.*]] = select i1 [[C]], i16 [[HIGH:%.*]], i16 [[LOW:%.*]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[CMP]], i16 [[T]], i16 [[F]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %a = add i32 %add, 128
  %cmp = icmp ult i32 %a, 256
  %t = trunc i32 %add to i16
  %c = icmp sgt i32 %add, -1
  %f = select i1 %c, i16 %high, i16 %low
  %r = select i1 %cmp, i16 %t, i16 %f
  ret i16 %r
}

define i32 @testi64i32addsat(i32 %a, i32 %b) {
; CHECK-LABEL: @testi64i32addsat(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.sadd.sat.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %sa = sext i32 %a to i64
  %sb = sext i32 %b to i64
  %add = add i64 %sa, %sb
  %sh = lshr i64 %add, 32
  %conv.i = trunc i64 %sh to i32
  %conv1.i = trunc i64 %add to i32
  %shr2.i = ashr i32 %conv1.i, 31
  %cmp.not.i = icmp eq i32 %shr2.i, %conv.i
  %shr4.i = ashr i64 %add, 63
  %conv5.i = trunc i64 %shr4.i to i32
  %xor.i = xor i32 %conv5.i, 2147483647
  %cond.i = select i1 %cmp.not.i, i32 %conv1.i, i32 %xor.i
  ret i32 %cond.i
}

define <4 x i8> @testv4i16i8(<4 x i16> %add) {
; CHECK-LABEL: @testv4i16i8(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt <4 x i16> [[ADD:%.*]], <i16 -128, i16 -128, i16 -128, i16 -128>
; CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[TMP1]], <4 x i16> [[ADD]], <4 x i16> <i16 -128, i16 -128, i16 -128, i16 -128>
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt <4 x i16> [[TMP2]], <i16 127, i16 127, i16 127, i16 127>
; CHECK-NEXT:    [[TMP4:%.*]] = select <4 x i1> [[TMP3]], <4 x i16> [[TMP2]], <4 x i16> <i16 127, i16 127, i16 127, i16 127>
; CHECK-NEXT:    [[TMP5:%.*]] = trunc <4 x i16> [[TMP4]] to <4 x i8>
; CHECK-NEXT:    ret <4 x i8> [[TMP5]]
;
  %sh = lshr <4 x i16> %add, <i16 8, i16 8, i16 8, i16 8>
  %conv.i = trunc <4 x i16> %sh to <4 x i8>
  %conv1.i = trunc <4 x i16> %add to <4 x i8>
  %shr2.i = ashr <4 x i8> %conv1.i, <i8 7, i8 7, i8 7, i8 7>
  %cmp.not.i = icmp eq <4 x i8> %shr2.i, %conv.i
  %shr4.i = ashr <4 x i16> %add, <i16 15, i16 15, i16 15, i16 15>
  %conv5.i = trunc <4 x i16> %shr4.i to <4 x i8>
  %xor.i = xor <4 x i8> %conv5.i, <i8 127, i8 127, i8 127, i8 127>
  %cond.i = select <4 x i1> %cmp.not.i, <4 x i8> %conv1.i, <4 x i8> %xor.i
  ret <4 x i8> %cond.i
}

define <4 x i8> @testv4i16i8add(<4 x i8> %a, <4 x i8> %b) {
; CHECK-LABEL: @testv4i16i8add(
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i8> @llvm.sadd.sat.v4i8(<4 x i8> [[A:%.*]], <4 x i8> [[B:%.*]])
; CHECK-NEXT:    ret <4 x i8> [[TMP1]]
;
  %sa = sext <4 x i8> %a to <4 x i16>
  %sb = sext <4 x i8> %b to <4 x i16>
  %add = add <4 x i16> %sa, %sb
  %sh = lshr <4 x i16> %add, <i16 8, i16 8, i16 8, i16 8>
  %conv.i = trunc <4 x i16> %sh to <4 x i8>
  %conv1.i = trunc <4 x i16> %add to <4 x i8>
  %shr2.i = ashr <4 x i8> %conv1.i, <i8 7, i8 7, i8 7, i8 7>
  %cmp.not.i = icmp eq <4 x i8> %shr2.i, %conv.i
  %shr4.i = ashr <4 x i16> %add, <i16 15, i16 15, i16 15, i16 15>
  %conv5.i = trunc <4 x i16> %shr4.i to <4 x i8>
  %xor.i = xor <4 x i8> %conv5.i, <i8 127, i8 127, i8 127, i8 127>
  %cond.i = select <4 x i1> %cmp.not.i, <4 x i8> %conv1.i, <4 x i8> %xor.i
  ret <4 x i8> %cond.i
}

define i8 @testi16i8_revcmp(i16 %add) {
; CHECK-LABEL: @testi16i8_revcmp(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i16 [[ADD:%.*]], -128
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i16 [[ADD]], i16 -128
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i16 [[TMP2]], 127
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i16 [[TMP2]], i16 127
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i16 [[TMP4]] to i8
; CHECK-NEXT:    ret i8 [[TMP5]]
;
  %sh = lshr i16 %add, 8
  %conv.i = trunc i16 %sh to i8
  %conv1.i = trunc i16 %add to i8
  %shr2.i = ashr i8 %conv1.i, 7
  %cmp.not.i = icmp eq i8 %conv.i, %shr2.i
  %shr4.i = ashr i16 %add, 15
  %conv5.i = trunc i16 %shr4.i to i8
  %xor.i = xor i8 %conv5.i, 127
  %cond.i = select i1 %cmp.not.i, i8 %conv1.i, i8 %xor.i
  ret i8 %cond.i
}

define i8 @testi16i8_revselect(i16 %add) {
; CHECK-LABEL: @testi16i8_revselect(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i16 [[ADD:%.*]], -128
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i16 [[ADD]], i16 -128
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i16 [[TMP2]], 127
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i16 [[TMP2]], i16 127
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i16 [[TMP4]] to i8
; CHECK-NEXT:    ret i8 [[TMP5]]
;
  %sh = lshr i16 %add, 8
  %conv.i = trunc i16 %sh to i8
  %conv1.i = trunc i16 %add to i8
  %shr2.i = ashr i8 %conv1.i, 7
  %cmp.not.i = icmp ne i8 %conv.i, %shr2.i
  %shr4.i = ashr i16 %add, 15
  %conv5.i = trunc i16 %shr4.i to i8
  %xor.i = xor i8 %conv5.i, 127
  %cond.i = select i1 %cmp.not.i, i8 %xor.i, i8 %conv1.i
  ret i8 %cond.i
}

define i8 @testi32i8(i32 %add) {
; CHECK-LABEL: @testi32i8(
; CHECK-NEXT:    [[SH:%.*]] = lshr i32 [[ADD:%.*]], 8
; CHECK-NEXT:    [[CONV_I:%.*]] = trunc i32 [[SH]] to i8
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i32 [[ADD]] to i8
; CHECK-NEXT:    [[SHR2_I:%.*]] = ashr i8 [[CONV1_I]], 7
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp eq i8 [[SHR2_I]], [[CONV_I]]
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i32 [[ADD]], 15
; CHECK-NEXT:    [[CONV5_I:%.*]] = trunc i32 [[TMP1]] to i8
; CHECK-NEXT:    [[XOR_I:%.*]] = xor i8 [[CONV5_I]], 127
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i8 [[CONV1_I]], i8 [[XOR_I]]
; CHECK-NEXT:    ret i8 [[COND_I]]
;
  %sh = lshr i32 %add, 8
  %conv.i = trunc i32 %sh to i8
  %conv1.i = trunc i32 %add to i8
  %shr2.i = ashr i8 %conv1.i, 7
  %cmp.not.i = icmp eq i8 %shr2.i, %conv.i
  %shr4.i = ashr i32 %add, 15
  %conv5.i = trunc i32 %shr4.i to i8
  %xor.i = xor i8 %conv5.i, 127
  %cond.i = select i1 %cmp.not.i, i8 %conv1.i, i8 %xor.i
  ret i8 %cond.i
}

define i16 @differentconsts(i32 %x, i16 %replacement_low, i16 %replacement_high) {
; CHECK-LABEL: @differentconsts(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt i32 [[X:%.*]], -16
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[X]], 127
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i32 [[X]] to i16
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP1]], i16 256, i16 [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = select i1 [[TMP2]], i16 -1, i16 [[TMP4]]
; CHECK-NEXT:    ret i16 [[TMP5]]
;
  %t0 = icmp slt i32 %x, 128
  %t1 = select i1 %t0, i16 256, i16 65535
  %t2 = add i32 %x, 16
  %t3 = icmp ult i32 %t2, 144
  %t4 = trunc i32 %x to i16
  %r = select i1 %t3, i16 %t4, i16 %t1
  ret i16 %r
}

define i8 @badimm1(i16 %add) {
; CHECK-LABEL: @badimm1(
; CHECK-NEXT:    [[SH:%.*]] = lshr i16 [[ADD:%.*]], 9
; CHECK-NEXT:    [[CONV_I:%.*]] = trunc i16 [[SH]] to i8
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i16 [[ADD]] to i8
; CHECK-NEXT:    [[SHR2_I:%.*]] = ashr i8 [[CONV1_I]], 7
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp eq i8 [[SHR2_I]], [[CONV_I]]
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i16 [[ADD]], -1
; CHECK-NEXT:    [[XOR_I:%.*]] = select i1 [[TMP1]], i8 127, i8 -128
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i8 [[CONV1_I]], i8 [[XOR_I]]
; CHECK-NEXT:    ret i8 [[COND_I]]
;
  %sh = lshr i16 %add, 9
  %conv.i = trunc i16 %sh to i8
  %conv1.i = trunc i16 %add to i8
  %shr2.i = ashr i8 %conv1.i, 7
  %cmp.not.i = icmp eq i8 %shr2.i, %conv.i
  %shr4.i = ashr i16 %add, 15
  %conv5.i = trunc i16 %shr4.i to i8
  %xor.i = xor i8 %conv5.i, 127
  %cond.i = select i1 %cmp.not.i, i8 %conv1.i, i8 %xor.i
  ret i8 %cond.i
}

define i8 @badimm2(i16 %add) {
; CHECK-LABEL: @badimm2(
; CHECK-NEXT:    [[SH:%.*]] = lshr i16 [[ADD:%.*]], 8
; CHECK-NEXT:    [[CONV_I:%.*]] = trunc i16 [[SH]] to i8
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i16 [[ADD]] to i8
; CHECK-NEXT:    [[SHR2_I:%.*]] = ashr i8 [[CONV1_I]], 6
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp eq i8 [[SHR2_I]], [[CONV_I]]
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt i16 [[ADD]], -1
; CHECK-NEXT:    [[XOR_I:%.*]] = select i1 [[TMP1]], i8 127, i8 -128
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i8 [[CONV1_I]], i8 [[XOR_I]]
; CHECK-NEXT:    ret i8 [[COND_I]]
;
  %sh = lshr i16 %add, 8
  %conv.i = trunc i16 %sh to i8
  %conv1.i = trunc i16 %add to i8
  %shr2.i = ashr i8 %conv1.i, 6
  %cmp.not.i = icmp eq i8 %shr2.i, %conv.i
  %shr4.i = ashr i16 %add, 15
  %conv5.i = trunc i16 %shr4.i to i8
  %xor.i = xor i8 %conv5.i, 127
  %cond.i = select i1 %cmp.not.i, i8 %conv1.i, i8 %xor.i
  ret i8 %cond.i
}

define i8 @badimm3(i16 %add) {
; CHECK-LABEL: @badimm3(
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i16 [[ADD:%.*]] to i8
; CHECK-NEXT:    [[TMP1:%.*]] = add i16 [[ADD]], 128
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp ult i16 [[TMP1]], 256
; CHECK-NEXT:    [[SHR4_I:%.*]] = ashr i16 [[ADD]], 14
; CHECK-NEXT:    [[CONV5_I:%.*]] = trunc i16 [[SHR4_I]] to i8
; CHECK-NEXT:    [[XOR_I:%.*]] = xor i8 [[CONV5_I]], 127
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i8 [[CONV1_I]], i8 [[XOR_I]]
; CHECK-NEXT:    ret i8 [[COND_I]]
;
  %sh = lshr i16 %add, 8
  %conv.i = trunc i16 %sh to i8
  %conv1.i = trunc i16 %add to i8
  %shr2.i = ashr i8 %conv1.i, 7
  %cmp.not.i = icmp eq i8 %shr2.i, %conv.i
  %shr4.i = ashr i16 %add, 14
  %conv5.i = trunc i16 %shr4.i to i8
  %xor.i = xor i8 %conv5.i, 127
  %cond.i = select i1 %cmp.not.i, i8 %conv1.i, i8 %xor.i
  ret i8 %cond.i
}

define i8 @badimm4(i16 %add) {
; CHECK-LABEL: @badimm4(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt i16 [[ADD:%.*]], -128
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i16 [[ADD]], 127
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i16 [[ADD]] to i8
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP1]], i8 -127, i8 [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = select i1 [[TMP2]], i8 126, i8 [[TMP4]]
; CHECK-NEXT:    ret i8 [[TMP5]]
;
  %sh = lshr i16 %add, 8
  %conv.i = trunc i16 %sh to i8
  %conv1.i = trunc i16 %add to i8
  %shr2.i = ashr i8 %conv1.i, 7
  %cmp.not.i = icmp eq i8 %shr2.i, %conv.i
  %shr4.i = ashr i16 %add, 15
  %conv5.i = trunc i16 %shr4.i to i8
  %xor.i = xor i8 %conv5.i, 126
  %cond.i = select i1 %cmp.not.i, i8 %conv1.i, i8 %xor.i
  ret i8 %cond.i
}

; One use checks

define i32 @oneusexor(i64 %add) {
; CHECK-LABEL: @oneusexor(
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i64 [[ADD:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[ADD]], 2147483648
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp ult i64 [[TMP1]], 4294967296
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i64 [[ADD]], -1
; CHECK-NEXT:    [[XOR_I:%.*]] = select i1 [[TMP2]], i32 2147483647, i32 -2147483648
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i32 [[CONV1_I]], i32 [[XOR_I]]
; CHECK-NEXT:    call void @use(i32 [[XOR_I]])
; CHECK-NEXT:    ret i32 [[COND_I]]
;
  %sh = lshr i64 %add, 32
  %conv.i = trunc i64 %sh to i32
  %conv1.i = trunc i64 %add to i32
  %shr2.i = ashr i32 %conv1.i, 31
  %cmp.not.i = icmp eq i32 %shr2.i, %conv.i
  %shr4.i = ashr i64 %add, 63
  %conv5.i = trunc i64 %shr4.i to i32
  %xor.i = xor i32 %conv5.i, 2147483647
  %cond.i = select i1 %cmp.not.i, i32 %conv1.i, i32 %xor.i
  call void @use(i32 %xor.i)
  ret i32 %cond.i
}

define i32 @oneuseconv(i64 %add) {
; CHECK-LABEL: @oneuseconv(
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i64 [[ADD:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[ADD]], 2147483648
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp ult i64 [[TMP1]], 4294967296
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i64 [[ADD]], -1
; CHECK-NEXT:    [[XOR_I:%.*]] = select i1 [[TMP2]], i32 2147483647, i32 -2147483648
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i32 [[CONV1_I]], i32 [[XOR_I]]
; CHECK-NEXT:    call void @use(i32 [[CONV1_I]])
; CHECK-NEXT:    ret i32 [[COND_I]]
;
  %sh = lshr i64 %add, 32
  %conv.i = trunc i64 %sh to i32
  %conv1.i = trunc i64 %add to i32
  %shr2.i = ashr i32 %conv1.i, 31
  %cmp.not.i = icmp eq i32 %shr2.i, %conv.i
  %shr4.i = ashr i64 %add, 63
  %conv5.i = trunc i64 %shr4.i to i32
  %xor.i = xor i32 %conv5.i, 2147483647
  %cond.i = select i1 %cmp.not.i, i32 %conv1.i, i32 %xor.i
  call void @use(i32 %conv1.i)
  ret i32 %cond.i
}

define i32 @oneusecmp(i64 %add) {
; CHECK-LABEL: @oneusecmp(
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i64 [[ADD:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[ADD]], 2147483648
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp ult i64 [[TMP1]], 4294967296
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i64 [[ADD]], -1
; CHECK-NEXT:    [[XOR_I:%.*]] = select i1 [[TMP2]], i32 2147483647, i32 -2147483648
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i32 [[CONV1_I]], i32 [[XOR_I]]
; CHECK-NEXT:    call void @use1(i1 [[CMP_NOT_I]])
; CHECK-NEXT:    ret i32 [[COND_I]]
;
  %sh = lshr i64 %add, 32
  %conv.i = trunc i64 %sh to i32
  %conv1.i = trunc i64 %add to i32
  %shr2.i = ashr i32 %conv1.i, 31
  %cmp.not.i = icmp eq i32 %shr2.i, %conv.i
  %shr4.i = ashr i64 %add, 63
  %conv5.i = trunc i64 %shr4.i to i32
  %xor.i = xor i32 %conv5.i, 2147483647
  %cond.i = select i1 %cmp.not.i, i32 %conv1.i, i32 %xor.i
  call void @use1(i1 %cmp.not.i)
  ret i32 %cond.i
}

define i32 @oneuseboth(i64 %add) {
; CHECK-LABEL: @oneuseboth(
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i64 [[ADD:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[ADD]], 2147483648
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp ult i64 [[TMP1]], 4294967296
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i64 [[ADD]], -1
; CHECK-NEXT:    [[XOR_I:%.*]] = select i1 [[TMP2]], i32 2147483647, i32 -2147483648
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i32 [[CONV1_I]], i32 [[XOR_I]]
; CHECK-NEXT:    call void @use(i32 [[XOR_I]])
; CHECK-NEXT:    call void @use(i32 [[CONV1_I]])
; CHECK-NEXT:    ret i32 [[COND_I]]
;
  %sh = lshr i64 %add, 32
  %conv.i = trunc i64 %sh to i32
  %conv1.i = trunc i64 %add to i32
  %shr2.i = ashr i32 %conv1.i, 31
  %cmp.not.i = icmp eq i32 %shr2.i, %conv.i
  %shr4.i = ashr i64 %add, 63
  %conv5.i = trunc i64 %shr4.i to i32
  %xor.i = xor i32 %conv5.i, 2147483647
  %cond.i = select i1 %cmp.not.i, i32 %conv1.i, i32 %xor.i
  call void @use(i32 %xor.i)
  call void @use(i32 %conv1.i)
  ret i32 %cond.i
}

define i32 @oneusethree(i64 %add) {
; CHECK-LABEL: @oneusethree(
; CHECK-NEXT:    [[CONV1_I:%.*]] = trunc i64 [[ADD:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[ADD]], 2147483648
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp ult i64 [[TMP1]], 4294967296
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i64 [[ADD]], -1
; CHECK-NEXT:    [[XOR_I:%.*]] = select i1 [[TMP2]], i32 2147483647, i32 -2147483648
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_NOT_I]], i32 [[CONV1_I]], i32 [[XOR_I]]
; CHECK-NEXT:    call void @use(i32 [[XOR_I]])
; CHECK-NEXT:    call void @use(i32 [[CONV1_I]])
; CHECK-NEXT:    call void @use1(i1 [[CMP_NOT_I]])
; CHECK-NEXT:    ret i32 [[COND_I]]
;
  %sh = lshr i64 %add, 32
  %conv.i = trunc i64 %sh to i32
  %conv1.i = trunc i64 %add to i32
  %shr2.i = ashr i32 %conv1.i, 31
  %cmp.not.i = icmp eq i32 %shr2.i, %conv.i
  %shr4.i = ashr i64 %add, 63
  %conv5.i = trunc i64 %shr4.i to i32
  %xor.i = xor i32 %conv5.i, 2147483647
  %cond.i = select i1 %cmp.not.i, i32 %conv1.i, i32 %xor.i
  call void @use(i32 %xor.i)
  call void @use(i32 %conv1.i)
  call void @use1(i1 %cmp.not.i)
  ret i32 %cond.i
}

define i16 @differentconsts_usetrunc(i32 %x, i16 %replacement_low, i16 %replacement_high) {
; CHECK-LABEL: @differentconsts_usetrunc(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 128
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i16 256, i16 -1
; CHECK-NEXT:    [[T2:%.*]] = add i32 [[X]], 16
; CHECK-NEXT:    [[T3:%.*]] = icmp ult i32 [[T2]], 144
; CHECK-NEXT:    [[T4:%.*]] = trunc i32 [[X]] to i16
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T3]], i16 [[T4]], i16 [[T1]]
; CHECK-NEXT:    call void @use16(i16 [[T4]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %t0 = icmp slt i32 %x, 128
  %t1 = select i1 %t0, i16 256, i16 65535
  %t2 = add i32 %x, 16
  %t3 = icmp ult i32 %t2, 144
  %t4 = trunc i32 %x to i16
  %r = select i1 %t3, i16 %t4, i16 %t1
  call void @use16(i16 %t4)
  ret i16 %r
}

define i16 @differentconsts_useadd(i32 %x, i16 %replacement_low, i16 %replacement_high) {
; CHECK-LABEL: @differentconsts_useadd(
; CHECK-NEXT:    [[T2:%.*]] = add i32 [[X:%.*]], 16
; CHECK-NEXT:    [[TMP1:%.*]] = icmp slt i32 [[X]], -16
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[X]], 127
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i32 [[X]] to i16
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP1]], i16 256, i16 [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = select i1 [[TMP2]], i16 -1, i16 [[TMP4]]
; CHECK-NEXT:    call void @use(i32 [[T2]])
; CHECK-NEXT:    ret i16 [[TMP5]]
;
  %t0 = icmp slt i32 %x, 128
  %t1 = select i1 %t0, i16 256, i16 65535
  %t2 = add i32 %x, 16
  %t3 = icmp ult i32 %t2, 144
  %t4 = trunc i32 %x to i16
  %r = select i1 %t3, i16 %t4, i16 %t1
  call void @use(i32 %t2)
  ret i16 %r
}

define i16 @differentconsts_useaddtrunc(i32 %x, i16 %replacement_low, i16 %replacement_high) {
; CHECK-LABEL: @differentconsts_useaddtrunc(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 128
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i16 256, i16 -1
; CHECK-NEXT:    [[T2:%.*]] = add i32 [[X]], 16
; CHECK-NEXT:    [[T3:%.*]] = icmp ult i32 [[T2]], 144
; CHECK-NEXT:    [[T4:%.*]] = trunc i32 [[X]] to i16
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T3]], i16 [[T4]], i16 [[T1]]
; CHECK-NEXT:    call void @use16(i16 [[T4]])
; CHECK-NEXT:    call void @use(i32 [[T2]])
; CHECK-NEXT:    ret i16 [[R]]
;
  %t0 = icmp slt i32 %x, 128
  %t1 = select i1 %t0, i16 256, i16 65535
  %t2 = add i32 %x, 16
  %t3 = icmp ult i32 %t2, 144
  %t4 = trunc i32 %x to i16
  %r = select i1 %t3, i16 %t4, i16 %t1
  call void @use16(i16 %t4)
  call void @use(i32 %t2)
  ret i16 %r
}


define i8 @C0zero(i8 %X, i8 %y, i8 %z) {
; CHECK-LABEL: @C0zero(
; CHECK-NEXT:    [[C:%.*]] = icmp slt i8 [[X:%.*]], -10
; CHECK-NEXT:    [[F:%.*]] = select i1 [[C]], i8 [[Y:%.*]], i8 [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[F]]
;
  %a = add i8 %X, 10
  %cmp = icmp ult i8 %a, 0
  %c = icmp slt i8 %X, -10
  %f = select i1 %c, i8 %y, i8 %z
  %r = select i1 %cmp, i8 %X, i8 %f
  ret i8 %r
}

define <2 x i8> @C0zeroV(<2 x i8> %X, <2 x i8> %y, <2 x i8> %z) {
; CHECK-LABEL: @C0zeroV(
; CHECK-NEXT:    [[C:%.*]] = icmp slt <2 x i8> [[X:%.*]], <i8 -10, i8 -10>
; CHECK-NEXT:    [[F:%.*]] = select <2 x i1> [[C]], <2 x i8> [[Y:%.*]], <2 x i8> [[Z:%.*]]
; CHECK-NEXT:    ret <2 x i8> [[F]]
;
  %a = add <2 x i8> %X, <i8 10, i8 10>
  %cmp = icmp ult <2 x i8> %a, zeroinitializer
  %c = icmp slt <2 x i8> %X, <i8 -10, i8 -10>
  %f = select <2 x i1> %c, <2 x i8> %y, <2 x i8> %z
  %r = select <2 x i1> %cmp, <2 x i8> %X, <2 x i8> %f
  ret <2 x i8> %r
}

define <2 x i8> @C0zeroVu(<2 x i8> %X, <2 x i8> %y, <2 x i8> %z) {
; CHECK-LABEL: @C0zeroVu(
; CHECK-NEXT:    [[A:%.*]] = add <2 x i8> [[X:%.*]], <i8 10, i8 10>
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult <2 x i8> [[A]], <i8 0, i8 10>
; CHECK-NEXT:    [[C:%.*]] = icmp slt <2 x i8> [[X]], <i8 -10, i8 -10>
; CHECK-NEXT:    [[F:%.*]] = select <2 x i1> [[C]], <2 x i8> [[Y:%.*]], <2 x i8> [[Z:%.*]]
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[CMP]], <2 x i8> [[X]], <2 x i8> [[F]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %a = add <2 x i8> %X, <i8 10, i8 10>
  %cmp = icmp ult <2 x i8> %a, <i8 0, i8 10>
  %c = icmp slt <2 x i8> %X, <i8 -10, i8 -10>
  %f = select <2 x i1> %c, <2 x i8> %y, <2 x i8> %z
  %r = select <2 x i1> %cmp, <2 x i8> %X, <2 x i8> %f
  ret <2 x i8> %r
}

define i8 @f(i32 %value, i8 %call.i) {
; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_I:%.*]] = icmp slt i32 [[VALUE:%.*]], 0
; CHECK-NEXT:    [[COND_I:%.*]] = select i1 [[CMP_I]], i8 [[CALL_I:%.*]], i8 0
; CHECK-NEXT:    [[CMP_I_I:%.*]] = icmp ult i32 [[VALUE]], 256
; CHECK-NEXT:    [[CONV4:%.*]] = trunc i32 [[VALUE]] to i8
; CHECK-NEXT:    [[COND:%.*]] = select i1 [[CMP_I_I]], i8 [[CONV4]], i8 [[COND_I]]
; CHECK-NEXT:    ret i8 [[COND]]
;
entry:
  %cmp.i = icmp slt i32 %value, 0
  %cond.i = select i1 %cmp.i, i8 %call.i, i8 0
  %cmp.i.i = icmp ult i32 %value, 256
  %conv4 = trunc i32 %value to i8
  %cond = select i1 %cmp.i.i, i8 %conv4, i8 %cond.i
  ret i8 %cond
}

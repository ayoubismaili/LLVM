; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=x86_64-unknown-linux -mcpu=corei7 -slp-vectorizer < %s | FileCheck %s

%struct.S = type { i8*, i8* }

@kS0 = common global %struct.S zeroinitializer, align 8

define { i64, i64 } @getS() {
; CHECK-LABEL: @getS(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, i64* bitcast (%struct.S* @kS0 to i64*), align 8
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, i64* bitcast (i8** getelementptr inbounds ([[STRUCT_S:%.*]], %struct.S* @kS0, i64 0, i32 1) to i64*), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = insertvalue { i64, i64 } undef, i64 [[TMP0]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertvalue { i64, i64 } [[TMP2]], i64 [[TMP1]], 1
; CHECK-NEXT:    ret { i64, i64 } [[TMP3]]
;
entry:
  %0 = load i64, i64* bitcast (%struct.S* @kS0 to i64*), align 8
  %1 = load i64, i64* bitcast (i8** getelementptr inbounds (%struct.S, %struct.S* @kS0, i64 0, i32 1) to i64*), align 8
  %2 = insertvalue { i64, i64 } undef, i64 %0, 0
  %3 = insertvalue { i64, i64 } %2, i64 %1, 1
  ret { i64, i64 } %3
}

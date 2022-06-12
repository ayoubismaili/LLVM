; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -debugify -basic-aa -licm -S | FileCheck %s

%Ty = type { i32, i32 }
@X2 = external global %Ty

; The GEP in dead1 is adding a zero offset, so the DIExpression can be kept as
; a "register location".
; The GEP in dead2 is adding a 4 bytes to the pointer, so the DIExpression is
; turned into an "implicit location" using DW_OP_stack_value.
define void @test11() {
; CHECK-LABEL: @test11(
; CHECK-NEXT:    br label [[LOOP:%.*]], !dbg [[DBG12:![0-9]+]]
; CHECK:       Loop:
; CHECK-NEXT:    call void @llvm.dbg.value(metadata %Ty* @X2, metadata [[META9:![0-9]+]], metadata !DIExpression()), !dbg [[DBG13:![0-9]+]]
; CHECK-NEXT:    call void @llvm.dbg.value(metadata %Ty* @X2, metadata [[META11:![0-9]+]], metadata !DIExpression(DW_OP_plus_uconst, 4, DW_OP_stack_value)), !dbg [[DBG14:![0-9]+]]
; CHECK-NEXT:    br i1 false, label [[LOOP]], label [[OUT:%.*]], !dbg [[DBG15:![0-9]+]]
; CHECK:       Out:
; CHECK-NEXT:    ret void, !dbg [[DBG16:![0-9]+]]
;
  br label %Loop
Loop:
  %dead1 = getelementptr %Ty, %Ty* @X2, i64 0, i32 0
  %dead2 = getelementptr %Ty, %Ty* @X2, i64 0, i32 1
  br i1 false, label %Loop, label %Out
Out:
  ret void
}

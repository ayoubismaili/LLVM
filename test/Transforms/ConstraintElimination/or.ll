; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

declare void @use(i1)

define void @test_or_ule(i4 %x, i4 %y, i4 %z, i4 %a) {
; CHECK-LABEL: @test_or_ule(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i4 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i4 [[Y]], [[Z:%.*]]
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[C_1]], [[C_2]]
; CHECK-NEXT:    br i1 [[OR]], label [[BB1:%.*]], label [[EXIT:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i4 [[X]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    [[C_4:%.*]] = icmp ule i4 [[X]], [[A:%.*]]
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    ret void
; CHECK:       exit:
; CHECK-NEXT:    [[F_1:%.*]] = icmp ule i4 [[X]], [[Z]]
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C_5:%.*]] = icmp ule i4 [[X]], [[A]]
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i4 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[T_2:%.*]] = icmp ugt i4 [[X]], [[Y]]
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[T_3:%.*]] = icmp ugt i4 [[X]], [[Z]]
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    ret void
;
entry:
  %c.1 = icmp ule i4 %x, %y
  %c.2 = icmp ule i4 %y, %z
  %or = or i1 %c.1, %c.2
  br i1 %or, label %bb1, label %exit

bb1:
  %c.3 = icmp ule i4 %x, %z
  call void @use(i1 %c.3)

  %c.4 = icmp ule i4 %x, %a
  call void @use(i1 %c.4)

  ret void

exit:
  %f.1 = icmp ule i4 %x, %z
  call void @use(i1 %f.1)

  %c.5 = icmp ule i4 %x, %a
  call void @use(i1 %c.5)

  %t.1 = icmp ugt i4 %y, %z
  call void @use(i1 %t.1)

  %t.2 = icmp ugt i4 %x, %y
  call void @use(i1 %t.2)

  %t.3 = icmp ugt i4 %x, %z
  call void @use(i1 %t.3)

  ret void
}

; The result of test_or_ule and test_or_select_ule should be same
define void @test_or_select_ule(i4 %x, i4 %y, i4 %z, i4 %a) {
; CHECK-LABEL: @test_or_select_ule(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i4 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i4 [[Y]], [[Z:%.*]]
; CHECK-NEXT:    [[OR:%.*]] = select i1 [[C_1]], i1 true, i1 [[C_2]]
; CHECK-NEXT:    br i1 [[OR]], label [[BB1:%.*]], label [[EXIT:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i4 [[X]], [[Z]]
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    [[C_4:%.*]] = icmp ule i4 [[X]], [[A:%.*]]
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    ret void
; CHECK:       exit:
; CHECK-NEXT:    [[F_1:%.*]] = icmp ule i4 [[X]], [[Z]]
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C_5:%.*]] = icmp ule i4 [[X]], [[A]]
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i4 [[Y]], [[Z]]
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[T_2:%.*]] = icmp ugt i4 [[X]], [[Y]]
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[T_3:%.*]] = icmp ugt i4 [[X]], [[Z]]
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    ret void
;
entry:
  %c.1 = icmp ule i4 %x, %y
  %c.2 = icmp ule i4 %y, %z
  %or = select i1 %c.1, i1 true, i1 %c.2
  br i1 %or, label %bb1, label %exit

bb1:
  %c.3 = icmp ule i4 %x, %z
  call void @use(i1 %c.3)

  %c.4 = icmp ule i4 %x, %a
  call void @use(i1 %c.4)

  ret void

exit:
  %f.1 = icmp ule i4 %x, %z
  call void @use(i1 %f.1)

  %c.5 = icmp ule i4 %x, %a
  call void @use(i1 %c.5)

  %t.1 = icmp ugt i4 %y, %z
  call void @use(i1 %t.1)

  %t.2 = icmp ugt i4 %x, %y
  call void @use(i1 %t.2)

  %t.3 = icmp ugt i4 %x, %z
  call void @use(i1 %t.3)

  ret void
}

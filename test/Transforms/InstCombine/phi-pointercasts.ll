; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -S < %s | FileCheck %s

define void @test_bitcast_1(i1 %c, i32* %ptr) {
; CHECK-LABEL: @test_bitcast_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    [[CAST_0:%.*]] = bitcast i32* [[PTR:%.*]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_0]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = bitcast i32* [[PTR]] to i8*
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %cast.0 = bitcast i32* %ptr to i8*
  %cast.1 = bitcast i32* %ptr to i8*
  br i1 %c, label %b0, label %b1

b0:
  call void @use(i8* %cast.0)
  br label %end

b1:
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i8 0, i8* %p
  ret void
}

define void @test_bitcast_2(i1 %c, i32* %ptr) {
; CHECK-LABEL: @test_bitcast_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[CAST_1:%.*]] = bitcast i32* [[PTR:%.*]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_1]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = bitcast i32* [[PTR]] to i8*
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %b0, label %b1

b0:
  %cast.0 = bitcast i32* %ptr to i8*
  br label %end

b1:
  %cast.1 = bitcast i32* %ptr to i8*
  call void @use(i8* %cast.1)
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i8 0, i8* %p
  ret void
}


define void @test_bitcast_3(i1 %c, i32** %ptr) {
; CHECK-LABEL: @test_bitcast_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOAD_PTR:%.*]] = load i32*, i32** [[PTR:%.*]], align 8
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[CAST_1:%.*]] = bitcast i32* [[LOAD_PTR]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_1]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = bitcast i32* [[LOAD_PTR]] to i8*
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %load.ptr = load i32*, i32** %ptr
  br i1 %c, label %b0, label %b1

b0:
  %cast.0 = bitcast i32* %load.ptr to i8*
  br label %end

b1:
  %cast.1 = bitcast i32* %load.ptr to i8*
  call void @use(i8* %cast.1)
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i8 0, i8* %p
  ret void
}

define void @test_bitcast_loads_in_different_bbs(i1 %c, i32** %ptr.0, i32** %ptr.1) {
; CHECK-LABEL: @test_bitcast_loads_in_different_bbs(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32** [[PTR_0:%.*]] to i8**
; CHECK-NEXT:    [[LOAD_PTR_02:%.*]] = load i8*, i8** [[TMP0]], align 8
; CHECK-NEXT:    call void @use(i8* [[LOAD_PTR_02]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32** [[PTR_1:%.*]] to i8**
; CHECK-NEXT:    [[LOAD_PTR_11:%.*]] = load i8*, i8** [[TMP1]], align 8
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = phi i8* [ [[LOAD_PTR_02]], [[B0]] ], [ [[LOAD_PTR_11]], [[B1]] ]
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %b0, label %b1

b0:
  %load.ptr.0 = load i32*, i32** %ptr.0
  %cast.0 = bitcast i32* %load.ptr.0 to i8*
  call void @use(i8* %cast.0)
  br label %end

b1:
  %load.ptr.1 = load i32*, i32** %ptr.1
  %cast.1 = bitcast i32* %load.ptr.1 to i8*
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i8 0, i8* %p
  ret void
}

define void @test_gep_1(i1 %c, i32* %ptr) {
; CHECK-LABEL: @test_gep_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    call void @use.i32(i32* [[PTR:%.*]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    store i32 0, i32* [[PTR]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %b0, label %b1

b0:
  %cast.0 = getelementptr i32, i32* %ptr, i32 0
  call void @use.i32(i32* %cast.0)
  br label %end

b1:
  %cast.1 = getelementptr i32, i32* %ptr, i32 0
  br label %end

end:
  %p = phi i32* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i32 0, i32* %p
  ret void
}

define void @test_bitcast_not_foldable(i1 %c, i32* %ptr.0, i32* %ptr.1) {
; CHECK-LABEL: @test_bitcast_not_foldable(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    [[CAST_0:%.*]] = bitcast i32* [[PTR_0:%.*]] to i8*
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[CAST_1:%.*]] = bitcast i32* [[PTR_1:%.*]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_1]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = phi i8* [ [[CAST_0]], [[B0]] ], [ [[CAST_1]], [[B1]] ]
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %b0, label %b1

b0:
  %cast.0 = bitcast i32* %ptr.0 to i8*
  br label %end

b1:
  %cast.1 = bitcast i32* %ptr.1 to i8*
  call void @use(i8* %cast.1)
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i8 0, i8* %p
  ret void
}

define void @test_bitcast_with_extra_use(i1 %c, i32* %ptr) {
; CHECK-LABEL: @test_bitcast_with_extra_use(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    [[CAST_0:%.*]] = bitcast i32* [[PTR:%.*]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_0]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = bitcast i32* [[PTR]] to i8*
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %b0, label %b1

b0:
  %cast.0 = bitcast i32* %ptr to i8*
  call void @use(i8* %cast.0)
  br label %end

b1:
  %cast.1 = bitcast i32* %ptr to i8*
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i8 0, i8* %p
  ret void
}

define void @test_bitcast_different_bases(i1 %c, i32* %ptr.0, i32* %ptr.1) {
; CHECK-LABEL: @test_bitcast_different_bases(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    [[CAST_0:%.*]] = bitcast i32* [[PTR_0:%.*]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_0]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[CAST_1:%.*]] = bitcast i32* [[PTR_1:%.*]] to i8*
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = phi i8* [ [[CAST_0]], [[B0]] ], [ [[CAST_1]], [[B1]] ]
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %b0, label %b1

b0:
  %cast.0 = bitcast i32* %ptr.0 to i8*
  call void @use(i8* %cast.0)
  br label %end

b1:
  %cast.1 = bitcast i32* %ptr.1 to i8*
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i8 0, i8* %p
  ret void
}

define void @test_bitcast_gep_chains(i1 %c, i32* %ptr) {
; CHECK-LABEL: @test_bitcast_gep_chains(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    [[CAST_0:%.*]] = bitcast i32* [[PTR:%.*]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_0]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    call void @use.i32(i32* [[PTR]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = bitcast i32* [[PTR]] to i8*
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %gep = getelementptr i32, i32* %ptr, i32 0
  br i1 %c, label %b0, label %b1

b0:
  %cast.0 = bitcast i32* %gep to i8*
  call void @use(i8* %cast.0)
  br label %end

b1:
  %cast.1 = bitcast i32* %ptr to i8*
  %cast.2 = bitcast i8* %cast.1 to i32*
  call void @use.i32(i32* %cast.2)
  %cast.3 = bitcast i32* %cast.2 to i8*
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.3, %b1 ]
  store i8 0, i8* %p
  ret void
}

define void @test_4_incoming_values_different_bases_1(i32 %c, i32* %ptr.0, i32* %ptr.1) {
; CHECK-LABEL: @test_4_incoming_values_different_bases_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[C:%.*]], label [[END_2:%.*]] [
; CHECK-NEXT:    i32 0, label [[B0:%.*]]
; CHECK-NEXT:    i32 1, label [[B1:%.*]]
; CHECK-NEXT:    i32 2, label [[B2:%.*]]
; CHECK-NEXT:    i32 3, label [[B3:%.*]]
; CHECK-NEXT:    ]
; CHECK:       b0:
; CHECK-NEXT:    [[CAST_0:%.*]] = bitcast i32* [[PTR_0:%.*]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_0]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[CAST_3:%.*]] = bitcast i32* [[PTR_1:%.*]] to i8*
; CHECK-NEXT:    br label [[END]]
; CHECK:       b2:
; CHECK-NEXT:    [[CAST_4:%.*]] = bitcast i32* [[PTR_0]] to i8*
; CHECK-NEXT:    br label [[END]]
; CHECK:       b3:
; CHECK-NEXT:    [[CAST_5:%.*]] = bitcast i32* [[PTR_0]] to i8*
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = phi i8* [ [[CAST_0]], [[B0]] ], [ [[CAST_3]], [[B1]] ], [ [[CAST_4]], [[B2]] ], [ [[CAST_5]], [[B3]] ]
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
; CHECK:       end.2:
; CHECK-NEXT:    ret void
;
entry:
  %gep = getelementptr i32, i32* %ptr.0, i32 0
  switch i32 %c, label %end.2 [ i32 0, label %b0
  i32 1, label %b1
  i32 2, label %b2
  i32 3, label %b3]

b0:
  %cast.0 = bitcast i32* %gep to i8*
  call void @use(i8* %cast.0)
  br label %end

b1:
  %cast.1 = bitcast i32* %ptr.1 to i8*
  %cast.2 = bitcast i8* %cast.1 to i64*
  %cast.3 = bitcast i64* %cast.2 to i8*
  br label %end

b2:
  %cast.4 = bitcast i32* %gep to i8*
  br label %end

b3:
  %cast.5 = bitcast i32 * %ptr.0 to i8*
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.3, %b1 ], [ %cast.4, %b2 ], [ %cast.5, %b3]
  store i8 0, i8* %p
  ret void

end.2:
  ret void
}

define void @test_4_incoming_values_different_bases_2(i32 %c, i32* %ptr.0, i32* %ptr.1) {
; CHECK-LABEL: @test_4_incoming_values_different_bases_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[C:%.*]], label [[END_2:%.*]] [
; CHECK-NEXT:    i32 0, label [[B0:%.*]]
; CHECK-NEXT:    i32 1, label [[B1:%.*]]
; CHECK-NEXT:    i32 2, label [[B2:%.*]]
; CHECK-NEXT:    i32 3, label [[B3:%.*]]
; CHECK-NEXT:    ]
; CHECK:       b0:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[CAST_1:%.*]] = bitcast i32* [[PTR_0:%.*]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_1]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       b2:
; CHECK-NEXT:    br label [[END]]
; CHECK:       b3:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P_IN:%.*]] = phi i32* [ [[PTR_1:%.*]], [[B0]] ], [ [[PTR_0]], [[B1]] ], [ [[PTR_0]], [[B2]] ], [ [[PTR_0]], [[B3]] ]
; CHECK-NEXT:    [[P:%.*]] = bitcast i32* [[P_IN]] to i8*
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
; CHECK:       end.2:
; CHECK-NEXT:    ret void
;
entry:
  %gep = getelementptr i32, i32* %ptr.0, i32 0
  switch i32 %c, label %end.2 [ i32 0, label %b0
  i32 1, label %b1
  i32 2, label %b2
  i32 3, label %b3]

b0:
  %cast.0 = bitcast i32* %ptr.1 to i8*
  br label %end

b1:
  %cast.1 = bitcast i32* %ptr.0 to i8*
  call void @use(i8* %cast.1)
  %cast.2 = bitcast i8* %cast.1 to i64*
  %cast.3 = bitcast i64* %cast.2 to i8*
  br label %end

b2:
  %cast.4 = bitcast i32* %gep to i8*
  br label %end

b3:
  %cast.5 = bitcast i32 * %ptr.0 to i8*
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.3, %b1 ], [ %cast.4, %b2 ], [ %cast.5, %b3]
  store i8 0, i8* %p
  ret void

end.2:
  ret void
}

define void @test_4_incoming_values_different_bases_3(i32 %c, i32* %ptr.0, i32* %ptr.1) {
; CHECK-LABEL: @test_4_incoming_values_different_bases_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[C:%.*]], label [[END_2:%.*]] [
; CHECK-NEXT:    i32 0, label [[B0:%.*]]
; CHECK-NEXT:    i32 1, label [[B1:%.*]]
; CHECK-NEXT:    i32 2, label [[B2:%.*]]
; CHECK-NEXT:    i32 3, label [[B3:%.*]]
; CHECK-NEXT:    ]
; CHECK:       b0:
; CHECK-NEXT:    [[CAST_0:%.*]] = bitcast i32* [[PTR_0:%.*]] to i8*
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[CAST_3:%.*]] = bitcast i32* [[PTR_0]] to i8*
; CHECK-NEXT:    br label [[END]]
; CHECK:       b2:
; CHECK-NEXT:    [[CAST_4:%.*]] = bitcast i32* [[PTR_0]] to i8*
; CHECK-NEXT:    call void @use(i8* [[CAST_4]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       b3:
; CHECK-NEXT:    [[CAST_5:%.*]] = bitcast i32* [[PTR_1:%.*]] to i8*
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[P:%.*]] = phi i8* [ [[CAST_0]], [[B0]] ], [ [[CAST_3]], [[B1]] ], [ [[CAST_4]], [[B2]] ], [ [[CAST_5]], [[B3]] ]
; CHECK-NEXT:    store i8 0, i8* [[P]], align 1
; CHECK-NEXT:    ret void
; CHECK:       end.2:
; CHECK-NEXT:    ret void
;
entry:
  %gep = getelementptr i32, i32* %ptr.0, i32 0
  switch i32 %c, label %end.2 [ i32 0, label %b0
  i32 1, label %b1
  i32 2, label %b2
  i32 3, label %b3]

b0:
  %cast.0 = bitcast i32* %ptr.0 to i8*
  br label %end

b1:
  %cast.1 = bitcast i32* %ptr.0 to i8*
  %cast.2 = bitcast i8* %cast.1 to i64*
  %cast.3 = bitcast i64* %cast.2 to i8*
  br label %end

b2:
  %cast.4 = bitcast i32* %gep to i8*
  call void @use(i8* %cast.4)
  br label %end

b3:
  %cast.5 = bitcast i32 * %ptr.1 to i8*
  br label %end

end:
  %p = phi i8* [ %cast.0, %b0 ], [ %cast.3, %b1 ], [ %cast.4, %b2 ], [ %cast.5, %b3]
  store i8 0, i8* %p
  ret void

end.2:
  ret void
}

define void @test_addrspacecast_1(i1 %c, i32* %ptr) {
; CHECK-LABEL: @test_addrspacecast_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[B0:%.*]], label [[B1:%.*]]
; CHECK:       b0:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       b1:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[PTR:%.*]] to i8*
; CHECK-NEXT:    [[CAST_1:%.*]] = addrspacecast i8* [[TMP0]] to i8 addrspace(1)*
; CHECK-NEXT:    call void @use.i8.addrspace1(i8 addrspace(1)* [[CAST_1]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32* [[PTR]] to i8*
; CHECK-NEXT:    [[P:%.*]] = addrspacecast i8* [[TMP1]] to i8 addrspace(1)*
; CHECK-NEXT:    store i8 0, i8 addrspace(1)* [[P]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %cast.0 = addrspacecast i32* %ptr to i8 addrspace(1)*
  %cast.1 = addrspacecast i32* %ptr to i8 addrspace(1)*
  br i1 %c, label %b0, label %b1

b0:
  br label %end

b1:
  call void @use.i8.addrspace1(i8 addrspace(1)* %cast.1)
  br label %end

end:
  %p = phi i8 addrspace(1)* [ %cast.0, %b0 ], [ %cast.1, %b1 ]
  store i8 0, i8 addrspace(1)* %p
  ret void
}

declare void @use(i8*)
declare void @use.i32(i32*)
declare void @use.i8.addrspace1(i8 addrspace(1)*)

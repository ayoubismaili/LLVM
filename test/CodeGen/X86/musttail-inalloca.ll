; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc %s -o - | FileCheck %s

; Previously, we would accidentally leave behind SP adjustments to setup a call
; frame for the musttail call target, and SP adjustments would end up
; unbalanced. Reported as https://crbug.com/1026882.

target datalayout = "e-m:x-p:32:32-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:32-n8:16:32-a:0:32-S32"
target triple = "i386-pc-windows-msvc19.16.0"

; 20 bytes of memory.
%struct.Args = type { i32, i32, i32, i32, i32 }

declare dso_local x86_thiscallcc void @methodWithVtorDisp(i8* nocapture readonly, <{ %struct.Args }>* inalloca(<{ %struct.Args }>))

; Function Attrs: nounwind optsize
define dso_local x86_thiscallcc void @methodWithVtorDisp_thunk(i8* %0, <{ %struct.Args }>* inalloca(<{ %struct.Args }>) %1) #0 {
; CHECK-LABEL: methodWithVtorDisp_thunk:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    movl %ecx, %esi
; CHECK-NEXT:    subl -4(%ecx), %esi
; CHECK-NEXT:    pushl {{[0-9]+}}(%esp)
; CHECK-NEXT:    pushl $_methodWithVtorDisp_thunk
; CHECK-NEXT:    calll ___cyg_profile_func_exit
; CHECK-NEXT:    addl $8, %esp
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    jmp _methodWithVtorDisp # TAILCALL
  %3 = getelementptr inbounds i8, i8* %0, i32 -4
  %4 = bitcast i8* %3 to i32*
  %5 = load i32, i32* %4, align 4
  %6 = sub i32 0, %5
  %7 = getelementptr i8, i8* %0, i32 %6
  %8 = call i8* @llvm.returnaddress(i32 0)
  call void @__cyg_profile_func_exit(i8* bitcast (void (i8*, <{ %struct.Args }>*)* @methodWithVtorDisp_thunk to i8*), i8* %8)
  musttail call x86_thiscallcc void @methodWithVtorDisp(i8* %7, <{ %struct.Args }>* inalloca(<{ %struct.Args }>) nonnull %1)
  ret void
}

declare void @__cyg_profile_func_exit(i8*, i8*)

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i8* @llvm.returnaddress(i32 immarg) #1

attributes #0 = { nounwind optsize }
attributes #1 = { nofree nosync nounwind readnone willreturn }

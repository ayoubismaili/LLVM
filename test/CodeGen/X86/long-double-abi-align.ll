; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --no_x86_scrub_sp --no_x86_scrub_mem_shuffle
; RUN: llc < %s -mtriple=i386-pc-windows-msvc | FileCheck %s --check-prefix=MSVC
; RUN: llc < %s -mtriple=i386-pc-mingw32 | FileCheck %s --check-prefix=MINGW
; RUN: llc < %s -mtriple=i386-pc-linux-gnu | FileCheck %s --check-prefix=LINUX
; RUN: llc < %s -mtriple=i386--apple-darwin  | FileCheck %s --check-prefix=DARWIN

define void @foo(i32 %0, x86_fp80 %1, i32 %2) nounwind {
; MSVC-LABEL: foo:
; MSVC:       # %bb.0:
; MSVC-NEXT:    pushl %ebp
; MSVC-NEXT:    movl %esp, %ebp
; MSVC-NEXT:    andl $-16, %esp
; MSVC-NEXT:    subl $32, %esp
; MSVC-NEXT:    fldt 24(%ebp)
; MSVC-NEXT:    fstpt (%esp)
; MSVC-NEXT:    leal 8(%ebp), %eax
; MSVC-NEXT:    pushl %eax
; MSVC-NEXT:    calll _escape
; MSVC-NEXT:    addl $4, %esp
; MSVC-NEXT:    movl %esp, %eax
; MSVC-NEXT:    pushl %eax
; MSVC-NEXT:    calll _escape
; MSVC-NEXT:    addl $4, %esp
; MSVC-NEXT:    leal 40(%ebp), %eax
; MSVC-NEXT:    pushl %eax
; MSVC-NEXT:    calll _escape
; MSVC-NEXT:    addl $4, %esp
; MSVC-NEXT:    movl %ebp, %esp
; MSVC-NEXT:    popl %ebp
; MSVC-NEXT:    retl
;
; MINGW-LABEL: foo:
; MINGW:       # %bb.0:
; MINGW-NEXT:    pushl %ebp
; MINGW-NEXT:    movl %esp, %ebp
; MINGW-NEXT:    andl $-16, %esp
; MINGW-NEXT:    subl $32, %esp
; MINGW-NEXT:    fldt 12(%ebp)
; MINGW-NEXT:    fstpt (%esp)
; MINGW-NEXT:    leal 8(%ebp), %eax
; MINGW-NEXT:    pushl %eax
; MINGW-NEXT:    calll _escape
; MINGW-NEXT:    addl $4, %esp
; MINGW-NEXT:    movl %esp, %eax
; MINGW-NEXT:    pushl %eax
; MINGW-NEXT:    calll _escape
; MINGW-NEXT:    addl $4, %esp
; MINGW-NEXT:    leal 24(%ebp), %eax
; MINGW-NEXT:    pushl %eax
; MINGW-NEXT:    calll _escape
; MINGW-NEXT:    addl $4, %esp
; MINGW-NEXT:    movl %ebp, %esp
; MINGW-NEXT:    popl %ebp
; MINGW-NEXT:    retl
;
; LINUX-LABEL: foo:
; LINUX:       # %bb.0:
; LINUX-NEXT:    subl $28, %esp
; LINUX-NEXT:    fldt 36(%esp)
; LINUX-NEXT:    fstpt 16(%esp)
; LINUX-NEXT:    leal 32(%esp), %eax
; LINUX-NEXT:    movl %eax, (%esp)
; LINUX-NEXT:    calll escape@PLT
; LINUX-NEXT:    leal 16(%esp), %eax
; LINUX-NEXT:    movl %eax, (%esp)
; LINUX-NEXT:    calll escape@PLT
; LINUX-NEXT:    leal 48(%esp), %eax
; LINUX-NEXT:    movl %eax, (%esp)
; LINUX-NEXT:    calll escape@PLT
; LINUX-NEXT:    addl $28, %esp
; LINUX-NEXT:    retl
;
; DARWIN-LABEL: foo:
; DARWIN:       ## %bb.0:
; DARWIN-NEXT:    subl $44, %esp
; DARWIN-NEXT:    fldt 64(%esp)
; DARWIN-NEXT:    fstpt 16(%esp)
; DARWIN-NEXT:    leal 48(%esp), %eax
; DARWIN-NEXT:    movl %eax, (%esp)
; DARWIN-NEXT:    calll _escape
; DARWIN-NEXT:    leal 16(%esp), %eax
; DARWIN-NEXT:    movl %eax, (%esp)
; DARWIN-NEXT:    calll _escape
; DARWIN-NEXT:    leal 80(%esp), %eax
; DARWIN-NEXT:    movl %eax, (%esp)
; DARWIN-NEXT:    calll _escape
; DARWIN-NEXT:    addl $44, %esp
; DARWIN-NEXT:    retl
  %4 = alloca i32, align 4
  %5 = alloca x86_fp80, align 16
  %6 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store x86_fp80 %1, x86_fp80* %5, align 16
  store i32 %2, i32* %6, align 4
  %7 = bitcast i32* %4 to i8*
  call void @escape(i8* nonnull %7)
  %8 = bitcast x86_fp80* %5 to i8*
  call void @escape(i8* nonnull %8)
  %9 = bitcast i32* %6 to i8*
  call void @escape(i8* nonnull %9)
  ret void
}

declare void @escape(i8*)

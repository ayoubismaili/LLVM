; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zbp -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64ZBP

declare i32 @llvm.riscv.grev.i32(i32 %a, i32 %b)

define signext i32 @grev32(i32 signext %a, i32 signext %b) nounwind {
; RV64ZBP-LABEL: grev32:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    grevw a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.grev.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

define signext i32 @grev32_demandedbits(i32 signext %a, i32 signext %b, i32 signext %c) nounwind {
; RV64ZBP-LABEL: grev32_demandedbits:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    add a0, a0, a1
; RV64ZBP-NEXT:    grevw a0, a0, a2
; RV64ZBP-NEXT:    ret
  %d = add i32 %a, %b
  %e = and i32 %c, 31
  %tmp = call i32 @llvm.riscv.grev.i32(i32 %d, i32 %e)
  ret i32 %tmp
}

declare i32 @llvm.riscv.grevi.i32(i32 %a)

define signext i32 @grevi32(i32 signext %a) nounwind {
; RV64ZBP-LABEL: grevi32:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    greviw a0, a0, 13
; RV64ZBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.grev.i32(i32 %a, i32 13)
 ret i32 %tmp
}

declare i32 @llvm.riscv.gorc.i32(i32 %a, i32 %b)

define signext i32 @gorc32(i32 signext %a, i32 signext %b) nounwind {
; RV64ZBP-LABEL: gorc32:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    gorcw a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.gorc.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

define signext i32 @gorc32_demandedbits(i32 signext %a, i32 signext %b, i32 signext %c) nounwind {
; RV64ZBP-LABEL: gorc32_demandedbits:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    add a0, a0, a1
; RV64ZBP-NEXT:    gorcw a0, a0, a2
; RV64ZBP-NEXT:    ret
  %d = add i32 %a, %b
  %e = and i32 %c, 31
  %tmp = call i32 @llvm.riscv.gorc.i32(i32 %d, i32 %e)
  ret i32 %tmp
}

define signext i32 @gorci32(i32 signext %a) nounwind {
; RV64ZBP-LABEL: gorci32:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    gorciw a0, a0, 13
; RV64ZBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.gorc.i32(i32 %a, i32 13)
 ret i32 %tmp
}

declare i32 @llvm.riscv.shfl.i32(i32 %a, i32 %b)

define signext i32 @shfl32(i32 signext %a, i32 signext %b) nounwind {
; RV64ZBP-LABEL: shfl32:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    shflw a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.shfl.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

define signext i32 @shfl32_demandedbits(i32 signext %a, i32 signext %b, i32 signext %c) nounwind {
; RV64ZBP-LABEL: shfl32_demandedbits:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    add a0, a0, a1
; RV64ZBP-NEXT:    shflw a0, a0, a2
; RV64ZBP-NEXT:    ret
  %d = add i32 %a, %b
  %e = and i32 %c, 15
  %tmp = call i32 @llvm.riscv.shfl.i32(i32 %d, i32 %e)
  ret i32 %tmp
}

define signext i32 @shfli32(i32 signext %a) nounwind {
; RV64ZBP-LABEL: shfli32:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    shfli a0, a0, 13
; RV64ZBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.shfl.i32(i32 %a, i32 13)
 ret i32 %tmp
}

declare i32 @llvm.riscv.unshfl.i32(i32 %a, i32 %b)

define signext i32 @unshfl32(i32 signext %a, i32 signext %b) nounwind {
; RV64ZBP-LABEL: unshfl32:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    unshflw a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.unshfl.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

define signext i32 @unshfl32_demandedbits(i32 signext %a, i32 signext %b, i32 signext %c) nounwind {
; RV64ZBP-LABEL: unshfl32_demandedbits:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    add a0, a0, a1
; RV64ZBP-NEXT:    unshflw a0, a0, a2
; RV64ZBP-NEXT:    ret
  %d = add i32 %a, %b
  %e = and i32 %c, 15
  %tmp = call i32 @llvm.riscv.unshfl.i32(i32 %d, i32 %e)
  ret i32 %tmp
}

define signext i32 @unshfli32(i32 signext %a) nounwind {
; RV64ZBP-LABEL: unshfli32:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    unshfli a0, a0, 13
; RV64ZBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.unshfl.i32(i32 %a, i32 13)
 ret i32 %tmp
}

declare i64 @llvm.riscv.grev.i64(i64 %a, i64 %b)

define i64 @grev64(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: grev64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    grev a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.grev.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

define i64 @grev64_demandedbits(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: grev64_demandedbits:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    grev a0, a0, a1
; RV64ZBP-NEXT:    ret
  %c = and i64 %b, 63
  %tmp = call i64 @llvm.riscv.grev.i64(i64 %a, i64 %c)
  ret i64 %tmp
}

define i64 @grevi64(i64 %a) nounwind {
; RV64ZBP-LABEL: grevi64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    grevi a0, a0, 13
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.grev.i64(i64 %a, i64 13)
 ret i64 %tmp
}

declare i64 @llvm.riscv.gorc.i64(i64 %a, i64 %b)

define i64 @gorc64(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: gorc64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    gorc a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.gorc.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

define i64 @gorc64_demandedbits(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: gorc64_demandedbits:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    gorc a0, a0, a1
; RV64ZBP-NEXT:    ret
  %c = and i64 %b, 63
  %tmp = call i64 @llvm.riscv.gorc.i64(i64 %a, i64 %c)
  ret i64 %tmp
}

declare i64 @llvm.riscv.gorci.i64(i64 %a)

define i64 @gorci64(i64 %a) nounwind {
; RV64ZBP-LABEL: gorci64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    gorci a0, a0, 13
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.gorc.i64(i64 %a, i64 13)
 ret i64 %tmp
}

declare i64 @llvm.riscv.shfl.i64(i64 %a, i64 %b)

define i64 @shfl64(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: shfl64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    shfl a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.shfl.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

define i64 @shfl64_demandedbits(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: shfl64_demandedbits:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    shfl a0, a0, a1
; RV64ZBP-NEXT:    ret
  %c = and i64 %b, 31
  %tmp = call i64 @llvm.riscv.shfl.i64(i64 %a, i64 %c)
  ret i64 %tmp
}

define i64 @shfli64(i64 %a) nounwind {
; RV64ZBP-LABEL: shfli64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    shfli a0, a0, 13
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.shfl.i64(i64 %a, i64 13)
 ret i64 %tmp
}

declare i64 @llvm.riscv.unshfl.i64(i64 %a, i64 %b)

define i64 @unshfl64(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: unshfl64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    unshfl a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.unshfl.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

define i64 @unshfl64_demandedbits(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: unshfl64_demandedbits:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    unshfl a0, a0, a1
; RV64ZBP-NEXT:    ret
  %c = and i64 %b, 31
  %tmp = call i64 @llvm.riscv.unshfl.i64(i64 %a, i64 %c)
  ret i64 %tmp
}

define i64 @unshfli64(i64 %a) nounwind {
; RV64ZBP-LABEL: unshfli64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    unshfli a0, a0, 13
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.unshfl.i64(i64 %a, i64 13)
 ret i64 %tmp
}

declare i64 @llvm.riscv.xperm.n.i64(i64 %a, i64 %b)

define i64 @xpermn64(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: xpermn64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    xperm.n a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.xperm.n.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

declare i64 @llvm.riscv.xperm.b.i64(i64 %a, i64 %b)

define i64 @xpermb64(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: xpermb64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    xperm.b a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.xperm.b.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

declare i64 @llvm.riscv.xperm.h.i64(i64 %a, i64 %b)

define i64 @xpermh64(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: xpermh64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    xperm.h a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.xperm.h.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

declare i64 @llvm.riscv.xperm.w.i64(i64 %a, i64 %b)

define i64 @xpermw64(i64 %a, i64 %b) nounwind {
; RV64ZBP-LABEL: xpermw64:
; RV64ZBP:       # %bb.0:
; RV64ZBP-NEXT:    xperm.w a0, a0, a1
; RV64ZBP-NEXT:    ret
  %tmp = call i64 @llvm.riscv.xperm.w.i64(i64 %a, i64 %b)
 ret i64 %tmp
}

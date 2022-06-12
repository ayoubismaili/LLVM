; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

; *Please* keep in sync with test/CodeGen/X86/extract-lowbits.ll

; https://bugs.llvm.org/show_bug.cgi?id=36419
; https://bugs.llvm.org/show_bug.cgi?id=37603
; https://bugs.llvm.org/show_bug.cgi?id=37610

; Patterns:
;   a) x &  (1 << nbits) - 1
;   b) x & ~(-1 << nbits)
;   c) x &  (-1 >> (32 - y))
;   d) x << (32 - y) >> (32 - y)
; are equivalent.

; ---------------------------------------------------------------------------- ;
; Pattern a. 32-bit
; ---------------------------------------------------------------------------- ;

define i32 @bzhi32_a0(i32 %val, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_a0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    lsl w8, w8, w1
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    and w0, w8, w0
; CHECK-NEXT:    ret
  %onebit = shl i32 1, %numlowbits
  %mask = add nsw i32 %onebit, -1
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_a1_indexzext(i32 %val, i8 zeroext %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_a1_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    lsl w8, w8, w1
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    and w0, w8, w0
; CHECK-NEXT:    ret
  %conv = zext i8 %numlowbits to i32
  %onebit = shl i32 1, %conv
  %mask = add nsw i32 %onebit, -1
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_a2_load(i32* %w, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_a2_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    ldr w9, [x0]
; CHECK-NEXT:    lsl w8, w8, w1
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    and w0, w8, w9
; CHECK-NEXT:    ret
  %val = load i32, i32* %w
  %onebit = shl i32 1, %numlowbits
  %mask = add nsw i32 %onebit, -1
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_a3_load_indexzext(i32* %w, i8 zeroext %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_a3_load_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    ldr w9, [x0]
; CHECK-NEXT:    lsl w8, w8, w1
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    and w0, w8, w9
; CHECK-NEXT:    ret
  %val = load i32, i32* %w
  %conv = zext i8 %numlowbits to i32
  %onebit = shl i32 1, %conv
  %mask = add nsw i32 %onebit, -1
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_a4_commutative(i32 %val, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_a4_commutative:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    lsl w8, w8, w1
; CHECK-NEXT:    sub w8, w8, #1
; CHECK-NEXT:    and w0, w0, w8
; CHECK-NEXT:    ret
  %onebit = shl i32 1, %numlowbits
  %mask = add nsw i32 %onebit, -1
  %masked = and i32 %val, %mask ; swapped order
  ret i32 %masked
}

; 64-bit

define i64 @bzhi64_a0(i64 %val, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_a0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    lsl x8, x8, x1
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    and x0, x8, x0
; CHECK-NEXT:    ret
  %onebit = shl i64 1, %numlowbits
  %mask = add nsw i64 %onebit, -1
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_a1_indexzext(i64 %val, i8 zeroext %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_a1_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    lsl x8, x8, x1
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    and x0, x8, x0
; CHECK-NEXT:    ret
  %conv = zext i8 %numlowbits to i64
  %onebit = shl i64 1, %conv
  %mask = add nsw i64 %onebit, -1
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_a2_load(i64* %w, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_a2_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    ldr x9, [x0]
; CHECK-NEXT:    lsl x8, x8, x1
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    and x0, x8, x9
; CHECK-NEXT:    ret
  %val = load i64, i64* %w
  %onebit = shl i64 1, %numlowbits
  %mask = add nsw i64 %onebit, -1
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_a3_load_indexzext(i64* %w, i8 zeroext %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_a3_load_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    ldr x9, [x0]
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    lsl x8, x8, x1
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    and x0, x8, x9
; CHECK-NEXT:    ret
  %val = load i64, i64* %w
  %conv = zext i8 %numlowbits to i64
  %onebit = shl i64 1, %conv
  %mask = add nsw i64 %onebit, -1
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_a4_commutative(i64 %val, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_a4_commutative:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    lsl x8, x8, x1
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    and x0, x0, x8
; CHECK-NEXT:    ret
  %onebit = shl i64 1, %numlowbits
  %mask = add nsw i64 %onebit, -1
  %masked = and i64 %val, %mask ; swapped order
  ret i64 %masked
}

; ---------------------------------------------------------------------------- ;
; Pattern b. 32-bit
; ---------------------------------------------------------------------------- ;

define i32 @bzhi32_b0(i32 %val, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_b0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1
; CHECK-NEXT:    lsl w8, w8, w1
; CHECK-NEXT:    bic w0, w0, w8
; CHECK-NEXT:    ret
  %notmask = shl i32 -1, %numlowbits
  %mask = xor i32 %notmask, -1
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_b1_indexzext(i32 %val, i8 zeroext %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_b1_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1
; CHECK-NEXT:    lsl w8, w8, w1
; CHECK-NEXT:    bic w0, w0, w8
; CHECK-NEXT:    ret
  %conv = zext i8 %numlowbits to i32
  %notmask = shl i32 -1, %conv
  %mask = xor i32 %notmask, -1
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_b2_load(i32* %w, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_b2_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    mov w9, #-1
; CHECK-NEXT:    lsl w9, w9, w1
; CHECK-NEXT:    bic w0, w8, w9
; CHECK-NEXT:    ret
  %val = load i32, i32* %w
  %notmask = shl i32 -1, %numlowbits
  %mask = xor i32 %notmask, -1
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_b3_load_indexzext(i32* %w, i8 zeroext %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_b3_load_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    mov w9, #-1
; CHECK-NEXT:    lsl w9, w9, w1
; CHECK-NEXT:    bic w0, w8, w9
; CHECK-NEXT:    ret
  %val = load i32, i32* %w
  %conv = zext i8 %numlowbits to i32
  %notmask = shl i32 -1, %conv
  %mask = xor i32 %notmask, -1
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_b4_commutative(i32 %val, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_b4_commutative:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1
; CHECK-NEXT:    lsl w8, w8, w1
; CHECK-NEXT:    bic w0, w0, w8
; CHECK-NEXT:    ret
  %notmask = shl i32 -1, %numlowbits
  %mask = xor i32 %notmask, -1
  %masked = and i32 %val, %mask ; swapped order
  ret i32 %masked
}

; 64-bit

define i64 @bzhi64_b0(i64 %val, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_b0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-1
; CHECK-NEXT:    lsl x8, x8, x1
; CHECK-NEXT:    bic x0, x0, x8
; CHECK-NEXT:    ret
  %notmask = shl i64 -1, %numlowbits
  %mask = xor i64 %notmask, -1
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_b1_indexzext(i64 %val, i8 zeroext %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_b1_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-1
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    lsl x8, x8, x1
; CHECK-NEXT:    bic x0, x0, x8
; CHECK-NEXT:    ret
  %conv = zext i8 %numlowbits to i64
  %notmask = shl i64 -1, %conv
  %mask = xor i64 %notmask, -1
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_b2_load(i64* %w, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_b2_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    mov x9, #-1
; CHECK-NEXT:    lsl x9, x9, x1
; CHECK-NEXT:    bic x0, x8, x9
; CHECK-NEXT:    ret
  %val = load i64, i64* %w
  %notmask = shl i64 -1, %numlowbits
  %mask = xor i64 %notmask, -1
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_b3_load_indexzext(i64* %w, i8 zeroext %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_b3_load_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    mov x9, #-1
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    lsl x9, x9, x1
; CHECK-NEXT:    bic x0, x8, x9
; CHECK-NEXT:    ret
  %val = load i64, i64* %w
  %conv = zext i8 %numlowbits to i64
  %notmask = shl i64 -1, %conv
  %mask = xor i64 %notmask, -1
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_b4_commutative(i64 %val, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_b4_commutative:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-1
; CHECK-NEXT:    lsl x8, x8, x1
; CHECK-NEXT:    bic x0, x0, x8
; CHECK-NEXT:    ret
  %notmask = shl i64 -1, %numlowbits
  %mask = xor i64 %notmask, -1
  %masked = and i64 %val, %mask ; swapped order
  ret i64 %masked
}

; ---------------------------------------------------------------------------- ;
; Pattern c. 32-bit
; ---------------------------------------------------------------------------- ;

define i32 @bzhi32_c0(i32 %val, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_c0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg w8, w1
; CHECK-NEXT:    mov w9, #-1
; CHECK-NEXT:    lsr w8, w9, w8
; CHECK-NEXT:    and w0, w8, w0
; CHECK-NEXT:    ret
  %numhighbits = sub i32 32, %numlowbits
  %mask = lshr i32 -1, %numhighbits
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_c1_indexzext(i32 %val, i8 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_c1_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32
; CHECK-NEXT:    mov w9, #-1
; CHECK-NEXT:    sub w8, w8, w1
; CHECK-NEXT:    lsr w8, w9, w8
; CHECK-NEXT:    and w0, w8, w0
; CHECK-NEXT:    ret
  %numhighbits = sub i8 32, %numlowbits
  %sh_prom = zext i8 %numhighbits to i32
  %mask = lshr i32 -1, %sh_prom
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_c2_load(i32* %w, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_c2_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg w8, w1
; CHECK-NEXT:    ldr w9, [x0]
; CHECK-NEXT:    mov w10, #-1
; CHECK-NEXT:    lsr w8, w10, w8
; CHECK-NEXT:    and w0, w8, w9
; CHECK-NEXT:    ret
  %val = load i32, i32* %w
  %numhighbits = sub i32 32, %numlowbits
  %mask = lshr i32 -1, %numhighbits
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_c3_load_indexzext(i32* %w, i8 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_c3_load_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32
; CHECK-NEXT:    ldr w9, [x0]
; CHECK-NEXT:    sub w8, w8, w1
; CHECK-NEXT:    mov w10, #-1
; CHECK-NEXT:    lsr w8, w10, w8
; CHECK-NEXT:    and w0, w8, w9
; CHECK-NEXT:    ret
  %val = load i32, i32* %w
  %numhighbits = sub i8 32, %numlowbits
  %sh_prom = zext i8 %numhighbits to i32
  %mask = lshr i32 -1, %sh_prom
  %masked = and i32 %mask, %val
  ret i32 %masked
}

define i32 @bzhi32_c4_commutative(i32 %val, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_c4_commutative:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg w8, w1
; CHECK-NEXT:    mov w9, #-1
; CHECK-NEXT:    lsr w8, w9, w8
; CHECK-NEXT:    and w0, w0, w8
; CHECK-NEXT:    ret
  %numhighbits = sub i32 32, %numlowbits
  %mask = lshr i32 -1, %numhighbits
  %masked = and i32 %val, %mask ; swapped order
  ret i32 %masked
}

; 64-bit

define i64 @bzhi64_c0(i64 %val, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_c0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg x8, x1
; CHECK-NEXT:    mov x9, #-1
; CHECK-NEXT:    lsr x8, x9, x8
; CHECK-NEXT:    and x0, x8, x0
; CHECK-NEXT:    ret
  %numhighbits = sub i64 64, %numlowbits
  %mask = lshr i64 -1, %numhighbits
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_c1_indexzext(i64 %val, i8 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_c1_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #64
; CHECK-NEXT:    mov x9, #-1
; CHECK-NEXT:    sub w8, w8, w1
; CHECK-NEXT:    lsr x8, x9, x8
; CHECK-NEXT:    and x0, x8, x0
; CHECK-NEXT:    ret
  %numhighbits = sub i8 64, %numlowbits
  %sh_prom = zext i8 %numhighbits to i64
  %mask = lshr i64 -1, %sh_prom
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_c2_load(i64* %w, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_c2_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg x8, x1
; CHECK-NEXT:    ldr x9, [x0]
; CHECK-NEXT:    mov x10, #-1
; CHECK-NEXT:    lsr x8, x10, x8
; CHECK-NEXT:    and x0, x8, x9
; CHECK-NEXT:    ret
  %val = load i64, i64* %w
  %numhighbits = sub i64 64, %numlowbits
  %mask = lshr i64 -1, %numhighbits
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_c3_load_indexzext(i64* %w, i8 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_c3_load_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #64
; CHECK-NEXT:    ldr x9, [x0]
; CHECK-NEXT:    sub w8, w8, w1
; CHECK-NEXT:    mov x10, #-1
; CHECK-NEXT:    lsr x8, x10, x8
; CHECK-NEXT:    and x0, x8, x9
; CHECK-NEXT:    ret
  %val = load i64, i64* %w
  %numhighbits = sub i8 64, %numlowbits
  %sh_prom = zext i8 %numhighbits to i64
  %mask = lshr i64 -1, %sh_prom
  %masked = and i64 %mask, %val
  ret i64 %masked
}

define i64 @bzhi64_c4_commutative(i64 %val, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_c4_commutative:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg x8, x1
; CHECK-NEXT:    mov x9, #-1
; CHECK-NEXT:    lsr x8, x9, x8
; CHECK-NEXT:    and x0, x0, x8
; CHECK-NEXT:    ret
  %numhighbits = sub i64 64, %numlowbits
  %mask = lshr i64 -1, %numhighbits
  %masked = and i64 %val, %mask ; swapped order
  ret i64 %masked
}

; ---------------------------------------------------------------------------- ;
; Pattern d. 32-bit.
; ---------------------------------------------------------------------------- ;

define i32 @bzhi32_d0(i32 %val, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_d0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg w8, w1
; CHECK-NEXT:    lsl w9, w0, w8
; CHECK-NEXT:    lsr w0, w9, w8
; CHECK-NEXT:    ret
  %numhighbits = sub i32 32, %numlowbits
  %highbitscleared = shl i32 %val, %numhighbits
  %masked = lshr i32 %highbitscleared, %numhighbits
  ret i32 %masked
}

define i32 @bzhi32_d1_indexzext(i32 %val, i8 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_d1_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32
; CHECK-NEXT:    sub w8, w8, w1
; CHECK-NEXT:    lsl w9, w0, w8
; CHECK-NEXT:    lsr w0, w9, w8
; CHECK-NEXT:    ret
  %numhighbits = sub i8 32, %numlowbits
  %sh_prom = zext i8 %numhighbits to i32
  %highbitscleared = shl i32 %val, %sh_prom
  %masked = lshr i32 %highbitscleared, %sh_prom
  ret i32 %masked
}

define i32 @bzhi32_d2_load(i32* %w, i32 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_d2_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg w8, w1
; CHECK-NEXT:    ldr w9, [x0]
; CHECK-NEXT:    lsl w9, w9, w8
; CHECK-NEXT:    lsr w0, w9, w8
; CHECK-NEXT:    ret
  %val = load i32, i32* %w
  %numhighbits = sub i32 32, %numlowbits
  %highbitscleared = shl i32 %val, %numhighbits
  %masked = lshr i32 %highbitscleared, %numhighbits
  ret i32 %masked
}

define i32 @bzhi32_d3_load_indexzext(i32* %w, i8 %numlowbits) nounwind {
; CHECK-LABEL: bzhi32_d3_load_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32
; CHECK-NEXT:    ldr w9, [x0]
; CHECK-NEXT:    sub w8, w8, w1
; CHECK-NEXT:    lsl w9, w9, w8
; CHECK-NEXT:    lsr w0, w9, w8
; CHECK-NEXT:    ret
  %val = load i32, i32* %w
  %numhighbits = sub i8 32, %numlowbits
  %sh_prom = zext i8 %numhighbits to i32
  %highbitscleared = shl i32 %val, %sh_prom
  %masked = lshr i32 %highbitscleared, %sh_prom
  ret i32 %masked
}

; 64-bit.

define i64 @bzhi64_d0(i64 %val, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_d0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg x8, x1
; CHECK-NEXT:    lsl x9, x0, x8
; CHECK-NEXT:    lsr x0, x9, x8
; CHECK-NEXT:    ret
  %numhighbits = sub i64 64, %numlowbits
  %highbitscleared = shl i64 %val, %numhighbits
  %masked = lshr i64 %highbitscleared, %numhighbits
  ret i64 %masked
}

define i64 @bzhi64_d1_indexzext(i64 %val, i8 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_d1_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #64
; CHECK-NEXT:    sub w8, w8, w1
; CHECK-NEXT:    lsl x9, x0, x8
; CHECK-NEXT:    lsr x0, x9, x8
; CHECK-NEXT:    ret
  %numhighbits = sub i8 64, %numlowbits
  %sh_prom = zext i8 %numhighbits to i64
  %highbitscleared = shl i64 %val, %sh_prom
  %masked = lshr i64 %highbitscleared, %sh_prom
  ret i64 %masked
}

define i64 @bzhi64_d2_load(i64* %w, i64 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_d2_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg x8, x1
; CHECK-NEXT:    ldr x9, [x0]
; CHECK-NEXT:    lsl x9, x9, x8
; CHECK-NEXT:    lsr x0, x9, x8
; CHECK-NEXT:    ret
  %val = load i64, i64* %w
  %numhighbits = sub i64 64, %numlowbits
  %highbitscleared = shl i64 %val, %numhighbits
  %masked = lshr i64 %highbitscleared, %numhighbits
  ret i64 %masked
}

define i64 @bzhi64_d3_load_indexzext(i64* %w, i8 %numlowbits) nounwind {
; CHECK-LABEL: bzhi64_d3_load_indexzext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #64
; CHECK-NEXT:    ldr x9, [x0]
; CHECK-NEXT:    sub w8, w8, w1
; CHECK-NEXT:    lsl x9, x9, x8
; CHECK-NEXT:    lsr x0, x9, x8
; CHECK-NEXT:    ret
  %val = load i64, i64* %w
  %numhighbits = sub i8 64, %numlowbits
  %sh_prom = zext i8 %numhighbits to i64
  %highbitscleared = shl i64 %val, %sh_prom
  %masked = lshr i64 %highbitscleared, %sh_prom
  ret i64 %masked
}

; ---------------------------------------------------------------------------- ;
; Constant mask
; ---------------------------------------------------------------------------- ;

; 32-bit

define i32 @bzhi32_constant_mask32(i32 %val) nounwind {
; CHECK-LABEL: bzhi32_constant_mask32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x7fffffff
; CHECK-NEXT:    ret
  %masked = and i32 %val, 2147483647
  ret i32 %masked
}

define i32 @bzhi32_constant_mask32_load(i32* %val) nounwind {
; CHECK-LABEL: bzhi32_constant_mask32_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    and w0, w8, #0x7fffffff
; CHECK-NEXT:    ret
  %val1 = load i32, i32* %val
  %masked = and i32 %val1, 2147483647
  ret i32 %masked
}

define i32 @bzhi32_constant_mask16(i32 %val) nounwind {
; CHECK-LABEL: bzhi32_constant_mask16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x7fff
; CHECK-NEXT:    ret
  %masked = and i32 %val, 32767
  ret i32 %masked
}

define i32 @bzhi32_constant_mask16_load(i32* %val) nounwind {
; CHECK-LABEL: bzhi32_constant_mask16_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    and w0, w8, #0x7fff
; CHECK-NEXT:    ret
  %val1 = load i32, i32* %val
  %masked = and i32 %val1, 32767
  ret i32 %masked
}

define i32 @bzhi32_constant_mask8(i32 %val) nounwind {
; CHECK-LABEL: bzhi32_constant_mask8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x7f
; CHECK-NEXT:    ret
  %masked = and i32 %val, 127
  ret i32 %masked
}

define i32 @bzhi32_constant_mask8_load(i32* %val) nounwind {
; CHECK-LABEL: bzhi32_constant_mask8_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    and w0, w8, #0x7f
; CHECK-NEXT:    ret
  %val1 = load i32, i32* %val
  %masked = and i32 %val1, 127
  ret i32 %masked
}

; 64-bit

define i64 @bzhi64_constant_mask64(i64 %val) nounwind {
; CHECK-LABEL: bzhi64_constant_mask64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and x0, x0, #0x3fffffffffffffff
; CHECK-NEXT:    ret
  %masked = and i64 %val, 4611686018427387903
  ret i64 %masked
}

define i64 @bzhi64_constant_mask64_load(i64* %val) nounwind {
; CHECK-LABEL: bzhi64_constant_mask64_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    and x0, x8, #0x3fffffffffffffff
; CHECK-NEXT:    ret
  %val1 = load i64, i64* %val
  %masked = and i64 %val1, 4611686018427387903
  ret i64 %masked
}

define i64 @bzhi64_constant_mask32(i64 %val) nounwind {
; CHECK-LABEL: bzhi64_constant_mask32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and x0, x0, #0x7fffffff
; CHECK-NEXT:    ret
  %masked = and i64 %val, 2147483647
  ret i64 %masked
}

define i64 @bzhi64_constant_mask32_load(i64* %val) nounwind {
; CHECK-LABEL: bzhi64_constant_mask32_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    and x0, x8, #0x7fffffff
; CHECK-NEXT:    ret
  %val1 = load i64, i64* %val
  %masked = and i64 %val1, 2147483647
  ret i64 %masked
}

define i64 @bzhi64_constant_mask16(i64 %val) nounwind {
; CHECK-LABEL: bzhi64_constant_mask16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and x0, x0, #0x7fff
; CHECK-NEXT:    ret
  %masked = and i64 %val, 32767
  ret i64 %masked
}

define i64 @bzhi64_constant_mask16_load(i64* %val) nounwind {
; CHECK-LABEL: bzhi64_constant_mask16_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    and x0, x8, #0x7fff
; CHECK-NEXT:    ret
  %val1 = load i64, i64* %val
  %masked = and i64 %val1, 32767
  ret i64 %masked
}

define i64 @bzhi64_constant_mask8(i64 %val) nounwind {
; CHECK-LABEL: bzhi64_constant_mask8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and x0, x0, #0x7f
; CHECK-NEXT:    ret
  %masked = and i64 %val, 127
  ret i64 %masked
}

define i64 @bzhi64_constant_mask8_load(i64* %val) nounwind {
; CHECK-LABEL: bzhi64_constant_mask8_load:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    and x0, x8, #0x7f
; CHECK-NEXT:    ret
  %val1 = load i64, i64* %val
  %masked = and i64 %val1, 127
  ret i64 %masked
}

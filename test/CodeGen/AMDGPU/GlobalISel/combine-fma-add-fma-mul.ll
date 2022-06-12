; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx900 -fp-contract=fast < %s | FileCheck -check-prefix=GFX9-CONTRACT %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx900 --denormal-fp-math=preserve-sign < %s | FileCheck -check-prefix=GFX9-DENORM %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1010 -fp-contract=fast < %s | FileCheck -check-prefix=GFX10-CONTRACT %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1010 --denormal-fp-math=preserve-sign < %s | FileCheck -check-prefix=GFX10-DENORM %s

; fadd (fma a, b, (fmul c, d)), e --> fma a, b, (fma c, d, e)
; fadd e, (fma a, b, (fmul c, d)) --> fma a, b, (fma c, d, e)

define float @test_f32_add_mul(float %a, float %b, float %c, float %d, float %e) {
; GFX9-CONTRACT-LABEL: test_f32_add_mul:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f32 v2, v2, v3, v4
; GFX9-CONTRACT-NEXT:    v_fma_f32 v0, v0, v1, v2
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_f32_add_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_mad_f32 v2, v2, v3, v4
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v2, v0, v1
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v0, v2
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_f32_add_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_fma_f32 v2, v2, v3, v4
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v2, v0, v1
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_f32_add_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_fma_f32 v2, v2, v3, v4
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v2, v0, v1
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast float %c, %d
  %y = call fast float @llvm.fmuladd.f32(float %a, float %b, float %x)
  %z = fadd fast float %y, %e
  ret float %z
}

define float @test_f32_add_mul_rhs(float %a, float %b, float %c, float %d, float %e) {
; GFX9-CONTRACT-LABEL: test_f32_add_mul_rhs:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f32 v2, v2, v3, v4
; GFX9-CONTRACT-NEXT:    v_fma_f32 v0, v0, v1, v2
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_f32_add_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_mad_f32 v2, v2, v3, v4
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v2, v0, v1
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v0, v2
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_f32_add_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_fma_f32 v2, v2, v3, v4
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v2, v0, v1
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_f32_add_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_fma_f32 v2, v2, v3, v4
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v2, v0, v1
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast float %c, %d
  %y = call fast float @llvm.fmuladd.f32(float %a, float %b, float %x)
  %z = fadd fast float %e, %y
  ret float %z
}

define half @test_half_add_mul(half %a, half %b, half %c, half %d, half %e) {
; GFX9-CONTRACT-LABEL: test_half_add_mul:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f16 v2, v2, v3, v4
; GFX9-CONTRACT-NEXT:    v_fma_f16 v0, v0, v1, v2
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_half_add_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_mad_legacy_f16 v2, v2, v3, v4
; GFX9-DENORM-NEXT:    v_mac_f16_e32 v2, v0, v1
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v0, v2
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_half_add_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_fma_f16 v2, v2, v3, v4
; GFX10-CONTRACT-NEXT:    v_fmac_f16_e32 v2, v0, v1
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_half_add_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v2, v2, v3
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v0, v0, v1
; GFX10-DENORM-NEXT:    v_add_f16_e32 v0, v0, v2
; GFX10-DENORM-NEXT:    v_add_f16_e32 v0, v0, v4
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast half %c, %d
  %y = call fast half @llvm.fmuladd.f16(half %a, half %b, half %x)
  %z = fadd fast half %y, %e
  ret half %z
}

define half @test_half_add_mul_rhs(half %a, half %b, half %c, half %d, half %e) {
; GFX9-CONTRACT-LABEL: test_half_add_mul_rhs:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f16 v2, v2, v3, v4
; GFX9-CONTRACT-NEXT:    v_fma_f16 v0, v0, v1, v2
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_half_add_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_mad_legacy_f16 v2, v2, v3, v4
; GFX9-DENORM-NEXT:    v_mac_f16_e32 v2, v0, v1
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v0, v2
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_half_add_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_fma_f16 v2, v2, v3, v4
; GFX10-CONTRACT-NEXT:    v_fmac_f16_e32 v2, v0, v1
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_half_add_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v2, v2, v3
; GFX10-DENORM-NEXT:    v_mul_f16_e32 v0, v0, v1
; GFX10-DENORM-NEXT:    v_add_f16_e32 v0, v0, v2
; GFX10-DENORM-NEXT:    v_add_f16_e32 v0, v4, v0
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast half %c, %d
  %y = call fast half @llvm.fmuladd.f16(half %a, half %b, half %x)
  %z = fadd fast half %e, %y
  ret half %z
}

define double @test_double_add_mul(double %a, double %b, double %c, double %d, double %e) {
; GFX9-CONTRACT-LABEL: test_double_add_mul:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[4:5], v[4:5], v[6:7], v[8:9]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_double_add_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_fma_f64 v[4:5], v[4:5], v[6:7], v[8:9]
; GFX9-DENORM-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_double_add_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[4:5], v[4:5], v[6:7], v[8:9]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_double_add_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_fma_f64 v[4:5], v[4:5], v[6:7], v[8:9]
; GFX10-DENORM-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast double %c, %d
  %y = call fast double @llvm.fmuladd.f64(double %a, double %b, double %x)
  %z = fadd fast double %y, %e
  ret double %z
}

define double @test_double_add_mul_rhs(double %a, double %b, double %c, double %d, double %e) {
; GFX9-CONTRACT-LABEL: test_double_add_mul_rhs:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[4:5], v[4:5], v[6:7], v[8:9]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_double_add_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_fma_f64 v[4:5], v[4:5], v[6:7], v[8:9]
; GFX9-DENORM-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_double_add_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[4:5], v[4:5], v[6:7], v[8:9]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_double_add_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_fma_f64 v[4:5], v[4:5], v[6:7], v[8:9]
; GFX10-DENORM-NEXT:    v_fma_f64 v[0:1], v[0:1], v[2:3], v[4:5]
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast double %c, %d
  %y = call fast double @llvm.fmuladd.f64(double %a, double %b, double %x)
  %z = fadd fast double %e, %y
  ret double %z
}

define <4 x float> @test_v4f32_add_mul(<4 x float> %a, <4 x float> %b, <4 x float> %c, <4 x float> %d, <4 x float> %e) {
; GFX9-CONTRACT-LABEL: test_v4f32_add_mul:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f32 v8, v8, v12, v16
; GFX9-CONTRACT-NEXT:    v_fma_f32 v9, v9, v13, v17
; GFX9-CONTRACT-NEXT:    v_fma_f32 v10, v10, v14, v18
; GFX9-CONTRACT-NEXT:    v_fma_f32 v11, v11, v15, v19
; GFX9-CONTRACT-NEXT:    v_fma_f32 v0, v0, v4, v8
; GFX9-CONTRACT-NEXT:    v_fma_f32 v1, v1, v5, v9
; GFX9-CONTRACT-NEXT:    v_fma_f32 v2, v2, v6, v10
; GFX9-CONTRACT-NEXT:    v_fma_f32 v3, v3, v7, v11
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_v4f32_add_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_mad_f32 v8, v8, v12, v16
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v8, v0, v4
; GFX9-DENORM-NEXT:    v_mad_f32 v4, v9, v13, v17
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v4, v1, v5
; GFX9-DENORM-NEXT:    v_mad_f32 v5, v10, v14, v18
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v5, v2, v6
; GFX9-DENORM-NEXT:    v_mad_f32 v6, v11, v15, v19
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v6, v3, v7
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v0, v8
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v1, v4
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v2, v5
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v3, v6
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_v4f32_add_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_fma_f32 v8, v8, v12, v16
; GFX10-CONTRACT-NEXT:    v_fma_f32 v9, v9, v13, v17
; GFX10-CONTRACT-NEXT:    v_fma_f32 v10, v10, v14, v18
; GFX10-CONTRACT-NEXT:    v_fma_f32 v11, v11, v15, v19
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v8, v0, v4
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v9, v1, v5
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v10, v2, v6
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v11, v3, v7
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v0, v8
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v1, v9
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v2, v10
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v3, v11
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_v4f32_add_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_fma_f32 v8, v8, v12, v16
; GFX10-DENORM-NEXT:    v_fma_f32 v9, v9, v13, v17
; GFX10-DENORM-NEXT:    v_fma_f32 v10, v10, v14, v18
; GFX10-DENORM-NEXT:    v_fma_f32 v11, v11, v15, v19
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v8, v0, v4
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v9, v1, v5
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v10, v2, v6
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v11, v3, v7
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v0, v8
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v1, v9
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v2, v10
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v3, v11
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast <4 x float> %c, %d
  %y = call fast <4 x float> @llvm.fmuladd.v4f32(<4 x float> %a, <4 x float> %b, <4 x float> %x)
  %z = fadd fast <4 x float> %y, %e
  ret <4 x float> %z
}

define <4 x float> @test_v4f32_add_mul_rhs(<4 x float> %a, <4 x float> %b, <4 x float> %c, <4 x float> %d, <4 x float> %e) {
; GFX9-CONTRACT-LABEL: test_v4f32_add_mul_rhs:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f32 v8, v8, v12, v16
; GFX9-CONTRACT-NEXT:    v_fma_f32 v9, v9, v13, v17
; GFX9-CONTRACT-NEXT:    v_fma_f32 v10, v10, v14, v18
; GFX9-CONTRACT-NEXT:    v_fma_f32 v11, v11, v15, v19
; GFX9-CONTRACT-NEXT:    v_fma_f32 v0, v0, v4, v8
; GFX9-CONTRACT-NEXT:    v_fma_f32 v1, v1, v5, v9
; GFX9-CONTRACT-NEXT:    v_fma_f32 v2, v2, v6, v10
; GFX9-CONTRACT-NEXT:    v_fma_f32 v3, v3, v7, v11
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_v4f32_add_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_mad_f32 v8, v8, v12, v16
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v8, v0, v4
; GFX9-DENORM-NEXT:    v_mad_f32 v4, v9, v13, v17
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v4, v1, v5
; GFX9-DENORM-NEXT:    v_mad_f32 v5, v10, v14, v18
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v5, v2, v6
; GFX9-DENORM-NEXT:    v_mad_f32 v6, v11, v15, v19
; GFX9-DENORM-NEXT:    v_mac_f32_e32 v6, v3, v7
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v0, v8
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v1, v4
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v2, v5
; GFX9-DENORM-NEXT:    v_mov_b32_e32 v3, v6
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_v4f32_add_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_fma_f32 v8, v8, v12, v16
; GFX10-CONTRACT-NEXT:    v_fma_f32 v9, v9, v13, v17
; GFX10-CONTRACT-NEXT:    v_fma_f32 v10, v10, v14, v18
; GFX10-CONTRACT-NEXT:    v_fma_f32 v11, v11, v15, v19
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v8, v0, v4
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v9, v1, v5
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v10, v2, v6
; GFX10-CONTRACT-NEXT:    v_fmac_f32_e32 v11, v3, v7
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v0, v8
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v1, v9
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v2, v10
; GFX10-CONTRACT-NEXT:    v_mov_b32_e32 v3, v11
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_v4f32_add_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_fma_f32 v8, v8, v12, v16
; GFX10-DENORM-NEXT:    v_fma_f32 v9, v9, v13, v17
; GFX10-DENORM-NEXT:    v_fma_f32 v10, v10, v14, v18
; GFX10-DENORM-NEXT:    v_fma_f32 v11, v11, v15, v19
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v8, v0, v4
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v9, v1, v5
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v10, v2, v6
; GFX10-DENORM-NEXT:    v_fmac_f32_e32 v11, v3, v7
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v0, v8
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v1, v9
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v2, v10
; GFX10-DENORM-NEXT:    v_mov_b32_e32 v3, v11
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast <4 x float> %c, %d
  %y = call fast <4 x float> @llvm.fmuladd.v4f32(<4 x float> %a, <4 x float> %b, <4 x float> %x)
  %z = fadd fast <4 x float> %e, %y
  ret <4 x float> %z
}

define <4 x half> @test_f16_add_mul(<4 x half> %a, <4 x half> %b, <4 x half> %c, <4 x half> %d, <4 x half> %e) {
; GFX9-CONTRACT-LABEL: test_f16_add_mul:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_pk_fma_f16 v4, v4, v6, v8
; GFX9-CONTRACT-NEXT:    v_pk_fma_f16 v5, v5, v7, v9
; GFX9-CONTRACT-NEXT:    v_pk_fma_f16 v0, v0, v2, v4
; GFX9-CONTRACT-NEXT:    v_pk_fma_f16 v1, v1, v3, v5
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_f16_add_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v4, v4, v6
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v5, v5, v7
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v0, v0, v2
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v1, v1, v3
; GFX9-DENORM-NEXT:    v_pk_add_f16 v0, v0, v4
; GFX9-DENORM-NEXT:    v_pk_add_f16 v1, v1, v5
; GFX9-DENORM-NEXT:    v_pk_add_f16 v0, v0, v8
; GFX9-DENORM-NEXT:    v_pk_add_f16 v1, v1, v9
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_f16_add_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v4, v4, v6, v8
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v5, v5, v7, v9
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v0, v0, v2, v4
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v1, v1, v3, v5
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_f16_add_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v4, v4, v6
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v5, v5, v7
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v0, v0, v2
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v1, v1, v3
; GFX10-DENORM-NEXT:    v_pk_add_f16 v0, v0, v4
; GFX10-DENORM-NEXT:    v_pk_add_f16 v1, v1, v5
; GFX10-DENORM-NEXT:    v_pk_add_f16 v0, v0, v8
; GFX10-DENORM-NEXT:    v_pk_add_f16 v1, v1, v9
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast <4 x half> %c, %d
  %y = call fast <4 x half> @llvm.fmuladd.v4f16(<4 x half> %a, <4 x half> %b, <4 x half> %x)
  %z = fadd fast <4 x half> %y, %e
  ret <4 x half> %z
}

define <4 x half> @test_f16_add_mul_rhs(<4 x half> %a, <4 x half> %b, <4 x half> %c, <4 x half> %d, <4 x half> %e) {
; GFX9-CONTRACT-LABEL: test_f16_add_mul_rhs:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    v_pk_fma_f16 v4, v4, v6, v8
; GFX9-CONTRACT-NEXT:    v_pk_fma_f16 v5, v5, v7, v9
; GFX9-CONTRACT-NEXT:    v_pk_fma_f16 v0, v0, v2, v4
; GFX9-CONTRACT-NEXT:    v_pk_fma_f16 v1, v1, v3, v5
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_f16_add_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v4, v4, v6
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v5, v5, v7
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v0, v0, v2
; GFX9-DENORM-NEXT:    v_pk_mul_f16 v1, v1, v3
; GFX9-DENORM-NEXT:    v_pk_add_f16 v0, v0, v4
; GFX9-DENORM-NEXT:    v_pk_add_f16 v1, v1, v5
; GFX9-DENORM-NEXT:    v_pk_add_f16 v0, v8, v0
; GFX9-DENORM-NEXT:    v_pk_add_f16 v1, v9, v1
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_f16_add_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v4, v4, v6, v8
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v5, v5, v7, v9
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v0, v0, v2, v4
; GFX10-CONTRACT-NEXT:    v_pk_fma_f16 v1, v1, v3, v5
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_f16_add_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v4, v4, v6
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v5, v5, v7
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v0, v0, v2
; GFX10-DENORM-NEXT:    v_pk_mul_f16 v1, v1, v3
; GFX10-DENORM-NEXT:    v_pk_add_f16 v0, v0, v4
; GFX10-DENORM-NEXT:    v_pk_add_f16 v1, v1, v5
; GFX10-DENORM-NEXT:    v_pk_add_f16 v0, v8, v0
; GFX10-DENORM-NEXT:    v_pk_add_f16 v1, v9, v1
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast <4 x half> %c, %d
  %y = call fast <4 x half> @llvm.fmuladd.v4f16(<4 x half> %a, <4 x half> %b, <4 x half> %x)
  %z = fadd fast <4 x half> %e, %y
  ret <4 x half> %z
}

define <4 x double> @test_f64_add_mul(<4 x double> %a, <4 x double> %b, <4 x double> %c, <4 x double> %d, <4 x double> %e) {
; GFX9-CONTRACT-LABEL: test_f64_add_mul:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    buffer_load_dword v31, off, s[0:3], s32 offset:4
; GFX9-CONTRACT-NEXT:    buffer_load_dword v32, off, s[0:3], s32 offset:8
; GFX9-CONTRACT-NEXT:    buffer_load_dword v33, off, s[0:3], s32 offset:12
; GFX9-CONTRACT-NEXT:    buffer_load_dword v34, off, s[0:3], s32 offset:16
; GFX9-CONTRACT-NEXT:    buffer_load_dword v35, off, s[0:3], s32 offset:20
; GFX9-CONTRACT-NEXT:    buffer_load_dword v36, off, s[0:3], s32 offset:24
; GFX9-CONTRACT-NEXT:    buffer_load_dword v37, off, s[0:3], s32 offset:28
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(5)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[16:17], v[16:17], v[24:25], v[31:32]
; GFX9-CONTRACT-NEXT:    buffer_load_dword v31, off, s[0:3], s32
; GFX9-CONTRACT-NEXT:    buffer_load_dword v38, off, s[0:3], s32 offset:32
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(5)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[18:19], v[18:19], v[26:27], v[33:34]
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(3)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[20:21], v[20:21], v[28:29], v[35:36]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[22:23], v[22:23], v[30:31], v[37:38]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_f64_add_mul:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    buffer_load_dword v31, off, s[0:3], s32 offset:4
; GFX9-DENORM-NEXT:    buffer_load_dword v32, off, s[0:3], s32 offset:8
; GFX9-DENORM-NEXT:    buffer_load_dword v33, off, s[0:3], s32 offset:12
; GFX9-DENORM-NEXT:    buffer_load_dword v34, off, s[0:3], s32 offset:16
; GFX9-DENORM-NEXT:    buffer_load_dword v35, off, s[0:3], s32 offset:20
; GFX9-DENORM-NEXT:    buffer_load_dword v36, off, s[0:3], s32 offset:24
; GFX9-DENORM-NEXT:    buffer_load_dword v37, off, s[0:3], s32 offset:28
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(5)
; GFX9-DENORM-NEXT:    v_fma_f64 v[16:17], v[16:17], v[24:25], v[31:32]
; GFX9-DENORM-NEXT:    buffer_load_dword v31, off, s[0:3], s32
; GFX9-DENORM-NEXT:    buffer_load_dword v38, off, s[0:3], s32 offset:32
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(5)
; GFX9-DENORM-NEXT:    v_fma_f64 v[18:19], v[18:19], v[26:27], v[33:34]
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(3)
; GFX9-DENORM-NEXT:    v_fma_f64 v[20:21], v[20:21], v[28:29], v[35:36]
; GFX9-DENORM-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX9-DENORM-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX9-DENORM-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0)
; GFX9-DENORM-NEXT:    v_fma_f64 v[22:23], v[22:23], v[30:31], v[37:38]
; GFX9-DENORM-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_f64_add_mul:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    s_clause 0x8
; GFX10-CONTRACT-NEXT:    buffer_load_dword v31, off, s[0:3], s32
; GFX10-CONTRACT-NEXT:    buffer_load_dword v32, off, s[0:3], s32 offset:4
; GFX10-CONTRACT-NEXT:    buffer_load_dword v33, off, s[0:3], s32 offset:8
; GFX10-CONTRACT-NEXT:    buffer_load_dword v34, off, s[0:3], s32 offset:12
; GFX10-CONTRACT-NEXT:    buffer_load_dword v35, off, s[0:3], s32 offset:16
; GFX10-CONTRACT-NEXT:    buffer_load_dword v36, off, s[0:3], s32 offset:20
; GFX10-CONTRACT-NEXT:    buffer_load_dword v37, off, s[0:3], s32 offset:24
; GFX10-CONTRACT-NEXT:    buffer_load_dword v38, off, s[0:3], s32 offset:28
; GFX10-CONTRACT-NEXT:    buffer_load_dword v39, off, s[0:3], s32 offset:32
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(6)
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[16:17], v[16:17], v[24:25], v[32:33]
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(4)
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[18:19], v[18:19], v[26:27], v[34:35]
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(2)
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[20:21], v[20:21], v[28:29], v[36:37]
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0)
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[22:23], v[22:23], v[30:31], v[38:39]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_f64_add_mul:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    s_clause 0x8
; GFX10-DENORM-NEXT:    buffer_load_dword v31, off, s[0:3], s32
; GFX10-DENORM-NEXT:    buffer_load_dword v32, off, s[0:3], s32 offset:4
; GFX10-DENORM-NEXT:    buffer_load_dword v33, off, s[0:3], s32 offset:8
; GFX10-DENORM-NEXT:    buffer_load_dword v34, off, s[0:3], s32 offset:12
; GFX10-DENORM-NEXT:    buffer_load_dword v35, off, s[0:3], s32 offset:16
; GFX10-DENORM-NEXT:    buffer_load_dword v36, off, s[0:3], s32 offset:20
; GFX10-DENORM-NEXT:    buffer_load_dword v37, off, s[0:3], s32 offset:24
; GFX10-DENORM-NEXT:    buffer_load_dword v38, off, s[0:3], s32 offset:28
; GFX10-DENORM-NEXT:    buffer_load_dword v39, off, s[0:3], s32 offset:32
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(6)
; GFX10-DENORM-NEXT:    v_fma_f64 v[16:17], v[16:17], v[24:25], v[32:33]
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(4)
; GFX10-DENORM-NEXT:    v_fma_f64 v[18:19], v[18:19], v[26:27], v[34:35]
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(2)
; GFX10-DENORM-NEXT:    v_fma_f64 v[20:21], v[20:21], v[28:29], v[36:37]
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0)
; GFX10-DENORM-NEXT:    v_fma_f64 v[22:23], v[22:23], v[30:31], v[38:39]
; GFX10-DENORM-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX10-DENORM-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX10-DENORM-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX10-DENORM-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast <4 x double> %c, %d
  %y = call fast <4 x double> @llvm.fmuladd.v4f64(<4 x double> %a, <4 x double> %b, <4 x double> %x)
  %z = fadd fast <4 x double> %y, %e
  ret <4 x double> %z
}

define <4 x double> @test_f64_add_mul_rhs(<4 x double> %a, <4 x double> %b, <4 x double> %c, <4 x double> %d, <4 x double> %e) {
; GFX9-CONTRACT-LABEL: test_f64_add_mul_rhs:
; GFX9-CONTRACT:       ; %bb.0: ; %.entry
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-CONTRACT-NEXT:    buffer_load_dword v31, off, s[0:3], s32 offset:4
; GFX9-CONTRACT-NEXT:    buffer_load_dword v32, off, s[0:3], s32 offset:8
; GFX9-CONTRACT-NEXT:    buffer_load_dword v33, off, s[0:3], s32 offset:12
; GFX9-CONTRACT-NEXT:    buffer_load_dword v34, off, s[0:3], s32 offset:16
; GFX9-CONTRACT-NEXT:    buffer_load_dword v35, off, s[0:3], s32 offset:20
; GFX9-CONTRACT-NEXT:    buffer_load_dword v36, off, s[0:3], s32 offset:24
; GFX9-CONTRACT-NEXT:    buffer_load_dword v37, off, s[0:3], s32 offset:28
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(5)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[16:17], v[16:17], v[24:25], v[31:32]
; GFX9-CONTRACT-NEXT:    buffer_load_dword v31, off, s[0:3], s32
; GFX9-CONTRACT-NEXT:    buffer_load_dword v38, off, s[0:3], s32 offset:32
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(5)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[18:19], v[18:19], v[26:27], v[33:34]
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(3)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[20:21], v[20:21], v[28:29], v[35:36]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX9-CONTRACT-NEXT:    s_waitcnt vmcnt(0)
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[22:23], v[22:23], v[30:31], v[37:38]
; GFX9-CONTRACT-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX9-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-DENORM-LABEL: test_f64_add_mul_rhs:
; GFX9-DENORM:       ; %bb.0: ; %.entry
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-DENORM-NEXT:    buffer_load_dword v31, off, s[0:3], s32 offset:4
; GFX9-DENORM-NEXT:    buffer_load_dword v32, off, s[0:3], s32 offset:8
; GFX9-DENORM-NEXT:    buffer_load_dword v33, off, s[0:3], s32 offset:12
; GFX9-DENORM-NEXT:    buffer_load_dword v34, off, s[0:3], s32 offset:16
; GFX9-DENORM-NEXT:    buffer_load_dword v35, off, s[0:3], s32 offset:20
; GFX9-DENORM-NEXT:    buffer_load_dword v36, off, s[0:3], s32 offset:24
; GFX9-DENORM-NEXT:    buffer_load_dword v37, off, s[0:3], s32 offset:28
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(5)
; GFX9-DENORM-NEXT:    v_fma_f64 v[16:17], v[16:17], v[24:25], v[31:32]
; GFX9-DENORM-NEXT:    buffer_load_dword v31, off, s[0:3], s32
; GFX9-DENORM-NEXT:    buffer_load_dword v38, off, s[0:3], s32 offset:32
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(5)
; GFX9-DENORM-NEXT:    v_fma_f64 v[18:19], v[18:19], v[26:27], v[33:34]
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(3)
; GFX9-DENORM-NEXT:    v_fma_f64 v[20:21], v[20:21], v[28:29], v[35:36]
; GFX9-DENORM-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX9-DENORM-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX9-DENORM-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX9-DENORM-NEXT:    s_waitcnt vmcnt(0)
; GFX9-DENORM-NEXT:    v_fma_f64 v[22:23], v[22:23], v[30:31], v[37:38]
; GFX9-DENORM-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX9-DENORM-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-CONTRACT-LABEL: test_f64_add_mul_rhs:
; GFX10-CONTRACT:       ; %bb.0: ; %.entry
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-CONTRACT-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-CONTRACT-NEXT:    s_clause 0x8
; GFX10-CONTRACT-NEXT:    buffer_load_dword v31, off, s[0:3], s32
; GFX10-CONTRACT-NEXT:    buffer_load_dword v32, off, s[0:3], s32 offset:4
; GFX10-CONTRACT-NEXT:    buffer_load_dword v33, off, s[0:3], s32 offset:8
; GFX10-CONTRACT-NEXT:    buffer_load_dword v34, off, s[0:3], s32 offset:12
; GFX10-CONTRACT-NEXT:    buffer_load_dword v35, off, s[0:3], s32 offset:16
; GFX10-CONTRACT-NEXT:    buffer_load_dword v36, off, s[0:3], s32 offset:20
; GFX10-CONTRACT-NEXT:    buffer_load_dword v37, off, s[0:3], s32 offset:24
; GFX10-CONTRACT-NEXT:    buffer_load_dword v38, off, s[0:3], s32 offset:28
; GFX10-CONTRACT-NEXT:    buffer_load_dword v39, off, s[0:3], s32 offset:32
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(6)
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[16:17], v[16:17], v[24:25], v[32:33]
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(4)
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[18:19], v[18:19], v[26:27], v[34:35]
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(2)
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[20:21], v[20:21], v[28:29], v[36:37]
; GFX10-CONTRACT-NEXT:    s_waitcnt vmcnt(0)
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[22:23], v[22:23], v[30:31], v[38:39]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX10-CONTRACT-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX10-CONTRACT-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-DENORM-LABEL: test_f64_add_mul_rhs:
; GFX10-DENORM:       ; %bb.0: ; %.entry
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-DENORM-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-DENORM-NEXT:    s_clause 0x8
; GFX10-DENORM-NEXT:    buffer_load_dword v31, off, s[0:3], s32
; GFX10-DENORM-NEXT:    buffer_load_dword v32, off, s[0:3], s32 offset:4
; GFX10-DENORM-NEXT:    buffer_load_dword v33, off, s[0:3], s32 offset:8
; GFX10-DENORM-NEXT:    buffer_load_dword v34, off, s[0:3], s32 offset:12
; GFX10-DENORM-NEXT:    buffer_load_dword v35, off, s[0:3], s32 offset:16
; GFX10-DENORM-NEXT:    buffer_load_dword v36, off, s[0:3], s32 offset:20
; GFX10-DENORM-NEXT:    buffer_load_dword v37, off, s[0:3], s32 offset:24
; GFX10-DENORM-NEXT:    buffer_load_dword v38, off, s[0:3], s32 offset:28
; GFX10-DENORM-NEXT:    buffer_load_dword v39, off, s[0:3], s32 offset:32
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(6)
; GFX10-DENORM-NEXT:    v_fma_f64 v[16:17], v[16:17], v[24:25], v[32:33]
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(4)
; GFX10-DENORM-NEXT:    v_fma_f64 v[18:19], v[18:19], v[26:27], v[34:35]
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(2)
; GFX10-DENORM-NEXT:    v_fma_f64 v[20:21], v[20:21], v[28:29], v[36:37]
; GFX10-DENORM-NEXT:    s_waitcnt vmcnt(0)
; GFX10-DENORM-NEXT:    v_fma_f64 v[22:23], v[22:23], v[30:31], v[38:39]
; GFX10-DENORM-NEXT:    v_fma_f64 v[0:1], v[0:1], v[8:9], v[16:17]
; GFX10-DENORM-NEXT:    v_fma_f64 v[2:3], v[2:3], v[10:11], v[18:19]
; GFX10-DENORM-NEXT:    v_fma_f64 v[4:5], v[4:5], v[12:13], v[20:21]
; GFX10-DENORM-NEXT:    v_fma_f64 v[6:7], v[6:7], v[14:15], v[22:23]
; GFX10-DENORM-NEXT:    s_setpc_b64 s[30:31]
.entry:
  %x = fmul fast <4 x double> %c, %d
  %y = call fast <4 x double> @llvm.fmuladd.v4f64(<4 x double> %a, <4 x double> %b, <4 x double> %x)
  %z = fadd fast <4 x double> %e, %y
  ret <4 x double> %z
}

declare <4 x double> @llvm.fmuladd.v4f64(<4 x double>, <4 x double>, <4 x double>) #0
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #0
declare <4 x half> @llvm.fmuladd.v4f16(<4 x half>, <4 x half>, <4 x half>) #0
declare double @llvm.fmuladd.f64(double, double, double) #0
declare float @llvm.fmuladd.f32(float, float, float) #0
declare half @llvm.fmuladd.f16(half, half, half) #0
attributes #0 = { nounwind readnone }

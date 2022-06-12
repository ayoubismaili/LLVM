; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=tonga -verify-machineinstrs < %s | FileCheck -check-prefix=GFX8-UNPACKED %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx810 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX8-PACKED %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX9 %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX10 %s

define amdgpu_ps half @load_1d_f16_x(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_f16_x:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x1 unorm d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_f16_x:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x1 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_f16_x:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v0, v0, s[0:7] dmask:0x1 unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f16_x:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x1 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call half @llvm.amdgcn.image.load.1d.half.i32(i32 1, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret half %v
}

define amdgpu_ps half @load_1d_f16_y(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_f16_y:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x2 unorm d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_f16_y:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x2 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_f16_y:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v0, v0, s[0:7] dmask:0x2 unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f16_y:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x2 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call half @llvm.amdgcn.image.load.1d.half.i32(i32 2, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret half %v
}

define amdgpu_ps half @load_1d_f16_z(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_f16_z:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x4 unorm d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_f16_z:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x4 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_f16_z:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v0, v0, s[0:7] dmask:0x4 unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f16_z:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x4 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call half @llvm.amdgcn.image.load.1d.half.i32(i32 4, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret half %v
}

define amdgpu_ps half @load_1d_f16_w(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_f16_w:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x8 unorm d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_f16_w:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x8 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_f16_w:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v0, v0, s[0:7] dmask:0x8 unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f16_w:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x8 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call half @llvm.amdgcn.image.load.1d.half.i32(i32 8, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret half %v
}

define amdgpu_ps <2 x half> @load_1d_v2f16_xy(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v2f16_xy:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x3 unorm d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_and_b32_e32 v1, 0xffff, v1
; GFX8-UNPACKED-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX8-UNPACKED-NEXT:    v_or_b32_sdwa v0, v0, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v2f16_xy:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x3 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v2f16_xy:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v0, v0, s[0:7] dmask:0x3 unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f16_xy:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x3 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <2 x half> @llvm.amdgcn.image.load.1d.v2f16.i32(i32 3, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <2 x half> %v
}

define amdgpu_ps <2 x half> @load_1d_v2f16_xz(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v2f16_xz:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x5 unorm d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_and_b32_e32 v1, 0xffff, v1
; GFX8-UNPACKED-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX8-UNPACKED-NEXT:    v_or_b32_sdwa v0, v0, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v2f16_xz:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x5 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v2f16_xz:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v0, v0, s[0:7] dmask:0x5 unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f16_xz:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x5 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <2 x half> @llvm.amdgcn.image.load.1d.v2f16.i32(i32 5, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <2 x half> %v
}

define amdgpu_ps <2 x half> @load_1d_v2f16_xw(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v2f16_xw:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x9 unorm d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_and_b32_e32 v1, 0xffff, v1
; GFX8-UNPACKED-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX8-UNPACKED-NEXT:    v_or_b32_sdwa v0, v0, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v2f16_xw:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x9 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v2f16_xw:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v0, v0, s[0:7] dmask:0x9 unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f16_xw:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x9 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <2 x half> @llvm.amdgcn.image.load.1d.v2f16.i32(i32 9, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <2 x half> %v
}

define amdgpu_ps <2 x half> @load_1d_v2f16_yz(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v2f16_yz:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x6 unorm d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_and_b32_e32 v1, 0xffff, v1
; GFX8-UNPACKED-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX8-UNPACKED-NEXT:    v_or_b32_sdwa v0, v0, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v2f16_yz:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v0, v0, s[0:7] dmask:0x6 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v2f16_yz:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v0, v0, s[0:7] dmask:0x6 unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f16_yz:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x6 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <2 x half> @llvm.amdgcn.image.load.1d.v2f16.i32(i32 6, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <2 x half> %v
}

define amdgpu_ps <3 x half> @load_1d_v3f16_xyz(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v3f16_xyz:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v[0:2], v0, s[0:7] dmask:0x7 unorm d16
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, 0xffff
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_and_b32_e32 v3, s0, v1
; GFX8-UNPACKED-NEXT:    v_and_b32_e32 v1, s0, v2
; GFX8-UNPACKED-NEXT:    v_lshlrev_b32_e32 v2, 16, v3
; GFX8-UNPACKED-NEXT:    v_or_b32_sdwa v0, v0, v2 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v3f16_xyz:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x7 unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    v_lshrrev_b32_e32 v2, 16, v0
; GFX8-PACKED-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX8-PACKED-NEXT:    v_and_b32_e32 v1, 0xffff, v1
; GFX8-PACKED-NEXT:    v_or_b32_sdwa v0, v0, v2 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v3f16_xyz:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x7 unorm d16
; GFX9-NEXT:    v_mov_b32_e32 v2, 0xffff
; GFX9-NEXT:    s_lshl_b32 s0, s0, 16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_lshrrev_b32_e32 v3, 16, v0
; GFX9-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; GFX9-NEXT:    v_and_or_b32 v1, v1, v2, s0
; GFX9-NEXT:    v_and_or_b32 v0, v0, v2, v3
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v3f16_xyz:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v3, 0xffff
; GFX10-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x7 dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-NEXT:    s_lshl_b32 s0, s0, 16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_lshrrev_b32_e32 v2, 16, v0
; GFX10-NEXT:    v_and_or_b32 v1, v1, v3, s0
; GFX10-NEXT:    v_lshlrev_b32_e32 v2, 16, v2
; GFX10-NEXT:    v_and_or_b32 v0, v0, v3, v2
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <3 x half> @llvm.amdgcn.image.load.1d.v3f16.i32(i32 7, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <3 x half> %v
}

define amdgpu_ps <4 x half> @load_1d_v4f16_xyzw(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v4f16_xyzw:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    image_load v[0:3], v0, s[0:7] dmask:0xf unorm d16
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, 0xffff
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_and_b32_e32 v1, s0, v1
; GFX8-UNPACKED-NEXT:    v_and_b32_e32 v3, s0, v3
; GFX8-UNPACKED-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; GFX8-UNPACKED-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; GFX8-UNPACKED-NEXT:    v_or_b32_sdwa v0, v0, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-UNPACKED-NEXT:    v_or_b32_sdwa v1, v2, v3 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v4f16_xyzw:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0xf unorm d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v4f16_xyzw:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0xf unorm d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v4f16_xyzw:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0xf dim:SQ_RSRC_IMG_1D unorm d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <4 x half> @llvm.amdgcn.image.load.1d.v4f16.i32(i32 15, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <4 x half> %v
}

define amdgpu_ps float @load_1d_f16_tfe_dmask_x(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_f16_tfe_dmask_x:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v1, 0
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v2, v1
; GFX8-UNPACKED-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x1 unorm tfe d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v0, v2
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_f16_tfe_dmask_x:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v1, 0
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v2, v1
; GFX8-PACKED-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x1 unorm tfe d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v0, v2
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_f16_tfe_dmask_x:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    v_mov_b32_e32 v1, 0
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    v_mov_b32_e32 v2, v1
; GFX9-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x1 unorm tfe d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, v2
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f16_tfe_dmask_x:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x1 dim:SQ_RSRC_IMG_1D unorm tfe d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { half, i32 } @llvm.amdgcn.image.load.1d.sl_f16i32s.i32(i32 1, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { half, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

define amdgpu_ps float @load_1d_v2f16_tfe_dmask_xy(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v2f16_tfe_dmask_xy:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v1, 0
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v2, v1
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v3, v1
; GFX8-UNPACKED-NEXT:    image_load v[1:3], v0, s[0:7] dmask:0x3 unorm tfe d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v0, v3
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v2f16_tfe_dmask_xy:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v1, 0
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v2, v1
; GFX8-PACKED-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x3 unorm tfe d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v0, v2
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v2f16_tfe_dmask_xy:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    v_mov_b32_e32 v1, 0
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    v_mov_b32_e32 v2, v1
; GFX9-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x3 unorm tfe d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, v2
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f16_tfe_dmask_xy:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x3 dim:SQ_RSRC_IMG_1D unorm tfe d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { <2 x half>, i32 } @llvm.amdgcn.image.load.1d.sl_v2f16i32s.i32(i32 3, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { <2 x half>, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

define amdgpu_ps float @load_1d_v3f16_tfe_dmask_xyz(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v3f16_tfe_dmask_xyz:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v1, 0
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v2, v1
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v3, v1
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v4, v1
; GFX8-UNPACKED-NEXT:    image_load v[1:4], v0, s[0:7] dmask:0x7 unorm tfe d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v0, v4
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v3f16_tfe_dmask_xyz:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v1, 0
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v2, v1
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v3, v1
; GFX8-PACKED-NEXT:    image_load v[1:3], v0, s[0:7] dmask:0x7 unorm tfe d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v0, v3
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v3f16_tfe_dmask_xyz:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    v_mov_b32_e32 v1, 0
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    v_mov_b32_e32 v2, v1
; GFX9-NEXT:    v_mov_b32_e32 v3, v1
; GFX9-NEXT:    image_load v[1:3], v0, s[0:7] dmask:0x7 unorm tfe d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, v3
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v3f16_tfe_dmask_xyz:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    v_mov_b32_e32 v3, v1
; GFX10-NEXT:    image_load v[1:3], v0, s[0:7] dmask:0x7 dim:SQ_RSRC_IMG_1D unorm tfe d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v3
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { <3 x half>, i32 } @llvm.amdgcn.image.load.1d.sl_v3f16i32s.i32(i32 7, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { <3 x half>, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

define amdgpu_ps float @load_1d_v4f16_tfe_dmask_xyzw(<8 x i32> inreg %rsrc, i32 %s) {
; GFX8-UNPACKED-LABEL: load_1d_v4f16_tfe_dmask_xyzw:
; GFX8-UNPACKED:       ; %bb.0:
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v1, 0
; GFX8-UNPACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-UNPACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-UNPACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-UNPACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-UNPACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-UNPACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-UNPACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-UNPACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v2, v1
; GFX8-UNPACKED-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x10 unorm tfe d16
; GFX8-UNPACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-UNPACKED-NEXT:    v_mov_b32_e32 v0, v2
; GFX8-UNPACKED-NEXT:    ; return to shader part epilog
;
; GFX8-PACKED-LABEL: load_1d_v4f16_tfe_dmask_xyzw:
; GFX8-PACKED:       ; %bb.0:
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v1, 0
; GFX8-PACKED-NEXT:    s_mov_b32 s0, s2
; GFX8-PACKED-NEXT:    s_mov_b32 s1, s3
; GFX8-PACKED-NEXT:    s_mov_b32 s2, s4
; GFX8-PACKED-NEXT:    s_mov_b32 s3, s5
; GFX8-PACKED-NEXT:    s_mov_b32 s4, s6
; GFX8-PACKED-NEXT:    s_mov_b32 s5, s7
; GFX8-PACKED-NEXT:    s_mov_b32 s6, s8
; GFX8-PACKED-NEXT:    s_mov_b32 s7, s9
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v2, v1
; GFX8-PACKED-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x10 unorm tfe d16
; GFX8-PACKED-NEXT:    s_waitcnt vmcnt(0)
; GFX8-PACKED-NEXT:    v_mov_b32_e32 v0, v2
; GFX8-PACKED-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: load_1d_v4f16_tfe_dmask_xyzw:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    v_mov_b32_e32 v1, 0
; GFX9-NEXT:    s_mov_b32 s0, s2
; GFX9-NEXT:    s_mov_b32 s1, s3
; GFX9-NEXT:    s_mov_b32 s2, s4
; GFX9-NEXT:    s_mov_b32 s3, s5
; GFX9-NEXT:    s_mov_b32 s4, s6
; GFX9-NEXT:    s_mov_b32 s5, s7
; GFX9-NEXT:    s_mov_b32 s6, s8
; GFX9-NEXT:    s_mov_b32 s7, s9
; GFX9-NEXT:    v_mov_b32_e32 v2, v1
; GFX9-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x10 unorm tfe d16
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, v2
; GFX9-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v4f16_tfe_dmask_xyzw:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x10 dim:SQ_RSRC_IMG_1D unorm tfe d16
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { <4 x half>, i32 } @llvm.amdgcn.image.load.1d.sl_v4f16i32s.i32(i32 16, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { <4 x half>, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

declare half @llvm.amdgcn.image.load.1d.half.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare <2 x half> @llvm.amdgcn.image.load.1d.v2f16.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare <3 x half> @llvm.amdgcn.image.load.1d.v3f16.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare <4 x half> @llvm.amdgcn.image.load.1d.v4f16.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0

declare { half, i32 } @llvm.amdgcn.image.load.1d.sl_f16i32s.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare { <2 x half>, i32 } @llvm.amdgcn.image.load.1d.sl_v2f16i32s.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare { <3 x half>, i32 } @llvm.amdgcn.image.load.1d.sl_v3f16i32s.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare { <4 x half>, i32 } @llvm.amdgcn.image.load.1d.sl_v4f16i32s.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0

attributes #0 = { nounwind readonly }

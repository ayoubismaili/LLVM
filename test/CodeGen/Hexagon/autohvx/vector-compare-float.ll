; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=hexagon -mattr=+hvxv69,+hvx-length128b,+hvx-qfloat < %s | FileCheck %s
; RUN: llc -march=hexagon -mattr=+hvxv69,+hvx-length128b,+hvx-ieee-fp < %s | FileCheck %s

; --- Half

define <64 x half> @test_00(<64 x half> %v0, <64 x half> %v1, <64 x half> %v2) #0 {
; CHECK-LABEL: test_00:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.eq(v0.h,v1.h)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v1,v2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp oeq <64 x half> %v0, %v1
  %t1 = select <64 x i1> %t0, <64 x half> %v1, <64 x half> %v2
  ret <64 x half> %t1
}

define <64 x half> @test_01(<64 x half> %v0, <64 x half> %v1, <64 x half> %v2) #0 {
; CHECK-LABEL: test_01:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.eq(v0.h,v1.h)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v2,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp one <64 x half> %v0, %v1
  %t1 = select <64 x i1> %t0, <64 x half> %v1, <64 x half> %v2
  ret <64 x half> %t1
}

define <64 x half> @test_02(<64 x half> %v0, <64 x half> %v1, <64 x half> %v2) #0 {
; CHECK-LABEL: test_02:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.gt(v1.hf,v0.hf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v1,v2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp olt <64 x half> %v0, %v1
  %t1 = select <64 x i1> %t0, <64 x half> %v1, <64 x half> %v2
  ret <64 x half> %t1
}

define <64 x half> @test_03(<64 x half> %v0, <64 x half> %v1, <64 x half> %v2) #0 {
; CHECK-LABEL: test_03:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.gt(v0.hf,v1.hf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v2,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp ole <64 x half> %v0, %v1
  %t1 = select <64 x i1> %t0, <64 x half> %v1, <64 x half> %v2
  ret <64 x half> %t1
}

define <64 x half> @test_04(<64 x half> %v0, <64 x half> %v1, <64 x half> %v2) #0 {
; CHECK-LABEL: test_04:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.gt(v0.hf,v1.hf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v1,v2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp ogt <64 x half> %v0, %v1
  %t1 = select <64 x i1> %t0, <64 x half> %v1, <64 x half> %v2
  ret <64 x half> %t1
}

define <64 x half> @test_05(<64 x half> %v0, <64 x half> %v1, <64 x half> %v2) #0 {
; CHECK-LABEL: test_05:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.gt(v1.hf,v0.hf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v2,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp oge <64 x half> %v0, %v1
  %t1 = select <64 x i1> %t0, <64 x half> %v1, <64 x half> %v2
  ret <64 x half> %t1
}

define <64 x half> @test_0a(<64 x half> %v0, <64 x half> %v1, <64 x i16> %v2) #0 {
; CHECK-LABEL: test_0a:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 &= vcmp.eq(v0.h,v1.h)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp oeq <64 x half> %v0, %v1
  %q1 = trunc <64 x i16> %v2 to <64 x i1>
  %q2 = and <64 x i1> %q0, %q1
  %t1 = select <64 x i1> %q2, <64 x half> %v0, <64 x half> %v1
  ret <64 x half> %t1
}

define <64 x half> @test_0b(<64 x half> %v0, <64 x half> %v1, <64 x i16> %v2) #0 {
; CHECK-LABEL: test_0b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 |= vcmp.eq(v0.h,v1.h)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp oeq <64 x half> %v0, %v1
  %q1 = trunc <64 x i16> %v2 to <64 x i1>
  %q2 = or <64 x i1> %q0, %q1
  %t1 = select <64 x i1> %q2, <64 x half> %v0, <64 x half> %v1
  ret <64 x half> %t1
}

define <64 x half> @test_0c(<64 x half> %v0, <64 x half> %v1, <64 x i16> %v2) #0 {
; CHECK-LABEL: test_0c:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 ^= vcmp.eq(v0.h,v1.h)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp oeq <64 x half> %v0, %v1
  %q1 = trunc <64 x i16> %v2 to <64 x i1>
  %q2 = xor <64 x i1> %q0, %q1
  %t1 = select <64 x i1> %q2, <64 x half> %v0, <64 x half> %v1
  ret <64 x half> %t1
}

define <64 x half> @test_0d(<64 x half> %v0, <64 x half> %v1, <64 x i16> %v2) #0 {
; CHECK-LABEL: test_0d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 &= vcmp.gt(v0.hf,v1.hf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp ogt <64 x half> %v0, %v1
  %q1 = trunc <64 x i16> %v2 to <64 x i1>
  %q2 = and <64 x i1> %q0, %q1
  %t1 = select <64 x i1> %q2, <64 x half> %v0, <64 x half> %v1
  ret <64 x half> %t1
}

define <64 x half> @test_0e(<64 x half> %v0, <64 x half> %v1, <64 x i16> %v2) #0 {
; CHECK-LABEL: test_0e:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 |= vcmp.gt(v0.hf,v1.hf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp ogt <64 x half> %v0, %v1
  %q1 = trunc <64 x i16> %v2 to <64 x i1>
  %q2 = or <64 x i1> %q0, %q1
  %t1 = select <64 x i1> %q2, <64 x half> %v0, <64 x half> %v1
  ret <64 x half> %t1
}

define <64 x half> @test_0f(<64 x half> %v0, <64 x half> %v1, <64 x i16> %v2) #0 {
; CHECK-LABEL: test_0f:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 ^= vcmp.gt(v0.hf,v1.hf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp ogt <64 x half> %v0, %v1
  %q1 = trunc <64 x i16> %v2 to <64 x i1>
  %q2 = xor <64 x i1> %q0, %q1
  %t1 = select <64 x i1> %q2, <64 x half> %v0, <64 x half> %v1
  ret <64 x half> %t1
}


; --- Single

define <32 x float> @test_10(<32 x float> %v0, <32 x float> %v1, <32 x float> %v2) #0 {
; CHECK-LABEL: test_10:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.eq(v0.w,v1.w)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v1,v2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp oeq <32 x float> %v0, %v1
  %t1 = select <32 x i1> %t0, <32 x float> %v1, <32 x float> %v2
  ret <32 x float> %t1
}

define <32 x float> @test_11(<32 x float> %v0, <32 x float> %v1, <32 x float> %v2) #0 {
; CHECK-LABEL: test_11:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.eq(v0.w,v1.w)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v2,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp one <32 x float> %v0, %v1
  %t1 = select <32 x i1> %t0, <32 x float> %v1, <32 x float> %v2
  ret <32 x float> %t1
}

define <32 x float> @test_12(<32 x float> %v0, <32 x float> %v1, <32 x float> %v2) #0 {
; CHECK-LABEL: test_12:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.gt(v1.sf,v0.sf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v1,v2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp olt <32 x float> %v0, %v1
  %t1 = select <32 x i1> %t0, <32 x float> %v1, <32 x float> %v2
  ret <32 x float> %t1
}

define <32 x float> @test_13(<32 x float> %v0, <32 x float> %v1, <32 x float> %v2) #0 {
; CHECK-LABEL: test_13:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.gt(v0.sf,v1.sf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v2,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp ole <32 x float> %v0, %v1
  %t1 = select <32 x i1> %t0, <32 x float> %v1, <32 x float> %v2
  ret <32 x float> %t1
}

define <32 x float> @test_14(<32 x float> %v0, <32 x float> %v1, <32 x float> %v2) #0 {
; CHECK-LABEL: test_14:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.gt(v0.sf,v1.sf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v1,v2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp ogt <32 x float> %v0, %v1
  %t1 = select <32 x i1> %t0, <32 x float> %v1, <32 x float> %v2
  ret <32 x float> %t1
}

define <32 x float> @test_15(<32 x float> %v0, <32 x float> %v1, <32 x float> %v2) #0 {
; CHECK-LABEL: test_15:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vcmp.gt(v1.sf,v0.sf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v2,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %t0 = fcmp oge <32 x float> %v0, %v1
  %t1 = select <32 x i1> %t0, <32 x float> %v1, <32 x float> %v2
  ret <32 x float> %t1
}

define <32 x float> @test_1a(<32 x float> %v0, <32 x float> %v1, <32 x i32> %v2) #0 {
; CHECK-LABEL: test_1a:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 &= vcmp.eq(v0.w,v1.w)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp oeq <32 x float> %v0, %v1
  %q1 = trunc <32 x i32> %v2 to <32 x i1>
  %q2 = and <32 x i1> %q0, %q1
  %t1 = select <32 x i1> %q2, <32 x float> %v0, <32 x float> %v1
  ret <32 x float> %t1
}

define <32 x float> @test_1b(<32 x float> %v0, <32 x float> %v1, <32 x i32> %v2) #0 {
; CHECK-LABEL: test_1b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 |= vcmp.eq(v0.w,v1.w)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp oeq <32 x float> %v0, %v1
  %q1 = trunc <32 x i32> %v2 to <32 x i1>
  %q2 = or <32 x i1> %q0, %q1
  %t1 = select <32 x i1> %q2, <32 x float> %v0, <32 x float> %v1
  ret <32 x float> %t1
}

define <32 x float> @test_1c(<32 x float> %v0, <32 x float> %v1, <32 x i32> %v2) #0 {
; CHECK-LABEL: test_1c:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 ^= vcmp.eq(v0.w,v1.w)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp oeq <32 x float> %v0, %v1
  %q1 = trunc <32 x i32> %v2 to <32 x i1>
  %q2 = xor <32 x i1> %q0, %q1
  %t1 = select <32 x i1> %q2, <32 x float> %v0, <32 x float> %v1
  ret <32 x float> %t1
}

define <32 x float> @test_1d(<32 x float> %v0, <32 x float> %v1, <32 x i32> %v2) #0 {
; CHECK-LABEL: test_1d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 &= vcmp.gt(v0.sf,v1.sf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp ogt <32 x float> %v0, %v1
  %q1 = trunc <32 x i32> %v2 to <32 x i1>
  %q2 = and <32 x i1> %q0, %q1
  %t1 = select <32 x i1> %q2, <32 x float> %v0, <32 x float> %v1
  ret <32 x float> %t1
}

define <32 x float> @test_1e(<32 x float> %v0, <32 x float> %v1, <32 x i32> %v2) #0 {
; CHECK-LABEL: test_1e:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 |= vcmp.gt(v0.sf,v1.sf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp ogt <32 x float> %v0, %v1
  %q1 = trunc <32 x i32> %v2 to <32 x i1>
  %q2 = or <32 x i1> %q0, %q1
  %t1 = select <32 x i1> %q2, <32 x float> %v0, <32 x float> %v1
  ret <32 x float> %t1
}

define <32 x float> @test_1f(<32 x float> %v0, <32 x float> %v1, <32 x i32> %v2) #0 {
; CHECK-LABEL: test_1f:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = ##16843009
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 = vand(v2,r0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     q0 ^= vcmp.gt(v0.sf,v1.sf)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     v0 = vmux(q0,v0,v1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %q0 = fcmp ogt <32 x float> %v0, %v1
  %q1 = trunc <32 x i32> %v2 to <32 x i1>
  %q2 = xor <32 x i1> %q0, %q1
  %t1 = select <32 x i1> %q2, <32 x float> %v0, <32 x float> %v1
  ret <32 x float> %t1
}

attributes #0 = { nounwind readnone "target-cpu"="hexagonv69" }

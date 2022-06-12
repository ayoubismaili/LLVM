; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -slp-vectorizer -S -o - -mtriple=x86_64-unknown-linux-gnu -mcpu=haswell < %s | FileCheck %s

@k = external dso_local constant [8 x [4 x i32]], align 16
@l = external dso_local global [366 x i32], align 16

; Function Attrs: nofree norecurse noreturn nounwind writeonly
define void @n() local_unnamed_addr #0 {
; CHECK-LABEL: @n(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i32>, <4 x i32>* bitcast ([8 x [4 x i32]]* @k to <4 x i32>*), align 16
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 1, i64 0), align 16
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 1, i64 1), align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 1, i64 2), align 8
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 1, i64 3), align 4
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 2, i64 0), align 16
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 2, i64 1), align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 2, i64 2), align 8
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 2, i64 3), align 4
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 3, i64 0), align 16
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 3, i64 1), align 4
; CHECK-NEXT:    [[TMP11:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 3, i64 2), align 8
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 3, i64 3), align 4
; CHECK-NEXT:    [[TMP13:%.*]] = load <16 x i32>, <16 x i32>* bitcast (i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 4, i64 0) to <16 x i32>*), align 16
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_COND]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[B_0:%.*]] = phi i32 [ [[SPEC_SELECT8_3_7:%.*]], [[FOR_COND]] ], [ undef, [[ENTRY]] ]
; CHECK-NEXT:    [[TMP14:%.*]] = trunc i64 [[INDVARS_IV]] to i32
; CHECK-NEXT:    [[TMP15:%.*]] = add i32 [[TMP14]], -183
; CHECK-NEXT:    [[TMP16:%.*]] = insertelement <4 x i32> poison, i32 [[TMP15]], i32 0
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[TMP16]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP17:%.*]] = sub <4 x i32> [[SHUFFLE]], [[TMP0]]
; CHECK-NEXT:    [[TMP18:%.*]] = icmp slt <4 x i32> [[TMP17]], zeroinitializer
; CHECK-NEXT:    [[TMP19:%.*]] = sub nsw <4 x i32> zeroinitializer, [[TMP17]]
; CHECK-NEXT:    [[TMP20:%.*]] = select <4 x i1> [[TMP18]], <4 x i32> [[TMP19]], <4 x i32> [[TMP17]]
; CHECK-NEXT:    [[TMP21:%.*]] = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> [[TMP20]])
; CHECK-NEXT:    [[OP_EXTRA:%.*]] = icmp slt i32 [[TMP21]], [[B_0]]
; CHECK-NEXT:    [[OP_EXTRA1:%.*]] = select i1 [[OP_EXTRA]], i32 [[TMP21]], i32 [[B_0]]
; CHECK-NEXT:    [[SUB_116:%.*]] = sub i32 [[TMP15]], [[TMP1]]
; CHECK-NEXT:    [[TMP22:%.*]] = icmp slt i32 [[SUB_116]], 0
; CHECK-NEXT:    [[NEG_117:%.*]] = sub nsw i32 0, [[SUB_116]]
; CHECK-NEXT:    [[TMP23:%.*]] = select i1 [[TMP22]], i32 [[NEG_117]], i32 [[SUB_116]]
; CHECK-NEXT:    [[CMP12_118:%.*]] = icmp slt i32 [[TMP23]], [[OP_EXTRA1]]
; CHECK-NEXT:    [[SPEC_SELECT8_120:%.*]] = select i1 [[CMP12_118]], i32 [[TMP23]], i32 [[OP_EXTRA1]]
; CHECK-NEXT:    [[SUB_1_1:%.*]] = sub i32 [[TMP15]], [[TMP2]]
; CHECK-NEXT:    [[TMP24:%.*]] = icmp slt i32 [[SUB_1_1]], 0
; CHECK-NEXT:    [[NEG_1_1:%.*]] = sub nsw i32 0, [[SUB_1_1]]
; CHECK-NEXT:    [[TMP25:%.*]] = select i1 [[TMP24]], i32 [[NEG_1_1]], i32 [[SUB_1_1]]
; CHECK-NEXT:    [[CMP12_1_1:%.*]] = icmp slt i32 [[TMP25]], [[SPEC_SELECT8_120]]
; CHECK-NEXT:    [[NARROW:%.*]] = or i1 [[CMP12_1_1]], [[CMP12_118]]
; CHECK-NEXT:    [[SPEC_SELECT8_1_1:%.*]] = select i1 [[CMP12_1_1]], i32 [[TMP25]], i32 [[SPEC_SELECT8_120]]
; CHECK-NEXT:    [[SUB_2_1:%.*]] = sub i32 [[TMP15]], [[TMP3]]
; CHECK-NEXT:    [[TMP26:%.*]] = icmp slt i32 [[SUB_2_1]], 0
; CHECK-NEXT:    [[NEG_2_1:%.*]] = sub nsw i32 0, [[SUB_2_1]]
; CHECK-NEXT:    [[TMP27:%.*]] = select i1 [[TMP26]], i32 [[NEG_2_1]], i32 [[SUB_2_1]]
; CHECK-NEXT:    [[CMP12_2_1:%.*]] = icmp slt i32 [[TMP27]], [[SPEC_SELECT8_1_1]]
; CHECK-NEXT:    [[NARROW34:%.*]] = or i1 [[CMP12_2_1]], [[NARROW]]
; CHECK-NEXT:    [[SPEC_SELECT8_2_1:%.*]] = select i1 [[CMP12_2_1]], i32 [[TMP27]], i32 [[SPEC_SELECT8_1_1]]
; CHECK-NEXT:    [[SUB_3_1:%.*]] = sub i32 [[TMP15]], [[TMP4]]
; CHECK-NEXT:    [[TMP28:%.*]] = icmp slt i32 [[SUB_3_1]], 0
; CHECK-NEXT:    [[NEG_3_1:%.*]] = sub nsw i32 0, [[SUB_3_1]]
; CHECK-NEXT:    [[TMP29:%.*]] = select i1 [[TMP28]], i32 [[NEG_3_1]], i32 [[SUB_3_1]]
; CHECK-NEXT:    [[CMP12_3_1:%.*]] = icmp slt i32 [[TMP29]], [[SPEC_SELECT8_2_1]]
; CHECK-NEXT:    [[NARROW35:%.*]] = or i1 [[CMP12_3_1]], [[NARROW34]]
; CHECK-NEXT:    [[SPEC_SELECT_3_1:%.*]] = zext i1 [[NARROW35]] to i32
; CHECK-NEXT:    [[SPEC_SELECT8_3_1:%.*]] = select i1 [[CMP12_3_1]], i32 [[TMP29]], i32 [[SPEC_SELECT8_2_1]]
; CHECK-NEXT:    [[SUB_222:%.*]] = sub i32 [[TMP15]], [[TMP5]]
; CHECK-NEXT:    [[TMP30:%.*]] = icmp slt i32 [[SUB_222]], 0
; CHECK-NEXT:    [[NEG_223:%.*]] = sub nsw i32 0, [[SUB_222]]
; CHECK-NEXT:    [[TMP31:%.*]] = select i1 [[TMP30]], i32 [[NEG_223]], i32 [[SUB_222]]
; CHECK-NEXT:    [[CMP12_224:%.*]] = icmp slt i32 [[TMP31]], [[SPEC_SELECT8_3_1]]
; CHECK-NEXT:    [[SPEC_SELECT8_226:%.*]] = select i1 [[CMP12_224]], i32 [[TMP31]], i32 [[SPEC_SELECT8_3_1]]
; CHECK-NEXT:    [[SUB_1_2:%.*]] = sub i32 [[TMP15]], [[TMP6]]
; CHECK-NEXT:    [[TMP32:%.*]] = icmp slt i32 [[SUB_1_2]], 0
; CHECK-NEXT:    [[NEG_1_2:%.*]] = sub nsw i32 0, [[SUB_1_2]]
; CHECK-NEXT:    [[TMP33:%.*]] = select i1 [[TMP32]], i32 [[NEG_1_2]], i32 [[SUB_1_2]]
; CHECK-NEXT:    [[CMP12_1_2:%.*]] = icmp slt i32 [[TMP33]], [[SPEC_SELECT8_226]]
; CHECK-NEXT:    [[TMP34:%.*]] = or i1 [[CMP12_1_2]], [[CMP12_224]]
; CHECK-NEXT:    [[SPEC_SELECT8_1_2:%.*]] = select i1 [[CMP12_1_2]], i32 [[TMP33]], i32 [[SPEC_SELECT8_226]]
; CHECK-NEXT:    [[SUB_2_2:%.*]] = sub i32 [[TMP15]], [[TMP7]]
; CHECK-NEXT:    [[TMP35:%.*]] = icmp slt i32 [[SUB_2_2]], 0
; CHECK-NEXT:    [[NEG_2_2:%.*]] = sub nsw i32 0, [[SUB_2_2]]
; CHECK-NEXT:    [[TMP36:%.*]] = select i1 [[TMP35]], i32 [[NEG_2_2]], i32 [[SUB_2_2]]
; CHECK-NEXT:    [[CMP12_2_2:%.*]] = icmp slt i32 [[TMP36]], [[SPEC_SELECT8_1_2]]
; CHECK-NEXT:    [[TMP37:%.*]] = or i1 [[CMP12_2_2]], [[TMP34]]
; CHECK-NEXT:    [[SPEC_SELECT8_2_2:%.*]] = select i1 [[CMP12_2_2]], i32 [[TMP36]], i32 [[SPEC_SELECT8_1_2]]
; CHECK-NEXT:    [[SUB_3_2:%.*]] = sub i32 [[TMP15]], [[TMP8]]
; CHECK-NEXT:    [[TMP38:%.*]] = icmp slt i32 [[SUB_3_2]], 0
; CHECK-NEXT:    [[NEG_3_2:%.*]] = sub nsw i32 0, [[SUB_3_2]]
; CHECK-NEXT:    [[TMP39:%.*]] = select i1 [[TMP38]], i32 [[NEG_3_2]], i32 [[SUB_3_2]]
; CHECK-NEXT:    [[CMP12_3_2:%.*]] = icmp slt i32 [[TMP39]], [[SPEC_SELECT8_2_2]]
; CHECK-NEXT:    [[TMP40:%.*]] = or i1 [[CMP12_3_2]], [[TMP37]]
; CHECK-NEXT:    [[SPEC_SELECT_3_2:%.*]] = select i1 [[TMP40]], i32 2, i32 [[SPEC_SELECT_3_1]]
; CHECK-NEXT:    [[SPEC_SELECT8_3_2:%.*]] = select i1 [[CMP12_3_2]], i32 [[TMP39]], i32 [[SPEC_SELECT8_2_2]]
; CHECK-NEXT:    [[SUB_328:%.*]] = sub i32 [[TMP15]], [[TMP9]]
; CHECK-NEXT:    [[TMP41:%.*]] = icmp slt i32 [[SUB_328]], 0
; CHECK-NEXT:    [[NEG_329:%.*]] = sub nsw i32 0, [[SUB_328]]
; CHECK-NEXT:    [[TMP42:%.*]] = select i1 [[TMP41]], i32 [[NEG_329]], i32 [[SUB_328]]
; CHECK-NEXT:    [[CMP12_330:%.*]] = icmp slt i32 [[TMP42]], [[SPEC_SELECT8_3_2]]
; CHECK-NEXT:    [[SPEC_SELECT8_332:%.*]] = select i1 [[CMP12_330]], i32 [[TMP42]], i32 [[SPEC_SELECT8_3_2]]
; CHECK-NEXT:    [[SUB_1_3:%.*]] = sub i32 [[TMP15]], [[TMP10]]
; CHECK-NEXT:    [[TMP43:%.*]] = icmp slt i32 [[SUB_1_3]], 0
; CHECK-NEXT:    [[NEG_1_3:%.*]] = sub nsw i32 0, [[SUB_1_3]]
; CHECK-NEXT:    [[TMP44:%.*]] = select i1 [[TMP43]], i32 [[NEG_1_3]], i32 [[SUB_1_3]]
; CHECK-NEXT:    [[CMP12_1_3:%.*]] = icmp slt i32 [[TMP44]], [[SPEC_SELECT8_332]]
; CHECK-NEXT:    [[TMP45:%.*]] = or i1 [[CMP12_1_3]], [[CMP12_330]]
; CHECK-NEXT:    [[SPEC_SELECT8_1_3:%.*]] = select i1 [[CMP12_1_3]], i32 [[TMP44]], i32 [[SPEC_SELECT8_332]]
; CHECK-NEXT:    [[SUB_2_3:%.*]] = sub i32 [[TMP15]], [[TMP11]]
; CHECK-NEXT:    [[TMP46:%.*]] = icmp slt i32 [[SUB_2_3]], 0
; CHECK-NEXT:    [[NEG_2_3:%.*]] = sub nsw i32 0, [[SUB_2_3]]
; CHECK-NEXT:    [[TMP47:%.*]] = select i1 [[TMP46]], i32 [[NEG_2_3]], i32 [[SUB_2_3]]
; CHECK-NEXT:    [[CMP12_2_3:%.*]] = icmp slt i32 [[TMP47]], [[SPEC_SELECT8_1_3]]
; CHECK-NEXT:    [[TMP48:%.*]] = or i1 [[CMP12_2_3]], [[TMP45]]
; CHECK-NEXT:    [[SPEC_SELECT8_2_3:%.*]] = select i1 [[CMP12_2_3]], i32 [[TMP47]], i32 [[SPEC_SELECT8_1_3]]
; CHECK-NEXT:    [[SUB_3_3:%.*]] = sub i32 [[TMP15]], [[TMP12]]
; CHECK-NEXT:    [[TMP49:%.*]] = icmp slt i32 [[SUB_3_3]], 0
; CHECK-NEXT:    [[NEG_3_3:%.*]] = sub nsw i32 0, [[SUB_3_3]]
; CHECK-NEXT:    [[TMP50:%.*]] = select i1 [[TMP49]], i32 [[NEG_3_3]], i32 [[SUB_3_3]]
; CHECK-NEXT:    [[CMP12_3_3:%.*]] = icmp slt i32 [[TMP50]], [[SPEC_SELECT8_2_3]]
; CHECK-NEXT:    [[TMP51:%.*]] = or i1 [[CMP12_3_3]], [[TMP48]]
; CHECK-NEXT:    [[SPEC_SELECT_3_3:%.*]] = select i1 [[TMP51]], i32 3, i32 [[SPEC_SELECT_3_2]]
; CHECK-NEXT:    [[SPEC_SELECT8_3_3:%.*]] = select i1 [[CMP12_3_3]], i32 [[TMP50]], i32 [[SPEC_SELECT8_2_3]]
; CHECK-NEXT:    [[TMP52:%.*]] = insertelement <16 x i32> poison, i32 [[TMP15]], i32 0
; CHECK-NEXT:    [[SHUFFLE2:%.*]] = shufflevector <16 x i32> [[TMP52]], <16 x i32> poison, <16 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP53:%.*]] = sub <16 x i32> [[SHUFFLE2]], [[TMP13]]
; CHECK-NEXT:    [[TMP54:%.*]] = extractelement <16 x i32> [[TMP53]], i32 0
; CHECK-NEXT:    [[NEG_4:%.*]] = sub nsw i32 0, [[TMP54]]
; CHECK-NEXT:    [[TMP55:%.*]] = icmp slt <16 x i32> [[TMP53]], zeroinitializer
; CHECK-NEXT:    [[TMP56:%.*]] = extractelement <16 x i1> [[TMP55]], i32 0
; CHECK-NEXT:    [[TMP57:%.*]] = select i1 [[TMP56]], i32 [[NEG_4]], i32 [[TMP54]]
; CHECK-NEXT:    [[CMP12_4:%.*]] = icmp slt i32 [[TMP57]], [[SPEC_SELECT8_3_3]]
; CHECK-NEXT:    [[SPEC_SELECT8_4:%.*]] = select i1 [[CMP12_4]], i32 [[TMP57]], i32 [[SPEC_SELECT8_3_3]]
; CHECK-NEXT:    [[TMP58:%.*]] = extractelement <16 x i32> [[TMP53]], i32 1
; CHECK-NEXT:    [[NEG_1_4:%.*]] = sub nsw i32 0, [[TMP58]]
; CHECK-NEXT:    [[TMP59:%.*]] = extractelement <16 x i1> [[TMP55]], i32 1
; CHECK-NEXT:    [[TMP60:%.*]] = select i1 [[TMP59]], i32 [[NEG_1_4]], i32 [[TMP58]]
; CHECK-NEXT:    [[CMP12_1_4:%.*]] = icmp slt i32 [[TMP60]], [[SPEC_SELECT8_4]]
; CHECK-NEXT:    [[TMP61:%.*]] = or i1 [[CMP12_1_4]], [[CMP12_4]]
; CHECK-NEXT:    [[SPEC_SELECT8_1_4:%.*]] = select i1 [[CMP12_1_4]], i32 [[TMP60]], i32 [[SPEC_SELECT8_4]]
; CHECK-NEXT:    [[TMP62:%.*]] = extractelement <16 x i32> [[TMP53]], i32 2
; CHECK-NEXT:    [[NEG_2_4:%.*]] = sub nsw i32 0, [[TMP62]]
; CHECK-NEXT:    [[TMP63:%.*]] = extractelement <16 x i1> [[TMP55]], i32 2
; CHECK-NEXT:    [[TMP64:%.*]] = select i1 [[TMP63]], i32 [[NEG_2_4]], i32 [[TMP62]]
; CHECK-NEXT:    [[CMP12_2_4:%.*]] = icmp slt i32 [[TMP64]], [[SPEC_SELECT8_1_4]]
; CHECK-NEXT:    [[TMP65:%.*]] = or i1 [[CMP12_2_4]], [[TMP61]]
; CHECK-NEXT:    [[SPEC_SELECT8_2_4:%.*]] = select i1 [[CMP12_2_4]], i32 [[TMP64]], i32 [[SPEC_SELECT8_1_4]]
; CHECK-NEXT:    [[TMP66:%.*]] = extractelement <16 x i32> [[TMP53]], i32 3
; CHECK-NEXT:    [[NEG_3_4:%.*]] = sub nsw i32 0, [[TMP66]]
; CHECK-NEXT:    [[TMP67:%.*]] = extractelement <16 x i1> [[TMP55]], i32 3
; CHECK-NEXT:    [[TMP68:%.*]] = select i1 [[TMP67]], i32 [[NEG_3_4]], i32 [[TMP66]]
; CHECK-NEXT:    [[CMP12_3_4:%.*]] = icmp slt i32 [[TMP68]], [[SPEC_SELECT8_2_4]]
; CHECK-NEXT:    [[TMP69:%.*]] = or i1 [[CMP12_3_4]], [[TMP65]]
; CHECK-NEXT:    [[SPEC_SELECT_3_4:%.*]] = select i1 [[TMP69]], i32 4, i32 [[SPEC_SELECT_3_3]]
; CHECK-NEXT:    [[SPEC_SELECT8_3_4:%.*]] = select i1 [[CMP12_3_4]], i32 [[TMP68]], i32 [[SPEC_SELECT8_2_4]]
; CHECK-NEXT:    [[TMP70:%.*]] = extractelement <16 x i32> [[TMP53]], i32 4
; CHECK-NEXT:    [[NEG_5:%.*]] = sub nsw i32 0, [[TMP70]]
; CHECK-NEXT:    [[TMP71:%.*]] = extractelement <16 x i1> [[TMP55]], i32 4
; CHECK-NEXT:    [[TMP72:%.*]] = select i1 [[TMP71]], i32 [[NEG_5]], i32 [[TMP70]]
; CHECK-NEXT:    [[CMP12_5:%.*]] = icmp slt i32 [[TMP72]], [[SPEC_SELECT8_3_4]]
; CHECK-NEXT:    [[SPEC_SELECT8_5:%.*]] = select i1 [[CMP12_5]], i32 [[TMP72]], i32 [[SPEC_SELECT8_3_4]]
; CHECK-NEXT:    [[TMP73:%.*]] = extractelement <16 x i32> [[TMP53]], i32 5
; CHECK-NEXT:    [[NEG_1_5:%.*]] = sub nsw i32 0, [[TMP73]]
; CHECK-NEXT:    [[TMP74:%.*]] = extractelement <16 x i1> [[TMP55]], i32 5
; CHECK-NEXT:    [[TMP75:%.*]] = select i1 [[TMP74]], i32 [[NEG_1_5]], i32 [[TMP73]]
; CHECK-NEXT:    [[CMP12_1_5:%.*]] = icmp slt i32 [[TMP75]], [[SPEC_SELECT8_5]]
; CHECK-NEXT:    [[TMP76:%.*]] = or i1 [[CMP12_1_5]], [[CMP12_5]]
; CHECK-NEXT:    [[SPEC_SELECT8_1_5:%.*]] = select i1 [[CMP12_1_5]], i32 [[TMP75]], i32 [[SPEC_SELECT8_5]]
; CHECK-NEXT:    [[TMP77:%.*]] = extractelement <16 x i32> [[TMP53]], i32 6
; CHECK-NEXT:    [[NEG_2_5:%.*]] = sub nsw i32 0, [[TMP77]]
; CHECK-NEXT:    [[TMP78:%.*]] = extractelement <16 x i1> [[TMP55]], i32 6
; CHECK-NEXT:    [[TMP79:%.*]] = select i1 [[TMP78]], i32 [[NEG_2_5]], i32 [[TMP77]]
; CHECK-NEXT:    [[CMP12_2_5:%.*]] = icmp slt i32 [[TMP79]], [[SPEC_SELECT8_1_5]]
; CHECK-NEXT:    [[TMP80:%.*]] = or i1 [[CMP12_2_5]], [[TMP76]]
; CHECK-NEXT:    [[SPEC_SELECT8_2_5:%.*]] = select i1 [[CMP12_2_5]], i32 [[TMP79]], i32 [[SPEC_SELECT8_1_5]]
; CHECK-NEXT:    [[TMP81:%.*]] = extractelement <16 x i32> [[TMP53]], i32 7
; CHECK-NEXT:    [[NEG_3_5:%.*]] = sub nsw i32 0, [[TMP81]]
; CHECK-NEXT:    [[TMP82:%.*]] = extractelement <16 x i1> [[TMP55]], i32 7
; CHECK-NEXT:    [[TMP83:%.*]] = select i1 [[TMP82]], i32 [[NEG_3_5]], i32 [[TMP81]]
; CHECK-NEXT:    [[CMP12_3_5:%.*]] = icmp slt i32 [[TMP83]], [[SPEC_SELECT8_2_5]]
; CHECK-NEXT:    [[TMP84:%.*]] = or i1 [[CMP12_3_5]], [[TMP80]]
; CHECK-NEXT:    [[SPEC_SELECT_3_5:%.*]] = select i1 [[TMP84]], i32 5, i32 [[SPEC_SELECT_3_4]]
; CHECK-NEXT:    [[SPEC_SELECT8_3_5:%.*]] = select i1 [[CMP12_3_5]], i32 [[TMP83]], i32 [[SPEC_SELECT8_2_5]]
; CHECK-NEXT:    [[TMP85:%.*]] = extractelement <16 x i32> [[TMP53]], i32 8
; CHECK-NEXT:    [[NEG_6:%.*]] = sub nsw i32 0, [[TMP85]]
; CHECK-NEXT:    [[TMP86:%.*]] = extractelement <16 x i1> [[TMP55]], i32 8
; CHECK-NEXT:    [[TMP87:%.*]] = select i1 [[TMP86]], i32 [[NEG_6]], i32 [[TMP85]]
; CHECK-NEXT:    [[CMP12_6:%.*]] = icmp slt i32 [[TMP87]], [[SPEC_SELECT8_3_5]]
; CHECK-NEXT:    [[SPEC_SELECT8_6:%.*]] = select i1 [[CMP12_6]], i32 [[TMP87]], i32 [[SPEC_SELECT8_3_5]]
; CHECK-NEXT:    [[TMP88:%.*]] = extractelement <16 x i32> [[TMP53]], i32 9
; CHECK-NEXT:    [[NEG_1_6:%.*]] = sub nsw i32 0, [[TMP88]]
; CHECK-NEXT:    [[TMP89:%.*]] = extractelement <16 x i1> [[TMP55]], i32 9
; CHECK-NEXT:    [[TMP90:%.*]] = select i1 [[TMP89]], i32 [[NEG_1_6]], i32 [[TMP88]]
; CHECK-NEXT:    [[CMP12_1_6:%.*]] = icmp slt i32 [[TMP90]], [[SPEC_SELECT8_6]]
; CHECK-NEXT:    [[TMP91:%.*]] = or i1 [[CMP12_1_6]], [[CMP12_6]]
; CHECK-NEXT:    [[SPEC_SELECT8_1_6:%.*]] = select i1 [[CMP12_1_6]], i32 [[TMP90]], i32 [[SPEC_SELECT8_6]]
; CHECK-NEXT:    [[TMP92:%.*]] = extractelement <16 x i32> [[TMP53]], i32 10
; CHECK-NEXT:    [[NEG_2_6:%.*]] = sub nsw i32 0, [[TMP92]]
; CHECK-NEXT:    [[TMP93:%.*]] = extractelement <16 x i1> [[TMP55]], i32 10
; CHECK-NEXT:    [[TMP94:%.*]] = select i1 [[TMP93]], i32 [[NEG_2_6]], i32 [[TMP92]]
; CHECK-NEXT:    [[CMP12_2_6:%.*]] = icmp slt i32 [[TMP94]], [[SPEC_SELECT8_1_6]]
; CHECK-NEXT:    [[TMP95:%.*]] = or i1 [[CMP12_2_6]], [[TMP91]]
; CHECK-NEXT:    [[SPEC_SELECT8_2_6:%.*]] = select i1 [[CMP12_2_6]], i32 [[TMP94]], i32 [[SPEC_SELECT8_1_6]]
; CHECK-NEXT:    [[TMP96:%.*]] = extractelement <16 x i32> [[TMP53]], i32 11
; CHECK-NEXT:    [[NEG_3_6:%.*]] = sub nsw i32 0, [[TMP96]]
; CHECK-NEXT:    [[TMP97:%.*]] = extractelement <16 x i1> [[TMP55]], i32 11
; CHECK-NEXT:    [[TMP98:%.*]] = select i1 [[TMP97]], i32 [[NEG_3_6]], i32 [[TMP96]]
; CHECK-NEXT:    [[CMP12_3_6:%.*]] = icmp slt i32 [[TMP98]], [[SPEC_SELECT8_2_6]]
; CHECK-NEXT:    [[TMP99:%.*]] = or i1 [[CMP12_3_6]], [[TMP95]]
; CHECK-NEXT:    [[SPEC_SELECT_3_6:%.*]] = select i1 [[TMP99]], i32 6, i32 [[SPEC_SELECT_3_5]]
; CHECK-NEXT:    [[SPEC_SELECT8_3_6:%.*]] = select i1 [[CMP12_3_6]], i32 [[TMP98]], i32 [[SPEC_SELECT8_2_6]]
; CHECK-NEXT:    [[TMP100:%.*]] = extractelement <16 x i32> [[TMP53]], i32 12
; CHECK-NEXT:    [[NEG_7:%.*]] = sub nsw i32 0, [[TMP100]]
; CHECK-NEXT:    [[TMP101:%.*]] = extractelement <16 x i1> [[TMP55]], i32 12
; CHECK-NEXT:    [[TMP102:%.*]] = select i1 [[TMP101]], i32 [[NEG_7]], i32 [[TMP100]]
; CHECK-NEXT:    [[CMP12_7:%.*]] = icmp slt i32 [[TMP102]], [[SPEC_SELECT8_3_6]]
; CHECK-NEXT:    [[SPEC_SELECT8_7:%.*]] = select i1 [[CMP12_7]], i32 [[TMP102]], i32 [[SPEC_SELECT8_3_6]]
; CHECK-NEXT:    [[TMP103:%.*]] = extractelement <16 x i32> [[TMP53]], i32 13
; CHECK-NEXT:    [[NEG_1_7:%.*]] = sub nsw i32 0, [[TMP103]]
; CHECK-NEXT:    [[TMP104:%.*]] = extractelement <16 x i1> [[TMP55]], i32 13
; CHECK-NEXT:    [[TMP105:%.*]] = select i1 [[TMP104]], i32 [[NEG_1_7]], i32 [[TMP103]]
; CHECK-NEXT:    [[CMP12_1_7:%.*]] = icmp slt i32 [[TMP105]], [[SPEC_SELECT8_7]]
; CHECK-NEXT:    [[TMP106:%.*]] = or i1 [[CMP12_1_7]], [[CMP12_7]]
; CHECK-NEXT:    [[SPEC_SELECT8_1_7:%.*]] = select i1 [[CMP12_1_7]], i32 [[TMP105]], i32 [[SPEC_SELECT8_7]]
; CHECK-NEXT:    [[TMP107:%.*]] = extractelement <16 x i32> [[TMP53]], i32 14
; CHECK-NEXT:    [[NEG_2_7:%.*]] = sub nsw i32 0, [[TMP107]]
; CHECK-NEXT:    [[TMP108:%.*]] = extractelement <16 x i1> [[TMP55]], i32 14
; CHECK-NEXT:    [[TMP109:%.*]] = select i1 [[TMP108]], i32 [[NEG_2_7]], i32 [[TMP107]]
; CHECK-NEXT:    [[CMP12_2_7:%.*]] = icmp slt i32 [[TMP109]], [[SPEC_SELECT8_1_7]]
; CHECK-NEXT:    [[TMP110:%.*]] = or i1 [[CMP12_2_7]], [[TMP106]]
; CHECK-NEXT:    [[SPEC_SELECT8_2_7:%.*]] = select i1 [[CMP12_2_7]], i32 [[TMP109]], i32 [[SPEC_SELECT8_1_7]]
; CHECK-NEXT:    [[TMP111:%.*]] = extractelement <16 x i32> [[TMP53]], i32 15
; CHECK-NEXT:    [[NEG_3_7:%.*]] = sub nsw i32 0, [[TMP111]]
; CHECK-NEXT:    [[TMP112:%.*]] = extractelement <16 x i1> [[TMP55]], i32 15
; CHECK-NEXT:    [[TMP113:%.*]] = select i1 [[TMP112]], i32 [[NEG_3_7]], i32 [[TMP111]]
; CHECK-NEXT:    [[CMP12_3_7:%.*]] = icmp slt i32 [[TMP113]], [[SPEC_SELECT8_2_7]]
; CHECK-NEXT:    [[TMP114:%.*]] = or i1 [[CMP12_3_7]], [[TMP110]]
; CHECK-NEXT:    [[SPEC_SELECT_3_7:%.*]] = select i1 [[TMP114]], i32 7, i32 [[SPEC_SELECT_3_6]]
; CHECK-NEXT:    [[SPEC_SELECT8_3_7]] = select i1 [[CMP12_3_7]], i32 [[TMP113]], i32 [[SPEC_SELECT8_2_7]]
; CHECK-NEXT:    [[K:%.*]] = getelementptr inbounds [366 x i32], [366 x i32]* @l, i64 0, i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 [[SPEC_SELECT_3_7]], i32* [[K]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br label [[FOR_COND]]
;
entry:
  %0 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 0, i64 0), align 16
  %1 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 0, i64 1), align 4
  %2 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 0, i64 2), align 8
  %3 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 0, i64 3), align 4
  %4 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 1, i64 0), align 16
  %5 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 1, i64 1), align 4
  %6 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 1, i64 2), align 8
  %7 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 1, i64 3), align 4
  %8 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 2, i64 0), align 16
  %9 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 2, i64 1), align 4
  %10 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 2, i64 2), align 8
  %11 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 2, i64 3), align 4
  %12 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 3, i64 0), align 16
  %13 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 3, i64 1), align 4
  %14 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 3, i64 2), align 8
  %15 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 3, i64 3), align 4
  %16 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 4, i64 0), align 16
  %17 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 4, i64 1), align 4
  %18 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 4, i64 2), align 8
  %19 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 4, i64 3), align 4
  %20 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 5, i64 0), align 16
  %21 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 5, i64 1), align 4
  %22 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 5, i64 2), align 8
  %23 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 5, i64 3), align 4
  %24 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 6, i64 0), align 16
  %25 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 6, i64 1), align 4
  %26 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 6, i64 2), align 8
  %27 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 6, i64 3), align 4
  %28 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 7, i64 0), align 16
  %29 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 7, i64 1), align 4
  %30 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 7, i64 2), align 8
  %31 = load i32, i32* getelementptr inbounds ([8 x [4 x i32]], [8 x [4 x i32]]* @k, i64 0, i64 7, i64 3), align 4
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.cond ], [ 0, %entry ]
  %b.0 = phi i32 [ %spec.select8.3.7, %for.cond ], [ undef, %entry ]
  %32 = trunc i64 %indvars.iv to i32
  %33 = add i32 %32, -183
  %sub = sub i32 %33, %0
  %34 = icmp slt i32 %sub, 0
  %neg = sub nsw i32 0, %sub
  %35 = select i1 %34, i32 %neg, i32 %sub
  %cmp12 = icmp slt i32 %35, %b.0
  %spec.select8 = select i1 %cmp12, i32 %35, i32 %b.0
  %sub.1 = sub i32 %33, %1
  %36 = icmp slt i32 %sub.1, 0
  %neg.1 = sub nsw i32 0, %sub.1
  %37 = select i1 %36, i32 %neg.1, i32 %sub.1
  %cmp12.1 = icmp slt i32 %37, %spec.select8
  %spec.select8.1 = select i1 %cmp12.1, i32 %37, i32 %spec.select8
  %sub.2 = sub i32 %33, %2
  %38 = icmp slt i32 %sub.2, 0
  %neg.2 = sub nsw i32 0, %sub.2
  %39 = select i1 %38, i32 %neg.2, i32 %sub.2
  %cmp12.2 = icmp slt i32 %39, %spec.select8.1
  %spec.select8.2 = select i1 %cmp12.2, i32 %39, i32 %spec.select8.1
  %sub.3 = sub i32 %33, %3
  %40 = icmp slt i32 %sub.3, 0
  %neg.3 = sub nsw i32 0, %sub.3
  %41 = select i1 %40, i32 %neg.3, i32 %sub.3
  %cmp12.3 = icmp slt i32 %41, %spec.select8.2
  %spec.select8.3 = select i1 %cmp12.3, i32 %41, i32 %spec.select8.2
  %sub.116 = sub i32 %33, %4
  %42 = icmp slt i32 %sub.116, 0
  %neg.117 = sub nsw i32 0, %sub.116
  %43 = select i1 %42, i32 %neg.117, i32 %sub.116
  %cmp12.118 = icmp slt i32 %43, %spec.select8.3
  %spec.select8.120 = select i1 %cmp12.118, i32 %43, i32 %spec.select8.3
  %sub.1.1 = sub i32 %33, %5
  %44 = icmp slt i32 %sub.1.1, 0
  %neg.1.1 = sub nsw i32 0, %sub.1.1
  %45 = select i1 %44, i32 %neg.1.1, i32 %sub.1.1
  %cmp12.1.1 = icmp slt i32 %45, %spec.select8.120
  %narrow = or i1 %cmp12.1.1, %cmp12.118
  %spec.select8.1.1 = select i1 %cmp12.1.1, i32 %45, i32 %spec.select8.120
  %sub.2.1 = sub i32 %33, %6
  %46 = icmp slt i32 %sub.2.1, 0
  %neg.2.1 = sub nsw i32 0, %sub.2.1
  %47 = select i1 %46, i32 %neg.2.1, i32 %sub.2.1
  %cmp12.2.1 = icmp slt i32 %47, %spec.select8.1.1
  %narrow34 = or i1 %cmp12.2.1, %narrow
  %spec.select8.2.1 = select i1 %cmp12.2.1, i32 %47, i32 %spec.select8.1.1
  %sub.3.1 = sub i32 %33, %7
  %48 = icmp slt i32 %sub.3.1, 0
  %neg.3.1 = sub nsw i32 0, %sub.3.1
  %49 = select i1 %48, i32 %neg.3.1, i32 %sub.3.1
  %cmp12.3.1 = icmp slt i32 %49, %spec.select8.2.1
  %narrow35 = or i1 %cmp12.3.1, %narrow34
  %spec.select.3.1 = zext i1 %narrow35 to i32
  %spec.select8.3.1 = select i1 %cmp12.3.1, i32 %49, i32 %spec.select8.2.1
  %sub.222 = sub i32 %33, %8
  %50 = icmp slt i32 %sub.222, 0
  %neg.223 = sub nsw i32 0, %sub.222
  %51 = select i1 %50, i32 %neg.223, i32 %sub.222
  %cmp12.224 = icmp slt i32 %51, %spec.select8.3.1
  %spec.select8.226 = select i1 %cmp12.224, i32 %51, i32 %spec.select8.3.1
  %sub.1.2 = sub i32 %33, %9
  %52 = icmp slt i32 %sub.1.2, 0
  %neg.1.2 = sub nsw i32 0, %sub.1.2
  %53 = select i1 %52, i32 %neg.1.2, i32 %sub.1.2
  %cmp12.1.2 = icmp slt i32 %53, %spec.select8.226
  %54 = or i1 %cmp12.1.2, %cmp12.224
  %spec.select8.1.2 = select i1 %cmp12.1.2, i32 %53, i32 %spec.select8.226
  %sub.2.2 = sub i32 %33, %10
  %55 = icmp slt i32 %sub.2.2, 0
  %neg.2.2 = sub nsw i32 0, %sub.2.2
  %56 = select i1 %55, i32 %neg.2.2, i32 %sub.2.2
  %cmp12.2.2 = icmp slt i32 %56, %spec.select8.1.2
  %57 = or i1 %cmp12.2.2, %54
  %spec.select8.2.2 = select i1 %cmp12.2.2, i32 %56, i32 %spec.select8.1.2
  %sub.3.2 = sub i32 %33, %11
  %58 = icmp slt i32 %sub.3.2, 0
  %neg.3.2 = sub nsw i32 0, %sub.3.2
  %59 = select i1 %58, i32 %neg.3.2, i32 %sub.3.2
  %cmp12.3.2 = icmp slt i32 %59, %spec.select8.2.2
  %60 = or i1 %cmp12.3.2, %57
  %spec.select.3.2 = select i1 %60, i32 2, i32 %spec.select.3.1
  %spec.select8.3.2 = select i1 %cmp12.3.2, i32 %59, i32 %spec.select8.2.2
  %sub.328 = sub i32 %33, %12
  %61 = icmp slt i32 %sub.328, 0
  %neg.329 = sub nsw i32 0, %sub.328
  %62 = select i1 %61, i32 %neg.329, i32 %sub.328
  %cmp12.330 = icmp slt i32 %62, %spec.select8.3.2
  %spec.select8.332 = select i1 %cmp12.330, i32 %62, i32 %spec.select8.3.2
  %sub.1.3 = sub i32 %33, %13
  %63 = icmp slt i32 %sub.1.3, 0
  %neg.1.3 = sub nsw i32 0, %sub.1.3
  %64 = select i1 %63, i32 %neg.1.3, i32 %sub.1.3
  %cmp12.1.3 = icmp slt i32 %64, %spec.select8.332
  %65 = or i1 %cmp12.1.3, %cmp12.330
  %spec.select8.1.3 = select i1 %cmp12.1.3, i32 %64, i32 %spec.select8.332
  %sub.2.3 = sub i32 %33, %14
  %66 = icmp slt i32 %sub.2.3, 0
  %neg.2.3 = sub nsw i32 0, %sub.2.3
  %67 = select i1 %66, i32 %neg.2.3, i32 %sub.2.3
  %cmp12.2.3 = icmp slt i32 %67, %spec.select8.1.3
  %68 = or i1 %cmp12.2.3, %65
  %spec.select8.2.3 = select i1 %cmp12.2.3, i32 %67, i32 %spec.select8.1.3
  %sub.3.3 = sub i32 %33, %15
  %69 = icmp slt i32 %sub.3.3, 0
  %neg.3.3 = sub nsw i32 0, %sub.3.3
  %70 = select i1 %69, i32 %neg.3.3, i32 %sub.3.3
  %cmp12.3.3 = icmp slt i32 %70, %spec.select8.2.3
  %71 = or i1 %cmp12.3.3, %68
  %spec.select.3.3 = select i1 %71, i32 3, i32 %spec.select.3.2
  %spec.select8.3.3 = select i1 %cmp12.3.3, i32 %70, i32 %spec.select8.2.3
  %sub.4 = sub i32 %33, %16
  %72 = icmp slt i32 %sub.4, 0
  %neg.4 = sub nsw i32 0, %sub.4
  %73 = select i1 %72, i32 %neg.4, i32 %sub.4
  %cmp12.4 = icmp slt i32 %73, %spec.select8.3.3
  %spec.select8.4 = select i1 %cmp12.4, i32 %73, i32 %spec.select8.3.3
  %sub.1.4 = sub i32 %33, %17
  %74 = icmp slt i32 %sub.1.4, 0
  %neg.1.4 = sub nsw i32 0, %sub.1.4
  %75 = select i1 %74, i32 %neg.1.4, i32 %sub.1.4
  %cmp12.1.4 = icmp slt i32 %75, %spec.select8.4
  %76 = or i1 %cmp12.1.4, %cmp12.4
  %spec.select8.1.4 = select i1 %cmp12.1.4, i32 %75, i32 %spec.select8.4
  %sub.2.4 = sub i32 %33, %18
  %77 = icmp slt i32 %sub.2.4, 0
  %neg.2.4 = sub nsw i32 0, %sub.2.4
  %78 = select i1 %77, i32 %neg.2.4, i32 %sub.2.4
  %cmp12.2.4 = icmp slt i32 %78, %spec.select8.1.4
  %79 = or i1 %cmp12.2.4, %76
  %spec.select8.2.4 = select i1 %cmp12.2.4, i32 %78, i32 %spec.select8.1.4
  %sub.3.4 = sub i32 %33, %19
  %80 = icmp slt i32 %sub.3.4, 0
  %neg.3.4 = sub nsw i32 0, %sub.3.4
  %81 = select i1 %80, i32 %neg.3.4, i32 %sub.3.4
  %cmp12.3.4 = icmp slt i32 %81, %spec.select8.2.4
  %82 = or i1 %cmp12.3.4, %79
  %spec.select.3.4 = select i1 %82, i32 4, i32 %spec.select.3.3
  %spec.select8.3.4 = select i1 %cmp12.3.4, i32 %81, i32 %spec.select8.2.4
  %sub.5 = sub i32 %33, %20
  %83 = icmp slt i32 %sub.5, 0
  %neg.5 = sub nsw i32 0, %sub.5
  %84 = select i1 %83, i32 %neg.5, i32 %sub.5
  %cmp12.5 = icmp slt i32 %84, %spec.select8.3.4
  %spec.select8.5 = select i1 %cmp12.5, i32 %84, i32 %spec.select8.3.4
  %sub.1.5 = sub i32 %33, %21
  %85 = icmp slt i32 %sub.1.5, 0
  %neg.1.5 = sub nsw i32 0, %sub.1.5
  %86 = select i1 %85, i32 %neg.1.5, i32 %sub.1.5
  %cmp12.1.5 = icmp slt i32 %86, %spec.select8.5
  %87 = or i1 %cmp12.1.5, %cmp12.5
  %spec.select8.1.5 = select i1 %cmp12.1.5, i32 %86, i32 %spec.select8.5
  %sub.2.5 = sub i32 %33, %22
  %88 = icmp slt i32 %sub.2.5, 0
  %neg.2.5 = sub nsw i32 0, %sub.2.5
  %89 = select i1 %88, i32 %neg.2.5, i32 %sub.2.5
  %cmp12.2.5 = icmp slt i32 %89, %spec.select8.1.5
  %90 = or i1 %cmp12.2.5, %87
  %spec.select8.2.5 = select i1 %cmp12.2.5, i32 %89, i32 %spec.select8.1.5
  %sub.3.5 = sub i32 %33, %23
  %91 = icmp slt i32 %sub.3.5, 0
  %neg.3.5 = sub nsw i32 0, %sub.3.5
  %92 = select i1 %91, i32 %neg.3.5, i32 %sub.3.5
  %cmp12.3.5 = icmp slt i32 %92, %spec.select8.2.5
  %93 = or i1 %cmp12.3.5, %90
  %spec.select.3.5 = select i1 %93, i32 5, i32 %spec.select.3.4
  %spec.select8.3.5 = select i1 %cmp12.3.5, i32 %92, i32 %spec.select8.2.5
  %sub.6 = sub i32 %33, %24
  %94 = icmp slt i32 %sub.6, 0
  %neg.6 = sub nsw i32 0, %sub.6
  %95 = select i1 %94, i32 %neg.6, i32 %sub.6
  %cmp12.6 = icmp slt i32 %95, %spec.select8.3.5
  %spec.select8.6 = select i1 %cmp12.6, i32 %95, i32 %spec.select8.3.5
  %sub.1.6 = sub i32 %33, %25
  %96 = icmp slt i32 %sub.1.6, 0
  %neg.1.6 = sub nsw i32 0, %sub.1.6
  %97 = select i1 %96, i32 %neg.1.6, i32 %sub.1.6
  %cmp12.1.6 = icmp slt i32 %97, %spec.select8.6
  %98 = or i1 %cmp12.1.6, %cmp12.6
  %spec.select8.1.6 = select i1 %cmp12.1.6, i32 %97, i32 %spec.select8.6
  %sub.2.6 = sub i32 %33, %26
  %99 = icmp slt i32 %sub.2.6, 0
  %neg.2.6 = sub nsw i32 0, %sub.2.6
  %100 = select i1 %99, i32 %neg.2.6, i32 %sub.2.6
  %cmp12.2.6 = icmp slt i32 %100, %spec.select8.1.6
  %101 = or i1 %cmp12.2.6, %98
  %spec.select8.2.6 = select i1 %cmp12.2.6, i32 %100, i32 %spec.select8.1.6
  %sub.3.6 = sub i32 %33, %27
  %102 = icmp slt i32 %sub.3.6, 0
  %neg.3.6 = sub nsw i32 0, %sub.3.6
  %103 = select i1 %102, i32 %neg.3.6, i32 %sub.3.6
  %cmp12.3.6 = icmp slt i32 %103, %spec.select8.2.6
  %104 = or i1 %cmp12.3.6, %101
  %spec.select.3.6 = select i1 %104, i32 6, i32 %spec.select.3.5
  %spec.select8.3.6 = select i1 %cmp12.3.6, i32 %103, i32 %spec.select8.2.6
  %sub.7 = sub i32 %33, %28
  %105 = icmp slt i32 %sub.7, 0
  %neg.7 = sub nsw i32 0, %sub.7
  %106 = select i1 %105, i32 %neg.7, i32 %sub.7
  %cmp12.7 = icmp slt i32 %106, %spec.select8.3.6
  %spec.select8.7 = select i1 %cmp12.7, i32 %106, i32 %spec.select8.3.6
  %sub.1.7 = sub i32 %33, %29
  %107 = icmp slt i32 %sub.1.7, 0
  %neg.1.7 = sub nsw i32 0, %sub.1.7
  %108 = select i1 %107, i32 %neg.1.7, i32 %sub.1.7
  %cmp12.1.7 = icmp slt i32 %108, %spec.select8.7
  %109 = or i1 %cmp12.1.7, %cmp12.7
  %spec.select8.1.7 = select i1 %cmp12.1.7, i32 %108, i32 %spec.select8.7
  %sub.2.7 = sub i32 %33, %30
  %110 = icmp slt i32 %sub.2.7, 0
  %neg.2.7 = sub nsw i32 0, %sub.2.7
  %111 = select i1 %110, i32 %neg.2.7, i32 %sub.2.7
  %cmp12.2.7 = icmp slt i32 %111, %spec.select8.1.7
  %112 = or i1 %cmp12.2.7, %109
  %spec.select8.2.7 = select i1 %cmp12.2.7, i32 %111, i32 %spec.select8.1.7
  %sub.3.7 = sub i32 %33, %31
  %113 = icmp slt i32 %sub.3.7, 0
  %neg.3.7 = sub nsw i32 0, %sub.3.7
  %114 = select i1 %113, i32 %neg.3.7, i32 %sub.3.7
  %cmp12.3.7 = icmp slt i32 %114, %spec.select8.2.7
  %115 = or i1 %cmp12.3.7, %112
  %spec.select.3.7 = select i1 %115, i32 7, i32 %spec.select.3.6
  %spec.select8.3.7 = select i1 %cmp12.3.7, i32 %114, i32 %spec.select8.2.7
  %k = getelementptr inbounds [366 x i32], [366 x i32]* @l, i64 0, i64 %indvars.iv
  store i32 %spec.select.3.7, i32* %k, align 4
  %indvars.iv.next = add i64 %indvars.iv, 1
  br label %for.cond
}


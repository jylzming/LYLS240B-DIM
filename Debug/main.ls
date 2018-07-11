   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3213                     	bsct
3214  0000               _second:
3215  0000 0000          	dc.w	0
3216  0002               _hour:
3217  0002 0000          	dc.w	0
3218  0004               _brightness:
3219  0004 28            	dc.b	40
3220  0005               _relayStat:
3221  0005 00            	dc.b	0
3222  0006               _isDimmingConfiged:
3223  0006 00            	dc.b	0
3224  0007               _timeChanged:
3225  0007 00            	dc.b	0
3226  0008               L3712_ex_state:
3227  0008 00            	dc.b	0
3316                     ; 26 void DimmingMode(Mode mode)
3316                     ; 27 {
3318                     	switch	.text
3319  0000               _DimmingMode:
3321  0000 88            	push	a
3322       00000000      OFST:	set	0
3325                     ; 28 	if(LIGHT == ON)
3327                     	btst	_PC_ODR_5
3328  0006 2530          	jrult	L1622
3329                     ; 30 		switch (mode)
3331  0008 0d01          	tnz	(OFST+1,sp)
3332  000a 262c          	jrne	L1622
3335  000c               L5712:
3336                     ; 32 			case MODE0:
3336                     ; 33 				if(hour >= 0 && hour < 6)
3338  000c be02          	ldw	x,_hour
3339  000e a30006        	cpw	x,#6
3340  0011 2406          	jruge	L7622
3341                     ; 34 					state = STATE1;
3343  0013 35010000      	mov	_state,#1
3345  0017 201f          	jra	L1622
3346  0019               L7622:
3347                     ; 35 				else if(hour >= 6 && hour < 10)//(hour >= 6 && hour < 10)
3349  0019 be02          	ldw	x,_hour
3350  001b a30006        	cpw	x,#6
3351  001e 250d          	jrult	L3722
3353  0020 be02          	ldw	x,_hour
3354  0022 a3000a        	cpw	x,#10
3355  0025 2406          	jruge	L3722
3356                     ; 36 					state = STATE2;
3358  0027 35020000      	mov	_state,#2
3360  002b 200b          	jra	L1622
3361  002d               L3722:
3362                     ; 37 				else if(hour >= 10) 
3364  002d be02          	ldw	x,_hour
3365  002f a3000a        	cpw	x,#10
3366  0032 2504          	jrult	L1622
3367                     ; 38 					state = STATE3;
3369  0034 35030000      	mov	_state,#3
3370  0038               L7712:
3371                     ; 41 			case MODE1:		break;
3373  0038               L1022:
3374                     ; 42 			case MODE2: 	break;
3376  0038               L3022:
3377                     ; 43 			case MODE3: 	break;
3379  0038               L5022:
3380                     ; 44 			default:			break;
3382  0038               L1622:
3383                     ; 48 	if(ex_state != state)
3385  0038 b608          	ld	a,L3712_ex_state
3386  003a b100          	cp	a,_state
3387  003c 2741          	jreq	L7032
3388                     ; 50 		switch (state)
3390  003e b600          	ld	a,_state
3392                     ; 56 			default: break;
3393  0040 4d            	tnz	a
3394  0041 270b          	jreq	L7022
3395  0043 4a            	dec	a
3396  0044 2713          	jreq	L1122
3397  0046 4a            	dec	a
3398  0047 271d          	jreq	L3122
3399  0049 4a            	dec	a
3400  004a 2728          	jreq	L5122
3401  004c 2031          	jra	L7032
3402  004e               L7022:
3403                     ; 52 			case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
3405  004e 5f            	clrw	x
3406  004f 89            	pushw	x
3407  0050 ae0064        	ldw	x,#100
3408  0053 cd0000        	call	_PWM_Config
3410  0056 85            	popw	x
3413  0057 2026          	jra	L7032
3414  0059               L1122:
3415                     ; 53 			case STATE1:	PWM_Config(100, 100);	break;
3417  0059 ae0064        	ldw	x,#100
3418  005c 89            	pushw	x
3419  005d ae0064        	ldw	x,#100
3420  0060 cd0000        	call	_PWM_Config
3422  0063 85            	popw	x
3425  0064 2019          	jra	L7032
3426  0066               L3122:
3427                     ; 54 			case STATE2:	PWM_Config(100, brightness);	break;			
3429  0066 b604          	ld	a,_brightness
3430  0068 5f            	clrw	x
3431  0069 97            	ld	xl,a
3432  006a 89            	pushw	x
3433  006b ae0064        	ldw	x,#100
3434  006e cd0000        	call	_PWM_Config
3436  0071 85            	popw	x
3439  0072 200b          	jra	L7032
3440  0074               L5122:
3441                     ; 55 			case STATE3:	PWM_Config(100, 20);	break;			
3443  0074 ae0014        	ldw	x,#20
3444  0077 89            	pushw	x
3445  0078 ae0064        	ldw	x,#100
3446  007b cd0000        	call	_PWM_Config
3448  007e 85            	popw	x
3451  007f               L7122:
3452                     ; 56 			default: break;
3454  007f               L5032:
3456  007f               L7032:
3457                     ; 59 	ex_state = state;
3459  007f 450008        	mov	L3712_ex_state,_state
3460                     ; 60 }
3463  0082 84            	pop	a
3464  0083 81            	ret
3467                     	bsct
3468  0009               L1132_adcData:
3469  0009 0000          	dc.w	0
3470  000b 0000          	dc.w	0
3471  000d 0000          	dc.w	0
3472  000f 0000          	dc.w	0
3560                     ; 63 main()
3560                     ; 64 {
3561                     	switch	.text
3562  0084               _main:
3564  0084 89            	pushw	x
3565       00000002      OFST:	set	2
3568                     ; 65 	unsigned char i = 0;
3570  0085 0f02          	clr	(OFST+0,sp)
3571                     ; 66 	bool exRelayStat = OFF;
3573  0087 a601          	ld	a,#1
3574  0089 6b01          	ld	(OFST-1,sp),a
3575                     ; 69 	CLK_CKDIVR = 0x08;//f = f HSI RCÊä³ö/2=8MHz
3577  008b 350850c6      	mov	_CLK_CKDIVR,#8
3578                     ; 72 	PWM_GPIO_Config();
3580  008f cd0000        	call	_PWM_GPIO_Config
3582                     ; 75 	InitADC();	
3584  0092 cd0000        	call	_InitADC
3586                     ; 76 	adcData[0] = adcData[1] = adcData[2] = adcData[3] = GetADC();
3588  0095 cd0000        	call	_GetADC
3590  0098 bf0f          	ldw	L1132_adcData+6,x
3591  009a be0f          	ldw	x,L1132_adcData+6
3592  009c bf0d          	ldw	L1132_adcData+4,x
3593  009e be0d          	ldw	x,L1132_adcData+4
3594  00a0 bf0b          	ldw	L1132_adcData+2,x
3595  00a2 be0b          	ldw	x,L1132_adcData+2
3596  00a4 bf09          	ldw	L1132_adcData,x
3597                     ; 77 	Rly_GPIO_Config();
3599  00a6 cd0000        	call	_Rly_GPIO_Config
3601                     ; 78 	if(adcData[0] < ON_LUX)//initial LIGHT IO
3603  00a9 be09          	ldw	x,L1132_adcData
3604  00ab a30dde        	cpw	x,#3550
3605  00ae 240f          	jruge	L1532
3606                     ; 80 		LIGHT = OFF;
3608  00b0 721a500a      	bset	_PC_ODR_5
3609                     ; 81 		PWM_Config(100, 0);//PWM off
3611  00b4 5f            	clrw	x
3612  00b5 89            	pushw	x
3613  00b6 ae0064        	ldw	x,#100
3614  00b9 cd0000        	call	_PWM_Config
3616  00bc 85            	popw	x
3618  00bd 200f          	jra	L3532
3619  00bf               L1532:
3620                     ; 85 		LIGHT = ON;
3622  00bf 721b500a      	bres	_PC_ODR_5
3623                     ; 86 		PWM_Config(100, 100);//PWM off
3625  00c3 ae0064        	ldw	x,#100
3626  00c6 89            	pushw	x
3627  00c7 ae0064        	ldw	x,#100
3628  00ca cd0000        	call	_PWM_Config
3630  00cd 85            	popw	x
3631  00ce               L3532:
3632                     ; 90 	TIM1_Init();
3634  00ce cd0000        	call	_TIM1_Init
3636  00d1               L5532:
3637                     ; 94 		adcData[i++] = GetADC();
3639  00d1 cd0000        	call	_GetADC
3641  00d4 7b02          	ld	a,(OFST+0,sp)
3642  00d6 9097          	ld	yl,a
3643  00d8 0c02          	inc	(OFST+0,sp)
3644  00da 909f          	ld	a,yl
3645  00dc 905f          	clrw	y
3646  00de 9097          	ld	yl,a
3647  00e0 9058          	sllw	y
3648  00e2 90ef09        	ldw	(L1132_adcData,y),x
3649                     ; 95 		if(i > 4)	i = 0;
3651  00e5 7b02          	ld	a,(OFST+0,sp)
3652  00e7 a105          	cp	a,#5
3653  00e9 2502          	jrult	L1632
3656  00eb 0f02          	clr	(OFST+0,sp)
3657  00ed               L1632:
3658                     ; 98 		if(adcData[0] < OFF_LUX && adcData[1] < OFF_LUX && adcData[2] < OFF_LUX && adcData[3] < OFF_LUX)
3660  00ed be09          	ldw	x,L1132_adcData
3661  00ef a309c4        	cpw	x,#2500
3662  00f2 243d          	jruge	L3632
3664  00f4 be0b          	ldw	x,L1132_adcData+2
3665  00f6 a309c4        	cpw	x,#2500
3666  00f9 2436          	jruge	L3632
3668  00fb be0d          	ldw	x,L1132_adcData+4
3669  00fd a309c4        	cpw	x,#2500
3670  0100 242f          	jruge	L3632
3672  0102 be0f          	ldw	x,L1132_adcData+6
3673  0104 a309c4        	cpw	x,#2500
3674  0107 2428          	jruge	L3632
3675                     ; 100 			if(LIGHT == ON)//only when light on/off change 
3677                     	btst	_PC_ODR_5
3678  010e 2511          	jrult	L5632
3679                     ; 102 				LIGHT = OFF;//Relay_IO = 1
3681  0110 721a500a      	bset	_PC_ODR_5
3682                     ; 103 				PWM_Config(100, 0);//PWM off
3684  0114 5f            	clrw	x
3685  0115 89            	pushw	x
3686  0116 ae0064        	ldw	x,#100
3687  0119 cd0000        	call	_PWM_Config
3689  011c 85            	popw	x
3690                     ; 104 				TIM1_CR1 &= 0xFE;//stop time counter
3692  011d 72115250      	bres	_TIM1_CR1,#0
3693  0121               L5632:
3694                     ; 106 			if(state != STATE0)
3696  0121 3d00          	tnz	_state
3697  0123 2704          	jreq	L7632
3698                     ; 107 				ex_state = state = STATE0;
3700  0125 3f00          	clr	_state
3701  0127 3f08          	clr	L3712_ex_state
3702  0129               L7632:
3703                     ; 109 			second = 0;
3705  0129 5f            	clrw	x
3706  012a bf00          	ldw	_second,x
3707                     ; 110 			hour = 0;
3709  012c 5f            	clrw	x
3710  012d bf02          	ldw	_hour,x
3712  012f 204b          	jra	L1732
3713  0131               L3632:
3714                     ; 113 		else if(adcData[0] > ON_LUX && adcData[1] > ON_LUX && adcData[2] > ON_LUX && adcData[3] > ON_LUX)
3716  0131 be09          	ldw	x,L1132_adcData
3717  0133 a30ddf        	cpw	x,#3551
3718  0136 2544          	jrult	L1732
3720  0138 be0b          	ldw	x,L1132_adcData+2
3721  013a a30ddf        	cpw	x,#3551
3722  013d 253d          	jrult	L1732
3724  013f be0d          	ldw	x,L1132_adcData+4
3725  0141 a30ddf        	cpw	x,#3551
3726  0144 2536          	jrult	L1732
3728  0146 be0f          	ldw	x,L1132_adcData+6
3729  0148 a30ddf        	cpw	x,#3551
3730  014b 252f          	jrult	L1732
3731                     ; 115 			if(LIGHT == OFF)//only when light on/off change 
3733                     	btst	_PC_ODR_5
3734  0152 2404          	jruge	L5732
3735                     ; 117 				LIGHT = ON;
3737  0154 721b500a      	bres	_PC_ODR_5
3738  0158               L5732:
3739                     ; 119 			if((TIM1_CR1 & 0x01) == 0)//if time counter not started, start counting
3741  0158 c65250        	ld	a,_TIM1_CR1
3742  015b a501          	bcp	a,#1
3743  015d 260e          	jrne	L7732
3744                     ; 121 				second = 0;
3746  015f 5f            	clrw	x
3747  0160 bf00          	ldw	_second,x
3748                     ; 122 				hour = 0;
3750  0162 5f            	clrw	x
3751  0163 bf02          	ldw	_hour,x
3752                     ; 123 				TIM1_CR1 |= 0x01;//start time counter
3754  0165 72105250      	bset	_TIM1_CR1,#0
3755                     ; 124 				TIM1_IER |= 0x01;				
3757  0169 72105254      	bset	_TIM1_IER,#0
3758  016d               L7732:
3759                     ; 126 			if(state == STATE0)
3761  016d 3d00          	tnz	_state
3762  016f 260b          	jrne	L1732
3763                     ; 128 				PWM_Config(100, 100);
3765  0171 ae0064        	ldw	x,#100
3766  0174 89            	pushw	x
3767  0175 ae0064        	ldw	x,#100
3768  0178 cd0000        	call	_PWM_Config
3770  017b 85            	popw	x
3771  017c               L1732:
3772                     ; 133 		DimmingMode(MODE0);
3774  017c 4f            	clr	a
3775  017d cd0000        	call	_DimmingMode
3777                     ; 134 		Delay();
3779  0180 cd0000        	call	_Delay
3782  0183 acd100d1      	jpf	L5532
3820                     ; 139 @far @interrupt void TIM1_UPD_IRQHandler(void)
3820                     ; 140 {
3822                     	switch	.text
3823  0187               f_TIM1_UPD_IRQHandler:
3826       00000001      OFST:	set	1
3827  0187 88            	push	a
3830                     ; 141 	unsigned char i = 0;
3832  0188 0f01          	clr	(OFST+0,sp)
3833                     ; 142 	TIM1_SR1 &= 0xFE;//clear interrupt label
3835  018a 72115255      	bres	_TIM1_SR1,#0
3836                     ; 143 	second++;
3838  018e be00          	ldw	x,_second
3839  0190 1c0001        	addw	x,#1
3840  0193 bf00          	ldw	_second,x
3841                     ; 144 	if(second == 3600)/***********´ý±ä¸ü£¡£¡£¡£¡£¡***************/
3843  0195 be00          	ldw	x,_second
3844  0197 a30e10        	cpw	x,#3600
3845  019a 260a          	jrne	L3242
3846                     ; 146 		second = 0;
3848  019c 5f            	clrw	x
3849  019d bf00          	ldw	_second,x
3850                     ; 147 		hour += 1;
3852  019f be02          	ldw	x,_hour
3853  01a1 1c0001        	addw	x,#1
3854  01a4 bf02          	ldw	_hour,x
3855  01a6               L3242:
3856                     ; 151 }
3859  01a6 84            	pop	a
3860  01a7 80            	iret
3985                     	xdef	f_TIM1_UPD_IRQHandler
3986                     	xdef	_main
3987                     	xdef	_DimmingMode
3988                     	switch	.ubsct
3989  0000               _state:
3990  0000 00            	ds.b	1
3991                     	xdef	_state
3992                     	xdef	_relayStat
3993                     	xdef	_timeChanged
3994                     	xdef	_isDimmingConfiged
3995                     	xdef	_brightness
3996                     	xdef	_hour
3997                     	xdef	_second
3998                     	xref	_TIM1_Init
3999                     	xref	_Delay
4000                     	xref	_GetADC
4001                     	xref	_InitADC
4002                     	xref	_PWM_GPIO_Config
4003                     	xref	_PWM_Config
4004                     	xref	_Rly_GPIO_Config
4024                     	end

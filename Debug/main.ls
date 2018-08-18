   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3213                     	bsct
3214  0000               _brightness:
3215  0000 23            	dc.b	35
3216  0001               _second:
3217  0001 0000          	dc.w	0
3218  0003               _hour:
3219  0003 0000          	dc.w	0
3220  0005               _relayStat:
3221  0005 00            	dc.b	0
3222  0006               _isDimmingConfiged:
3223  0006 00            	dc.b	0
3224  0007               _timeChanged:
3225  0007 00            	dc.b	0
3226  0008               L3712_ex_state:
3227  0008 00            	dc.b	0
3316                     ; 29 void DimmingMode(Mode mode)
3316                     ; 30 {
3318                     	switch	.text
3319  0000               _DimmingMode:
3321  0000 88            	push	a
3322       00000000      OFST:	set	0
3325                     ; 31 	if(LIGHT == ON)
3327                     	btst	_PC_ODR_5
3328  0006 2550          	jrult	L1622
3329                     ; 33 		switch (mode)
3331  0008 7b01          	ld	a,(OFST+1,sp)
3333                     ; 52 			default:			break;
3334  000a 4d            	tnz	a
3335  000b 2705          	jreq	L5712
3336  000d 4a            	dec	a
3337  000e 2730          	jreq	L7712
3338  0010 2046          	jra	L1622
3339  0012               L5712:
3340                     ; 35 			case MODE0:
3340                     ; 36 				if(hour >= 0 && hour < 6)
3342  0012 be03          	ldw	x,_hour
3343  0014 a30006        	cpw	x,#6
3344  0017 2406          	jruge	L7622
3345                     ; 37 					state = STATE1;
3347  0019 35010000      	mov	_state,#1
3349  001d 2039          	jra	L1622
3350  001f               L7622:
3351                     ; 38 				else if(hour >= 6 && hour < 10)//(hour >= 6 && hour < 10)
3353  001f be03          	ldw	x,_hour
3354  0021 a30006        	cpw	x,#6
3355  0024 250d          	jrult	L3722
3357  0026 be03          	ldw	x,_hour
3358  0028 a3000a        	cpw	x,#10
3359  002b 2406          	jruge	L3722
3360                     ; 39 					state = STATE2;
3362  002d 35020000      	mov	_state,#2
3364  0031 2025          	jra	L1622
3365  0033               L3722:
3366                     ; 40 				else if(hour >= 10) 
3368  0033 be03          	ldw	x,_hour
3369  0035 a3000a        	cpw	x,#10
3370  0038 251e          	jrult	L1622
3371                     ; 41 					state = STATE3;
3373  003a 35030000      	mov	_state,#3
3374  003e 2018          	jra	L1622
3375  0040               L7712:
3376                     ; 44 			case MODE1:
3376                     ; 45 				if(hour >= 0 && hour < 6)
3378  0040 be03          	ldw	x,_hour
3379  0042 a30006        	cpw	x,#6
3380  0045 2406          	jruge	L1032
3381                     ; 46 					state = STATE1;
3383  0047 35010000      	mov	_state,#1
3385  004b 200b          	jra	L1622
3386  004d               L1032:
3387                     ; 47 				else if(hour >= 6)//(hour >= 6 && hour < 10)
3389  004d be03          	ldw	x,_hour
3390  004f a30006        	cpw	x,#6
3391  0052 2504          	jrult	L1622
3392                     ; 48 					state = STATE2;
3394  0054 35020000      	mov	_state,#2
3395  0058               L1022:
3396                     ; 50 			case MODE2: 	break;
3398  0058               L3022:
3399                     ; 51 			case MODE3: 	break;
3401  0058               L5022:
3402                     ; 52 			default:			break;
3404  0058               L5622:
3405  0058               L1622:
3406                     ; 56 	if(ex_state != state)
3408  0058 b608          	ld	a,L3712_ex_state
3409  005a b100          	cp	a,_state
3410  005c 2741          	jreq	L5132
3411                     ; 58 		switch (state)
3413  005e b600          	ld	a,_state
3415                     ; 64 			default: break;
3416  0060 4d            	tnz	a
3417  0061 270b          	jreq	L7022
3418  0063 4a            	dec	a
3419  0064 2713          	jreq	L1122
3420  0066 4a            	dec	a
3421  0067 271d          	jreq	L3122
3422  0069 4a            	dec	a
3423  006a 2728          	jreq	L5122
3424  006c 2031          	jra	L5132
3425  006e               L7022:
3426                     ; 60 			case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
3428  006e 5f            	clrw	x
3429  006f 89            	pushw	x
3430  0070 ae0064        	ldw	x,#100
3431  0073 cd0000        	call	_PWM_Config
3433  0076 85            	popw	x
3436  0077 2026          	jra	L5132
3437  0079               L1122:
3438                     ; 61 			case STATE1:	PWM_Config(100, 100);	break;
3440  0079 ae0064        	ldw	x,#100
3441  007c 89            	pushw	x
3442  007d ae0064        	ldw	x,#100
3443  0080 cd0000        	call	_PWM_Config
3445  0083 85            	popw	x
3448  0084 2019          	jra	L5132
3449  0086               L3122:
3450                     ; 62 			case STATE2:	PWM_Config(100, brightness);	break;			
3452  0086 b600          	ld	a,_brightness
3453  0088 5f            	clrw	x
3454  0089 97            	ld	xl,a
3455  008a 89            	pushw	x
3456  008b ae0064        	ldw	x,#100
3457  008e cd0000        	call	_PWM_Config
3459  0091 85            	popw	x
3462  0092 200b          	jra	L5132
3463  0094               L5122:
3464                     ; 63 			case STATE3:	PWM_Config(100, 100);	break;			
3466  0094 ae0064        	ldw	x,#100
3467  0097 89            	pushw	x
3468  0098 ae0064        	ldw	x,#100
3469  009b cd0000        	call	_PWM_Config
3471  009e 85            	popw	x
3474  009f               L7122:
3475                     ; 64 			default: break;
3477  009f               L3132:
3479  009f               L5132:
3480                     ; 67 	ex_state = state;
3482  009f 450008        	mov	L3712_ex_state,_state
3483                     ; 68 }
3486  00a2 84            	pop	a
3487  00a3 81            	ret
3490                     	bsct
3491  0009               L7132_adcData:
3492  0009 0000          	dc.w	0
3493  000b 0000          	dc.w	0
3494  000d 0000          	dc.w	0
3495  000f 0000          	dc.w	0
3583                     ; 71 main()
3583                     ; 72 {
3584                     	switch	.text
3585  00a4               _main:
3587  00a4 89            	pushw	x
3588       00000002      OFST:	set	2
3591                     ; 73 	unsigned char i = 0;
3593  00a5 0f02          	clr	(OFST+0,sp)
3594                     ; 74 	bool exRelayStat = OFF;
3596  00a7 a601          	ld	a,#1
3597  00a9 6b01          	ld	(OFST-1,sp),a
3598                     ; 77 	CLK_CKDIVR = 0x08;//f = f HSI RCÊä³ö/2=8MHz
3600  00ab 350850c6      	mov	_CLK_CKDIVR,#8
3601                     ; 80 	PWM_GPIO_Config();
3603  00af cd0000        	call	_PWM_GPIO_Config
3605                     ; 83 	InitADC();	
3607  00b2 cd0000        	call	_InitADC
3609                     ; 84 	adcData[0] = adcData[1] = adcData[2] = adcData[3] = GetADC();
3611  00b5 cd0000        	call	_GetADC
3613  00b8 bf0f          	ldw	L7132_adcData+6,x
3614  00ba be0f          	ldw	x,L7132_adcData+6
3615  00bc bf0d          	ldw	L7132_adcData+4,x
3616  00be be0d          	ldw	x,L7132_adcData+4
3617  00c0 bf0b          	ldw	L7132_adcData+2,x
3618  00c2 be0b          	ldw	x,L7132_adcData+2
3619  00c4 bf09          	ldw	L7132_adcData,x
3620                     ; 85 	Rly_GPIO_Config();
3622  00c6 cd0000        	call	_Rly_GPIO_Config
3624                     ; 86 	if(adcData[0] < ON_LUX)//initial LIGHT IO
3626  00c9 be09          	ldw	x,L7132_adcData
3627  00cb a3128e        	cpw	x,#4750
3628  00ce 240f          	jruge	L7532
3629                     ; 88 		LIGHT = OFF;
3631  00d0 721a500a      	bset	_PC_ODR_5
3632                     ; 89 		PWM_Config(100, 0);//PWM off
3634  00d4 5f            	clrw	x
3635  00d5 89            	pushw	x
3636  00d6 ae0064        	ldw	x,#100
3637  00d9 cd0000        	call	_PWM_Config
3639  00dc 85            	popw	x
3641  00dd 200f          	jra	L1632
3642  00df               L7532:
3643                     ; 93 		LIGHT = ON;
3645  00df 721b500a      	bres	_PC_ODR_5
3646                     ; 94 		PWM_Config(100, 100);//PWM off
3648  00e3 ae0064        	ldw	x,#100
3649  00e6 89            	pushw	x
3650  00e7 ae0064        	ldw	x,#100
3651  00ea cd0000        	call	_PWM_Config
3653  00ed 85            	popw	x
3654  00ee               L1632:
3655                     ; 98 	TIM1_Init();
3657  00ee cd0000        	call	_TIM1_Init
3659  00f1               L3632:
3660                     ; 102 		adcData[i++] = GetADC();
3662  00f1 cd0000        	call	_GetADC
3664  00f4 7b02          	ld	a,(OFST+0,sp)
3665  00f6 9097          	ld	yl,a
3666  00f8 0c02          	inc	(OFST+0,sp)
3667  00fa 909f          	ld	a,yl
3668  00fc 905f          	clrw	y
3669  00fe 9097          	ld	yl,a
3670  0100 9058          	sllw	y
3671  0102 90ef09        	ldw	(L7132_adcData,y),x
3672                     ; 103 		if(i > 4)	i = 0;
3674  0105 7b02          	ld	a,(OFST+0,sp)
3675  0107 a105          	cp	a,#5
3676  0109 2502          	jrult	L7632
3679  010b 0f02          	clr	(OFST+0,sp)
3680  010d               L7632:
3681                     ; 106 		if(adcData[0] < OFF_LUX && adcData[1] < OFF_LUX && adcData[2] < OFF_LUX && adcData[3] < OFF_LUX)
3683  010d be09          	ldw	x,L7132_adcData
3684  010f a31162        	cpw	x,#4450
3685  0112 243d          	jruge	L1732
3687  0114 be0b          	ldw	x,L7132_adcData+2
3688  0116 a31162        	cpw	x,#4450
3689  0119 2436          	jruge	L1732
3691  011b be0d          	ldw	x,L7132_adcData+4
3692  011d a31162        	cpw	x,#4450
3693  0120 242f          	jruge	L1732
3695  0122 be0f          	ldw	x,L7132_adcData+6
3696  0124 a31162        	cpw	x,#4450
3697  0127 2428          	jruge	L1732
3698                     ; 108 			if(LIGHT == ON)//only when light on/off change 
3700                     	btst	_PC_ODR_5
3701  012e 2511          	jrult	L3732
3702                     ; 110 				LIGHT = OFF;//Relay_IO = 1
3704  0130 721a500a      	bset	_PC_ODR_5
3705                     ; 111 				PWM_Config(100, 0);//PWM off
3707  0134 5f            	clrw	x
3708  0135 89            	pushw	x
3709  0136 ae0064        	ldw	x,#100
3710  0139 cd0000        	call	_PWM_Config
3712  013c 85            	popw	x
3713                     ; 112 				TIM1_CR1 &= 0xFE;//stop time counter
3715  013d 72115250      	bres	_TIM1_CR1,#0
3716  0141               L3732:
3717                     ; 114 			if(state != STATE0)
3719  0141 3d00          	tnz	_state
3720  0143 2704          	jreq	L5732
3721                     ; 115 				ex_state = state = STATE0;
3723  0145 3f00          	clr	_state
3724  0147 3f08          	clr	L3712_ex_state
3725  0149               L5732:
3726                     ; 117 			second = 0;
3728  0149 5f            	clrw	x
3729  014a bf01          	ldw	_second,x
3730                     ; 118 			hour = 0;
3732  014c 5f            	clrw	x
3733  014d bf03          	ldw	_hour,x
3735  014f 204b          	jra	L7732
3736  0151               L1732:
3737                     ; 121 		else if(adcData[0] > ON_LUX && adcData[1] > ON_LUX && adcData[2] > ON_LUX && adcData[3] > ON_LUX)
3739  0151 be09          	ldw	x,L7132_adcData
3740  0153 a3128f        	cpw	x,#4751
3741  0156 2544          	jrult	L7732
3743  0158 be0b          	ldw	x,L7132_adcData+2
3744  015a a3128f        	cpw	x,#4751
3745  015d 253d          	jrult	L7732
3747  015f be0d          	ldw	x,L7132_adcData+4
3748  0161 a3128f        	cpw	x,#4751
3749  0164 2536          	jrult	L7732
3751  0166 be0f          	ldw	x,L7132_adcData+6
3752  0168 a3128f        	cpw	x,#4751
3753  016b 252f          	jrult	L7732
3754                     ; 123 			if(LIGHT == OFF)//only when light on/off change 
3756                     	btst	_PC_ODR_5
3757  0172 2404          	jruge	L3042
3758                     ; 125 				LIGHT = ON;
3760  0174 721b500a      	bres	_PC_ODR_5
3761  0178               L3042:
3762                     ; 127 			if((TIM1_CR1 & 0x01) == 0)//if time counter not started, start counting
3764  0178 c65250        	ld	a,_TIM1_CR1
3765  017b a501          	bcp	a,#1
3766  017d 260e          	jrne	L5042
3767                     ; 129 				second = 0;
3769  017f 5f            	clrw	x
3770  0180 bf01          	ldw	_second,x
3771                     ; 130 				hour = 0;
3773  0182 5f            	clrw	x
3774  0183 bf03          	ldw	_hour,x
3775                     ; 131 				TIM1_CR1 |= 0x01;//start time counter
3777  0185 72105250      	bset	_TIM1_CR1,#0
3778                     ; 132 				TIM1_IER |= 0x01;				
3780  0189 72105254      	bset	_TIM1_IER,#0
3781  018d               L5042:
3782                     ; 134 			if(state == STATE0)
3784  018d 3d00          	tnz	_state
3785  018f 260b          	jrne	L7732
3786                     ; 136 				PWM_Config(100, 100);
3788  0191 ae0064        	ldw	x,#100
3789  0194 89            	pushw	x
3790  0195 ae0064        	ldw	x,#100
3791  0198 cd0000        	call	_PWM_Config
3793  019b 85            	popw	x
3794  019c               L7732:
3795                     ; 141 		DimmingMode(userMode);
3797  019c a601          	ld	a,#1
3798  019e cd0000        	call	_DimmingMode
3800                     ; 142 		Delay();
3802  01a1 cd0000        	call	_Delay
3805  01a4 acf100f1      	jpf	L3632
3843                     ; 147 @far @interrupt void TIM1_UPD_IRQHandler(void)
3843                     ; 148 {
3845                     	switch	.text
3846  01a8               f_TIM1_UPD_IRQHandler:
3849       00000001      OFST:	set	1
3850  01a8 88            	push	a
3853                     ; 149 	unsigned char i = 0;
3855  01a9 0f01          	clr	(OFST+0,sp)
3856                     ; 150 	TIM1_SR1 &= 0xFE;//clear interrupt label
3858  01ab 72115255      	bres	_TIM1_SR1,#0
3859                     ; 151 	second++;
3861  01af be01          	ldw	x,_second
3862  01b1 1c0001        	addw	x,#1
3863  01b4 bf01          	ldw	_second,x
3864                     ; 152 	if(second == 3600)/***********´ý±ä¸ü£¡£¡£¡£¡£¡***************/
3866  01b6 be01          	ldw	x,_second
3867  01b8 a30e10        	cpw	x,#3600
3868  01bb 260a          	jrne	L1342
3869                     ; 154 		second = 0;
3871  01bd 5f            	clrw	x
3872  01be bf01          	ldw	_second,x
3873                     ; 155 		hour += 1;
3875  01c0 be03          	ldw	x,_hour
3876  01c2 1c0001        	addw	x,#1
3877  01c5 bf03          	ldw	_hour,x
3878  01c7               L1342:
3879                     ; 159 }
3882  01c7 84            	pop	a
3883  01c8 80            	iret
4008                     	xdef	f_TIM1_UPD_IRQHandler
4009                     	xdef	_main
4010                     	xdef	_DimmingMode
4011                     	switch	.ubsct
4012  0000               _state:
4013  0000 00            	ds.b	1
4014                     	xdef	_state
4015                     	xdef	_relayStat
4016                     	xdef	_timeChanged
4017                     	xdef	_isDimmingConfiged
4018                     	xdef	_brightness
4019                     	xdef	_hour
4020                     	xdef	_second
4021                     	xref	_TIM1_Init
4022                     	xref	_Delay
4023                     	xref	_GetADC
4024                     	xref	_InitADC
4025                     	xref	_PWM_GPIO_Config
4026                     	xref	_PWM_Config
4027                     	xref	_Rly_GPIO_Config
4047                     	end

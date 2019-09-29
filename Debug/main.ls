   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3213                     	bsct
3214  0000               _brightness:
3215  0000 2b            	dc.b	43
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
3338                     ; 29 void DimmingMode(Mode mode)
3338                     ; 30 {
3340                     	switch	.text
3341  0000               _DimmingMode:
3343  0000 88            	push	a
3344       00000000      OFST:	set	0
3347                     ; 31 	if(LIGHT == ON)
3349                     	btst	_PC_ODR_5
3350  0006 2403          	jruge	L6
3351  0008 cc01ca        	jp	L7232
3352  000b               L6:
3353                     ; 33 		switch (mode)
3355  000b 7b01          	ld	a,(OFST+1,sp)
3357                     ; 109 			default:	break;
3358  000d 4d            	tnz	a
3359  000e 2722          	jreq	L5712
3360  0010 4a            	dec	a
3361  0011 2756          	jreq	L7712
3362  0013 4a            	dec	a
3363  0014 2774          	jreq	L1022
3364  0016 4a            	dec	a
3365  0017 2603cc00ab    	jreq	L3022
3366  001c 4a            	dec	a
3367  001d 2603          	jrne	L01
3368  001f cc00f1        	jp	L5022
3369  0022               L01:
3370  0022 4a            	dec	a
3371  0023 2603          	jrne	L21
3372  0025 cc0142        	jp	L7022
3373  0028               L21:
3374  0028 4a            	dec	a
3375  0029 2603          	jrne	L41
3376  002b cc0191        	jp	L1122
3377  002e               L41:
3378  002e acca01ca      	jpf	L7232
3379  0032               L5712:
3380                     ; 35 			case MODE0:
3380                     ; 36 				if(hour >= 0 && hour < 6)
3382  0032 be03          	ldw	x,_hour
3383  0034 a30006        	cpw	x,#6
3384  0037 2408          	jruge	L5332
3385                     ; 37 					state = STATE1;
3387  0039 35010000      	mov	_state,#1
3389  003d acca01ca      	jpf	L7232
3390  0041               L5332:
3391                     ; 38 				else if(hour >= 6 && hour < 10)//(hour >= 6 && hour < 10)
3393  0041 be03          	ldw	x,_hour
3394  0043 a30006        	cpw	x,#6
3395  0046 250f          	jrult	L1432
3397  0048 be03          	ldw	x,_hour
3398  004a a3000a        	cpw	x,#10
3399  004d 2408          	jruge	L1432
3400                     ; 39 					state = STATE2;
3402  004f 35020000      	mov	_state,#2
3404  0053 acca01ca      	jpf	L7232
3405  0057               L1432:
3406                     ; 40 				else if(hour >= 10) 
3408  0057 be03          	ldw	x,_hour
3409  0059 a3000a        	cpw	x,#10
3410  005c 2403          	jruge	L61
3411  005e cc01ca        	jp	L7232
3412  0061               L61:
3413                     ; 41 					state = STATE3;
3415  0061 35030000      	mov	_state,#3
3416  0065 acca01ca      	jpf	L7232
3417  0069               L7712:
3418                     ; 44 			case MODE1:
3418                     ; 45 				if(hour >= 0 && hour < 6)
3420  0069 be03          	ldw	x,_hour
3421  006b a30006        	cpw	x,#6
3422  006e 2408          	jruge	L7432
3423                     ; 46 					state = STATE1;
3425  0070 35010000      	mov	_state,#1
3427  0074 acca01ca      	jpf	L7232
3428  0078               L7432:
3429                     ; 47 				else if(hour >= 6)//(hour >= 6 && hour < 10)
3431  0078 be03          	ldw	x,_hour
3432  007a a30006        	cpw	x,#6
3433  007d 2403          	jruge	L02
3434  007f cc01ca        	jp	L7232
3435  0082               L02:
3436                     ; 48 					state = STATE2;
3438  0082 35020000      	mov	_state,#2
3439  0086 acca01ca      	jpf	L7232
3440  008a               L1022:
3441                     ; 51 			case MODE2:
3441                     ; 52 				if(hour >= 0 && hour < 9)
3443  008a be03          	ldw	x,_hour
3444  008c a30009        	cpw	x,#9
3445  008f 2408          	jruge	L5532
3446                     ; 53 					state = STATE1;
3448  0091 35010000      	mov	_state,#1
3450  0095 acca01ca      	jpf	L7232
3451  0099               L5532:
3452                     ; 54 				else if(hour >= 9)//always in dimming state
3454  0099 be03          	ldw	x,_hour
3455  009b a30009        	cpw	x,#9
3456  009e 2403          	jruge	L22
3457  00a0 cc01ca        	jp	L7232
3458  00a3               L22:
3459                     ; 55 					state = STATE2;
3461  00a3 35020000      	mov	_state,#2
3462  00a7 acca01ca      	jpf	L7232
3463  00ab               L3022:
3464                     ; 58 			case MODE3: 	
3464                     ; 59 				if(second >= 0 && second < 10)
3466  00ab be01          	ldw	x,_second
3467  00ad a3000a        	cpw	x,#10
3468  00b0 2408          	jruge	L3632
3469                     ; 60 					state = STATE1;
3471  00b2 35010000      	mov	_state,#1
3473  00b6 acca01ca      	jpf	L7232
3474  00ba               L3632:
3475                     ; 61 				else if(second >= 10 && second < 20)//(hour >= 6 && hour < 10)
3477  00ba be01          	ldw	x,_second
3478  00bc a3000a        	cpw	x,#10
3479  00bf 250f          	jrult	L7632
3481  00c1 be01          	ldw	x,_second
3482  00c3 a30014        	cpw	x,#20
3483  00c6 2408          	jruge	L7632
3484                     ; 62 					state = STATE2;
3486  00c8 35020000      	mov	_state,#2
3488  00cc acca01ca      	jpf	L7232
3489  00d0               L7632:
3490                     ; 63 				else if(second >= 20 && second < 30) 
3492  00d0 be01          	ldw	x,_second
3493  00d2 a30014        	cpw	x,#20
3494  00d5 250f          	jrult	L3732
3496  00d7 be01          	ldw	x,_second
3497  00d9 a3001e        	cpw	x,#30
3498  00dc 2408          	jruge	L3732
3499                     ; 64 					state = STATE3;	
3501  00de 35030000      	mov	_state,#3
3503  00e2 acca01ca      	jpf	L7232
3504  00e6               L3732:
3505                     ; 67 					state = STATE1;	
3507  00e6 35010000      	mov	_state,#1
3508                     ; 68 					second = 0;
3510  00ea 5f            	clrw	x
3511  00eb bf01          	ldw	_second,x
3512  00ed acca01ca      	jpf	L7232
3513  00f1               L5022:
3514                     ; 72 			case MODE4:
3514                     ; 73 				if(hour >= 0 && hour < 1)//1hour
3516  00f1 be03          	ldw	x,_hour
3517  00f3 2608          	jrne	L7732
3518                     ; 74 					state = STATE1;
3520  00f5 35010000      	mov	_state,#1
3522  00f9 acca01ca      	jpf	L7232
3523  00fd               L7732:
3524                     ; 75 				else if(hour >= 1 && hour < 4)//3hours
3526  00fd be03          	ldw	x,_hour
3527  00ff 270f          	jreq	L3042
3529  0101 be03          	ldw	x,_hour
3530  0103 a30004        	cpw	x,#4
3531  0106 2408          	jruge	L3042
3532                     ; 76 					state = STATE2;
3534  0108 35020000      	mov	_state,#2
3536  010c acca01ca      	jpf	L7232
3537  0110               L3042:
3538                     ; 77 				else if(hour >= 4 && hour < 5)//1hour
3540  0110 be03          	ldw	x,_hour
3541  0112 a30004        	cpw	x,#4
3542  0115 250f          	jrult	L7042
3544  0117 be03          	ldw	x,_hour
3545  0119 a30005        	cpw	x,#5
3546  011c 2408          	jruge	L7042
3547                     ; 78 					state = STATE3;					
3549  011e 35030000      	mov	_state,#3
3551  0122 acca01ca      	jpf	L7232
3552  0126               L7042:
3553                     ; 79 				else if(hour >= 5 && hour < 12)//7hours
3555  0126 be03          	ldw	x,_hour
3556  0128 a30005        	cpw	x,#5
3557  012b 250e          	jrult	L3142
3559  012d be03          	ldw	x,_hour
3560  012f a3000c        	cpw	x,#12
3561  0132 2407          	jruge	L3142
3562                     ; 80 					state = STATE4;
3564  0134 35040000      	mov	_state,#4
3566  0138 cc01ca        	jra	L7232
3567  013b               L3142:
3568                     ; 82 					state = STATE5;
3570  013b 35050000      	mov	_state,#5
3571  013f cc01ca        	jra	L7232
3572  0142               L7022:
3573                     ; 85 			case MODE5:
3573                     ; 86 				if(hour >= 0 && hour < 5)//5hour
3575  0142 be03          	ldw	x,_hour
3576  0144 a30005        	cpw	x,#5
3577  0147 2406          	jruge	L7142
3578                     ; 87 					state = STATE1;
3580  0149 35010000      	mov	_state,#1
3582  014d 207b          	jra	L7232
3583  014f               L7142:
3584                     ; 88 				else if(hour >= 5 && hour < 7)//2hours
3586  014f be03          	ldw	x,_hour
3587  0151 a30005        	cpw	x,#5
3588  0154 250d          	jrult	L3242
3590  0156 be03          	ldw	x,_hour
3591  0158 a30007        	cpw	x,#7
3592  015b 2406          	jruge	L3242
3593                     ; 89 					state = STATE2;
3595  015d 35020000      	mov	_state,#2
3597  0161 2067          	jra	L7232
3598  0163               L3242:
3599                     ; 90 				else if(hour >= 7 && hour < 11)//4hour
3601  0163 be03          	ldw	x,_hour
3602  0165 a30007        	cpw	x,#7
3603  0168 250d          	jrult	L7242
3605  016a be03          	ldw	x,_hour
3606  016c a3000b        	cpw	x,#11
3607  016f 2406          	jruge	L7242
3608                     ; 91 					state = STATE3;					
3610  0171 35030000      	mov	_state,#3
3612  0175 2053          	jra	L7232
3613  0177               L7242:
3614                     ; 92 				else if(hour >= 11 && hour < 12)//1hours
3616  0177 be03          	ldw	x,_hour
3617  0179 a3000b        	cpw	x,#11
3618  017c 250d          	jrult	L3342
3620  017e be03          	ldw	x,_hour
3621  0180 a3000c        	cpw	x,#12
3622  0183 2406          	jruge	L3342
3623                     ; 93 					state = STATE4;
3625  0185 35040000      	mov	_state,#4
3627  0189 203f          	jra	L7232
3628  018b               L3342:
3629                     ; 95 					state = STATE5;
3631  018b 35050000      	mov	_state,#5
3632  018f 2039          	jra	L7232
3633  0191               L1122:
3634                     ; 98 			case MODE6:
3634                     ; 99 				if(hour >= 0 && hour < 4)//4hours
3636  0191 be03          	ldw	x,_hour
3637  0193 a30004        	cpw	x,#4
3638  0196 2406          	jruge	L7342
3639                     ; 100 					state = STATE1;
3641  0198 35010000      	mov	_state,#1
3643  019c 202c          	jra	L7232
3644  019e               L7342:
3645                     ; 101 				else if(hour >= 4 && hour < 7)//3hours
3647  019e be03          	ldw	x,_hour
3648  01a0 a30004        	cpw	x,#4
3649  01a3 250d          	jrult	L3442
3651  01a5 be03          	ldw	x,_hour
3652  01a7 a30007        	cpw	x,#7
3653  01aa 2406          	jruge	L3442
3654                     ; 102 					state = STATE2;
3656  01ac 35020000      	mov	_state,#2
3658  01b0 2018          	jra	L7232
3659  01b2               L3442:
3660                     ; 103 				else if(hour >= 7 && hour < 11)//4hours
3662  01b2 be03          	ldw	x,_hour
3663  01b4 a30007        	cpw	x,#7
3664  01b7 250d          	jrult	L7442
3666  01b9 be03          	ldw	x,_hour
3667  01bb a3000b        	cpw	x,#11
3668  01be 2406          	jruge	L7442
3669                     ; 104 					state = STATE3;					
3671  01c0 35030000      	mov	_state,#3
3673  01c4 2004          	jra	L7232
3674  01c6               L7442:
3675                     ; 106 					state = STATE4;
3677  01c6 35040000      	mov	_state,#4
3678  01ca               L3122:
3679                     ; 109 			default:	break;
3681  01ca               L3332:
3682  01ca               L7232:
3683                     ; 113 	if(ex_state != state)
3685  01ca b608          	ld	a,L3712_ex_state
3686  01cc b100          	cp	a,_state
3687  01ce 2603          	jrne	L42
3688  01d0 cc02ef        	jp	L1052
3689  01d3               L42:
3690                     ; 115 		if(mode == MODE5)
3692  01d3 7b01          	ld	a,(OFST+1,sp)
3693  01d5 a105          	cp	a,#5
3694  01d7 2678          	jrne	L5542
3695                     ; 117 			switch (state)
3697  01d9 b600          	ld	a,_state
3699                     ; 125 				default: break;
3700  01db 4d            	tnz	a
3701  01dc 2713          	jreq	L5122
3702  01de 4a            	dec	a
3703  01df 271d          	jreq	L7122
3704  01e1 4a            	dec	a
3705  01e2 2729          	jreq	L1222
3706  01e4 4a            	dec	a
3707  01e5 2735          	jreq	L3222
3708  01e7 4a            	dec	a
3709  01e8 2741          	jreq	L5222
3710  01ea 4a            	dec	a
3711  01eb 274d          	jreq	L7222
3712  01ed acef02ef      	jpf	L1052
3713  01f1               L5122:
3714                     ; 119 				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
3716  01f1 5f            	clrw	x
3717  01f2 89            	pushw	x
3718  01f3 ae0064        	ldw	x,#100
3719  01f6 cd0000        	call	_PWM_Config
3721  01f9 85            	popw	x
3724  01fa acef02ef      	jpf	L1052
3725  01fe               L7122:
3726                     ; 120 				case STATE1:	PWM_Config(100, 100);	break;
3728  01fe ae0064        	ldw	x,#100
3729  0201 89            	pushw	x
3730  0202 ae0064        	ldw	x,#100
3731  0205 cd0000        	call	_PWM_Config
3733  0208 85            	popw	x
3736  0209 acef02ef      	jpf	L1052
3737  020d               L1222:
3738                     ; 121 				case STATE2:	PWM_Config(100, 75);	break;			
3740  020d ae004b        	ldw	x,#75
3741  0210 89            	pushw	x
3742  0211 ae0064        	ldw	x,#100
3743  0214 cd0000        	call	_PWM_Config
3745  0217 85            	popw	x
3748  0218 acef02ef      	jpf	L1052
3749  021c               L3222:
3750                     ; 122 				case STATE3:	PWM_Config(100, 50);	break;
3752  021c ae0032        	ldw	x,#50
3753  021f 89            	pushw	x
3754  0220 ae0064        	ldw	x,#100
3755  0223 cd0000        	call	_PWM_Config
3757  0226 85            	popw	x
3760  0227 acef02ef      	jpf	L1052
3761  022b               L5222:
3762                     ; 123 				case STATE4:	PWM_Config(100, 60);	break;
3764  022b ae003c        	ldw	x,#60
3765  022e 89            	pushw	x
3766  022f ae0064        	ldw	x,#100
3767  0232 cd0000        	call	_PWM_Config
3769  0235 85            	popw	x
3772  0236 acef02ef      	jpf	L1052
3773  023a               L7222:
3774                     ; 124 				case STATE5:	PWM_Config(100, 60);	break;
3776  023a ae003c        	ldw	x,#60
3777  023d 89            	pushw	x
3778  023e ae0064        	ldw	x,#100
3779  0241 cd0000        	call	_PWM_Config
3781  0244 85            	popw	x
3784  0245 acef02ef      	jpf	L1052
3785  0249               L1322:
3786                     ; 125 				default: break;
3788  0249 acef02ef      	jpf	L1052
3789  024d               L1642:
3791  024d acef02ef      	jpf	L1052
3792  0251               L5542:
3793                     ; 128 		else if(mode == MODE6)
3795  0251 7b01          	ld	a,(OFST+1,sp)
3796  0253 a106          	cp	a,#6
3797  0255 2657          	jrne	L5642
3798                     ; 130 			switch (state)
3800  0257 b600          	ld	a,_state
3802                     ; 137 				default: break;
3803  0259 4d            	tnz	a
3804  025a 270f          	jreq	L3322
3805  025c 4a            	dec	a
3806  025d 2717          	jreq	L5322
3807  025f 4a            	dec	a
3808  0260 2721          	jreq	L7322
3809  0262 4a            	dec	a
3810  0263 272b          	jreq	L1422
3811  0265 4a            	dec	a
3812  0266 2735          	jreq	L3422
3813  0268 cc02ef        	jra	L1052
3814  026b               L3322:
3815                     ; 132 				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
3817  026b 5f            	clrw	x
3818  026c 89            	pushw	x
3819  026d ae0064        	ldw	x,#100
3820  0270 cd0000        	call	_PWM_Config
3822  0273 85            	popw	x
3825  0274 2079          	jra	L1052
3826  0276               L5322:
3827                     ; 133 				case STATE1:	PWM_Config(100, 100);	break;
3829  0276 ae0064        	ldw	x,#100
3830  0279 89            	pushw	x
3831  027a ae0064        	ldw	x,#100
3832  027d cd0000        	call	_PWM_Config
3834  0280 85            	popw	x
3837  0281 206c          	jra	L1052
3838  0283               L7322:
3839                     ; 134 				case STATE2:	PWM_Config(100, 60+1);	break;			
3841  0283 ae003d        	ldw	x,#61
3842  0286 89            	pushw	x
3843  0287 ae0064        	ldw	x,#100
3844  028a cd0000        	call	_PWM_Config
3846  028d 85            	popw	x
3849  028e 205f          	jra	L1052
3850  0290               L1422:
3851                     ; 135 				case STATE3:	PWM_Config(100, 40+3);	break;
3853  0290 ae002b        	ldw	x,#43
3854  0293 89            	pushw	x
3855  0294 ae0064        	ldw	x,#100
3856  0297 cd0000        	call	_PWM_Config
3858  029a 85            	popw	x
3861  029b 2052          	jra	L1052
3862  029d               L3422:
3863                     ; 136 				case STATE4:	PWM_Config(100, 50+2);	break;
3865  029d ae0034        	ldw	x,#52
3866  02a0 89            	pushw	x
3867  02a1 ae0064        	ldw	x,#100
3868  02a4 cd0000        	call	_PWM_Config
3870  02a7 85            	popw	x
3873  02a8 2045          	jra	L1052
3874  02aa               L5422:
3875                     ; 137 				default: break;
3877  02aa 2043          	jra	L1052
3878  02ac               L1742:
3880  02ac 2041          	jra	L1052
3881  02ae               L5642:
3882                     ; 142 			switch (state)
3884  02ae b600          	ld	a,_state
3886                     ; 148 				default: break;
3887  02b0 4d            	tnz	a
3888  02b1 270b          	jreq	L7422
3889  02b3 4a            	dec	a
3890  02b4 2713          	jreq	L1522
3891  02b6 4a            	dec	a
3892  02b7 271d          	jreq	L3522
3893  02b9 4a            	dec	a
3894  02ba 2728          	jreq	L5522
3895  02bc 2031          	jra	L1052
3896  02be               L7422:
3897                     ; 144 				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
3899  02be 5f            	clrw	x
3900  02bf 89            	pushw	x
3901  02c0 ae0064        	ldw	x,#100
3902  02c3 cd0000        	call	_PWM_Config
3904  02c6 85            	popw	x
3907  02c7 2026          	jra	L1052
3908  02c9               L1522:
3909                     ; 145 				case STATE1:	PWM_Config(100, 100);	break;
3911  02c9 ae0064        	ldw	x,#100
3912  02cc 89            	pushw	x
3913  02cd ae0064        	ldw	x,#100
3914  02d0 cd0000        	call	_PWM_Config
3916  02d3 85            	popw	x
3919  02d4 2019          	jra	L1052
3920  02d6               L3522:
3921                     ; 146 				case STATE2:	PWM_Config(100, brightness);	break;			
3923  02d6 b600          	ld	a,_brightness
3924  02d8 5f            	clrw	x
3925  02d9 97            	ld	xl,a
3926  02da 89            	pushw	x
3927  02db ae0064        	ldw	x,#100
3928  02de cd0000        	call	_PWM_Config
3930  02e1 85            	popw	x
3933  02e2 200b          	jra	L1052
3934  02e4               L5522:
3935                     ; 147 				case STATE3:	PWM_Config(100, 80);	break;			
3937  02e4 ae0050        	ldw	x,#80
3938  02e7 89            	pushw	x
3939  02e8 ae0064        	ldw	x,#100
3940  02eb cd0000        	call	_PWM_Config
3942  02ee 85            	popw	x
3945  02ef               L7522:
3946                     ; 148 				default: break;
3948  02ef               L7742:
3949  02ef               L1052:
3950                     ; 152 	ex_state = state;
3952  02ef 450008        	mov	L3712_ex_state,_state
3953                     ; 153 }
3956  02f2 84            	pop	a
3957  02f3 81            	ret
3960                     	bsct
3961  0009               L3052_adcCount:
3962  0009 00            	dc.b	0
3963  000a               L5052_adcData:
3964  000a 0000          	dc.w	0
3965  000c 000000000000  	ds.b	18
4081                     ; 156 main()
4081                     ; 157 {
4082                     	switch	.text
4083  02f4               _main:
4085  02f4 5205          	subw	sp,#5
4086       00000005      OFST:	set	5
4089                     ; 159 	volatile unsigned char offCount = 0;
4091  02f6 0f02          	clr	(OFST-3,sp)
4092                     ; 160 	volatile unsigned char onCount = 0;	
4094  02f8 0f03          	clr	(OFST-2,sp)
4095                     ; 162 	bool exRelayStat = OFF;
4097  02fa a601          	ld	a,#1
4098  02fc 6b01          	ld	(OFST-4,sp),a
4099                     ; 165 	CLK_CKDIVR = 0x08;//f = f HSI RCÊä³ö/2=8MHz
4101  02fe 350850c6      	mov	_CLK_CKDIVR,#8
4102                     ; 168 	Delay(); Delay(); Delay(); Delay(); Delay(); //about 5s
4104  0302 cd0000        	call	_Delay
4108  0305 cd0000        	call	_Delay
4112  0308 cd0000        	call	_Delay
4116  030b cd0000        	call	_Delay
4120  030e cd0000        	call	_Delay
4122                     ; 172 	PWM_GPIO_Config();
4124  0311 cd0000        	call	_PWM_GPIO_Config
4126                     ; 175 	InitADC();	
4128  0314 cd0000        	call	_InitADC
4130                     ; 177 	for(i=0;i<DELAY;i++)
4132  0317 5f            	clrw	x
4133  0318 1f04          	ldw	(OFST-1,sp),x
4134  031a               L1652:
4135                     ; 179 		adcData[i] = GetADC();
4137  031a cd0000        	call	_GetADC
4139  031d 1604          	ldw	y,(OFST-1,sp)
4140  031f 9058          	sllw	y
4141  0321 90ef0a        	ldw	(L5052_adcData,y),x
4142                     ; 177 	for(i=0;i<DELAY;i++)
4144  0324 1e04          	ldw	x,(OFST-1,sp)
4145  0326 1c0001        	addw	x,#1
4146  0329 1f04          	ldw	(OFST-1,sp),x
4149  032b 1e04          	ldw	x,(OFST-1,sp)
4150  032d a3000a        	cpw	x,#10
4151  0330 25e8          	jrult	L1652
4152                     ; 181 	Rly_GPIO_Config();
4154  0332 cd0000        	call	_Rly_GPIO_Config
4156                     ; 182 	if(adcData[0] < ON_LUX)//initial LIGHT IO
4158  0335 be0a          	ldw	x,L5052_adcData
4159  0337 a312c0        	cpw	x,#4800
4160  033a 240f          	jruge	L7652
4161                     ; 184 		LIGHT = OFF;
4163  033c 721a500a      	bset	_PC_ODR_5
4164                     ; 185 		PWM_Config(100, 0);//PWM off
4166  0340 5f            	clrw	x
4167  0341 89            	pushw	x
4168  0342 ae0064        	ldw	x,#100
4169  0345 cd0000        	call	_PWM_Config
4171  0348 85            	popw	x
4173  0349 200f          	jra	L1752
4174  034b               L7652:
4175                     ; 189 		LIGHT = ON;
4177  034b 721b500a      	bres	_PC_ODR_5
4178                     ; 190 		PWM_Config(100, 100);//PWM off
4180  034f ae0064        	ldw	x,#100
4181  0352 89            	pushw	x
4182  0353 ae0064        	ldw	x,#100
4183  0356 cd0000        	call	_PWM_Config
4185  0359 85            	popw	x
4186  035a               L1752:
4187                     ; 194 	TIM1_Init();
4189  035a cd0000        	call	_TIM1_Init
4191  035d               L3752:
4192                     ; 197 		adcData[adcCount++] = GetADC();
4194  035d cd0000        	call	_GetADC
4196  0360 b609          	ld	a,L3052_adcCount
4197  0362 9097          	ld	yl,a
4198  0364 3c09          	inc	L3052_adcCount
4199  0366 909f          	ld	a,yl
4200  0368 905f          	clrw	y
4201  036a 9097          	ld	yl,a
4202  036c 9058          	sllw	y
4203  036e 90ef0a        	ldw	(L5052_adcData,y),x
4204                     ; 198 		if(adcCount >= DELAY)	
4206  0371 b609          	ld	a,L3052_adcCount
4207  0373 a10a          	cp	a,#10
4208  0375 2502          	jrult	L7752
4209                     ; 199 			adcCount = 0;
4211  0377 3f09          	clr	L3052_adcCount
4212  0379               L7752:
4213                     ; 202 		for(i=0; i<DELAY;i++)
4215  0379 5f            	clrw	x
4216  037a 1f04          	ldw	(OFST-1,sp),x
4217  037c               L1062:
4218                     ; 204 			if(adcData[i] < OFF_LUX)
4220  037c 1e04          	ldw	x,(OFST-1,sp)
4221  037e 58            	sllw	x
4222  037f 9093          	ldw	y,x
4223  0381 90ee0a        	ldw	y,(L5052_adcData,y)
4224  0384 90a310cc      	cpw	y,#4300
4225  0388 2404          	jruge	L7062
4226                     ; 205 				offCount += 1;
4228  038a 0c02          	inc	(OFST-3,sp)
4230  038c 2010          	jra	L1162
4231  038e               L7062:
4232                     ; 206 			else if(adcData[i] > ON_LUX)
4234  038e 1e04          	ldw	x,(OFST-1,sp)
4235  0390 58            	sllw	x
4236  0391 9093          	ldw	y,x
4237  0393 90ee0a        	ldw	y,(L5052_adcData,y)
4238  0396 90a312c1      	cpw	y,#4801
4239  039a 2502          	jrult	L1162
4240                     ; 207 				onCount += 1;
4242  039c 0c03          	inc	(OFST-2,sp)
4244  039e               L1162:
4245                     ; 202 		for(i=0; i<DELAY;i++)
4247  039e 1e04          	ldw	x,(OFST-1,sp)
4248  03a0 1c0001        	addw	x,#1
4249  03a3 1f04          	ldw	(OFST-1,sp),x
4252  03a5 1e04          	ldw	x,(OFST-1,sp)
4253  03a7 a3000a        	cpw	x,#10
4254  03aa 25d0          	jrult	L1062
4255                     ; 211 		if(offCount >= DELAY)
4257  03ac 7b02          	ld	a,(OFST-3,sp)
4258  03ae a10a          	cp	a,#10
4259  03b0 2528          	jrult	L7162
4260                     ; 213 			if(LIGHT == ON)//only when light on/off change 
4262                     	btst	_PC_ODR_5
4263  03b7 2511          	jrult	L1262
4264                     ; 215 				LIGHT = OFF;//Relay_IO = 1
4266  03b9 721a500a      	bset	_PC_ODR_5
4267                     ; 216 				PWM_Config(100, 0);//PWM off
4269  03bd 5f            	clrw	x
4270  03be 89            	pushw	x
4271  03bf ae0064        	ldw	x,#100
4272  03c2 cd0000        	call	_PWM_Config
4274  03c5 85            	popw	x
4275                     ; 217 				TIM1_CR1 &= 0xFE;//stop time counter
4277  03c6 72115250      	bres	_TIM1_CR1,#0
4278  03ca               L1262:
4279                     ; 219 			if(state != STATE0)
4281  03ca 3d00          	tnz	_state
4282  03cc 2704          	jreq	L3262
4283                     ; 220 				ex_state = state = STATE0;
4285  03ce 3f00          	clr	_state
4286  03d0 3f08          	clr	L3712_ex_state
4287  03d2               L3262:
4288                     ; 222 			second = 0;
4290  03d2 5f            	clrw	x
4291  03d3 bf01          	ldw	_second,x
4292                     ; 223 			hour = 0;
4294  03d5 5f            	clrw	x
4295  03d6 bf03          	ldw	_hour,x
4297  03d8 2035          	jra	L5262
4298  03da               L7162:
4299                     ; 226 		else if(onCount >= DELAY)
4301  03da 7b03          	ld	a,(OFST-2,sp)
4302  03dc a10a          	cp	a,#10
4303  03de 252f          	jrult	L5262
4304                     ; 228 			if(LIGHT == OFF)//only when light on/off change 
4306                     	btst	_PC_ODR_5
4307  03e5 2404          	jruge	L1362
4308                     ; 230 				LIGHT = ON;
4310  03e7 721b500a      	bres	_PC_ODR_5
4311  03eb               L1362:
4312                     ; 232 			if((TIM1_CR1 & 0x01) == 0)//if time counter not started, start counting
4314  03eb c65250        	ld	a,_TIM1_CR1
4315  03ee a501          	bcp	a,#1
4316  03f0 260e          	jrne	L3362
4317                     ; 234 				second = 0;
4319  03f2 5f            	clrw	x
4320  03f3 bf01          	ldw	_second,x
4321                     ; 235 				hour = 0;
4323  03f5 5f            	clrw	x
4324  03f6 bf03          	ldw	_hour,x
4325                     ; 236 				TIM1_CR1 |= 0x01;//start time counter
4327  03f8 72105250      	bset	_TIM1_CR1,#0
4328                     ; 237 				TIM1_IER |= 0x01;				
4330  03fc 72105254      	bset	_TIM1_IER,#0
4331  0400               L3362:
4332                     ; 239 			if(state == STATE0)
4334  0400 3d00          	tnz	_state
4335  0402 260b          	jrne	L5262
4336                     ; 241 				PWM_Config(100, 100);
4338  0404 ae0064        	ldw	x,#100
4339  0407 89            	pushw	x
4340  0408 ae0064        	ldw	x,#100
4341  040b cd0000        	call	_PWM_Config
4343  040e 85            	popw	x
4344  040f               L5262:
4345                     ; 246 		offCount = 0;
4347  040f 0f02          	clr	(OFST-3,sp)
4348                     ; 247 		onCount  = 0;	
4350  0411 0f03          	clr	(OFST-2,sp)
4351                     ; 248 		DimmingMode(userMode);
4353  0413 a606          	ld	a,#6
4354  0415 cd0000        	call	_DimmingMode
4356                     ; 249 		Delay500ms();
4358  0418 cd0000        	call	_Delay500ms
4361  041b ac5d035d      	jpf	L3752
4399                     ; 308 @far @interrupt void TIM1_UPD_IRQHandler(void)
4399                     ; 309 {
4401                     	switch	.text
4402  041f               f_TIM1_UPD_IRQHandler:
4405       00000001      OFST:	set	1
4406  041f 88            	push	a
4409                     ; 310 	unsigned char i = 0;
4411  0420 0f01          	clr	(OFST+0,sp)
4412                     ; 311 	TIM1_SR1 &= 0xFE;//clear interrupt label
4414  0422 72115255      	bres	_TIM1_SR1,#0
4415                     ; 312 	second++;
4417  0426 be01          	ldw	x,_second
4418  0428 1c0001        	addw	x,#1
4419  042b bf01          	ldw	_second,x
4420                     ; 313 	if(second >= 3600)/***********´ý±ä¸ü£¡£¡£¡£¡£¡***************/
4422  042d be01          	ldw	x,_second
4423  042f a30e10        	cpw	x,#3600
4424  0432 250a          	jrult	L7562
4425                     ; 315 		second = 0;
4427  0434 5f            	clrw	x
4428  0435 bf01          	ldw	_second,x
4429                     ; 316 		hour += 1;
4431  0437 be03          	ldw	x,_hour
4432  0439 1c0001        	addw	x,#1
4433  043c bf03          	ldw	_hour,x
4434  043e               L7562:
4435                     ; 320 }
4438  043e 84            	pop	a
4439  043f 80            	iret
4578                     	xdef	f_TIM1_UPD_IRQHandler
4579                     	xdef	_main
4580                     	xdef	_DimmingMode
4581                     	switch	.ubsct
4582  0000               _state:
4583  0000 00            	ds.b	1
4584                     	xdef	_state
4585                     	xdef	_relayStat
4586                     	xdef	_timeChanged
4587                     	xdef	_isDimmingConfiged
4588                     	xdef	_brightness
4589                     	xdef	_hour
4590                     	xdef	_second
4591                     	xref	_TIM1_Init
4592                     	xref	_Delay500ms
4593                     	xref	_Delay
4594                     	xref	_GetADC
4595                     	xref	_InitADC
4596                     	xref	_PWM_GPIO_Config
4597                     	xref	_PWM_Config
4598                     	xref	_Rly_GPIO_Config
4618                     	end

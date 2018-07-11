   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3254                     ; 3 void InitADC(void)
3254                     ; 4 {
3256                     	switch	.text
3257  0000               _InitADC:
3261                     ; 5 	PD_DDR &= 0xBF;//PD6 IO口设置为悬浮输入
3263  0000 721d5011      	bres	_PD_DDR,#6
3264                     ; 6 	PD_CR1 &= 0xBF;
3266  0004 721d5012      	bres	_PD_CR1,#6
3267                     ; 7 	PD_CR2 &= 0xBF;
3269  0008 721d5013      	bres	_PD_CR2,#6
3270                     ; 9 	ADC_CR1 = 0x01;//第一次打开ADC，第二次开始ADC转换
3272  000c 35015401      	mov	_ADC_CR1,#1
3273                     ; 10 	ADC_CSR = 0X06;//选择通道AIN6
3275  0010 35065400      	mov	_ADC_CSR,#6
3276                     ; 11 	ADC_CR2 = 0X00;//数据左对齐（默认）	
3278  0014 725f5402      	clr	_ADC_CR2
3279                     ; 12 }
3282  0018 81            	ret
3320                     .const:	section	.text
3321  0000               L01:
3322  0000 000003ff      	dc.l	1023
3323                     ; 14 unsigned int GetADC(void)
3323                     ; 15 {
3324                     	switch	.text
3325  0019               _GetADC:
3327  0019 89            	pushw	x
3328       00000002      OFST:	set	2
3331                     ; 17 	ADC_CR1 |= 0x01;
3333  001a 72105401      	bset	_ADC_CR1,#0
3335  001e               L1322:
3336                     ; 18 	while((ADC_CSR & 0x80) == 0);//等待转换结束
3338  001e c65400        	ld	a,_ADC_CSR
3339  0021 a580          	bcp	a,#128
3340  0023 27f9          	jreq	L1322
3341                     ; 19 	ADC_CSR &= 0xEF;//清除转换结束标志位
3343  0025 72195400      	bres	_ADC_CSR,#4
3344                     ; 20 	adcValue = (unsigned int)ADC_DRH;
3346  0029 c65404        	ld	a,_ADC_DRH
3347  002c 5f            	clrw	x
3348  002d 97            	ld	xl,a
3349  002e 1f01          	ldw	(OFST-1,sp),x
3350                     ; 21 	adcValue = adcValue << 2;
3352  0030 0802          	sll	(OFST+0,sp)
3353  0032 0901          	rlc	(OFST-1,sp)
3354  0034 0802          	sll	(OFST+0,sp)
3355  0036 0901          	rlc	(OFST-1,sp)
3356                     ; 22 	adcValue |= ADC_DRL;
3358  0038 c65405        	ld	a,_ADC_DRL
3359  003b 5f            	clrw	x
3360  003c 97            	ld	xl,a
3361  003d 01            	rrwa	x,a
3362  003e 1a02          	or	a,(OFST+0,sp)
3363  0040 01            	rrwa	x,a
3364  0041 1a01          	or	a,(OFST-1,sp)
3365  0043 01            	rrwa	x,a
3366  0044 1f01          	ldw	(OFST-1,sp),x
3367                     ; 24 	return(adcValue * 5000UL / 1023UL);//10位分辨率为1023，即Vdd/1023*ADC
3369  0046 1e01          	ldw	x,(OFST-1,sp)
3370  0048 90ae1388      	ldw	y,#5000
3371  004c cd0000        	call	c_umul
3373  004f ae0000        	ldw	x,#L01
3374  0052 cd0000        	call	c_ludv
3376  0055 be02          	ldw	x,c_lreg+2
3379  0057 5b02          	addw	sp,#2
3380  0059 81            	ret
3393                     	xdef	_GetADC
3394                     	xdef	_InitADC
3395                     	xref.b	c_lreg
3414                     	xref	c_ludv
3415                     	xref	c_umul
3416                     	end

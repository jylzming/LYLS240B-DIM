   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3268                     ; 7 void Delay(void)
3268                     ; 8 {
3270                     	switch	.text
3271  0000               _Delay:
3273  0000 5204          	subw	sp,#4
3274       00000004      OFST:	set	4
3277                     ; 10 	for(i=0; i<1024; i++)//for(i=0; i<1024; i++)
3279  0002 5f            	clrw	x
3280  0003 1f01          	ldw	(OFST-3,sp),x
3282  0005 201a          	jra	L7222
3283  0007               L3222:
3284                     ; 12 		for(j=0; j<512; j++); 
3286  0007 5f            	clrw	x
3287  0008 1f03          	ldw	(OFST-1,sp),x
3289  000a 2007          	jra	L7322
3290  000c               L3322:
3294  000c 1e03          	ldw	x,(OFST-1,sp)
3295  000e 1c0001        	addw	x,#1
3296  0011 1f03          	ldw	(OFST-1,sp),x
3297  0013               L7322:
3300  0013 1e03          	ldw	x,(OFST-1,sp)
3301  0015 a30200        	cpw	x,#512
3302  0018 25f2          	jrult	L3322
3303                     ; 10 	for(i=0; i<1024; i++)//for(i=0; i<1024; i++)
3305  001a 1e01          	ldw	x,(OFST-3,sp)
3306  001c 1c0001        	addw	x,#1
3307  001f 1f01          	ldw	(OFST-3,sp),x
3308  0021               L7222:
3311  0021 1e01          	ldw	x,(OFST-3,sp)
3312  0023 a30400        	cpw	x,#1024
3313  0026 25df          	jrult	L3222
3314                     ; 14 }
3317  0028 5b04          	addw	sp,#4
3318  002a 81            	ret
3361                     ; 15 void Delay500ms(void)
3361                     ; 16 {
3362                     	switch	.text
3363  002b               _Delay500ms:
3365  002b 5204          	subw	sp,#4
3366       00000004      OFST:	set	4
3369                     ; 18 	for(i=0; i<555; i++)//for(i=0; i<1024; i++)
3371  002d 5f            	clrw	x
3372  002e 1f01          	ldw	(OFST-3,sp),x
3374  0030 201a          	jra	L1722
3375  0032               L5622:
3376                     ; 20 		for(j=0; j<512; j++); 
3378  0032 5f            	clrw	x
3379  0033 1f03          	ldw	(OFST-1,sp),x
3381  0035 2007          	jra	L1032
3382  0037               L5722:
3386  0037 1e03          	ldw	x,(OFST-1,sp)
3387  0039 1c0001        	addw	x,#1
3388  003c 1f03          	ldw	(OFST-1,sp),x
3389  003e               L1032:
3392  003e 1e03          	ldw	x,(OFST-1,sp)
3393  0040 a30200        	cpw	x,#512
3394  0043 25f2          	jrult	L5722
3395                     ; 18 	for(i=0; i<555; i++)//for(i=0; i<1024; i++)
3397  0045 1e01          	ldw	x,(OFST-3,sp)
3398  0047 1c0001        	addw	x,#1
3399  004a 1f01          	ldw	(OFST-3,sp),x
3400  004c               L1722:
3403  004c 1e01          	ldw	x,(OFST-3,sp)
3404  004e a3022b        	cpw	x,#555
3405  0051 25df          	jrult	L5622
3406                     ; 22 }
3409  0053 5b04          	addw	sp,#4
3410  0055 81            	ret
3441                     ; 24 void TIM1_Init(void)
3441                     ; 25 {
3442                     	switch	.text
3443  0056               _TIM1_Init:
3447                     ; 26 	_asm("sim");
3450  0056 9b            sim
3452                     ; 27 	TIM1_IER = 0x00;
3454  0057 725f5254      	clr	_TIM1_IER
3455                     ; 28 	TIM1_CR1 = 0x00;
3457  005b 725f5250      	clr	_TIM1_CR1
3458                     ; 29 	TIM1_CR2 = 0x00;
3460  005f 725f5251      	clr	_TIM1_CR2
3461                     ; 30 	TIM1_PSCRH = 0x1F;//8000 DIV----->1KHz
3463  0063 351f5260      	mov	_TIM1_PSCRH,#31
3464                     ; 31 	TIM1_PSCRL = 0x3F;
3466  0067 353f5261      	mov	_TIM1_PSCRL,#63
3467                     ; 34 	TIM1_ARRH = (unsigned char)(990 >> 8);
3469  006b 35035262      	mov	_TIM1_ARRH,#3
3470                     ; 35 	TIM1_ARRL = (unsigned char)990;
3472  006f 35de5263      	mov	_TIM1_ARRL,#222
3473                     ; 36 	TIM1_EGR = 0X01;
3475  0073 35015257      	mov	_TIM1_EGR,#1
3476                     ; 37 	TIM1_CR1 &= 0xFE;
3478  0077 72115250      	bres	_TIM1_CR1,#0
3479                     ; 39 	_asm("rim");
3482  007b 9a            rim
3484                     ; 40 }
3487  007c 81            	ret
3500                     	xdef	_TIM1_Init
3501                     	xdef	_Delay500ms
3502                     	xdef	_Delay
3521                     	end

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
3349                     ; 16 void TIM1_Init(void)
3349                     ; 17 {
3350                     	switch	.text
3351  002b               _TIM1_Init:
3355                     ; 18 	_asm("sim");
3358  002b 9b            sim
3360                     ; 19 	TIM1_IER = 0x00;
3362  002c 725f5254      	clr	_TIM1_IER
3363                     ; 20 	TIM1_CR1 = 0x00;
3365  0030 725f5250      	clr	_TIM1_CR1
3366                     ; 21 	TIM1_CR2 = 0x00;
3368  0034 725f5251      	clr	_TIM1_CR2
3369                     ; 22 	TIM1_PSCRH = 0x1F;//8000 DIV----->1KHz
3371  0038 351f5260      	mov	_TIM1_PSCRH,#31
3372                     ; 23 	TIM1_PSCRL = 0x3F;
3374  003c 353f5261      	mov	_TIM1_PSCRL,#63
3375                     ; 26 	TIM1_ARRH = (unsigned char)(990 >> 8);
3377  0040 35035262      	mov	_TIM1_ARRH,#3
3378                     ; 27 	TIM1_ARRL = (unsigned char)990;
3380  0044 35de5263      	mov	_TIM1_ARRL,#222
3381                     ; 28 	TIM1_EGR = 0X01;
3383  0048 35015257      	mov	_TIM1_EGR,#1
3384                     ; 29 	TIM1_CR1 &= 0xFE;
3386  004c 72115250      	bres	_TIM1_CR1,#0
3387                     ; 31 	_asm("rim");
3390  0050 9a            rim
3392                     ; 32 }
3395  0051 81            	ret
3408                     	xdef	_TIM1_Init
3409                     	xdef	_Delay
3428                     	end

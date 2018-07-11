   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
3268                     ; 7 void Delay(void)
3268                     ; 8 {
3270                     	switch	.text
3271  0000               _Delay:
3273  0000 5204          	subw	sp,#4
3274       00000004      OFST:	set	4
3277                     ; 10 	for(i=0; i<512; i++)
3279  0002 5f            	clrw	x
3280  0003 1f01          	ldw	(OFST-3,sp),x
3281  0005               L3222:
3282                     ; 12 		for(j=0; j<512; j++); 
3284  0005 5f            	clrw	x
3285  0006 1f03          	ldw	(OFST-1,sp),x
3286  0008               L1322:
3290  0008 1e03          	ldw	x,(OFST-1,sp)
3291  000a 1c0001        	addw	x,#1
3292  000d 1f03          	ldw	(OFST-1,sp),x
3295  000f 1e03          	ldw	x,(OFST-1,sp)
3296  0011 a30200        	cpw	x,#512
3297  0014 25f2          	jrult	L1322
3298                     ; 10 	for(i=0; i<512; i++)
3300  0016 1e01          	ldw	x,(OFST-3,sp)
3301  0018 1c0001        	addw	x,#1
3302  001b 1f01          	ldw	(OFST-3,sp),x
3305  001d 1e01          	ldw	x,(OFST-3,sp)
3306  001f a30200        	cpw	x,#512
3307  0022 25e1          	jrult	L3222
3308                     ; 14 }
3311  0024 5b04          	addw	sp,#4
3312  0026 81            	ret
3343                     ; 16 void TIM1_Init(void)
3343                     ; 17 {
3344                     	switch	.text
3345  0027               _TIM1_Init:
3349                     ; 18 	_asm("sim");
3352  0027 9b            sim
3354                     ; 19 	TIM1_IER = 0x00;
3356  0028 725f5254      	clr	_TIM1_IER
3357                     ; 20 	TIM1_CR1 = 0x00;
3359  002c 725f5250      	clr	_TIM1_CR1
3360                     ; 21 	TIM1_CR2 = 0x00;
3362  0030 725f5251      	clr	_TIM1_CR2
3363                     ; 22 	TIM1_PSCRH = 0x1F;//8000 DIV----->1KHz
3365  0034 351f5260      	mov	_TIM1_PSCRH,#31
3366                     ; 23 	TIM1_PSCRL = 0x3F;
3368  0038 353f5261      	mov	_TIM1_PSCRL,#63
3369                     ; 26 	TIM1_ARRH = (unsigned char)(990 >> 8);
3371  003c 35035262      	mov	_TIM1_ARRH,#3
3372                     ; 27 	TIM1_ARRL = (unsigned char)990;
3374  0040 35de5263      	mov	_TIM1_ARRL,#222
3375                     ; 28 	TIM1_EGR = 0X01;
3377  0044 35015257      	mov	_TIM1_EGR,#1
3378                     ; 29 	TIM1_CR1 &= 0xFE;
3380  0048 72115250      	bres	_TIM1_CR1,#0
3381                     ; 31 	_asm("rim");
3384  004c 9a            rim
3386                     ; 32 }
3389  004d 81            	ret
3402                     	xdef	_TIM1_Init
3403                     	xdef	_Delay
3422                     	end

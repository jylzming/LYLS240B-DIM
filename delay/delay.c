#include "delay.h"
#include "pwm.h"
#include "relay.h"
#include "adc.h"
#include "global.h"

void Delay(void)
{
	unsigned int i,j;
	for(i=0; i<1024; i++)
	{
		for(j=0; j<512; j++); 
	}
}

void TIM1_Init(void)
{
	_asm("sim");
	TIM1_IER = 0x00;
	TIM1_CR1 = 0x00;
	TIM1_CR2 = 0x00;
	TIM1_PSCRH = 0x1F;//8000 DIV----->1KHz
	TIM1_PSCRL = 0x3F;
	
	//TIM1_ARRx = 1000 TIME is 1.006 Second
	TIM1_ARRH = (unsigned char)(990 >> 8);
	TIM1_ARRL = (unsigned char)990;
	TIM1_EGR = 0X01;
	TIM1_CR1 &= 0xFE;
	//TIM1_IER |= 0x01;
	_asm("rim");
}


#include "adc.h"

void InitADC(void)
{
	PD_DDR &= 0xBF;//PD6 IO口设置为悬浮输入
	PD_CR1 &= 0xBF;
	PD_CR2 &= 0xBF;
	
	ADC_CR1 = 0x01;//第一次打开ADC，第二次开始ADC转换
	ADC_CSR = 0X06;//选择通道AIN6
	ADC_CR2 = 0X00;//数据左对齐（默认）	
}

unsigned int GetADC(void)
{
	unsigned int adcValue;
	ADC_CR1 |= 0x01;
	while((ADC_CSR & 0x80) == 0);//等待转换结束
	ADC_CSR &= 0xEF;//清除转换结束标志位
	adcValue = (unsigned int)ADC_DRH;
	adcValue = adcValue << 2;
	adcValue |= ADC_DRL;
		
	return(adcValue * 5000UL / 1023UL);//10位分辨率为1023，即Vdd/1023*ADC
}

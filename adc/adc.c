#include "adc.h"

void InitADC(void)
{
	PD_DDR &= 0xBF;//PD6 IO������Ϊ��������
	PD_CR1 &= 0xBF;
	PD_CR2 &= 0xBF;
	
	ADC_CR1 = 0x01;//��һ�δ�ADC���ڶ��ο�ʼADCת��
	ADC_CSR = 0X06;//ѡ��ͨ��AIN6
	ADC_CR2 = 0X00;//��������루Ĭ�ϣ�	
}

unsigned int GetADC(void)
{
	unsigned int adcValue;
	ADC_CR1 |= 0x01;
	while((ADC_CSR & 0x80) == 0);//�ȴ�ת������
	ADC_CSR &= 0xEF;//���ת��������־λ
	adcValue = (unsigned int)ADC_DRH;
	adcValue = adcValue << 2;
	adcValue |= ADC_DRL;
		
	return(adcValue * 5000UL / 1023UL);//10λ�ֱ���Ϊ1023����Vdd/1023*ADC
}

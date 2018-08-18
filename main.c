/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "STM8S001J3.h"
#include "stm8s_bit.h"
//#include "stdio.h"
#include "relay.h"
#include "pwm.h"
#include "adc.h"
#include "delay.h"
#include "global.h"

typedef enum {MODE0 = 0, MODE1 = 1, MODE2 = 2, MODE3 = 3} Mode;
typedef enum {STATE0 = 0, STATE1 = 1, STATE2 = 2, STATE3 = 3} State;

#define userMode MODE1 //userMode(MODE0~MODExx),need confirm
unsigned char brightness = 35; //brightness(0~100),brightness

unsigned int second = 0;
unsigned int hour = 0;

bool relayStat = ON;
bool isDimmingConfiged = FALSE;
bool timeChanged = FALSE;
State state;
static State ex_state = STATE0;

void DimmingMode(Mode mode)
{
	if(LIGHT == ON)
	{
		switch (mode)
		{
			case MODE0:
				if(hour >= 0 && hour < 6)
					state = STATE1;
				else if(hour >= 6 && hour < 10)//(hour >= 6 && hour < 10)
					state = STATE2;
				else if(hour >= 10) 
					state = STATE3;
			break;		
	
			case MODE1:
				if(hour >= 0 && hour < 6)
					state = STATE1;
				else if(hour >= 6)//(hour >= 6 && hour < 10)
					state = STATE2;
			break;
			case MODE2: 	break;
			case MODE3: 	break;
			default:			break;
		}
	}
	//when state changed
	if(ex_state != state)
	{
		switch (state)
		{
			case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
			case STATE1:	PWM_Config(100, 100);	break;
			case STATE2:	PWM_Config(100, brightness);	break;			
			case STATE3:	PWM_Config(100, 100);	break;			
			default: break;
		}
	}	else;//when state no change, do nothing
	ex_state = state;
}
		

main()
{
	unsigned char i = 0;
	bool exRelayStat = OFF;
	static unsigned int adcData[4] = {0,0,0,0};
	
	CLK_CKDIVR = 0x08;//f = f HSI RCÊä³ö/2=8MHz
	
	//Dimming IO config
	PWM_GPIO_Config();
	
	//Get ADC initial data and check the light ON/OFF state
	InitADC();	
	adcData[0] = adcData[1] = adcData[2] = adcData[3] = GetADC();
	Rly_GPIO_Config();
	if(adcData[0] < ON_LUX)//initial LIGHT IO
	{
		LIGHT = OFF;
		PWM_Config(100, 0);//PWM off
	}
	else
	{
		LIGHT = ON;
		PWM_Config(100, 100);//PWM off
	}

	//Time1 use for time counter, 1S/interrupt service
	TIM1_Init();
	
	while (1)
	{
		adcData[i++] = GetADC();
		if(i > 4)	i = 0;
		
		//if it's daytime, turn the light off
		if(adcData[0] < OFF_LUX && adcData[1] < OFF_LUX && adcData[2] < OFF_LUX && adcData[3] < OFF_LUX)
		{
			if(LIGHT == ON)//only when light on/off change 
			{
				LIGHT = OFF;//Relay_IO = 1
				PWM_Config(100, 0);//PWM off
				TIM1_CR1 &= 0xFE;//stop time counter
			}
			if(state != STATE0)
				ex_state = state = STATE0;
				
			second = 0;
			hour = 0;
		}		
		//if it's nighttime, turn the light on
		else if(adcData[0] > ON_LUX && adcData[1] > ON_LUX && adcData[2] > ON_LUX && adcData[3] > ON_LUX)
		{
			if(LIGHT == OFF)//only when light on/off change 
			{
				LIGHT = ON;
			}	
			if((TIM1_CR1 & 0x01) == 0)//if time counter not started, start counting
			{
				second = 0;
				hour = 0;
				TIM1_CR1 |= 0x01;//start time counter
				TIM1_IER |= 0x01;				
			}
			if(state == STATE0)
			{
				PWM_Config(100, 100);
			}
		}
		else;//when the the lux is between ON/OFF, do nothing
		
		DimmingMode(userMode);
		Delay();
	}
}

/****************************************************/
@far @interrupt void TIM1_UPD_IRQHandler(void)
{
	unsigned char i = 0;
	TIM1_SR1 &= 0xFE;//clear interrupt label
	second++;
	if(second == 3600)/***********´ý±ä¸ü£¡£¡£¡£¡£¡***************/
	{
		second = 0;
		hour += 1;
		if(hour > 65536)
			hour = 0;
	}
}

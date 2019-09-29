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

typedef enum {MODE0 = 0, MODE1 = 1, MODE2 = 2, MODE3 = 3, MODE4 = 4, MODE5 = 5, MODE6 = 6} Mode;
typedef enum {STATE0 = 0, STATE1 = 1, STATE2 = 2, STATE3 = 3, STATE4 = 4, STATE5 = 5} State;


unsigned char brightness = BRIGHTNESS; //brightness(0~100),brightness should be add about 3 is correct

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
			
			case MODE2:
				if(hour >= 0 && hour < 9)
					state = STATE1;
				else if(hour >= 9)//always in dimming state
					state = STATE2;
			break;	
			
			case MODE3: 	
				if(second >= 0 && second < 10)
					state = STATE1;
				else if(second >= 10 && second < 20)//(hour >= 6 && hour < 10)
					state = STATE2;
				else if(second >= 20 && second < 30) 
					state = STATE3;	
				else
				{
					state = STATE1;	
					second = 0;
				}
			break;

			case MODE4:
				if(hour >= 0 && hour < 1)//1hour
					state = STATE1;
				else if(hour >= 1 && hour < 4)//3hours
					state = STATE2;
				else if(hour >= 4 && hour < 5)//1hour
					state = STATE3;					
				else if(hour >= 5 && hour < 12)//7hours
					state = STATE4;
				else
					state = STATE5;
			break;

			case MODE5:
				if(hour >= 0 && hour < 5)//5hour
					state = STATE1;
				else if(hour >= 5 && hour < 7)//2hours
					state = STATE2;
				else if(hour >= 7 && hour < 11)//4hour
					state = STATE3;					
				else if(hour >= 11 && hour < 12)//1hours
					state = STATE4;
				else
					state = STATE5;
			break;

			case MODE6:
				if(hour >= 0 && hour < 4)//4hours
					state = STATE1;
				else if(hour >= 4 && hour < 7)//3hours
					state = STATE2;
				else if(hour >= 7 && hour < 11)//4hours
					state = STATE3;					
				else
					state = STATE4;
			break;

			default:	break;
		}
	}
	//when state changed
	if(ex_state != state)
	{
		if(mode == MODE5)
		{
			switch (state)
			{
				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
				case STATE1:	PWM_Config(100, 100);	break;
				case STATE2:	PWM_Config(100, 75);	break;			
				case STATE3:	PWM_Config(100, 50);	break;
				case STATE4:	PWM_Config(100, 60);	break;
				case STATE5:	PWM_Config(100, 60);	break;
				default: break;
			}		
		}
		else if(mode == MODE6)
		{
			switch (state)
			{
				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
				case STATE1:	PWM_Config(100, 100);	break;
				case STATE2:	PWM_Config(100, 60+1);	break;			
				case STATE3:	PWM_Config(100, 40+3);	break;
				case STATE4:	PWM_Config(100, 50+2);	break;
				default: break;
			}		
		}		
		else
		{
			switch (state)
			{
				case STATE0:	PWM_Config(100, 0);	break;//never run to STATE0
				case STATE1:	PWM_Config(100, 100);	break;
				case STATE2:	PWM_Config(100, brightness);	break;			
				case STATE3:	PWM_Config(100, 80);	break;			
				default: break;
			}
		}
	}	else;//when state no change, do nothing
	ex_state = state;
}
		

main()
{
	volatile static unsigned char adcCount = 0;
	volatile unsigned char offCount = 0;
	volatile unsigned char onCount = 0;	
	unsigned int i,x,y;
	bool exRelayStat = OFF;
	static unsigned int adcData[DELAY] = {0};
	
	CLK_CKDIVR = 0x08;//f = f HSI RCÊä³ö/2=8MHz
	
	//delay a while in cace ADC get the wrong voltage
	Delay(); Delay(); Delay(); Delay(); Delay(); //about 5s
	
	
	//Dimming IO config
	PWM_GPIO_Config();
	
	//Get ADC initial data and check the light ON/OFF state
	InitADC();	
	//adcData[0] = adcData[1] = adcData[2] = adcData[3] = adcData[4] = GetADC();
	for(i=0;i<DELAY;i++)
	{
		adcData[i] = GetADC();
	}
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
	while(1)
	{
		adcData[adcCount++] = GetADC();
		if(adcCount >= DELAY)	
			adcCount = 0;
		
		//only when all data is lager than ON or small than OFF
		for(i=0; i<DELAY;i++)
		{
			if(adcData[i] < OFF_LUX)
				offCount += 1;
			else if(adcData[i] > ON_LUX)
				onCount += 1;
			else;//do nothing
		}
		//if it's daytime, turn the light OFF
		if(offCount >= DELAY)
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
		//if it's nighttime, turn the light ON
		else if(onCount >= DELAY)
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
		else;//between ON/OFF, do nothing
		
		offCount = 0;
		onCount  = 0;	
		DimmingMode(userMode);
		Delay500ms();
		//Delay50us();
	}
	
	while (0)
	{
		adcData[adcCount++] = GetADC();
		if(adcCount > 4)	adcCount = 0;
		
		//if it's daytime, turn the light off
		if(adcData[0] < OFF_LUX \
		&& adcData[1] < OFF_LUX \
		&& adcData[2] < OFF_LUX \
		&& adcData[3] < OFF_LUX \
		&& adcData[4] < OFF_LUX)
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
		else if(adcData[0] > ON_LUX \
		&& adcData[1] > ON_LUX \
		&& adcData[2] > ON_LUX \
		&& adcData[3] > ON_LUX \
		&& adcData[4] > ON_LUX)
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
	if(second >= 3600)/***********´ý±ä¸ü£¡£¡£¡£¡£¡***************/
	{
		second = 0;
		hour += 1;
		if(hour > 65536)
			hour = 0;
	}
}



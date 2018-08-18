#ifndef _GLOBAL_H_
#define _GLOBAL_H_

#define OFF_LUX 	4450  //60lux
#define ON_LUX 		4750  //16lux
#define ON				0
#define OFF				1

extern unsigned int second;
extern unsigned int hour;
extern unsigned char brightness;
typedef enum {FALSE = 0, TRUE = !FALSE} bool;
extern bool isDimmingConfiged;
extern bool timeChanged;
extern bool relayStat;

#endif
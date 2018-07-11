#ifndef _GLOBAL_H_
#define _GLOBAL_H_

#define OFF_LUX 	2500
#define ON_LUX 		3550
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
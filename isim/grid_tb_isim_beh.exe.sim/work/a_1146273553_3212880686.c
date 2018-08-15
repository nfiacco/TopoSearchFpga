/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//thayerfs.thayer.dartmouth.edu/f0019wr/Documents/Xilinx/FinalProject/SlowClkGen.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_1146273553_3212880686_p_0(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    int t8;
    char *t9;
    int t10;
    int t11;
    unsigned char t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3640);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(59, ng0);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(61, ng0);
    t3 = (t0 + 1512U);
    t7 = *((char **)t3);
    t8 = *((int *)t7);
    t3 = (t0 + 2088U);
    t9 = *((char **)t3);
    t10 = *((int *)t9);
    t11 = (t10 - 1);
    t12 = (t8 == t11);
    if (t12 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t8 = *((int *)t3);
    t10 = (t8 + 1);
    t1 = (t0 + 3736);
    t4 = (t1 + 56U);
    t7 = *((char **)t4);
    t9 = (t7 + 56U);
    t13 = *((char **)t9);
    *((int *)t13) = t10;
    xsi_driver_first_trans_fast(t1);

LAB9:    goto LAB6;

LAB8:    xsi_set_current_line(62, ng0);
    t3 = (t0 + 3736);
    t13 = (t3 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    *((int *)t16) = 0;
    xsi_driver_first_trans_fast(t3);
    goto LAB9;

}

static void work_a_1146273553_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    char *t4;
    int t5;
    int t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(75, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t1 = (t0 + 2088U);
    t4 = *((char **)t1);
    t5 = *((int *)t4);
    t6 = (t5 - 1);
    t7 = (t3 == t6);
    if (t7 != 0)
        goto LAB3;

LAB4:
LAB5:    t12 = (t0 + 3800);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t12);

LAB2:    t17 = (t0 + 3656);
    *((int *)t17) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 3800);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB6:    goto LAB2;

}


extern void work_a_1146273553_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1146273553_3212880686_p_0,(void *)work_a_1146273553_3212880686_p_1};
	xsi_register_didat("work_a_1146273553_3212880686", "isim/grid_tb_isim_beh.exe.sim/work/a_1146273553_3212880686.didat");
	xsi_register_executes(pe);
}

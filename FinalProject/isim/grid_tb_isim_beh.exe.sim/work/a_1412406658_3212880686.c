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
static const char *ng0 = "//thayerfs.thayer.dartmouth.edu/f0019wr/Documents/Xilinx/FinalProject/generic_decoder.vhd";
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_1657552908_1035706684(char *, char *, char *);


static void work_a_1412406658_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    int t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;

LAB0:    xsi_set_current_line(46, ng0);
    t1 = xsi_get_transient_memory(256U);
    memset(t1, 0, 256U);
    t2 = t1;
    memset(t2, (unsigned char)2, 256U);
    t3 = (t0 + 2912);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 256U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(48, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t8 = *((unsigned char *)t2);
    t9 = (t8 == (unsigned char)3);
    if (t9 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 2832);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(49, ng0);
    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t1 = (t0 + 4764U);
    t10 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t3, t1);
    t11 = (t10 - 255);
    t12 = (t11 * -1);
    t13 = (1 * t12);
    t14 = (0U + t13);
    t4 = (t0 + 2912);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t15 = *((char **)t7);
    *((unsigned char *)t15) = (unsigned char)3;
    xsi_driver_first_trans_delta(t4, t14, 1, 0LL);
    goto LAB3;

}


extern void work_a_1412406658_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1412406658_3212880686_p_0};
	xsi_register_didat("work_a_1412406658_3212880686", "isim/grid_tb_isim_beh.exe.sim/work/a_1412406658_3212880686.didat");
	xsi_register_executes(pe);
}

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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_1242562249;
char *WORK_P_0448454464;
char *WORK_P_1529582702;
char *WORK_P_2351567727;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_1242562249_init();
    work_p_2351567727_init();
    work_p_1529582702_init();
    work_p_0448454464_init();
    work_a_4074272516_3212880686_init();
    work_a_1146273553_3212880686_init();
    work_a_2256837143_3212880686_init();
    work_a_1412406658_3212880686_init();
    work_a_1121535680_3212880686_init();
    work_a_4005775292_3212880686_init();
    work_a_0607857678_3212880686_init();
    work_a_2897498504_3212880686_init();
    work_a_2779932835_3212880686_init();
    work_a_0171960276_3212880686_init();
    work_a_2872731708_3212880686_init();
    work_a_1918179550_3212880686_init();
    work_a_2333286337_3212880686_init();
    work_a_2895730147_3212880686_init();
    work_a_1231308667_3212880686_init();
    work_a_0535646419_3212880686_init();
    work_a_1647657036_2372691052_init();


    xsi_register_tops("work_a_1647657036_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    WORK_P_0448454464 = xsi_get_engine_memory("work_p_0448454464");
    WORK_P_1529582702 = xsi_get_engine_memory("work_p_1529582702");
    WORK_P_2351567727 = xsi_get_engine_memory("work_p_2351567727");

    return xsi_run_simulation(argc, argv);

}

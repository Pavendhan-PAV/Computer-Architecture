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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "\nREAD---\nRead: %b\nOutput_Addr1: %0d\tOutput_Addr2: %0d\nOutput1: %0d\t\tOutput2: %0d\n\nWRITE---\nWrite: %0d\nInput_addr: %0d\t\tInput: %0d\n";
static const char *ng1 = "/home/pav/CS/CA/32bit_Register File/Reg_f.v";
static unsigned int ng2[] = {65530U, 0U};
static unsigned int ng3[] = {29U, 0U};
static unsigned int ng4[] = {0U, 0U};
static unsigned int ng5[] = {7U, 0U};
static unsigned int ng6[] = {1U, 0U};
static unsigned int ng7[] = {23467233U, 0U};

void Monitor_54_2(char *);
void Monitor_54_2(char *);


static void Monitor_54_2_Func(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
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
    char *t18;
    char *t19;
    char *t20;

LAB0:    t1 = (t0 + 2248);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t0 + 1768);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t0 + 1928);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t0 + 1048U);
    t11 = *((char **)t10);
    t10 = (t0 + 1208U);
    t12 = *((char **)t10);
    t10 = (t0 + 2408);
    t13 = (t10 + 56U);
    t14 = *((char **)t13);
    t15 = (t0 + 2088);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t0 + 1608);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    xsi_vlogfile_write(1, 0, 3, ng0, 9, t0, (char)118, t3, 1, (char)118, t6, 5, (char)118, t9, 5, (char)118, t11, 32, (char)118, t12, 32, (char)118, t14, 1, (char)118, t17, 5, (char)118, t20, 32);

LAB1:    return;
}

static void Initial_42_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;

LAB0:    t1 = (t0 + 3320U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(43, ng1);

LAB4:    xsi_set_current_line(44, ng1);
    t2 = (t0 + 3128);
    xsi_process_wait(t2, 0LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(44, ng1);
    t3 = ((char*)((ng2)));
    t4 = (t0 + 1608);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    xsi_set_current_line(44, ng1);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2088);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 5);
    xsi_set_current_line(44, ng1);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2248);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(45, ng1);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 5);
    xsi_set_current_line(45, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 1928);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 5);
    xsi_set_current_line(45, ng1);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2408);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(47, ng1);
    t2 = (t0 + 3128);
    xsi_process_wait(t2, 1000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(47, ng1);
    t3 = ((char*)((ng6)));
    t4 = (t0 + 2408);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(48, ng1);
    t2 = (t0 + 3128);
    xsi_process_wait(t2, 2000LL);
    *((char **)t1) = &&LAB7;
    goto LAB1;

LAB7:    xsi_set_current_line(48, ng1);
    t3 = ((char*)((ng5)));
    t4 = (t0 + 2088);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 5);
    xsi_set_current_line(48, ng1);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 1608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(49, ng1);
    t2 = (t0 + 3128);
    xsi_process_wait(t2, 3000LL);
    *((char **)t1) = &&LAB8;
    goto LAB1;

LAB8:    xsi_set_current_line(49, ng1);
    t3 = ((char*)((ng6)));
    t4 = (t0 + 2248);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    goto LAB1;

}

static void Initial_52_1(char *t0)
{

LAB0:    xsi_set_current_line(53, ng1);

LAB2:    xsi_set_current_line(54, ng1);
    Monitor_54_2(t0);

LAB1:    return;
}

void Monitor_54_2(char *t0)
{
    char *t1;
    char *t2;

LAB0:    t1 = (t0 + 3624);
    t2 = (t0 + 4136);
    xsi_vlogfile_monitor((void *)Monitor_54_2_Func, t1, t2);

LAB1:    return;
}


extern void work_m_14685702347858054532_3823007873_init()
{
	static char *pe[] = {(void *)Initial_42_0,(void *)Initial_52_1,(void *)Monitor_54_2};
	xsi_register_didat("work_m_14685702347858054532_3823007873", "isim/top_isim_beh.exe.sim/work/m_14685702347858054532_3823007873.didat");
	xsi_register_executes(pe);
}

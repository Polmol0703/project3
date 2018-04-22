clear all
close all
clc

eff_comp = 0.85;
eff_turbine = 0.85;
eff_reg = 0.75;
p_2 = 500000;
gamma = 0.25;
t_4 = 1600;
q_dot_sol = 2e6;
[alpha, t_5, w_t_actual, w_c_actual, w_net, q_c, eff_cycle] = findalpha(eff_comp, eff_turbine, eff_reg, p_2, gamma, t_4, q_dot_sol);
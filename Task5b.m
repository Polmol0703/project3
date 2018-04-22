clear all
close all
clc

eff_comp = 0.85;
eff_turbine = 0.85;
eff_reg = 0.75;
p_2 = 500000;
gamma = 0.25;
t_4 = 1600;

alpha_array = [];
w_net_array = [];
q_c_array = [];
eff_cycle = [];

i = 1;
for q_dot_sol = [0, 2e6, 2.5e6, 3e6]

    [alpha, t_5, w_t_actual, w_c_actual, w_net, q_c, eff_cycle] = findalpha(eff_comp, eff_turbine, eff_reg, p_2, gamma, t_4, q_dot_sol);

    alpha_array(i) = alpha;
    w_net_array(i) = w_net;
    q_c_array(i) = q_c;
    eff_cycle_array(i) = eff_cycle;
    
    i = i+1;
end
clear all
close all
clc

eff_comp = 0.85;
eff_turbine = 0.85;
eff_reg = 0.75;
p_2 = 500000;
t_4 = 1600;

alpha_array = [];
w_net_array = [];
q_c_array = [];
eff_cycle = [];


i = 1;
for gamma = [0,0.25,0.5]
for q_dot_sol = [0, 2e6, 2.5e6, 3e6]

    [alpha, t_5, w_t_actual, w_c_actual, w_net, q_c, eff_cycle, eff_cycle_constant_cp] = findalpha(eff_comp, eff_turbine, eff_reg, p_2, gamma, t_4, q_dot_sol);

    alpha_array(i) = alpha;
    w_net_array(i) = w_net;
    q_c_array(i) = q_c;
    eff_cycle_array(i) = eff_cycle;
    
    i = i+1;
end
end

figure(1)
plot([0,2,2.5,3], alpha_array(1:4), '-r',...
[0,2,2.5,3], alpha_array(5:8), '-b',...
[0,2,2.5,3], alpha_array(9:12), '-g')
xlabel('Solar Power')
ylabel('Alpha')
legend('\gamma = 0', '\gamma = 0.25', '\gamma = 0.5')
figure(2)
plot([0,2,2.5,3], w_net_array(1:4), '-r',...
[0,2,2.5,3], w_net_array(5:8), '-b',...
[0,2,2.5,3], w_net_array(9:12), '-g')
xlabel('Solar Power')
ylabel('Net Power Out')
legend('\gamma = 0', '\gamma = 0.25', '\gamma = 0.5')
figure(3)
plot([0,2,2.5,3], eff_cycle_array(1:4), '-r',...
[0,2,2.5,3], eff_cycle_array(5:8), '-b',...
[0,2,2.5,3], eff_cycle_array(9:12), '-g')
xlabel('Solar Power')
ylabel('Cycle Efficiency')
legend('\gamma = 0', '\gamma = 0.25', '\gamma = 0.5')
figure(4)
plot([0,2,2.5,3], q_c_array(1:4), '-r',...
[0,2,2.5,3], q_c_array(5:8), '-b',...
[0,2,2.5,3], q_c_array(9:12), '-g')
xlabel('Solar Power')
ylabel('Combustor Heat Input')
legend('\gamma = 0', '\gamma = 0.25', '\gamma = 0.5')


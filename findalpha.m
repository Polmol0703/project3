function [alpha, t_5, w_t_actual, w_c_actual, w_net, q_c, eff_cycle, eff_cycle_constant_cp] = findalpha(eff_comp, eff_turbine, eff_reg, p_2, gamma, t_4, q_dot_sol)  

i = 1;
e2 = 1;
alpha_stoic = 4.76*(2+ 3*gamma);
alpha_guess = alpha_stoic;
while e2 > 0.2


[t_2, W, h_2] = t2_W_h2_finder (p_2, eff_comp);
t_1 = 25 + 273;
R = 8.315; %gas constant in J/mol K
p_1 = 101000; %inlet pressure in pascals

e = 1;
t_5_guess = 1000;


m_dot_air = 6; %in kg/s
molar_mass_air = 0.02897; %kg/mol
n_dot_air = (m_dot_air/molar_mass_air); %mol/s
n_dot_fuel = n_dot_air / alpha_guess;
moles_prod_per_fuel = alpha_guess + gamma + 1; % moles of product per moles of fuel
n_dot_prod = n_dot_fuel * moles_prod_per_fuel; %mol/s

    while e>0.2
        [y_H2O, y_CO2, y_N2, y_O2] = mol_frac_finder(alpha_guess, gamma);
        t_avg_turbine = 0.5*(t_4 + t_5_guess);
        [cp_prod] = cp_prod_finder(y_H2O, y_CO2, y_N2, y_O2, t_avg_turbine); %kJ/kmol K 
        cv_prod = cp_prod - R;
        k = cp_prod / cv_prod;
        delta_h5_h4 = cp_prod*(t_4 - t_5_guess);
        p_4 = p_2;
        p_5 = p_1;
        t_5 = t_4*(p_5/p_4)^((k-1)/k);
        e = abs(t_5 - t_5_guess);
        t_5_guess = t_5;
    end
    
    
[a_air, b_air, c_air, d_air] = findConstants('air-');
cp_air = a_air + b_air*t_avg_turbine + c_air*t_avg_turbine^2 + d_air*t_avg_turbine^3; %kJ/kmol K

ncp_air = n_dot_air*cp_air; %J/sK or W/K
ncp_prod = n_dot_prod*cp_prod; %J/sK or W/K

ncp_min = min(ncp_air,ncp_prod); %J/sK or W/K

t_2r = ((eff_reg * ncp_min * (t_5_guess - t_2)) / ncp_air) + t_2;

t_3 = (q_dot_sol / (ncp_air)) + t_2r;

[xData, yData, fitresult, a, n, T_af_array, alpha_array] = curvefit(t_3);
alpha_new = ((t_4 - t_3)/a)^(-1/n) * alpha_stoic;
e2 = abs(alpha_new - alpha_guess);
alpha_guess = alpha_new;
i = i+1;
end 
alpha = alpha_guess;
cv_air = cp_air - R;
k_air = cp_air/cv_air;
k_prod = cp_prod/cp_prod;

w_t_actual = cp_prod*(t_4-t_5)*n_dot_prod*eff_turbine;
w_c_actual = cp_air*(t_2-t_1)*n_dot_air*eff_comp;
w_net = w_t_actual - w_c_actual;
q_c = cp_prod*(t_4 - t_3)*n_dot_prod;
eff_cycle = w_net / (q_c + q_dot_sol);
eff_cycle_constant_cp = 1 - (t_1/t_4)*(p_2/p_1)^((k_prod-1)/k_prod);




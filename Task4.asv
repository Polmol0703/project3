clear all
close all

gamma = 0.25;
alpha_stoic = 4.76*(2+ 3*gamma);
t_4 = 1600;
R = 8.315; %gas constant in J/mol K
p_1 = 101000; %inlet pressure in pascals
p_2 = 500000; 
e = 1;
t_5_guess = 1000;
alpha = alpha_stoic;
i=1;
while e>0.2
    [t_2, W, h_2] = t2_W_h2_finder(500000, 0.5);
    if i ~= 1
        [xData, yData, fitresult, a, n, T_af_array, alpha_array] = curvefit(t_4);
        alpha = ((t_4 - t_5_guess)/a)^(-1/n) * alpha_stoic;
    end
    [y_H2O, y_CO2, y_N2, y_O2] = mol_frac_finder(alpha, gamma);
    t_avg_turbine = 0.5*(t_4 + t_5_guess);
    [cp_prod] = cp_prod_finder(y_H2O, y_CO2, y_N2, y_O2, t_avg_turbine);
    cv_prod = cp_prod - R;
    k = cp_prod / cv_prod;
    delta_h5_h4 = cp_prod*(t_4 - t_5_guess);
    p_4 = p_2;
    p_5 = p_1;
    t_5 = t_4*(p_5/p_4)^((k-1)/k);
    e = abs(t_5 - t_5_guess);
    t_5_guess = t_5;
    i = i+1;
end

t_avg_regen = 0.5*(t_2 + t_5);




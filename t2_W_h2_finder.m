function [t_2, W, h_2] = t2_w_h2_finder (p_2, eff_comp)
t_1 = 25 + 273;
t_2_guess = t_1 + 1; % left guess t2 in Kelvin
t_2_right_guess = 500 + 273; % right guess t2 in Kelvin
[a_air, b_air, c_air, d_air] = findConstants('air-');
p_1 = 101000; %inlet pressure in pascals
e = 2;
h_1 = 0;
while e > 0.2
    t_avg_comp = (t_1+t_2_guess)*0.5;
    cp_air = a_air + b_air*t_avg_comp + c_air*t_avg_comp^2 + d_air*t_avg_comp^3;
    R = 8.315; %gas constant in J/mol K
    c_v = cp_air - R;
    h_2 = cp_air*(t_2_guess - t_1) + h_1;
    k = cp_air / c_v;
    t_2 = t_1*(p_2/p_1)^((k-1)/k);
    e = abs(t_2_guess - t_2);
    t_2_guess = t_2_guess + 0.1;
end
t_2 = t_2_guess;
W = cp_air*(t_2 - t_1)/eff_comp;

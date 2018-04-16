t_1 = 25 + 273;
t_2_guess = 50 + 273; %guess t2 in Kelvin
[a_o2, b_o2, c_o2, d_o2, h_i_o2] = findConstants('o2--');
T = (t_1+t_2_guess)*0.5;
c_p = a_o2 + b_o2*T + c_o2*T^2 + d_o2*T^3;
R = 8.315; %gas constant in J/mol K
c_v = c_p - R;
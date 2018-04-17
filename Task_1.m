clear all
close all
t_1 = 25 + 273;
t_2_guess = t_1 + 1; % left guess t2 in Kelvin
t_2_right_guess = 500 + 273; % right guess t2 in Kelvin
[a_o2, b_o2, c_o2, d_o2, h_i_o2] = findConstants('o2--');
p_1 = 101000; %inlet pressure in pascals
p_2 = 500000; %outlet pressure in pascals
e = 2;
while e > 0.2
    T = (t_1+t_2_guess)*0.5;
    c_p = a_o2 + b_o2*T + c_o2*T^2 + d_o2*T^3;
    R = 8.315; %gas constant in J/mol K
    c_v = c_p - R;
    h_2 = c_p*(t_2_guess - t_1);
    k = c_p / c_v;
    t_2 = t_1*(p_2/p_1)^((k-1)/k);
    e = abs(t_2_guess - t_2);
    t_2_guess = t_2_guess + 0.1;
end
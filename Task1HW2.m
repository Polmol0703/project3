clear all
close all
[a_o2, b_o2, c_o2, d_o2, h_i_o2] = findConstants('o2--');
[a_n2, b_n2, c_n2, d_n2, h_i_n2] = findConstants('n2--');
[a_h2o, b_h2o, c_h2o, d_h2o, h_i_h2o] = findConstants('h2o-');
[a_c3h8, b_c3h8, c_c3h8, d_c3h8, h_i_c3h8] = findConstants('c3h8');
[a_ch4, b_ch4, c_ch4, d_ch4, h_i_ch4] = findConstants('ch4-');
[a_co2, b_co2, c_co2, d_co2, h_i_co2] = findConstants('co2-');

T_r = 550;
gamma = 1;
alpha = 4.76*(2+ 3*gamma);

syms T_p h_o2_tr h_n2_tr h_c3h8_tr h_ch4_tr h_n2_tp h_o2_tp h_h2o_tp h_co2_tp

eqns = [h_o2_tr == h_i_o2 + (a_o2 + b_o2*(0.5*(T_r + T_p)) + c_o2*(0.5*(T_r + T_p))^2 + d_o2*(0.5*(T_r + T_p))^3)*(T_r - 298),...
    
        h_n2_tr == h_i_n2 + (a_n2 + b_n2*(0.5*(T_r + T_p)) + c_n2*(0.5*(T_r + T_p))^2 + d_n2*(0.5*(T_r + T_p))^3)*(T_r - 298),...
        
        h_c3h8_tr == h_i_c3h8 + (a_c3h8 + b_c3h8*(0.5*(T_r + T_p)) + c_c3h8*(0.5*(T_r + T_p))^2 + d_c3h8*(0.5*(T_r + T_p))^3)*(T_r - 298),...
        
        h_ch4_tr == h_i_ch4 + (a_ch4 + b_ch4*(0.5*(T_r + T_p)) + c_ch4*(0.5*(T_r + T_p))^2 + d_ch4*(0.5*(T_r + T_p))^3)*(T_r - 298),...

        h_n2_tp == h_i_n2 + (a_n2 + b_n2*(0.5*(T_r + T_p)) + c_n2*(0.5*(T_r + T_p))^2 + d_n2*(0.5*(T_r + T_p))^3)*(T_p - 298),...

        h_o2_tp == h_i_o2 + (a_o2 + b_o2*(0.5*(T_r + T_p)) + c_o2*(0.5*(T_r + T_p))^2 + d_o2*(0.5*(T_r + T_p))^3)*(T_p - 298),...

        h_h2o_tp == h_i_h2o + (a_h2o + b_h2o*(0.5*(T_r + T_p)) + c_h2o*(0.5*(T_r + T_p))^2 + d_h2o*(0.5*(T_r + T_p))^3)*(T_p - 298),...

        h_co2_tp == h_i_co2 + (a_co2 + b_co2*(0.5*(T_r + T_p)) + c_co2*(0.5*(T_r + T_p))^2 + d_co2*(0.5*(T_r + T_p))^3)*(T_p - 298),...
        
        0 == (((alpha / 4.76) * h_o2_tr + ((3.76 * alpha) / 4.76) * h_n2_tr + gamma * h_c3h8_tr + (1 - gamma) * h_ch4_tr)) ...
        - ((((3.76 * alpha) / 4.76) * h_n2_tp + ((alpha / 4.76) - 3*gamma - 2) * h_o2_tp + (2 + 2*gamma) * h_h2o_tp + (1 + 2*gamma) * h_co2_tp))];
    
S = solve(eqns, [T_p h_o2_tr h_n2_tr h_c3h8_tr h_ch4_tr h_n2_tp h_o2_tp h_h2o_tp h_co2_tp]);
double(S.T_p)
        


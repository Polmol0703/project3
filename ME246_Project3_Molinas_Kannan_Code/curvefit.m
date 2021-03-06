function [xData, yData, fitresult, a, n, T_af_array, alpha_array,T] = curvefit(T_r)

[a_o2, b_o2, c_o2, d_o2, h_i_o2] = findConstants('o2--');
[a_n2, b_n2, c_n2, d_n2, h_i_n2] = findConstants('n2--');
[a_h2o, b_h2o, c_h2o, d_h2o, h_i_h2o] = findConstants('h2o-');
[a_c3h8, b_c3h8, c_c3h8, d_c3h8, h_i_c3h8] = findConstants('c3h8');
[a_ch4, b_ch4, c_ch4, d_ch4, h_i_ch4] = findConstants('ch4-');
[a_co2, b_co2, c_co2, d_co2, h_i_co2] = findConstants('co2-');
alpha_array = [13.09, 16, 20, 24, 28, 32, 36];

i=1;
gamma = 0.25;
alpha_stoic = 4.76*(2+ 3*gamma);


for alpha = alpha_array
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
T_af = double(S.T_p);
T_af_array(i) = T_af(1);
i = i+1;
end        


T = T_af_array - T_r;

[xData, yData] = prepareCurveData( alpha_array./alpha_stoic, T);
ft = fittype( 'a*(x)^(-b)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
[fitresult, gof] = fit( xData, yData, ft, opts );
coeff = coeffvalues(fitresult);
a = coeff(1);
n = coeff(2);







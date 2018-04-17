clc
clear all
close all
[a_o2, b_o2, c_o2, d_o2, h_i_o2] = findConstants('o2--');
[a_n2, b_n2, c_n2, d_n2, h_i_n2] = findConstants('n2--');
[a_h2o, b_h2o, c_h2o, d_h2o, h_i_h2o] = findConstants('h2o-');
[a_c3h8, b_c3h8, c_c3h8, d_c3h8, h_i_c3h8] = findConstants('c3h8');
[a_ch4, b_ch4, c_ch4, d_ch4, h_i_ch4] = findConstants('ch4-');
[a_co2, b_co2, c_co2, d_co2, h_i_co2] = findConstants('co2-');
alpha_array = [13.09, 16, 20, 24, 28, 32, 36];

i=1;
for T_r = [300,550,800]
gamma = 0.25;


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
end

T_af_array_300 = T_af_array(1:7);
T_af_array_550 = T_af_array(8:14);
T_af_array_800 = T_af_array(15:21);

T_300 = T_af_array_300 - T_r;
T_550 = T_af_array_550 - T_r;
T_800 = T_af_array_800 - T_r;

figure(1)
loglog(alpha_array, T_300, '-r', alpha_array, T_550, '-b', ...
alpha_array, T_800, '-g')
xlabel('\alpha')
ylabel('T_{af} - T_r')
legend('300K', '550K', '800K')

[xData_300, yData_300] = prepareCurveData( alpha_array, T_300 );
ft = fittype( 'a*(x/0.5)^(-b)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
[fitresult_300, gof_300] = fit( xData_300, yData_300, ft, opts );
figure(2)
plot(fitresult_300, xData_300, yData_300);
xlabel('\alpha')
ylabel('T_{af} - T_r')
coeff_300 = coeffvalues(fitresult_300);
a_300 = coeff_300(1);
n_300 = coeff_300(2);
T_300_pred = a_300.*(alpha_array./0.5).^(-n_300);
max_error_300 = max(abs(T_300 - T_300_pred));
mean_error_300 = mean(abs(T_300 - T_300_pred));
fprintf('The maximum absolute deviation for T_r = 300K is %f', max_error_300, '\n')
fprintf('The mean absolute deviation for T_r = 300K is %f', mean_error_300, '\n')

[xData_550, yData_550] = prepareCurveData( alpha_array, T_550 );
ft = fittype( 'a*(x/0.5)^(-b)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
[fitresult_550, gof_550] = fit(xData_550, yData_550, ft, opts );
figure(3)
plot(fitresult_550, xData_550, yData_550);
xlabel('\alpha')
ylabel('T_{af} - T_r')
coeff_550 = coeffvalues(fitresult_550);
a_550 = coeff_550(1);
n_550 = coeff_550(2);
T_550_pred = a_550.*(alpha_array./0.5).^(-n_550);
max_error_550 = max(abs(T_550 - T_550_pred));
mean_error_550 = mean(abs(T_550 - T_550_pred));
fprintf('The maximum absolute deviation for T_r = 550K is %f', max_error_550, '\n')
fprintf('The mean absolute deviation for T_r = 550K is %f', mean_error_550, '\n')

[xData_800, yData_800] = prepareCurveData( alpha_array, T_800);
ft = fittype( 'a*(x/0.5)^(-b)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
[fitresult_800, gof_800] = fit( xData_800, yData_800, ft, opts );
figure(4)
plot(fitresult_800, xData_800, yData_800);
xlabel('\alpha')
ylabel('T_{af} - T_r')
coeff_800 = coeffvalues(fitresult_800);
a_800 = coeff_800(1);
n_800 = coeff_800(2);
T_800_pred = a_800.*(alpha_array./0.5).^(-n_800);
max_error_800 = max(abs(T_800 - T_800_pred));
mean_error_800 = mean(abs(T_800 - T_800_pred));
fprintf('The maximum absolute deviation for T_r = 800K is %f', max_error_800, '\n')
fprintf('The mean absolute deviation for T_r = 800K is %f', mean_error_800, '\n')


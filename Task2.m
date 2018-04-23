clear all
close all

gamma = 0.25;
alpha_stoic = 4.76*(2+ 3*gamma);
for T_r = [300,550,800]
[xData, yData, fitresult, a, n, T_af_array, alpha_array] = curvefit(T_r);
T = T_af_array - T_r;
figure(1)
loglog(alpha_array, T)
hold on
xlabel('\alpha')
ylabel('T_{af} - T_r')
legend('300K', '500K', '800K')
T_pred = a.*(alpha_array./alpha_stoic).^(-n);
max_error = max(abs(T - T_pred));
mean_error = mean(abs(T - T_pred));
fprintf('The maximum absolute deviation for T_r = %f is %f \n', T_r, max_error)
fprintf('The mean absolute deviation for T_r = %f is %f \n', T_r, mean_error)
end 

i = 1;
for T_r = [300,550,800]
[xData, yData, fitresult, a, n, T_af_array, alpha_array] = curvefit(T_r);
T = T_af_array - T_r;
if i == 1
    dataformat = 'xb';
    curveformat = '-b';
elseif i == 2
    dataformat = 'xr';
    curveformat = '-r';
elseif i == 3
    dataformat = 'xg';
    curveformat = '-g';
end
figure(2)
plot(fitresult,curveformat, xData, yData,dataformat);
hold on
xlabel('\alpha')
ylabel('T_{af} - T_r')
legend('data 300K', 'curve fit 300K', 'data 550K', 'curve fit 550K', 'data 800K', 'curve fit 800K')
i = i + 1;
end 





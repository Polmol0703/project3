clear all
close all

for T_r = [300, 550, 800]
[xData, yData, fitresult, a, n, T_af_array, alpha_array] = curvefit(T_r);

T = T_af_array - T_r;
hold on
loglog(alpha_array, T)
xlabel('\alpha')
ylabel('T_{af} - T_r')
legend('300K', '500K', '800K')
end 

figure(2)
plot(fitresult, xData, yData);
xlabel('\alpha')
ylabel('T_{af} - T_r')


function [a, b, c, d, h_i] = findConstants(i)

if i == 'o2--'
    a = 25.48;
    b = 1.520e-2;
    c = -0.7155e-5;
    d = 1.312e-9;
    h_i = 0;
elseif i == 'n2--'
    a = 28.9;
    b = -0.1571e-2;
    c = 0.8081e-5;
    d = -2.873e-9;
    h_i = 0;
elseif i == 'h2o-'
    a = 33.24;
    b = 0.1923e-2;
    c = 1.055e-5;
    d = -3.595e-9;
    h_i = -241820;
elseif i == 'c3h8'
    a = -4.04;
    b = 30.48e-2;
    c = -15.72e-5;
    d = 31.74e-9;
    h_i = -103850;
elseif i == 'ch4-'
    a = 19.89;
    b = 5.024e-2;
    c = 1.269e-5;
    d = -11.01e-9;
    h_i = -74850;
elseif i == 'co2-'
    a = 22.26;
    b = 5.981e-2;
    c = -3.501e-5;
    d = 7.469e-9;
    h_i = -393520;
end





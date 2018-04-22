function [cp_prod] = cp_prod_finder(y_H2O, y_CO2, y_N2, y_O2, T_4)

[a_o2, b_o2, c_o2, d_o2] = findConstants('o2--');
[a_n2, b_n2, c_n2, d_n2] = findConstants('n2--');
[a_h2o, b_h2o, c_h2o, d_h2o] = findConstants('h2o-');
[a_co2, b_co2, c_co2, d_co2] = findConstants('co2-');

cp_O2 = (a_o2 + b_o2*(T_4) + c_o2*(T_4)^2 + d_o2*(T_4)^3);
cp_H2O = (a_h2o + b_h2o*(T_4) + c_h2o*(T_4)^2 + d_h2o*(T_4)^3);
cp_N2 = (a_n2 + b_n2*(T_4) + c_n2*(T_4)^2 + d_n2*(T_4)^3);
cp_CO2 = (a_co2 + b_co2*(T_4) + c_co2*(T_4)^2 + d_co2*(T_4)^3);

cp_prod = cp_O2 * y_O2 + cp_CO2 * y_CO2 + cp_N2 * y_N2 + cp_H2O * y_H2O;
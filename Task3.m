clear all

gamma = 0.25;
alpha_stoic = 4.76*(2+ 3*gamma);
alpha = alpha_stoic;
T = 600;

[y_H2O, y_CO2, y_N2, y_O2] = mol_frac_finder(alpha, gamma);
[cp_prod] = cp_prod_finder(y_H2O, y_CO2, y_N2, y_O2, T);

fprintf("The molar fraction of the products are as follows:\n");
fprintf("\nCO2: %1.4f",y_CO2);
fprintf("\nH2O: %1.4f",y_H2O);
fprintf("\nO2: %1.4f",y_O2);
fprintf("\nN2: %1.4f",y_N2);

fprintf("\ncp_prod: %4.4f",cp_prod);




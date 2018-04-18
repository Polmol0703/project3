function [y_H2O, y_CO2, y_N2, y_O2] = mol_frac_finder(alpha, gamma)

moles_H2O = 3.76 * alpha / 4.76;
moles_CO2 = ((alpha / 4.76) - (3 * gamma) - 2);
moles_N2 = 2 + 2 * gamma;
moles_O2 = 1 + 2 * gamma;
moles_total = moles_H2O + moles_CO2 + moles_N2 + moles_O2;
y_H2O = moles_H2O / moles_total;
y_CO2 = moles_CO2 / moles_total;
y_N2 = moles_N2 / moles_total;
y_O2 = moles_O2 / moles_total;

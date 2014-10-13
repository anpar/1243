function [Ar, N2, O2, H2O, CH4] = OutilDeGestion(T, NH3)
% Groupe 124.3 - 13/10/014 
% Retourne les masses/jour de matières premières :
% - Air : N2, O2, Ar, CO ;
% - CH4, H20
% Input : T en Kelvin et NH3 en t/d.
% Output : matières premières en tonnes.

MNH3 = 17;
nNH3 = (NH3*1000*1000)/MNH3;

R = 8.3144621;
G1 = (188369.9) - (71.16*T*log(T)) + (238.21*T) + (0.04163*T^2) - ((4.045e-6)*T^3);
K1 = exp(-G1/(R*T)); 
G2 = (-42533.33) + (69.67*T) - (2.93e-3)*(T^2) + (2.1e-7)*(T^3);
K2 = exp(-G2/(R*T));
ptot = 28e5;
p0 = 1e5;

syms x y H2O CH4 positive;
eqn1 = K1 == ((x-y)*((3*x + y)^3)*ptot^2)/((H2O-x)*(H2O-x-y)*(H2O+CH4+(2*x))*p0^2);
eqn2 = K2 == (y*(3*x + y))/((x-y)*(H2O-x-y));
eqn3 = CH4 - x == 7/442 * nNH3;
eqn4 = 3*x + y == (9/221 * nNH3) -x+y;
eqns = [eqn1 eqn2 eqn3 eqn4];

% Solutions du système en moles
[x, y, H2O, CH4] = solve(eqns);  

% On va remettre les solutions du système en tonnes
MAr = 40;
MN2 = 28;
MO2 = 32;
MH2O = 18;
MCH4 = 16;

% On transforme les valeurs en tonnes
% Il faut vérifier la valeur de Ar car Pauline et Nathan
% n'arrivent pas aux mêmes valeurs.
[(((0.25/663)*nNH3)*(MAr))/(1e06), ((nNH3/34)*(MN2))/(1e06), ((7.91855e-3)*nNH3*MO2)/(1e06), (H2O*MH2O)/(1e06), (CH4*MCH4)/(1e06)]
end
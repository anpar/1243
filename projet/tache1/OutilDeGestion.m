function [AIR, H2O, CH4] = OutilDeGestion(T, NH3)
% Groupe 124.3 - 13/10/2014 
% Retourne les masses/jour de matieres premieres :
% - Air : N2, O2, Ar;
% - CH4, H20
% Input : T en Kelvin et NH3 en tonnes/jour.
% Output : matières premieres en tonnes/jour.

% On convertit les tonnes en kilogrammes (*1000) puis en grammes (*1000)
mNH3 = NH3*1e06;

% Constante des gaz parfaits
R = 8.3144621; 

% Constantes d'equilibres des reactions du reformage primaire
G1 = (188369.9) - (71.16*T*log(T)) + (238.21*T) + (0.04163*T^2) - ((4.045e-6)*T^3);
K1 = exp(-G1/(R*T)); 
G2 = (-42533.33) + (69.67*T) - (2.93e-3)*(T^2) + (2.1e-7)*(T^3) - (3.77*T*log(T));
K2 = exp(-G2/(R*T));
% ptot = 28bars, pression a la sortie du reformage primaire
ptot = 28e5;
% p0 = 1 bar, pression standard
p0 = 1e5;

% On resout le systeme formes des 4 equations.
syms x y H2O CH4 positive;
eqn1 = K1 == ((x-y)*((3*x + y)^3)*ptot^2)/((H2O-x)*(H2O-x-y)*(H2O+CH4+(2*x))^2*p0^2);
eqn2 = K2 == (y*(3*x + y))/((x-y)*(H2O-x-y));
eqn3 = CH4 - x == 7/442 * mNH3;
eqn4 = 3*x + y == (9/221 * mNH3) -x+y;
eqns = [eqn1 eqn2 eqn3 eqn4];

% Solutions du systeme en moles
[x, y, H2O, CH4] = solve(eqns);  

% On va remettre les solutions du systeme en tonnes
MAr = 39.948;
MN2 = 28.014;
MO2 = 31.998;
MH2O = 18.0148;
MCH4 = 16.0426;

nAr = (0.01*mNH3)/26.52; % 26.52 = 34*0.78
nN2 =  mNH3/34;
nO2 = (0.21*mNH3)/26.52;
% Masse d'air en tonnes
mAIR = ((nAr)*(MAr))/(1e06) + ((nN2)*(MN2))/(1e06) + (nO2*MO2)/(1e06);

% On transforme les valeurs en tonnes
[mAIR, (H2O*MH2O)/(1e06), (CH4*MCH4)/(1e06)]
end

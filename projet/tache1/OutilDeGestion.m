function [Ar, N2, O2, H2O, CH4] = OutilDeGestion(T, NH3)
% Groupe 124.3 - 13/10/2014 
% Retourne les masses/jour de matières premères :
% - Air : N2, O2, Ar;
% - CH4, H20
% Input : T en Kelvin et NH3 en tonnes/jour.
% Output : matières premières en tonnes/jour.

MNH3 = 17; % Masse molaire du NH3
nNH3 = (NH3*1000*1000)/MNH3; % P-e useless
mNH3 = NH3*1e06;
% On convertit les tonnes en kilogrammes (*1000) puis en grammes (*1000) et
% on divise pas la masse molaire de NH3

R = 8.3144621; % Constante des gaz parfaits

% ----------------------------------------------------------
%      Constantes d'équilibre (c) by Simon Quiriny
% ----------------------------------------------------------
G1 = (188369.9) - (71.16*T*log(T)) + (238.21*T) + (0.04163*T^2) - ((4.045e-6)*T^3);
K1 = exp(-G1/(R*T)); 
G2 = (-42533.33) + (69.67*T) - (2.93e-3)*(T^2) + (2.1e-7)*(T^3) - (3.77*T*log(T));
K2 = exp(-G2/(R*T));
% ptot = 28bars, pression à  la sortie du réformage primaire
ptot = 28e5;
% p0 = pression standard
p0 = 1e5;

% On montre à MatLab quelles sont les variables du système et on lui dit de
% choisir les valeurs positives uniquement.
% Quelles sont les inconnues? A mettre au clair, surtout au niveau des
% unités.
% x : []
% y : []
% CH4 : []
% H2O : []
syms x y H2O CH4 positive;
eqn1 = K1 == ((x-y)*((3*x + y)^3)*ptot^2)/((H2O-x)*(H2O-x-y)*(H2O+CH4+(2*x))*p0^2);
eqn2 = K2 == (y*(3*x + y))/((x-y)*(H2O-x-y));
eqn3 = CH4 - x == 7/442 * mNH3;
eqn4 = 3*x + y == (9/221 * mNH3) -x+y;
eqns = [eqn1 eqn2 eqn3 eqn4];

% Solutions du système en moles
[x, y, H2O, CH4] = solve(eqns);  

% On va remettre les solutions du système en tonnes
MAr = 39.948;
MN2 = 28.014;
MO2 = 31.998;
MH2O = 18.0148;
MCH4 = 16.0426;

nAr = (0.01*mNH3)/26.52 %26.52 = 34*0.78
nN2 =  mNH3/34
nO2 = (0.21*mNH3)/26.52
nAIR = mNH3/26.52; %=nAR+nO2+nN2
nCO2 = ((0.42*mNH3)/26.52) + x; %SORTIE
nH2O = H2O - 2*x ((0.42*mNH3)/26.52); %SORTIE


% On transforme les valeurs en tonnes
[((nAr)*(MAr))/(1e06), ((nN2)*(MN2))/(1e06), (nO2*MO2)/(1e06), (H2O*MH2O)/(1e06), (CH4*MCH4)/(1e06)]
end

function [Output] = ComputeK2(T)
% ComputeK2 - Calcul la constante d'equilibre de la deuxieme reaction du
% reformage primaire ainsi que le DeltaH2 de cette reaction.
%
% Cette fonction MATLAB calcule la constante d'equilibre K2
% de la premiere reaction du reformage primaire en fonction de la
% temperature T exprimee en Kelvin ainsi que le DeltaH2 de cette reaction.
% CO(g) + H2O(g) <-> CO2(g) + H2(g)
% Les donnees thermodynamiques utilisees proviennent du Atkins et de
% <http://www.edu.upmc.fr/chimie/lc101-202-301/communs/public/capcalo.htm> .
%
% ComputeK2(T)
%
% Derniere version : 16-11-2014
% Auteur : le groupe 1243

R = 8.3144621; 
syms t;
% Capacite calorifique a pression constante en fonction de la temperature,
% en joules/mole*Kelvin
CpCO = @(t) 27.62 + (5.02e-3)*t;
CpH2 = @(t) 29.30 - (0.84e-3)*t + (2.09e-6)*t.^2;
CpCO2 =@(t) 32.22 + (22.18e-3)*t - (3.35e-6)*t.^2;
CpH2O = @(t) 30.13 + (10.46e-3)*t;
DeltaCp = @(t) (CpH2(t) + CpCO2(t)) - (CpCO(t) + CpH2O(t));

% Enthalpies de formation et de reaction standard (298.15K), en joules par moles.
HfstdCO = -110.53e3;
HfstdH2 = 0;
HfstdCO2 = -393.51e3;
HfstdH2O = -241.82e3;
Hrstd = (HfstdH2 + HfstdCO2) - (HfstdCO + HfstdH2O);

DeltaH2 = Hrstd + integral(DeltaCp, 298.15, T);

% Entropie de formation et de reaction standard (298.15K), en
% joules/mole*Kelvin (298.15K)
SstdCO = 197.67;
SstdH2 = 130.68;
SstdCO2 = 213.74;
SstdH2O = 188.83;
Srstd = (SstdH2 + SstdCO2) - (SstdCO + SstdH2O);

DeltaCpByt = @(t) (CpH2(t) + CpCO2(t))./t - (CpCO(t) + CpH2O(t))./t;
DeltaS2 = Srstd + integral(DeltaCpByt, 298.15, T);
DeltaG2 = DeltaH2 - T*DeltaS2;
K2 = exp(-DeltaG2/(R*T));

Output = [DeltaH2, K2];
end
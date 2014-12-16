function [A] = SizePSV(SetPressure, T, Hvap, F)
% SizePSV - Fonction de dimensionnement d'une soupape
% de securite.
% INPUT :
% - SetPressure : pression de tarage, en Bar ;
% - T : temperature durant la decharge, en Kelvin ;
% - Hvap : enthalpie de vaporisation correspondant a T,
% en kilojoules/kg.
% - F : un coefficient dependant de l'isolation thermique.
% OUTPUT :
% - Taille de l'orifice en mm squared.

Q = 43200*F*(143.6)^(0.82); % W
P1 = (1.21*SetPressure*10^2); % kPa

W = (3600*Q)/(Hvap*1000); % kg/h

% Physical/chemical constants
C = 0.02655536953;
Kd = 0.975;
Kb = 1;
Kc = 1;
Z = 1;
M = 17;

A = W/(C*Kd*P1*Kb*Kc)*sqrt((T*Z)/M);
end


function [K1] = ComputeK1(T)
% Cette fonction calcule la constante d'équilibre K1
% de la première réaction du reformage primaire en fonction de la température :
% CH4(g) + H2O(g) <-> CO(g) + 3H2(g)

R = 8.3144621; 
syms t;
% Capacité calorifique à pression constante en fonction de la température,
% en joules/mole*Kelvin
CpCO = @(t) 27.62 + (5.02e-3)*t;
CpH2 = @(t) 29.30 + (0.84e-3)*t + (2.09e-6)*t.^2;
CpCH4 =@(t) 14.23 + (75.3e-3)*t - (18e-6)*t.^2;
CpH2O = @(t) 30.13 + (10.46e-3)*t;
DeltaCp = @(t) (3*CpH2(t) + CpCO(t)) - (CpCH4(t) + CpH2O(t));

% Enthalpies de formation et de réaction standard (298.15K), en joules par moles.
HfstdCO = -110.53e3;
HfstdH2 = 0;
HfstdCH4 = -74.81e3;
HfstdH2O = -241.82e3;
Hrstd = (3*HfstdH2 + HfstdCO) - (HfstdCH4 + HfstdH2O);

DeltaH1 = Hrstd + integral(DeltaCp, 298.15, T);

% Entropie de formation et de réaction standard (298.15K), en
% joules/mole*Kelvin (298.15K)
SstdCO = 197.67;
SstdH2 = 130.68;
SstdCH4 = 186.26;
SstdH2O = 188.83;
Srstd = (3*SstdH2 + SstdCO) - (SstdCH4 + SstdH2O);

DeltaCpByt = @(t) (3*CpH2(t) + CpCO(t))./t - (CpCH4(t) + CpH2O(t))./t;
DeltaS1 = Srstd + integral(DeltaCpByt, 298.15, T);
DeltaG1 = DeltaH1 - T*DeltaS1;
K1 = exp(-DeltaG1/(R*T));
end


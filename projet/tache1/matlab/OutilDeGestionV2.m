function [Output] = OutilDeGestionV2(a, T)
% OutilDeGestionV2 - Calcul les débits de matières à chaque étape du
% processus de fabrication de l'ammoniac.
%
% Cette fonction MATLAB retourne, sous forme de tableau, tous les débits de
% matière (en moles/s), à chaque étape, nécessaire à la fabrication de a tonnes/jour
% d'ammoniac à une température de T kelvin. Elle retourne également le
% nombre de tubes nécessaires aux passage du mélange H2O et CH4 à l'entrée
% du reformage prilmaire. Cette fonction utilise deux fonctions auxiliaire, 
% ComputeK1 et ComputeK2. 
%
%   OutilDeGestionV2(a, T)
%
% Dernière version : 16-11-2014
% Auteur : le groupe 1243

% On limite la precision a 4 decimales.
format short;

% Donnees thermodynamiques
K1 = ComputeK1(T); 
K2 = ComputeK2(T);
ptot = 28e5;
p0 = 1e5;

% Equation d'equilibre du reformage primaire
syms x y n01 n02 real positive;
eqn1 = K1 == ((x-y)*((3*x + y)^3)*ptot^2)/((n01-x)*(n02-x-y)*(n01+n02+(2*x))^2*p0^2);
eqn2 = K2 == (y*(3*x + y))/((x-y)*(n02-x-y));
eqn3 = n01 - x == (0.42*a*10^6)/(26.52*86400);
eqn4 = 4*x + 3*(0.42*a*10^6)/(26.52*86400) == (3*a*10^6)/(34*86400);
eqns = [eqn1 eqn2 eqn3 eqn4];
[x, y, n01, n02] = solve(eqns, x, y, n01, n02); 

% Reformer primaire
CH4_in1 = double(n01);
H2O_in1 = double(n02);

% Nombre de tubes
R = 8.3144621;
Tubes = ceil(((CH4_in1 + H2O_in1)*R*T)/(2*31e5*7.854e-3));

% Four
CH4_in2 = 0;
O2_in1 = 0;

% Reformer secondaire
CH4_in3 = (0.42*a*10^6)/(26.52*86400);
H2O_in2 = double(n02-x-y);
CO_in1 = double(x-y);
CO2_in1 = double(y);
H2_in1 = double(3*x + y);
O2_in2 = (0.21*a*10^6)/(26.52*86400);
N2_in1 = 0.5*(a*10^6)/(17*86400);
Ar_in1 = (0.01*a*10^6)/(26.52*86400);

% Water-Gas-Shift
CO_in2 = (0.42*a*10^6)/(26.52*86400) + CO_in1;
CO2_in2 = double(y);
N2_in2 = 0.5 *(a*10^6)/(17*86400);
H2_in2 = H2_in1 + 0.84*(a*10^6)/(26.52*86400);
Ar_in2 = (0.01*a*10^6)/(26.52*86400);
H2O_in3 = H2O_in2;

% Separation
CO2_in_out = double(n01);
N2_in3 = 0.5 *(a*10^6)/(17*86400);
H2_in3 = 1.5 * (a*10^6)/(17*86400);
Ar_in3 = (0.01*a*10^6)/(26.52*86400);
H2O_in_out = H2O_in2 - CO_in2;

% Synthese d'ammoniac
N2_in4 = 0.5 *(a*10^6)/(17*86400);
H2_in4 = 1.5 * (a*10^6)/(17*86400);
Ar_in4 = (0.01*a*10^6)/(26.52*86400);
NH3_out =  (a*10^6)/(17*86400);

% Un peu de mise en forme...
Elements = {'-- TUBES'; '-- REFORMER PRIMAIRE'; 'CH4 (in)1'; 'H2O (in)1'; '-- FOUR'; 'CH4 (in)2'; 'O2 (in)1'; 
    '-- REFORMER SECONDAIRE'; 'CH4 (in)3'; 'H2O (in)2'; 'CO (in)1'; 'CO2 (in)1'; 'H2 (in)1';
    'O2 (in)2'; 'N2 (in)1'; 'Ar (in)1'; '-- WATER-GAS-SHIFT'; 'CO (in)2'; 'CO2 (in)2'; 'N2 (in)2'
    ; 'H2 (in)2'; 'Ar (in)2'; 'H2O (in)3'; '-- SEPARATION'; 'CO2 (in) = CO2 (out)'; 'N2 (in)3';
    'H2 (in)3'; 'Ar (in)3'; 'H2O (in) = H2O (out)'; '-- AMMONIA SYNTHESIS'; 'N2 (in)4'; 
    'H2 (in)4'; 'Ar (in) = Ar (out)'; 'NH3 (out)'};
MolesBySecond = {Tubes;'----------'; CH4_in1; H2O_in1; '----------'; CH4_in2; O2_in1; 
    '----------'; CH4_in3; H2O_in2; CO_in1; CO2_in1; H2_in1;
    O2_in2; N2_in1; Ar_in1; '----------'; CO_in2; CO2_in2; N2_in2
    ; H2_in2; Ar_in2; H2O_in3; '----------'; CO2_in_out; N2_in3;
    H2_in3; Ar_in3; H2O_in_out; '----------'; N2_in4; 
    H2_in4; Ar_in4; NH3_out};

Output = table(MolesBySecond, 'RowNames', Elements);
end


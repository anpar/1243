function [Output] = OutilDeGestionV2(a, T)
% OutilDeGestionV2 - Calcul les debits de matieres a chaque etape du
% processus de fabrication de l'ammoniac.
%
% Cette fonction MATLAB retourne, sous forme de tableau, tous les debits de
% matiere (en moles/s), a chaque etape, necessaire a la fabrication de a tonnes/jour
% d'ammoniac a une temperature de T kelvin. Elle retourne egalement le
% nombre de tubes necessaires aux passage du melange H2O et CH4 a l'entree
% du reformage prilmaire. Cette fonction utilise deux fonctions auxiliaire, 
% ComputeK1 et ComputeK2. Le troisieme argument print permet de choisir ce
% que retourne la fonction. Si print = true, la reponse retournee sera
% affichee sous forme de tablau. Si print = false, la reponse retournee
% sera un simple vecteur sans mise en forme. Ce dernier argument permet de
% manipuler plus facilement les donnees, pour l'etude parametrique par
% exemple.
%
%   OutilDeGestionV2(a, T, print)
%
% Derniere version : 19-11-2014
% Auteur : le groupe 1243

% On limite la precision a 4 decimales.
format short;

% Donnees thermodynamiques
Output1 = ComputeK1(T);
Output2 = ComputeK2(T);
DeltaH1 = Output1(1);
DeltaH2 = Output2(1);
K1 = Output1(2); 
K2 = Output2(2);
% Pression pour le calcul de l'equilibre selon le fichier Resultats_bilan
% sur iCampus
ptot = 26e5; 
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

% Reformer secondaire
CH4_in3 = (0.42*a*10^6)/(26.52*86400);
H2O_in2 = double(n02-x-y);
CO_in1 = double(x-y);
CO2_in1 = double(y);
H2_in1 = double(3*x + y);
O2_in2 = (0.21*a*10^6)/(26.52*86400);
N2_in1 = 0.5*(a*10^6)/(17*86400);
Ar_in1 = (0.01*a*10^6)/(26.52*86400);

syms nfour;
eqn5 = (CH4_in1-CH4_in3)*DeltaH1 + (CO2_in1)*DeltaH2 == nfour*805990*0.75;
nfour = solve(eqn5, nfour);

% Four
CH4_in2 = double(nfour);
O2_in1 = 2*double(nfour);

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
NH3_out = (a*10^6)/(17*86400);

Output = O2_in1;
end
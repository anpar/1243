function [x, y, H2O, CH4] = OutilDeGestion(T, NH3)
% Groupe 124.3 - 13/10/014 
% Retourne les masses/jour de matières premières :
% - Air : N2, O2, Ar, CO ;
% - CH4, H20
% Input : T en Kelvin et NH3 en t/d.
% Output : matières premières.

MNH3 = 17;
NH3 = (NH3*1000*1000)/MNH3;

R = 8.3144621;
% G1 et G2 à changer, mauvaises Cp utilisée lors du calcul
G1 = (-2.14e14)-(T*(71.16*log(T)))+(T*(1.08e12))+(41630*(T^2))-(4045000*(T^3));
K1 = exp(-G1/(R*T));
G2 = (1.1e13)-(T*(5.6e10))-(2930*(T^2))+(210000*(T^3));
K2 = exp(-G2/(R*T));
ptot = 28e5;
p0 = 10e5;

syms x y H2O CH4 positive;
eqn1 = K1 == ((x-y)*((3*x + y)^3)*ptot^2)/((H2O-x)*(H2O-x-y)*(H2O+CH4+(2*x))*p0^2);
pretty(eqn1)
eqn2 = K2 == (y*(3*x + y))/((x-y)*(H2O-x-y));
pretty(eqn2)
eqn3 = CH4 - x == 7/442 * NH3;
pretty(eqn3)
eqn4 = 3*x + y == (9/221 * NH3) -x+y;
pretty(eqn4)
eqns = [eqn1 eqn2 eqn3 eqn4];

[x, y, H2O, CH4] = solve(eqns);
end
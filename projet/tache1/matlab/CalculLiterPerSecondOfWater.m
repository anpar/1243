function [] = CalculLiterPerSecondOfWater()
% Fonction pour projet 3 qui calcule le nombre de litre d'eau par seconde nécessaire
% à maintenir la température à une certaine valeur.
  syms T;
  % Cp from edu.upmc.fr
  H = -46e03 + int(31.81+(15.48e-03)*T+(5.86e-06)*T^2, T, 298.15, 773.15) - 0.5*int(27.62+(4.19e-03)*T, T, 298.15, 773.15) - 1.5*int(29.30-(0.84e-03)*T+(2.09e-06)*T^2, T, 298.15, 773.15);
  q = 58.83e06 * H;
  flow = q/(65*4185.5);
  finalFlow = -flow/(24*60*60)
end

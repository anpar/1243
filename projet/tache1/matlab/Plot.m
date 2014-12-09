function [X] = Plot(T1, T2, a)
% Permet de tracer un graphe a deux dimensions (T et a)

T = linspace(T1,T2,20);
X = zeros(20,1);
for j=1:20
   X(j) = OutilDeGestionBis(a, T(j));
end
figure;
plot(T,X); grid;
title('O2 entrant dans le four en fonction de la température [K].');
xlabel('Température [K]');
ylabel('Débit molaire [mol/s]');
end


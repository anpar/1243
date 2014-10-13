function [CH4entree, H2Oentree] = BilanMatieres( Mf, Tr ) %Masse Finale, Temperature Reformage(Primaire)
%Copyright Group 1243(©) (under Creative Commons)
%Sponsored by Coca-Cola(©) and Bandai Co. Ltd
%I would like to thank my mother for supporting me through all these years.
%I love you, mom.


syms CH4e H2Oe CO2s H2s COs H2Os;%e pour "entrée", s pour ceux qui sont à la sortie du premier réacteur après les 2 premieres reactions (en equilibre) là, + j'ai mis un surplus de variables pour faciliter la partie "liste de beauocup de trucs qu'on a déjà"
R = 8.314;
a = Mf/17; %Nombre de mole de NH3 final


%%%LISTE DE BEAUCOUP DE TRUCS QU'ON A DEJA%%%
%NOTE : 26.52 = 0.78 * 34
%Parce que nombre de moles d'air = a/26.52 = a/(34*0.78)
%Note : masse d'air = 1.0919752*a [g] je sais pas si ça sera utile
N2 = a/34;
Ar = (0.01*a)/26.52;
CH4SortieReac1 = (0.42*a)/26.52;
CO2degagefinal = CO2s + COs + (0.42*a)/26.52;
H2Odegagefinal = H2Os - (0.42*a)/26.52 - COs;

EQUATION1 = ((3*a)/34) == ((1.26*a)/26.52) + COs + H2s; %lie le H2 et le CO qui sortent du reacteur 1 (j'appelle "reacteur 1" les 2 premieres reactions chimiques)
% Reste des equations en bas










%First Equation CH4 + H2O <-> CO + 3H2 (1)
DeltaG1 = DeltaGEq1( Tr );
K1 = exp(-(DeltaG1)/(R*Tr));
Delta1 = DeltaEq1( CH4e, H2Oe, K1); %Delta genre "Delta de l'équation du second degré". Le 
[X1plus, X1minus] = Xfind1(K1, Delta1, H2Oe, CH4e);%Pour avoir LE x, voir plus bas
EQUATION2 = ((0.42*a)/26.52) == CH4e - X1plus;
%GROS BUG
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%Du coup je devrais avoir 2 equations avec le X1plus et le X1moins...
%Je ne sais pas quoi faire.


end

function [ G ] = DeltaGEq1( T )
%T la température
%G le DeltaG de sortie
DeltaS29815 = 214.62;
G = (-2.14*(10^14)) - (T*(DeltaS29815)) - (T*71.16*log(T)) + (1.08*(10^12)*T) + (41630*(T^2)) - (4045000*(T^3));
end

function [ G ] = DeltaGEq2( T )
%T la température
%G le DeltaG de sortie
G = (1.1*10^13) - (T*5.6*10^10) - (2930*(T^2)) + (210000*(T^3))
end


%TOUT CE QUI VIENT CI-APRèS EST PROBABLEMENT USELESS VU QUE VOUS AVEZ
%CHANGé LES CALCULS


function [ D ] = DeltaEq1( C, H, K )
%C = CH4 en entree
%H = H2O en entree
%K = K de la premiere reaction (constante d'eq)
D = (K^2)*((H + C)^2) - (4*(K-3)*H*C);
end

function [ Xplus, Xminus ] = Xfind1(K, D, H, C)
%K = K1
%D = Delta1 /!\ =/= DeltaG1
%H = H2O entree
%C = CH4 entree
%Trouve X. Qui est X? Lui :
%CH4sortie = CH4entree - x
%H2Osortie = H2Oentree - x
%COsortie = x
%H2sortie = 3x
% tout ceci seulement pour l'EQUATION 1!
%H2O, CO et H2 changent encore avec l'equation 2


%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%Guillaume et Simon ne sont PAS SUR si on doit faire "+" ou "-" dans le "+-
%racine de delta". J'ai donc créé 2 lignes : une avec +, l'autre avec -. On
%vera ce qu'il faut.
Xplus = (K*(C + H)+sqrt(D))/(2*(K-3)); % avec +
Xminus = (K*(C + H)-sqrt(D))/(2*(K-3)); %avec -
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
end

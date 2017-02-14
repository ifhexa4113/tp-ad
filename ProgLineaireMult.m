function [ ] = ProgLineaireMult(Gains, Functions, Solutions, A, b, lb, options)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
DistancesVector = CalculerDistanceNormalisee(Gains);
DistancesVector
display('La solution qui minimise l utilisation des machines 1 et 3 est la proche de l optimum');

Max = [10159 389 2016 389 8000]; % /!\ 8000 douteux
CritereDistance = zeros(1,5);
for i=1:1:5
    CritereDistance(1,i) = 1 - (Gains(5,i) / Max(i));
end
CritereDistance

[A_pers, b_pers, f_responsablepersonnel] = responsablepersonnel(A, b, 330);
A_pers = [A_pers
         -Functions(1,:)];
b_pers = [b_pers -9000]
NouvelleRepartition = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb,[],[],options);
NouvellesSolutions = [Solutions NouvelleRepartition];
NouveauxGains = (Functions*NouvellesSolutions).'
NouvellesDistancesVector = CalculerDistanceNormalisee(NouveauxGains);
NouvellesDistancesVector

end



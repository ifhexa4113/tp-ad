function [ ] = ProgLineaireMult(Gains, Functions, Solutions, A, b, lb, options)

Optimum = diag(Gains);

DistancesVector = CalculerDistanceNormalisee(Gains);
DistancesVector
display('La solution qui minimise l utilisation des machines 1 et 3 est la plus proche de l optimum');

Max = [10159 389 2016 389 7500];
CritereDistance = zeros(1,5);
for i=1:1:5
    CritereDistance(1,i) = abs(Optimum(i) - Gains(5,i)) / Max(i);
end
CritereDistance

% On observe que le critère le moins respecté est la maximisation du
% bénéfice.

[A_pers, b_pers, f_responsablepersonnel] = responsablepersonnel(A, b, 7960, Functions(1,:));

X = zeros(10159-8017+1);
Y = zeros(10159-8017+1);
i = 1;
for eps=8017:1:10159
    A_temp = [A_pers
             -Functions(1,:)];
    b_temp = [b_pers -eps];
    
    NouvelleRepartition = linprog(f_responsablepersonnel,A_temp,b_temp,[],[],lb,[],[],options);
    NouveauxGains = (Functions*NouvelleRepartition);
    ecart = DistEuclVec(Optimum, NouveauxGains, Max);
    
    X(i) = eps;
    Y(i) = ecart;
    i = i+1;
end
[minimum, index] = min(Y);
display('min');
eps = X(index(1))
plot(X, Y)

A_pers = [A_pers
         -Functions(1,:)]
b_pers = [b_pers -eps]

[NouvelleRepartition,fval,exitflag] = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb,[],[],options);
NouveauxGains = (Functions*NouvelleRepartition)


CritereDistance = zeros(1,5);
for i=1:1:5
    CritereDistance(1,i) = abs(Optimum(i) - NouveauxGains(i)) / Max(i);
end
CritereDistance


%% MAXIMUM PRODUIT

% X = zeros(389-330+1);
% Y = zeros(389-330+1);
% i = 1;
% for eps=330:1:389
%     A_temp = [A_pers
%              -Functions(2,:)];
%     b_temp = [b_pers -eps];
%     
%     NouvelleRepartition = linprog(f_responsablepersonnel,A_temp,b_temp,[],[],lb,[],[],options);
%     NouveauxGains = (Functions*NouvelleRepartition);
%     ecart = DistEuclVec(Optimum, NouveauxGains, Max);
%     
%     X(i) = eps;
%     Y(i) = ecart;
%     i = i+1;
% end
% [minimum, index] = min(Y);
% display('min');
% eps = X(index(1))
% plot(X, Y)
% 
% NouvelleRepartition = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb,[],[],options);
% NouveauxGains = (Functions*NouvelleRepartition)
% 
% CritereDistance = zeros(1,5);
% for i=1:1:5
%     CritereDistance(1,i) = abs(Optimum(i) - NouveauxGains(i)) / Max(i);
% end
% CritereDistance

%% STOCK

% X = zeros(1667-1375+1);
% Y = zeros(1667-1375+1);
% i = 1;
% for eps=1375:1:1667
%     A_temp = [A_pers
%              Functions(3,:)];
%     b_temp = [b_pers eps];
%     
%     [NouvelleRepartition, fval, exitflags] = linprog(f_responsablepersonnel,A_temp,b_temp,[],[],lb,[],[],options);
%     NouveauxGains = (Functions*NouvelleRepartition);
%     ecart = DistEuclVec(Optimum, NouveauxGains, Max);
% 
%     X(i) = eps;
%     Y(i) = 1;
%     if exitflags >= 0
%         Y(i) = ecart;
%     end
%     i = i+1;
% end
% [minimum, index] = min(Y);
% display('min');
% eps = X(index(1))
% plot(X, Y)
% 
% A_pers = [A_pers
%          Functions(3,:)]
% b_pers = [b_pers eps]
% 
% NouvelleRepartition = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb,[],[],options);
% NouveauxGains = (Functions*NouvelleRepartition)
% 
% CritereDistance = zeros(1,5);
% for i=1:1:5
%     CritereDistance(1,i) = abs(Optimum(i) - NouveauxGains(i)) / Max(i);
% end
% CritereDistance


%% Commercial

% X = zeros(376-330+1);
% Y = zeros(376-330+1);
% i = 1;
% for eps=330:1:376
%     A_temp = [A_pers
%              -Functions(4,:)];
%     b_temp = [b_pers -eps];
%     
%     NouvelleRepartition = linprog(f_responsablepersonnel,A_temp,b_temp,[],[],lb,[],[],options);
%     NouveauxGains = (Functions*NouvelleRepartition);
%     ecart = DistEuclVec(Optimum, NouveauxGains, Max);
%     
%     X(i) = eps;
%     Y(i) = ecart;
%     i = i+1;
% end
% [minimum, index] = min(Y);
% display('min');
% eps = X(index(1))
% plot(X, Y)
% 
% A_pers = [A_pers
%          -Functions(4,:)]
% b_pers = [b_pers -eps]
% 
% NouvelleRepartition = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb,[],[],options);
% NouveauxGains = (Functions*NouvelleRepartition)
% 
% CritereDistance = zeros(1,5);
% for i=1:1:5
%     CritereDistance(1,i) = abs(Optimum(i) - NouveauxGains(i)) / Max(i);
% end
% CritereDistance

%NouvelleRepartition = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb,[],[],options);
%NouvellesSolutions = [Solutions NouvelleRepartition];
%NouveauxGains = (Functions*NouvellesSolutions).'
%NouvellesDistancesVector = CalculerDistanceNormalisee(NouveauxGains);
%NouvellesDistancesVector

display('Solution actuelle');
A_pers
b_pers
NouvelleRepartition
NouveauxGains
CritereDistance
SolutionDinstance = sqrt(CritereDistance(1)^2 + CritereDistance(2)^2 + CritereDistance(3)^2 + CritereDistance(4)^2 + CritereDistance(5)^2)
exitflag


display('Test amélioration du bénéfice');
b_pers(12) = -8700;
          
[NouvelleRepartition,fval,exitflag] = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb,[],[],options);
NouveauxGains = (Functions*NouvelleRepartition);
for i=1:1:5
    CritereDistance(1,i) = abs(Optimum(i) - NouveauxGains(i)) / Max(i);
end


A_pers
b_pers
NouvelleRepartition
NouveauxGains
CritereDistance
SolutionDinstance = sqrt(CritereDistance(1)^2 + CritereDistance(2)^2 + CritereDistance(3)^2 + CritereDistance(4)^2 + CritereDistance(5)^2)
exitflag

end



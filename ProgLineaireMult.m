function [ ] = ProgLineaireMult(Gains, Functions, Solutions, A, b, lb, options)

Optimum = diag(Gains);

DistancesVector = CalculerDistanceNormalisee(Gains);
DistancesVector
display('La solution qui équilibre la production entre les deux familles est la plus proche de l optimum');

Max = [10159 389 2016 389 7500];
CritereDistance = zeros(1,5);
for i=1:1:5
    CritereDistance(1,i) = abs(Optimum(i) - Gains(4,i)) / Max(i);
end
CritereDistance

display('On observe que le critère le moins respecté est la minimisation du stock');


% STOCK

[A_pers, b_pers] = responsablecommercial(A, b, 40);

X = zeros(1655);
Y = zeros(1655);
i = 1;
for eps=1:1:1655
    A_temp = [A_pers
             Functions(3,:)];
    b_temp = [b_pers eps];
    
    [NouvelleRepartition, fval, exitflags] = linprog(-Functions(1,:),A_temp,b_temp,[],[],lb,[],[],options);
    NouveauxGains = (Functions*NouvelleRepartition);
    ecart = DistEuclVec(Optimum, NouveauxGains, Max);

    X(i) = eps;
    Y(i) = 0;
    if exitflags >= 0
        Y(i) = ecart;
    end
    i = i+1;
end
display('Imposer un stock minimum de 1600 permet de ne pas trop dégrader les autres critères');

plot(X, Y)
xlabel('Niveau de stock')
ylabel('Ecart en distance euclidienne par rapport à l optimum')
figure;

A_pers = [A_pers
         Functions(3,:)];
b_pers = [b_pers 1550];

NouvelleRepartition = linprog(-Functions(1,:),A_pers,b_pers,[],[],lb,[],[],options);
NouveauxGains = (Functions*NouvelleRepartition)

CritereDistance = zeros(1,5);
for i=1:1:5
    CritereDistance(1,i) = abs(Optimum(i) - NouveauxGains(i)) / Max(i);
end
CritereDistance

SolutionDinstance = sqrt(CritereDistance(1)^2 + CritereDistance(2)^2 + CritereDistance(3)^2 + CritereDistance(4)^2 + CritereDistance(5)^2)



% BENEFICE

b_pers(11) = 60;
b_pers(12) = 60;

X = zeros(10159-7997+1);
Y = zeros(10159-7997+1);
i = 1;
for eps=7997:1:10159
    A_temp = [A_pers
             -Functions(1,:)];
    b_temp = [b_pers -eps];
    
    [NouvelleRepartition,fval,exitflag] = linprog(-Functions(1,:),A_temp,b_temp,[],[],lb,[],[],options);
    NouveauxGains = (Functions*NouvelleRepartition);
    ecart = DistEuclVec(Optimum, NouveauxGains, Max);
    
    X(i) = eps;
    if exitflag >= 0
        Y(i) = ecart;
    end
    i = i+1;
end
[minimum, index] = min(Y);
display('min');
eps = X(index(1)) - 1; 
plot(X, Y)
xlabel('Bénéfice')
ylabel('Ecart en distance euclidienne par rapport à l optimum')
figure;

A_pers = [A_pers
         -Functions(1,:)];
b_pers = [b_pers -eps];

[NouvelleRepartition,fval,exitflag] = linprog(-Functions(1,:),A_pers,b_pers,[],[],lb,[],[],options);
NouveauxGains = (Functions*NouvelleRepartition)


CritereDistance = zeros(1,5);
for i=1:1:5
    CritereDistance(1,i) = abs(Optimum(i) - NouveauxGains(i)) / Max(i);
end
CritereDistance

SolutionDinstance = sqrt(CritereDistance(1)^2 + CritereDistance(2)^2 + CritereDistance(3)^2 + CritereDistance(4)^2 + CritereDistance(5)^2)


% MAXIMUM PRODUIT

X = zeros(389-309+1);
Y = zeros(389-309+1);
i = 1;
for eps=309:1:389
    A_temp = [A_pers
             -Functions(2,:)];
    b_temp = [b_pers -eps];
    
    [NouvelleRepartition,fval,exitflag] = linprog(-Functions(1,:),A_temp,b_temp,[],[],lb,[],[],options);
    NouveauxGains = (Functions*NouvelleRepartition);
    ecart = DistEuclVec(Optimum, NouveauxGains, Max);
    
    X(i) = eps;
    if exitflag >= 0
        Y(i) = ecart;
    end
    i = i+1;
end
plot(X, Y)
xlabel('Nombre de produit fabriqué')
ylabel('Ecart en distance euclidienne par rapport à l optimum')
figure;

end



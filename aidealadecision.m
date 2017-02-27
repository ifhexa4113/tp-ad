function [] = aidealadecision()
    
    TempsUnitaireUsinage = [18 17  8  2 15  5 13;
                             5  2  1 10  0  5  3;
                             0 12 11  5  8  3  5;
                             5 15  0  4  7 12  8;
                             0  7 10 13 10  8 10;
                            10 12 25  7 15  6  7];

    QuantiteMPProduit    = [1 2 1 2 0 4;
                            2 1 1 5 2 1;
                            1 1 3 2 2 0];

    QuantiteMaxMP        = [350 820 485];
    
    PrixVente            = [20 27 26 30 45 40];
    
    PrixAchatMP          = [2 4 1];
    
    CoutHoraire          = [1 3 1 4 2 3 1];
    
    options = optimset('Display','none');
    
    [A, b, lb] = contraintes();
    
    Solutions = zeros(6, 5);
    Gains = zeros(5, 5);
    Functions = zeros(5, 6);
    
    % Comptable
    display('Comptable');
    f_comptable = comptable(PrixVente, QuantiteMPProduit, TempsUnitaireUsinage, CoutHoraire, PrixAchatMP)
    
    %%% EXEMPLE: remplir ça avec votre fonction: un vecteur de dimension 6,
    %%% chaque dimension représentant un produit
    Functions(1, :) = f_comptable;
    
    display('Répartitions des produits');
    ans_comptable = linprog(-f_comptable,A,b,[],[],lb,[],[],options);
    ans_comptable
    
    %%% EXEMPLE: remplir ca avec votre solution: un point dans un espace à 
    %%% 6 dimensions, chaque dimension représentant un produit
    Solutions(:, 1) = ans_comptable;
    
    display('Bénéfice maximum')
    ans_max = f_comptable*ans_comptable
        
    % Responsable Atelier
    display('Responsable Atelier');
    f_responsableatelier = responsableatelier();
    Functions(2, :) = f_responsableatelier;
    
    display('Répartitions des produits');
    ans_responsableatelier = linprog(-f_responsableatelier,A,b,[],[],lb,[],[],options);
    ans_responsableatelier
    
    Solutions(:, 2) = ans_responsableatelier;
    
    display('Nombre maximum de produits possibles');
    f_responsableatelier*ans_responsableatelier
    
    % Responsable Stocks
    display('Responsable Stocks');
    f_responsablestocks = responsablestocks();
    Functions(3, :) = f_responsablestocks;
    
    display('Répartition pour le nombre maximum de produits');
    ans_responsablestocks = linprog(-f_responsablestocks,A,b,[],[],lb,[],[],options); % Maximiser
    ans_responsablestocks
    
    display('Nombre maximum de produits possibles')
    f_responsablestocks*ans_responsablestocks
    
    display('Nombre minimum de produits possibles selon la quantité produite')
    ans_responsablestocksmin = zeros(ceil(ans_max/100));
    for i=1:ceil(ans_max/100)
        %Aeq = [1 1 1 1 1 1];
        %beq = [i];
        
        Abis = [A
                -f_comptable];
        bbis = [b -i*100];  % PS: même résultat avec Aeq & Beq
        
        [answer, ~, exitflag] = linprog(f_responsablestocks,Abis,bbis,[],[],lb,[],[],options); % Minimiser
        
        if exitflag == 1
            ans_responsablestocksmin(i) = f_responsablestocks*answer;
        end
        
        if i == 80
            ans_stock = answer;
        end
    end
    plot(ans_responsablestocksmin);
    figure;
    display('Quantité de produits');
    [1 1 1 1 1 1]*ans_stock
    Solutions(:, 3) = ans_stock;
    
    % Responsable Commercial
    display('Responsable Commercial');
    f_responsablecommercial = f_comptable;
    
    Functions(4, :) = [ 1 1 1 -1 -1 -1];
    
    vector_responsablecommercial = zeros(389,1);
    for eps=1:1:389
        [A_com, b_com] = responsablecommercial(A, b, eps);
        ans_responsablecommercial = linprog(-f_responsablecommercial,A_com,b_com,[],[],lb,[],[],options);
        vector_responsablecommercial(eps, 1) = f_responsablecommercial*ans_responsablecommercial;
    
        if eps == 1
           Solutions(:, 4) = ans_responsablecommercial;
        end
    end
    
    plot(vector_responsablecommercial);
    xlabel('Ecart maximum des quantités faites par famille de produits')
    ylabel('Bénéfice')
    figure;
    
    % Responsable Personnel
    display('Responsable Personnel');
    pas = 10;
    ANS = zeros(10160,3);
    ben_found=0;
    for ben_min=1:1:10160      
        [A_pers, b_pers, f_responsablepersonnel] = responsablepersonnel(A, b, ben_min, f_comptable);
    
        ans_responsablepersonnel = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb,[],[],options);
        
        ANS(ben_min,1) = 18 * ans_responsablepersonnel(1) + 5 * ans_responsablepersonnel(2) + 5 * ans_responsablepersonnel(4) + 10 * ans_responsablepersonnel(6);
        
        if ANS(ben_min,1) >= 10 && ben_found == 0
           % Point ou la machine 1 commence à être utilisée.
           ben_found = 1;
           Functions(5, :) = f_responsablepersonnel;
           Solutions(:, 5) = ans_responsablepersonnel;
        end
        
        ANS(ben_min,2) = 8 * ans_responsablepersonnel(1) + 1 * ans_responsablepersonnel(2) + 11 * ans_responsablepersonnel(3) + 10 * ans_responsablepersonnel(5) + 25 * ans_responsablepersonnel(6);
        ANS(ben_min,3) = ANS(ben_min,1) + ANS(ben_min,2);
    end
    plot(ANS);
    xlabel('Bénéfice minimum imposé')
    ylabel('Utilisation des machines en minutes par semaines')
    legend('Machine 1', 'Machine 3', 'Machines 1 et 3')
    figure;
    
    %%% PARTIE 2 PROGRAMMATION LINEAIRE MULTICRITERE
    display('Matrice de gains');
    Functions
    Solutions
    Gains = (Functions * Solutions).';
    Gains = abs(Gains)
    
    ProgLineaireMult(Gains, Functions, Solutions, A, b, lb, options)
end


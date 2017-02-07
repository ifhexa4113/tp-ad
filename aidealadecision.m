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
    
    [A, b, lb] = contraintes();
    
    % Responsable Atelier
    display('Responsable Atelier');
    f_responsableatelier = responsableatelier();
    
    display('R�partitions des produits');
    ans_responsableatelier = linprog(-f_responsableatelier,A,b,[],[],lb)
    
    display('Nombre maximum de produits possibles');
    ans_max = f_responsableatelier*ans_responsableatelier
    
    % Responsable Stocks
    display('Responsable Stocks');
    f_responsablestocks = responsablestocks();
    
    display('R�partitions des produits');
    ans_responsablestocks = linprog(-f_responsablestocks,A,b,[],[],lb) % Maximiser
    
    display('Nombre maximum de produits possibles')
    f_responsablestocks*ans_responsablestocks
    
    display('Nombre minimum de produits possibles selon la quantit� produite')
    ans_responsablestocksmin = zeros(ceil(ans_max));
    for i=1:ceil(ans_max)
        Aeq = [1 1 1 1 1 1];
        beq = [i];
        
        Abis = [A
                -1 -1 -1 -1 -1 -1];
        bbis = [b -i];  % PS: m�me r�sultat avec Aeq & Beq
        
        [answer, ~, exitflag] = linprog(f_responsablestocks,Abis,bbis,[],[],lb); % Minimiser
        
        if exitflag == 1
            ans_responsablestocksmin(i) = f_responsablestocks*answer;
        end
    end
    plot(ans_responsablestocksmin);
    
    % Comptable
    display('Comptable');
    f_comptable = comptable(PrixVente, QuantiteMPProduit, TempsUnitaireUsinage, CoutHoraire, PrixAchatMP)
    
    display('R�partitions des produits');
    ans_comptable = linprog(-f_comptable,A,b,[],[],lb)
    
    display('Nombre maximum de produits possibles')
    f_comptable*ans_comptable
    
    % Responsable Commercial
    display('Responsable Commercial');
    f_responsablecommercial = responsableatelier();
    [A_com, b_com] = responsablecommercial(A, b, 5);
    
    display('R�partitions des produits');
    ans_responsablecommercial = linprog(-f_responsablecommercial,A_com,b_com,[],[],lb)
    
    display('Equilibre entre familles de produits');
    f_responsablecommercial*ans_responsablecommercial
    
    % Responsable Personnel
    display('Responsable Personnel');
    ANS = zeros(389,3);
    for nb_min_produits=1:1:389
        [A_pers, b_pers, f_responsablepersonnel] = responsablepersonnel(A, b, nb_min_produits);
    
        ans_responsablepersonnel = linprog(f_responsablepersonnel,A_pers,b_pers,[],[],lb);
        
        ANS(nb_min_produits,1) = 18 * ans_responsablepersonnel(1) + 5 * ans_responsablepersonnel(2) + 5 * ans_responsablepersonnel(4) + 10 * ans_responsablepersonnel(6);
        ANS(nb_min_produits,2) = 8 * ans_responsablepersonnel(1) + 1 * ans_responsablepersonnel(2) + 11 * ans_responsablepersonnel(3) + 10 * ans_responsablepersonnel(5) + 25 * ans_responsablepersonnel(6);
        ANS(nb_min_produits,3) = ANS(nb_min_produits,1) + ANS(nb_min_produits,2); 
    end
    plot(ANS)
    title('Utilisation des machines 1 et 3 en fonction de la production minimum')
    xlabel('Production minimum impos�e en nombre total de produits')
    ylabel('Utilisation des machines en minutes par semaines')
    legend('Machine 1', 'Machine 3', 'Machines 1 et 3')
    
end
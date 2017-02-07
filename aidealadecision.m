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
    
    display('Répartitions des produits');
    ans_responsableatelier = linprog(-f_responsableatelier,A,b,[],[],lb)
    
    display('Nombre maximum de produits possibles');
    f_responsableatelier*ans_responsableatelier
    
    
    % Responsable Stocks
    display('Responsable Stocks');
    f_responsablestocks = responsablestocks();
    
    display('Répartitions des produits');
    ans_responsablestocks = linprog(-f_responsablestocks,A,b,[],[],lb)
    
    display('Nombre maximum de produits possibles')
    f_responsablestocks*ans_responsablestocks
    
    % Comptable
    display('Comptable');
    f_comptable = comptable(PrixVente, QuantiteMPProduit, TempsUnitaireUsinage, CoutHoraire, PrixAchatMP)
    
    display('Répartitions des produits');
    ans_comptable = linprog(-f_comptable,A,b,[],[],lb)
    
    display('Nombre maximum de produits possibles')
    f_comptable*ans_comptable
    
    % Responsable Commercial
    display('Responsable Commercial');
    f_responsablecommercial = responsableatelier();
    [A_com, b_com] = responsablecommercial(A, b, 5);
    
    display('Répartitions des produits');
    ans_responsablecommercial = linprog(-f_responsablecommercial,A_com,b_com,[],[],lb)
    
    display('Equilibre entre familles de produits');
    f_responsablecommercial*ans_responsablecommercial
    
    % Responsable Personnel
    display('Responsable Personnel');
    f_responsablepersonnel = responsableatelier();
    [b_pers] = responsablepersonnel(b, 1500, 1500);
    
    display('Répartitions des produits');
    ans_responsablepersonnel = linprog(-f_responsablepersonnel,A,b_pers,[],[],lb)
    
    display('Limitation usage machine 1 et 3');
    f_responsablepersonnel*ans_responsablepersonnel
    
end
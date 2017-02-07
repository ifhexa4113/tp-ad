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
    
    
end
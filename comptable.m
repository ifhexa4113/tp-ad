function X = comptable(prixVente, QMPPP, TUU , coutHM, prixMP)
%     display('sum(QMPPP, 2)')
%     sum(QMPPP, 2)
%     display('prixMP')
%     prixMP
%     display('sum(TUU/60, 2)')
%     sum(TUU/60, 1)
%     display('coutHM')
%     coutHM
%     display('sum(QMPPP, 2)T .* prixMP')
%     sum(QMPPP, 2).' .* prixMP
    ppppmp = zeros(3, 6);
    for i = 1:size(QMPPP, 2)
        ppppmp(:, i) = QMPPP(:, i) .* prixMP.';
    end
    
    ppppm = zeros(6, 7);
    for i = 1:size(TUU, 1)
        ppppm(i, :) = TUU(i, :)/60 .* coutHM;
    end
    couts = sum(ppppmp, 1)  + sum(ppppm, 2).';
    X = prixVente - couts;
end
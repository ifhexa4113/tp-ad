function X = comptable(prixVente, QMPPP, TUU , coutHM, prixMP, previsions)
    couts = sum(QMPPP .* prixMP, 1) + sum(TUU/60 .* coutHM);
    X = sum((prixVente - couts) .* previsions);
end
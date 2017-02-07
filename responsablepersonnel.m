function [A, b, f] = responsablepersonnel( A, b, nb_min_produits )

A = [A
     -1 -1 -1 -1 -1 -1];
 
b = [b -nb_min_produits];

f = [26 6 11 5 10 35];

end


function [A, b, f] = responsablepersonnel( A, b, ben_min, f_comptable )

A = [A
     -f_comptable];
 
b = [b -ben_min];

f = [26 6 11 5 10 35];

end


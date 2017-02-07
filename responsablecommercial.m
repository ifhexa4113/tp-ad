function [A, b] = responsablecommercial(A, b, eps)

A = [A
      1  1  1 -1 -1 -1
     -1 -1 -1  1  1  1];

b = [b eps eps];

end


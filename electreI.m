function [Incidence] = electreI(Concordance, Discordance, seuilC, seuilD)
   Incidence = zeros(size(Concordance));
   
   for i=1:size(Incidence, 1)
        for j=1:size(Incidence, 1)
            if i ~= j && Concordance(i, j) >= seuilC && Discordance(i, j) <= seuilD
                Incidence(i,j) = 1;
            end
        end
   end
end
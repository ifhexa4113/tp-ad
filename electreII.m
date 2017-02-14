function [Incidence] = electreII(Concordance, Discordance, seuilC1, seuilC2, seuilD)
% C1 > C2
   Incidence = zeros(size(Concordance));
   
   for i=1:size(Incidence, 1)
        for j=1:size(Incidence, 1)
            if i ~= j && Concordance(i, j) >= seuilC1 && Discordance(i, j) <= seuilD
                Incidence(i,j) = 1; % Fleche en dur
            elseif i ~= j && Concordance(i, j) >= seuilC2 && Discordance(i, j) <= seuilD
                Incidence(i,j) = 2; % Fleche en pointilles
            end
        end
   end
end
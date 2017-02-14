function [] = multicritere()
    Jugements = [
        6 5 4 5
        5 2 6 7
        4 3 2 5
        3 7 5 4
        1 7 2 9
        2 5 3 3
        5 4 2 9
        3 5 7 4  
    ];

    J2 = deleteDominated(Jugements)
    
    Concordance = fillConcordance(J2)
    Discordance = fillDiscordance(J2, 10)  
    
    plot(digraph(electreI(Concordance, Discordance, 0.6, 0.3)))
    G = digraph(electreII(Concordance, Discordance, 0.6, 0.3, 0.3));
    plot(G,'Layout','force','EdgeLabel',G.Edges.Weight)
end


function [C] = fillConcordance(Jugements)
    C = zeros(size(Jugements, 1));
    for i=1:size(Jugements, 1)
        for j=1:size(Jugements, 1)
            somme = 0;
            for k=1:size(Jugements, 2)
                if Jugements(i,k) >= Jugements(j,k)
                    somme = somme + 1;
                end
            end
            
            C(i,j) = somme/size(Jugements, 2);
        end
    end
end

function [D] = fillDiscordance(Jugements, echMax)
    D = zeros(size(Jugements, 1));
    for i=1:size(Jugements, 1)
        for j=1:size(Jugements, 1)
            D(i,j) = max(max(Jugements(j,:)-Jugements(i,:)),0)/echMax;
        end
    end
end

% TODO
function [J] = deleteDominated(Jugements)
    Domine = zeros(size(Jugements, 1), 1);

    for i=1:size(Jugements,1)
        for j=1:size(Jugements,1)
            if i~= j && sum(Jugements(j, :) > Jugements(i, :)) == 0
                Domine(j) = Domine(j) + 1;
                break;
            end
        end 
    end
    
    x = 1;
    for j=1:size(Jugements,1)
        if(Domine(j) == 0)
            J(x, :) = Jugements(j, :);
            x = x + 1;
        end
    end
end
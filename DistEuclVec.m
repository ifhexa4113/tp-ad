function [ result ] = DistEuclVec(Vec1, Vec2, Max)

result = 0;
for i=1:1:size(Vec1)
   result =  result + abs( Vec1(i)/Max(i) - Vec2(i)/Max(i) )^2; 
end
result = sqrt(result);

end


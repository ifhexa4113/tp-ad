function [ DistancesVector ] = CalculerDistanceNormalisee( Gains )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Rows = size(Gains,1);
Columns = size(Gains,2);
Max = [10159 389 2016 389 8000]; % /!\ 8000 douteux
DistancesVector = zeros(Rows,1);
% Normalisation
for i=1:1:Rows
    for j=1:1:Columns
       Gains(i,j) = Gains(i,j)/Max(j); 
    end
end
for i=1:1:Rows % line index
    sum = 0;
   for j=1:1:Columns % column index
       sum = sum + (Gains(j,j) - Gains(i,j))^2;
   end
   DistancesVector(i) = sum;
end
end


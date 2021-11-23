function [H] = Hfunction(X, Y, xd, yd)
%Hcalculation is designed for calculating H,which is the Manhattan distance
%between the current node and the destination.
H = (abs(X - xd) + abs(Y - yd))*10;
end


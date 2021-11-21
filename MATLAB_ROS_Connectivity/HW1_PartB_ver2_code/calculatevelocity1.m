   function [output1] = calculatevelocity1(x1)
%The function is used to calculate the velocity1
%Assume the first function,which is a circle with (0,0) center and radius is 1
center_Point1 = [0,0];
radius = 0.9;

syms x
f(x) = center_Point1(1,2)-sqrt(radius^2-x^2);
k(x) = diff(f(x));
output1 = k(x1);

end


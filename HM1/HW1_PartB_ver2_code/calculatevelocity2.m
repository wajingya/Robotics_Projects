function [output2] = calculatevelocity2(x2)
%The function is used to calculate the velocity2
%the part of a specified cos function, which is the range from 0 to $\pi$, 
%and reverse the figure on the x axis, and shift to the -y axis direction 3 .
syms x
f(x) = -3*cos(pi*x)-3;
k(x) = diff(f(x));

output2 = k(x2);
end


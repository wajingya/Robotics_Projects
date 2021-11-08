function [output3] = calculatevelocity3(x3)
%The function is used to calculate the velocity3
%the part of a complete specified sin function, which is the range from 0 to $2*\pi$
syms x
f(x) = 0.8*sin((4/3)*pi*x)-6;
k(x) = diff(f(x));

output3 = k(x3);
end


function [Surrounding] = Surrounding_function(Xc,Yc)
% This function is used to calculate the surrounding eight cells coordinates
% Input: the center cells coordinates
% Output: the surroungding eight cells coordinates

x1 = Xc-1;
y1 = Yc+1;

x2 = Xc;
y2 = Yc+1;

x3 = Xc+1;
y3 = Yc+1;

x4 = Xc+1;
y4 = Yc;

x5 = Xc+1;
y5 = Yc-1;

x6 = Xc;
y6 = Yc-1;

x7 = Xc-1;
y7 = Yc-1;

x8 = Xc-1;
y8 = Yc;

Surrounding= zeros(8,2);

Surrounding(1,1)=x1;
Surrounding(1,2)=y1;

Surrounding(2,1)=x2;
Surrounding(2,2)=y2;

Surrounding(3,1)=x3;
Surrounding(3,2)=y3;

Surrounding(4,1)=x4;
Surrounding(4,2)=y4;

Surrounding(5,1)=x5;
Surrounding(5,2)=y5;

Surrounding(6,1)=x6;
Surrounding(6,2)=y6;

Surrounding(7,1)=x7;
Surrounding(7,2)=y7;

Surrounding(8,1)=x8;
Surrounding(8,2)=y8;
end


function [G] = Gfunction(current_x,current_y,center_x,center_y,G_original)
% The function is used to calculate the G value of each cells
% The input value:current_x and current_y means the cell's coordinate which
%                 you want to calculate now
%                 center_x and center_y means the center cell's coordinate which
%                 the above cell's based on
% The output value:The G value of the cell
%
% Wang Jingya(T02157119)
Xa=current_x;
Ya=current_y;

Xb=center_x;
Yb=center_y;

error_x=abs(Xa-Xb);
error_y=abs(Ya-Yb);


if error_x==1&&error_y==1
    G=14+G_original;
else
    G=10+G_original;
end
end


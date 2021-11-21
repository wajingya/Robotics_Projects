function [outputX,outputY] = Calculate(centerX,centerY,radius)
%Use these function to calculate and then draw the figure
angle = 0:0.01:2*pi;
outputX = centerX + radius*cos(angle);
outputY = centerY + radius*sin(angle);
end


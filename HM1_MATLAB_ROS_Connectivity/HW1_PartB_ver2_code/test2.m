% Homework1
% plot a shape which like letter L;
clear all
clc


 center_Point = [0,0];
 radius = 1;
 
 x1 = 0:0.001:radius;
 y1 = center_Point(1,2)-sqrt(radius^2-x1.^2);
 plot(x1,y1,'b')
 hold on
 
 x2 = 0:0.001:1;
 y2 = -3*cos(pi*x2)-3;

 plot(x2,y2,'r')
 hold on
 x3 = 0:0.001:1.3;
 y3 = 0.8*sin(20/13*pi*x3)-6;
 plot(x3,y3,'g')

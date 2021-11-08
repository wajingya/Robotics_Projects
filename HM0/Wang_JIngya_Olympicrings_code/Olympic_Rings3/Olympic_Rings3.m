clear all
clc

center = Centerfuntion(); %creat a center matrix

condition = 1;
while (condition ==1)
radius = Radiusfunction(); %creat a radius matrix

r1 = radius(1,1);  % seperate r1
r2 = radius(1,2);  % seperate r2
r3 = radius(1,3);  % seperate r3
r4 = radius(1,4);  % seperate r4
r5 = radius(1,5);  % seperate r5


a = r1 + r2;
b = r2 + r3;

c = r2 + r4;
d = r2 + r5;

e = r1 + r4;
f = r3 + r5;

g = r4 + r5;

angle = 0:0.01:2*pi

if a<6 && b<6 && c>5 && d>5 && e>5 && f>5 && g<6
    x1 = center(1,1) + r1*cos(angle);
    y1 = center(1,2) + r1*sin(angle);
    figure (1)
    axis equal
    plot(x1,y1,".b"); % drawing circle1
    
 
    x1 = center(1,1) + r1*cos(angle);
    y1 = center(1,2) + r1*sin(angle);
    figure (2)
    axis equal
    plot(x1,y1,".b"); % drawing circle1
    hold on
    x2 = center(2,1) + r2*cos(angle);
    y2 = center(2,2) + r2*sin(angle);
    plot(x2,y2,".k"); % drawing circle2
   
  
    x1 = center(1,1) + r1*cos(angle);
    y1 = center(1,2) + r1*sin(angle);
    figure (3)
    axis equal
    plot(x1,y1,".b"); % drawing circle1
    hold on
    x2 = center(2,1) + r2*cos(angle);
    y2 = center(2,2) + r2*sin(angle);
    plot(x2,y2,".k"); % drawing circle2
    hold on
    x3 = center(3,1) + r3*cos(angle);
    y3 = center(3,2) + r3*sin(angle);
    plot(x3,y3,".r"); % drawing circle3
   
   
    
    x1 = center(1,1) + r1*cos(angle);
    y1 = center(1,2) + r1*sin(angle);
    figure (4)
    axis equal
    plot(x1,y1,".b"); % drawing circle1
    hold on
    x2 = center(2,1) + r2*cos(angle);
    y2 = center(2,2) + r2*sin(angle);
    plot(x2,y2,".k"); % drawing circle2
    hold on
    x3 = center(3,1) + r3*cos(angle);
    y3 = center(3,2) + r3*sin(angle);
    plot(x3,y3,".r"); % drawing circle3
    hold on
    x4 = center(4,1) + r4*cos(angle);
    y4 = center(4,2) + r4*sin(angle);
    plot(x4,y4,".y"); % drawing circle4
 
    
    
    x1 = center(1,1) + r1*cos(angle);
    y1 = center(1,2) + r1*sin(angle);
    figure (5)
    axis equal
    plot(x1,y1,".b"); % drawing circle1
    hold on
    x2 = center(2,1) + r2*cos(angle);
    y2 = center(2,2) + r2*sin(angle);
    plot(x2,y2,".k"); % drawing circle2
    hold on
    x3 = center(3,1) + r3*cos(angle);
    y3 = center(3,2) + r3*sin(angle);
    plot(x3,y3,".r"); % drawing circle3
    hold on
    x4 = center(4,1) + r4*cos(angle);
    y4 = center(4,2) + r4*sin(angle);
    plot(x4,y4,".y"); % drawing circle4
    hold on
    x5 = center(5,1) + r5*cos(angle);
    y5 = center(5,2) + r5*sin(angle);
    plot(x5,y5,".g"); % drawing circle5   
    break
else 
    continue;
    
end
end
    


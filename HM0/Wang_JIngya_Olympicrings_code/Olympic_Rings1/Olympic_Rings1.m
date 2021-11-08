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


a = r1 + r2; % caculate the sum of each two radius and use for the later judgment
b = r2 + r3;

c = r2 + r4;
d = r2 + r5;

e = r1 + r4;
f = r3 + r5;

g = r4 + r5;


if a<6 && b<6 && c>5 && d>5 && e>5 && f>5 && g<6
    [x1 y1] = Calculate(center(1,1),center(1,2),r1)
    axis equal
    pause(1)
    plot(x1,y1,".b"); % drawing circle1
    
    hold on
    [x2 y2] = Calculate(center(2,1),center(2,2),r2)
    axis equal
    pause(5)
    plot(x2,y2,".k"); % drawing circle2
   
    hold on
    [x3 y3] = Calculate(center(3,1),center(3,2),r3)
    axis equal
    pause(5)
    plot(x3,y3,".r"); % drawing circle3
   
   
    hold on
    [x4 y4] = Calculate(center(4,1),center(4,2),r4)
    axis equal
    pause(5)
    plot(x4,y4,".y"); % drawing circle4
 
    
    hold on
    [x5 y5] = Calculate(center(5,1),center(5,2),r5)
    axis equal
    pause(5)
    plot(x5,y5,".g"); % drawing circle5   
    break
else 
    continue;
    
end
end

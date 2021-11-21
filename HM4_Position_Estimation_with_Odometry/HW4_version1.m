%HW4

%% Ideal(circle) equations:
clear all
clc

L = 0.25; % The distance between two wheel is 2L = 0.5
v = 0.4; % The velocity of the robot is 0.4m/s
w = -0.2; % The angular velocity of the robot is -0.2r/s

X0 = 0; % assume that the initial point is (0,0);
Y0 = 0;
theta0 = 0;% assume that the initial direction is point to the positive x axis;

R = abs(v/w); % calculate the radius of the path
Rl = R-L; % The left wheel's radius
Rr = R+L; % The right wheel's radiu

pace = 0.05; %every step is 0.05m
n = ceil((2*pi*R)/pace); %calculate the element number for the trajectory
theta = pace/R; % calculate the first rotate angle for the robot

Sl1 = zeros(1,n); %creat an array for the left wheel's each step movement
Sr1 = zeros(1,n); %creat an array for the right wheel's each step movement
Sm1 = zeros(1,n); %creat an array for the center points of the two wheels
deltheta1 = zeros(1,n); %creat an array for each step's changing angle

theta1 = zeros(1,n); %creat an array for each step's direction angle
theta1(1,1)= theta0; %initialize the first element

X1 = zeros(1,n);% creat an array for the x 
Y1 = zeros(1,n);% creat an array for the y 
X1(1,1)=X0; %initialze the first element as x0
Y1(1,1)=Y0; %initialze the first element as y0

for i1 = 1:n  % calculate the left wheel and right wheel movements at each step
    Sl1(1,i1) = Rl*theta;
    Sr1(1,i1) = Rr*theta; 
end

for k1 = 1:n % calculate the Sm and the change of each step's theta
    Sm1(1,k1) = (Sl1(1,k1)+Sr1(1,k1))/2;
    deltheta1(1,k1) = -[(Sr1(1,k1)-Sl1(1,k1))/(2*L)]; 
    theta1(1,k1+1)=theta1(1,k1)+deltheta1(1,k1);
end

A = zeros(1,n);

for m1=1:n %calculate the coefficient 
    A(1,m1)=Sm1(1,m1)/deltheta1(1,m1);
end

for j1= 2:n %calculate the coordinate of every segment 
X1(1,j1) = X1(1,j1-1) + A(1,j1-1)*(sin(deltheta1(1,j1-1)+theta1(1,j1-1))-sin(theta1(1,j1-1)));
Y1(1,j1) = Y1(1,j1-1) - A(1,j1-1)*(cos(deltheta1(1,j1-1)+theta1(1,j1-1))-cos(theta1(1,j1-1)));
end


plot(X1,Y1);
axis equal

%% adding Gaussian noise 

Sl2 = zeros(1,n); %creat an array for the left wheel's each step movement
Sr2 = zeros(1,n); %creat an array for the right wheel's each step movement
Sm2 = zeros(1,n); %creat an array for the center points of the two wheels
deltheta2 = zeros(1,n); %creat an array for each step's changing angle

theta2 = zeros(1,n); %creat an array for each step's direction angle
theta2(1,1)= theta0; %initialize the first element

X2 = zeros(1,n); % creat an array for the x 
Y2 = zeros(1,n); % creat an array for the y
X2(1,1)=X0; %initialze the first element as x0
Y2(1,1)=Y0; %initialze the first element as y0

for i2 = 1:n % calculate the left wheel and right wheel movements at each step
    Sl2(1,i2) = Rl*theta;
    Sr2(1,i2) = Rr*theta; 
end

noise1 = normrnd(0,0.005,[1,n]); %creat the noise array for left wheel
noise1(find(noise1>0.01))=0.01; % judge the noise's elements if higher than 0.01,replace it with 0.01
noise1(find(noise1<-0.01))=-0.01; % judge the noise's elements if lower than 0.01,replace it with -0.01

noise2 = normrnd(0,0.005,[1,n]);  %creat the noise array for right wheel
noise2(find(noise2>0.01))=0.01; % judge the noise's elements if higher than 0.01,replace it with 0.01
noise2(find(noise2<-0.01))=-0.01; % judge the noise's elements if lower than 0.01,replace it with -0.01

Sl2 = Sl2 + noise1; % add the noise on the left wheel
Sr2 = Sr2 + noise2; % add the noise on the right wheel

for k2 = 1:n % calculate the Sm and the change of each step's theta
    Sm2(1,k2) = (Sl2(1,k2)+Sr2(1,k2))/2;
    deltheta2(1,k2) = -[(Sr2(1,k2)-Sl2(1,k2))/(2*L)]; 
    theta2(1,k2+1)=theta2(1,k2)+deltheta2(1,k2);
end

B = zeros(1,n);

for m2=1:n %calculate the coefficient 
    B(1,m2)=Sm2(1,m2)/deltheta2(1,m2);
end

for j2= 2:n %calculate the coordinate of every segment 
X2(1,j2) = X2(1,j2-1) + B(1,j2-1)*(sin(deltheta2(1,j2-1)+theta2(1,j2-1))-sin(theta2(1,j2-1)));
Y2(1,j2) = Y2(1,j2-1) - B(1,j2-1)*(cos(deltheta2(1,j2-1)+theta2(1,j2-1))-cos(theta2(1,j2-1)));
end

hold on
plot(X2,Y2,'r');
axis equal
%% Borenstein approximation

Sl3 = zeros(1,n); %creat an array for the left wheel's each step movement
Sr3 = zeros(1,n); %creat an array for the right wheel's each step movement
Sm3 = zeros(1,n); %creat an array for the center points of the two wheels
deltheta3 = zeros(1,n); %creat an array for each step's changing angle

theta3= zeros(1,n); %creat an array for each step's direction angle
theta3(1,1)= theta0; %initialize the first element

X3 = zeros(1,n); % creat an array for the x 
Y3 = zeros(1,n); % creat an array for the y
X3(1,1)=X0; %initialze the first element as x0
Y3(1,1)=Y0; %initialze the first element as y0

for i3= 1:n % calculate the left wheel and right wheel movements at each step
    Sl3(1,i3) = Rl*theta;
    Sr3(1,i3) = Rr*theta; 
end

Sl3 = Sl3 + noise1; % add the noise on the left wheel
Sr3 = Sr3 + noise2; % add the noise on the right wheel

for k3 = 1:n % calculate the Sm and the change of each step's theta
    Sm3(1,k3) = (Sl3(1,k3)+Sr3(1,k3))/2;
    deltheta3(1,k3) = -[(Sr3(1,k3)-Sl3(1,k3))/(2*L)]; 
    theta3(1,k3+1)=theta3(1,k3)+deltheta3(1,k3);
end

for j3 = 2:n %use Borenstein approximation to calculate the coordinate of every segments
X3(1,j3) = X3(1,j3-1) + Sm3(1,j3)*cos(theta3(1,j3));
Y3(1,j3) = Y3(1,j3-1) + Sm3(1,j3)*sin(theta3(1,j3));
end

hold on
plot(X3,Y3,'g');

legend('Ideal(circle)','adding noise ','Borenstein approximation','location','southeast');



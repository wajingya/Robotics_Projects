%%%%%%%%%%%%%%%%%% ideal circle
clc
clear all
v=0.4;%robot's speed is 0.4m/s
w=-0.2;%robot's rotation speed is -0.2 rad/s
L=0.25;%the longth of robot is 2L,0.5m
reading_number=size(0:0.05:2*pi*abs(v/w));%get the number of point(each point apart 0.05)
cita_change=zeros(1,reading_number(2));%build a  matrix for the ideal theta
cita=-(2*pi)/(reading_number(2)-1);%the ideal theta

syms SR SL;%figure out SL and SR
eq1=(SR-SL)/(2*L)==cita; 
eq2=(SR+SL)/2==0.05;
[SR,SL]=solve([eq1,eq2],[SR,SL]);%get SL and SR

SR=double(SR);% change sym to int ,in oder to caculate
SL=double(SL);% change sym to int ,in oder to caculate
x_y(1,1)=0;% initial point ,X
x_y(1,2)=0;% initial point ,Y
cita_change(1)=cita;
for i=2:1:reading_number(2)
   cita_change(i)=cita_change(i-1)+cita; % the ideal theta for every point
end
hold on
for i=2:1:reading_number(2) %caculate the position of each point
    x_y(i,1)=x_y(i-1,1)+L*((SR+SL)/(SR-SL))*(sin(cita_change(i-1)+((SR-SL)/(2*L)))-sin(cita_change(i-1)));
    x_y(i,2)=x_y(i-1,2)-L*((SR+SL)/(SR-SL))*(cos(cita_change(i-1)+((SR-SL)/(2*L)))-cos(cita_change(i-1)));
end
plot(x_y(:,1),x_y(:,2))%draw the circle
axis equal
%%%%%%%%%%%%%%%%%%%%%%%%  noise circle
noise_x_y=zeros(reading_number(2),2);%build a matrix for noise circle
noise_x_y(1,1)=0;% initial point ,X
noise_x_y(1,2)=0;% initial point ,Y
random_L=normrnd(0,sqrt(0.000025),1,reading_number(2));% use normrnd to get radome number
random_R=normrnd(0,sqrt(0.000025),1,reading_number(2));% use normrnd to get radome number
random_L(random_L>0.01)=0.01;% limit the range of noise
random_L(random_L<-0.01)=-0.01;% limit the range of noise
random_R(random_R>0.01)=0.01;% limit the range of noise
random_R(random_R<-0.01)=-0.01;% limit the range of noise
cita_noise_change(1)=0;% initial the theta include noise
for i=2:1:reading_number(2)%the position of the circle with noise
    random_SR=SR+random_R(i);%get the SR with noise
    random_SL=SL+random_L(i);%get the SL with noise
    cita_noise=(random_SR-random_SL)/(2*L);%caculate the theta with noise
    cita_noise_change(i)=cita_noise_change(i-1)+cita_noise;%cita_noise_change is the theta relative to Coordinate origin?0?0?
    noise_x_y(i,1)= noise_x_y(i-1,1)+L*((random_SR+random_SL)/(random_SR-random_SL))*(sin(cita_noise_change(i-1)+((random_SR-random_SL)/(2*L)))-sin(cita_noise_change(i-1)));
    noise_x_y(i,2)= noise_x_y(i-1,2)-L*((random_SR+random_SL)/(random_SR-random_SL))*(cos(cita_noise_change(i-1)+((random_SR-random_SL)/(2*L)))-cos(cita_noise_change(i-1)));
end
plot(noise_x_y(:,1),noise_x_y(:,2));%draw the noise circle
%%%%%%%%%%%%%%%%%%  Borenstein circle
B_x_y=zeros(reading_number(2),2);% build a matrix for Borenstein circle
B_x_y(1,1)=0;% initial point ,X
B_x_y(1,2)=0;% initial point ,Y
cita_noise_change=0;%initial the theta include noise
for i=2:1:reading_number(2)%the position of the Borenstein circle with noise
    random_SR=SR+random_R(i);%get the SR with noise, the namuber same as noise circle
    random_SL=SL+random_L(i);%get the SR with noise, the namuber same as noise circle
    cita_noise=(random_SR-random_SL)/(2*L);%caculate the theta with noise, the namuber same as noise circle
    cita_noise_change(i)=cita_noise_change(i-1)+cita_noise;%cita_noise_change is the theta relative to Coordinate origin?0?0?
    B_x_y(i,1)=((random_SL+random_SR)/2)*cos(cita_noise_change(i-1))+B_x_y(i-1,1);
    B_x_y(i,2)=((random_SL+random_SR)/2)*sin(cita_noise_change(i-1))+B_x_y(i-1,2);
end
plot(B_x_y(:,1),B_x_y(:,2))%draw  Borenstein circle
legend('Ideal circle','Add noise','Borenstein approximation')%add legend
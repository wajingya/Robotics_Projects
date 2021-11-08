clc;
clear all;
rosshutdown;
ipad='localhost';%get the address
rosinit(ipad);   %initialise
robot=rospublisher('/mobile_base/commands/velocity');%build a velocity topic
velmsg=rosmessage(robot);%build a message about topic "rotob"
global m; %control the "while" loop
global linear_velocity; %use global to change the data in function
global angular_velocity;%use global to change the data in function
m=1;i=1;
while m  
function_changedata(i); % a function to change the robot's move 
velmsg.Linear.X=linear_velocity;
velmsg.Angular.Z=angular_velocity;
send(robot,velmsg);     %send message
pause(0.1)  %use i and pause to caculate the times and control
i=i+1;
""end
fprintf("the performance period is %d s ",i*0.1);%show the time of robot run
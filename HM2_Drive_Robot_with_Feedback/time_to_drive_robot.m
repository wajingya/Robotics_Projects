 %%%%this program use timing to drive the robot%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
reset_odom=rospublisher('/mobile_base/commands/reset_odometry');%reset Odometry
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);
rosshutdown;
ipad='localhost';%get the address
rosinit(ipad);   %initialise
robot=rospublisher('/mobile_base/commands/velocity');%build a velocity topic
velmsg=rosmessage(robot);%build a message about topic "rotob"
rostime('now')%use rostime to limit time
time1=rostime('now')%begin timing
while 1 %this"while" is used to run the Longest edge
linear_velocity=0.5;  %Declared speed 
angular_velocity=0;   %Declared angle
velmsg.Linear.X=linear_velocity;   %change speed
velmsg.Angular.Z=angular_velocity; %change angular velocity
send(robot,velmsg);     %send message
time2=rostime('now')    %get time
distance=sqrt(5^2-2.5^2)*2;%the long we want run
if (time2-time1)>=(distance/linear_velocity) %use deviations to get time that robot has run 
    %and caculate the time robot should run then compare whether reacher the time
    break  %if time over, stop the "while" loop, go to the nest step
end
end
rostime('now') %reset timing
time1=rostime('now')% the time begin to run the second edge
while 1 %the second "while" is used to turn the first angle
linear_velocity=0;  
angular_velocity=0.5; %the speed turn a corner
velmsg.Linear.X=linear_velocity; %change speed
velmsg.Angular.Z=angular_velocity;%change angle speed
send(robot,velmsg);     %send message
time2=rostime('now')    %stop timing
angle=150; %the first angle 
if (time2-time1)>=((angle/360)*2*pi)/angular_velocity %caculate the time should turn
    linear_velocity=0;  %Declared speed 
    angular_velocity=0;   %Declared angle
    send(robot,velmsg);     %send message
    break
end
end
rostime('now')
time1=rostime('now')
while 1 %run the second edge
linear_velocity=0.5;  %change speed
angular_velocity=0;   %change angle speed
velmsg.Linear.X=linear_velocity;
velmsg.Angular.Z=angular_velocity;
send(robot,velmsg);     %send message
time2=rostime('now')
distance=5
if (time2-time1)>=(distance/linear_velocity)%caculate the time should run and judge
    break %stop
end
end
rostime('now')%reset timeing
time1=rostime('now')%the time begin run
while 1 
linear_velocity=0;  %change speed
angular_velocity=0.5;%change angle speed
velmsg.Linear.X=linear_velocity;
velmsg.Angular.Z=angular_velocity;
send(robot,velmsg);     %send message
time2=rostime('now') % get the time 
angle=60;% the angle should running
if (time2-time1)>=((angle/360)*2*pi)/angular_velocity%caculate the time should run
    break%stop "while" loop
end
end
rostime('now')%reset timeing
time1=rostime('now')%get the begin time
while 1 
linear_velocity=0.5;  %change speed
angular_velocity=0;   %change angle speed
velmsg.Linear.X=linear_velocity;
velmsg.Angular.Z=angular_velocity;
send(robot,velmsg);     %send message
time2=rostime('now')   %get time
distance=5
if (time2-time1)>=(distance/linear_velocity)%caculate the time should running
    break%stop "while" loop
end
end


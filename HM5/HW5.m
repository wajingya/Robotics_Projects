%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AMR HW5
% Fall Term / 2019
% Author: Wang Jingya
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc

rosshutdown;
ipaddress='localhost'; 

rosinit(ipaddress); % Initialize ROS

reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

 robot = rospublisher('/mobile_base/commands/velocity'); 
% Create a publisher 

odom_subs = subscriber('/odom');
% Create a subscribers

velmsg= rosmessage(robot);
% Create a message with the right format to the topic

pose = rosmessage(odom_subs);
% Create the message with the right format for the topic

forwardVelocity= 0.5; 
% Create velocity variable

angularVelocity= 0;
% Create angular velocity variable

velmsg.Linear.X= forwardVelocity;
velmsg.Angular.Z=angularVelocity;
% Attribute the desired values to the message

while(true)
send(robot,velmsg);
% Publish the message

end
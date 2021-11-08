clear all
close all
clc

% Shut down the executing ros
rosshutdown;

% Initialize ROS
ipaddress='localhost';
rosinit(ipaddress);

% Reset Odometry
reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

% Create the publishers and subscribers
robot = rospublisher('/mobile_base/commands/velocity');
odom_subs = rossubscriber('/odom');
model_subs = rossubscriber('/gazebo/model_states');

velmsg = rosmessage(robot);
pose = rosmessage(odom_subs);
model = rosmessage(model_subs);

velmsg.Linear.X = 0.1;
velmsg.Angular.Z = 0.15;
send(robot,velmsg);

model=receive(model_subs);
pose=receive(odom_subs);


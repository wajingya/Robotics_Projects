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
% reset the position to the global (0,0)

robot = rospublisher('/mobile_base/commands/velocity'); 
% Create a publisher 

odom_subs = rossubscriber('/odom');
% Create a subscribers

velmsg= rosmessage(robot);
% Create a message with the right format to the topic

pose = receive(odom_subs);
% Create the message with the right format for the topic

forwardVelocity= 0.5; 
% Create velocity variable

angularVelocity= 0;
% Create angular velocity variable

velmsg.Linear.X= forwardVelocity;
velmsg.Angular.Z=angularVelocity;
% Attribute the desired values to the message

send(robot,velmsg);
% send the message to the robot

x = zeros(1,1000);
y = zeros(1,1000);
X = zeros(1,1000);
Y = zeros(1,1000);
Z = zeros(1,1000);
W = zeros(1,1000);
theta = zeros(1,1000);

theta1 = atan((1-4)/(8-1))+pi;
theta2 = atan((9-4)/(9-1));

for i = 1:1000;
    pose = receive(odom_subs);
    x(1,i) = pose.Pose.Pose.Position.X;
    y(1,i) = pose.Pose.Pose.Position.Y;

    robot_axis = [x(1,i);y(1,i)];

    X(1,i) = pose.Pose.Pose.Orientation.X;
    Y(1,i) = pose.Pose.Pose.Orientation.Y;
    Z(1,i) = pose.Pose.Pose.Orientation.Z;
    W(1,i) = pose.Pose.Pose.Orientation.W;

     
    Eangle = quat2eul([W(1,i) X(1,i) Y(1,i) Z(1,i)]);
    theta(1,i) = Eangle(1,1)+pi;
    
    R = [cos(theta(1,i)),-sin(theta(1,i));sin(theta(1,i)),cos(theta(1,i))];

    global_axis1 = R * robot_axis;

    global_axis2 = global_axis1 + [x(1,i);y(1,i)]; % Question;

    x_now = global_axis2(1,1);
    y_now = global_axis2(2,1);

    a = 0;
    if (x_now > 1 && x_now < 8 && y_now >1 && y_now <4)
        a = 1;
    elseif(x_now == 6 && y_now ==1)
        a = 2;
    elseif(x_now > 1 && x_now < 9 && y_now >4 && y_now <9)
        a = 3;
    elseif(x_now == 1 && y_now ==9)
        a = 4;
    end

    switch a
        case 1
             if (theta(1,i)>theta1)
             velmsg.Angular.Z = -0.1; 
             send(robot,velmsg);
             elseif(theta(1,i)<theta1)
             velmsg.Angular.Z = 0.1; 
             send(robot,velmsg);
             end
        case 2
             velmsg.Linear.X= 0.5;
             velmsg.Angular.Z=-0.6;
             send(robot,velmsg);
        case 3
            if (theta(1,i)>theta2)
            velmsg.Angular.Z = -0.1; 
            send(robot,velmsg);
            elseif(theta(1,i)<theta2)
            velmsg.Angular.Z = 0.1; 
            send(robot,velmsg);
            end
        case 4
            velmsg.Linear.X= 0;
            velmsg.Angular.Z=0;
            send(robot,velmsg);
    end
end

plot (x,y);
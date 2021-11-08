%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Homework 6: Drive Robot to Avoid Obstacles              %
%Auther's name: Wang Jingya                              %
%Date:10/28/2019                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task A: Outside of the given “island”- keep the wall to the right
% Setting the initial position as   
% position:
%       x: -10.0
%       y: -6.0
%       z: 0.0
% orientation:
%       x: 0.0
%       y: 0.0
%       z: 0.7
%       w: 0.7
            
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
model_subs=rossubscriber('/gazebo/model_states');
laser=rossubscriber('/laserscan');

% Create the message with the right format for the topic
velmsg = rosmessage(robot);
pose = rosmessage(odom_subs);
model=rosmessage(model_subs);
laser_msg=rosmessage(laser);

% Calculate the degrees between two LIDAR lines
index_incre = 270/1080;
% Claculate the RIDAR lines number we want
index1 = -90/index_incre + 540;

% Setting a number to start running the robot
m = 1;

% Initializing the running distance value which used to record the ditance 
% between the starting position and the current position
running_distance = 0;

% Used to make the distance recording continue
j=1;

% Setting two arraies to recording the odometry in order to calculate the
% distance which the robot has run
odom_pose_X(1,j)=0;
odom_pose_Y(1,j)=0;

while m==1
 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);
        
        position_X = model.Pose(34,1).Position.X;
        position_Y = model.Pose(34,1).Position.Y;
        
        hold on
        axis equal
        plot(position_X,position_Y,'.');
        
 % This section is used to  receive the coordinates information from 
 % the Odometry, which is used to calculate the distance the robot has run,
 % Finally, output the distance 
        j=j+1;
        pose=receive(odom_subs);
        odom_pose_X(1,j) = pose.Pose.Pose.Position.X;
        odom_pose_Y(1,j) = pose.Pose.Pose.Position.Y;
        
        delta_x = odom_pose_X(1,j)-odom_pose_X(1,j-1);
        delta_y = odom_pose_Y(1,j)-odom_pose_Y(1,j-1);
        delta_distance = delta_x^2+delta_y^2;
        running_distance = running_distance + delta_distance;
        fprintf(" The robot have run %f meters. \n", running_distance);
       
 % This section is used to receive the RIDAR information and control the
 % robot.My idea is dividing task into three basic conditions, and in each 
 % conditions, adding some subconditions 
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        distance = laser_msg.Ranges;
        
 % This part is used to calculate the mean value about 11 LIDAR lines
 % feedback value, which are from 535 to 545(The front conditions),
 % preparing for the later controling. Using the mean value
 % will make the running more smoothly.
        sum1 = 0;
        for i = (540-5):(540+5)
            sum1 = sum1 + distance(i);
            length1 = sum1 / 11;
        end
        
 % This part is used to calculate the mean value about 7 LIDAR lines
 % feedback value, which are from 897 to 903 (The right side conditions),
 % preparing for the later controling. Using the mean value
 % will make the running more smoothly.
        sum2 = 0;
        for i = (index1-3):(index1+3)
              sum2 = sum2 + distance(i);
              length2 = sum2 / 7;
        end
        
 % This part is used to control the robot moving; My mean idea is 
 % 1. Judging the front condition, if the distance is larger than 2.5 and
 % less than 100(The value is simulating the Infinite value). This means
 % the robot is running along a straight line. So, if the robot leans to the
 % left, changing the angular rate to make the robot turning to the right. 
 % If the robot leans to the right, changing the angular velocity to make
 % the robot turning to the left. Otherwise, running in a stright line. The
 % judging distance is 2.01 meters, which gives the robot a 0.02 tolerance.
        if length1 >3 && length1 <= 100
            1
                if length2 > 2.01 
                    11
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = -0.18;
                send(robot,velmsg);
                elseif length2 < 2.01
                    12
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0.18;
                send(robot,velmsg);
                else
                    13
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0;
                send(robot,velmsg);
                end
                
  % 2. If the front distance is less than 2.5, the situation is that the
  % robot are facing the wall and need to rotate a big angle to avoiding
  % hit on the wall. 
        elseif length1 <= 3
            2
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0.35;
                send(robot,velmsg);
                
  % 3. The last situation is when the front distance is Infinite, which
  % means there is no barrier in the front. Then let the robot to judge the
  % lateral conditions. If the lateral sides also doesn't have the barrier,
  % the situation means that the robot is at the corner, and it should turn
  % around. But if there are also some obstacles on the side. This is means
  % that the robot is still running along the wall, but the wall is very
  % long, the robot should adjust its angular velocity in a small range.
        else
            if length2 == Inf
                31
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = -0.35;
                send(robot,velmsg);
            else
                32
                if length2 > 2.01 
                    321
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = -0.18;
                send(robot,velmsg);
                elseif length2 < 2.01
                    322
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0.18;
                send(robot,velmsg);
                else
                    323
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0;
                send(robot,velmsg);
                end
            end
        end
end

%% Task A: Outside of the given “island”- keep the wall to the left
% Setting the initial position as   
% position:
%       x: -10.0
%       y: -6.0
%       z: 0.0
% orientation:
%       x: 0.0
%       y: 0.0
%       z: -0.7
%       w: 0.7

% The second task used the same idea as the first one. But the codes should
% change the angular velocity directioins in different situations.
clear all
close all
clc

%shut down the executing ros
rosshutdown;
%Initialize ROS
ipaddress='localhost';
rosinit(ipaddress);

%Reset Odometry
reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

%Create the publishers and subscribers
robot = rospublisher('/mobile_base/commands/velocity');
odom_subs = rossubscriber('/odom');
model_subs=rossubscriber('/gazebo/model_states');
laser=rossubscriber('/laserscan');

%Create the message with the right format for the topic
velmsg = rosmessage(robot);
pose = rosmessage(odom_subs);
model=rosmessage(model_subs);
laser_msg=rosmessage(laser);

index_incre = 270/1080;
index1 = 90/index_incre + 540;

running_distance = 0;
j=1;
odom_pose_X(1,j)=0;
odom_pose_Y(1,j)=0;

m = 1;
while m==1
        model=receive(model_subs);
        pose=receive(odom_subs);
        
        position_X = model.Pose(34,1).Position.X;
        position_Y = model.Pose(34,1).Position.Y;
        
        hold on
        axis equal
        plot(position_X,position_Y,'.');
        
        j=j+1;
        pose=receive(odom_subs);
        odom_pose_X(1,j) = pose.Pose.Pose.Position.X;
        odom_pose_Y(1,j) = pose.Pose.Pose.Position.Y;
        
        delta_x = odom_pose_X(1,j)-odom_pose_X(1,j-1);
        delta_y = odom_pose_Y(1,j)-odom_pose_Y(1,j-1);
        delta_distance = delta_x^2+delta_y^2;
        running_distance = running_distance + delta_distance;
        fprintf(" The robot have run %f meters. \n", running_distance);
        
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        distance = laser_msg.Ranges;
        
        sum1 = 0;
        for i = (540-5):(540+5)
            sum1 = sum1 + distance(i);
            length1 = sum1 / 11;
        end
        sum2 = 0;
        for i = (index1-3):(index1+3)
              sum2 = sum2 + distance(i);
              length2 = sum2 / 7;
        end
        if length1 >2.5 && length1 <= 100
                if length2 > 2.01 
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0.18;
                send(robot,velmsg);
                elseif length2 < 2.01
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = -0.18;
                send(robot,velmsg);
                else
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0;
                send(robot,velmsg);
                end
        elseif length1 <= 2.5
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = -0.35;
                send(robot,velmsg);
        else
            if length2 == Inf
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0.35;
                send(robot,velmsg);
            else
                if length2 > 2.01 
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0.18;
                send(robot,velmsg);
                elseif length2 < 2.01
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = -0.18;
                send(robot,velmsg);
                else
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0;
                send(robot,velmsg);
                end
            end
        end

end

%% Task B: Inside of the given “island”- keep the wall to the left
% Setting the initial position as   
% position:
%       x: 0.0
%       y: 0.0
%       z: 0.0
% orientation:
%       x: 0.0
%       y: 0.0
%       z: 0.0
%       w: 0.0

% The third task used the same idea as the first one. But the codes should
% change the angular velocity directioins in different situations.
clear all
close all
clc

%shut down the executing ros
rosshutdown;
%Initialize ROS
ipaddress='localhost';
rosinit(ipaddress);

%Reset Odometry
reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

%create the publishers and subscribers
robot = rospublisher('/mobile_base/commands/velocity');
odom_subs = rossubscriber('/odom');
model_subs=rossubscriber('/gazebo/model_states');
laser=rossubscriber('/laserscan');

%create the message with the right format for the topic
velmsg = rosmessage(robot);
pose = rosmessage(odom_subs);
model=rosmessage(model_subs);
laser_msg=rosmessage(laser);

index_incre = 270/1080;
index1 = 90/index_incre + 540;

running_distance = 0;
j=1;
odom_pose_X(1,j)=0;
odom_pose_Y(1,j)=0;

m = 1;
while m==1
        model=receive(model_subs);
        pose=receive(odom_subs);
        
        position_X = model.Pose(34,1).Position.X;
        position_Y = model.Pose(34,1).Position.Y;
        
        hold on
        axis equal
        plot(position_X,position_Y,'.');
        
        j=j+1;
        pose=receive(odom_subs);
        odom_pose_X(1,j) = pose.Pose.Pose.Position.X;
        odom_pose_Y(1,j) = pose.Pose.Pose.Position.Y;
        
        delta_x = odom_pose_X(1,j)-odom_pose_X(1,j-1);
        delta_y = odom_pose_Y(1,j)-odom_pose_Y(1,j-1);
        delta_distance = delta_x^2+delta_y^2;
        running_distance = running_distance + delta_distance;
        fprintf(" The robot have run %f meters. \n", running_distance);
        
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        distance = laser_msg.Ranges;
        
        sum1 = 0;
        for i = (540-5):(540+5)
            sum1 = sum1 + distance(i);
            length1 = sum1 / 11;
        end
        sum2 = 0;
        for i = (index1-3):(index1+3)
              sum2 = sum2 + distance(i);
              length2 = sum2 / 7;
        end
        if length1 >2.5 && length1 <= 100
                if length2 > 2.01 
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0.18;
                send(robot,velmsg);
                elseif length2 < 2.01
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = -0.18;
                send(robot,velmsg);
                else
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0;
                send(robot,velmsg);
                end
        elseif length1 <= 2.5
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = -0.35;
                send(robot,velmsg);
        else
            if length2 == Inf
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0.35;
                send(robot,velmsg);
            else
                if length2 > 2.01 
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0.18;
                send(robot,velmsg);
                elseif length2 < 2.01
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = -0.18;
                send(robot,velmsg);
                else
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0;
                send(robot,velmsg);
                end
            end
        end

end


%% Task B: Inside of the given “island”- keep the wall to the right
% Setting the initial position as   
% position:
%       x: 0.0
%       y: 0.0
%       z: 0.0
% orientation:
%       x: 0.0
%       y: 0.0
%       z: 1.0
%       w: 0.0

% The third task used the same idea as the first one. But the codes should
% change the angular velocity directioins in different situations.
clear all
close all
clc

%shut down the executing ros
rosshutdown;
%Initialize ROS
ipaddress='localhost';
rosinit(ipaddress);

%Reset Odometry
reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

%create the publishers and subscribers
robot = rospublisher('/mobile_base/commands/velocity');
odom_subs = rossubscriber('/odom');
model_subs=rossubscriber('/gazebo/model_states');
laser=rossubscriber('/laserscan');

%create the message with the right format for the topic
velmsg = rosmessage(robot);
pose = rosmessage(odom_subs);
model=rosmessage(model_subs);
laser_msg=rosmessage(laser);

index_incre = 270/1080;
index1 = -90/index_incre + 540;

running_distance = 0;
j=1;
odom_pose_X(1,j)=0;
odom_pose_Y(1,j)=0;

m = 1;
while m==1
        model=receive(model_subs);
        pose=receive(odom_subs);
        
        position_X = model.Pose(34,1).Position.X;
        position_Y = model.Pose(34,1).Position.Y;
        
        hold on
        axis equal
        plot(position_X,position_Y,'.');
        
        j=j+1;
        pose=receive(odom_subs);
        odom_pose_X(1,j) = pose.Pose.Pose.Position.X;
        odom_pose_Y(1,j) = pose.Pose.Pose.Position.Y;
        
        delta_x = odom_pose_X(1,j)-odom_pose_X(1,j-1);
        delta_y = odom_pose_Y(1,j)-odom_pose_Y(1,j-1);
        delta_distance = delta_x^2+delta_y^2;
        running_distance = running_distance + delta_distance;
        fprintf(" The robot have run %f meters. \n", running_distance);
        
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        distance = laser_msg.Ranges;
        
        sum1 = 0;
        for i = (540-5):(540+5)
            sum1 = sum1 + distance(i);
            length1 = sum1 / 11;
        end
        sum2 = 0;
        for i = (index1-3):(index1+3)
              sum2 = sum2 + distance(i);
              length2 = sum2 / 7;
        end
        if length1 >2.5 && length1 <= 100
                if length2 > 2.01 
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = -0.18;
                send(robot,velmsg);
                elseif length2 < 2.01
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0.18;
                send(robot,velmsg);
                else
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0;
                send(robot,velmsg);
                end
        elseif length1 <= 2.5
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0.35;
                send(robot,velmsg);
        else
            if length2 == Inf
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = -0.35;
                send(robot,velmsg);
            else
                if length2 > 2.01 
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = -0.18;
                send(robot,velmsg);
                elseif length2 < 2.01
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0.18;
                send(robot,velmsg);
                else
                velmsg.Linear.X = 0.3;
                velmsg.Angular.Z = 0;
                send(robot,velmsg);
                end
            end
        end

end

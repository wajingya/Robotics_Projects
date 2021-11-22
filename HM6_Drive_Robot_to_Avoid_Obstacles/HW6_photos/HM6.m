%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Homework 6: Drive Robot to Avoid Obstacles              %
%Auther's name: Wang Jingya                              %
%Date:10/28/2019                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task A:" random Walk"_using Hokuyo:
clear all
close all
clc

% Initialize ROS
rosshutdown;
ipaddress='localhost';
rosinit(ipaddress);

% Reset Odometry
reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

% Create a suscriber to the laserscan topic
laser=rossubscriber('/laserscan');
% Create a message with the right format to the topic
laser_msg=rosmessage(laser);
% Receive the message from the topic
laser_msg=receive(laser);

% Create a publisher to the velocity topic
robot = rospublisher('/mobile_base/commands/velocity');
% Create a message with the right format to the topic
velmsg = rosmessage(robot);

% Create velocity variables
velocity = 0.25;

% Attribute the desired values to the message
velmsg.Linear.X = velocity;
velmsg.Angular.Z = 0;

% Publish the message
send(robot,velmsg);

% Let the robot to start moving
while(1) 
    % Receive the message from the laser topic, to make sure the range
    % message renew with the moving
    laser_msg=receive(laser);
    
    % Using logic to change the negative infinite value to the positive
    % infinite value,because we need to find the minimum distance between
    % the robot to the obstracle,the negative infinite value will influence
    % our judgment.
    laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
    
    % Using logic to find the minimum value among the feedback data
    dis = min(laser_msg.Ranges);
    
    % Setting a array called range to record the distance data, in order to
    % judge the minimum distance data belongs to the left side or the right
    % side and to make sure that the robot should turn to the right or to
    % the left
    range = laser_msg.Ranges;
    
    % The condition loops is ued to judge whether the robot should turn
    % around,if the minimum distance from robot to the obstracle is bigger
    % than 1, we set the condition is safe, and order the robot to go
    % straightly,otherwise the robot should turn around according to the
    % conditions.
    
    if (dis > 1)
        % The situation is safe, setting the robot to go straightly
        velocity = 0.25; % set the velocity 
        velmsg.Linear.X = velocity;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);% send the message
      
    else 
        % The condition is not safe, set the robot to rotate
        
        % Using the for loop to find the minimum distance's number is
        % which lines among the 1080 ridar lines
        for i= 1:1080
          if range(i,1)==dis
             a = i;% Get the sequence number
           end
        end
        
        % Using the sequence number to judge which range the number belongs
        % to,and depending on the range to judge the angular velocity
        if a>=1 && a<180
            % If the minimum distance feedback comes from the 1 to 180,set
            % the velocity like the following 
                angular_velocity = 0.1;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                
            % Send the message to the robot
                send(robot,velmsg);
        elseif a>=180 && a<360
            % If the minimum distance feedback comes from the 180 to 360,set
            % the velocity like the following 
                angular_velocity = 0.15;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                
            % Send the message to the robot
                send(robot,velmsg);
        elseif a>=360 && a<720
            % If the minimum distance feedback comes from the 360 to 720,set
            % the velocity like the following 
                angular_velocity = 0.3;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
               
            % Send the message to the robot
                send(robot,velmsg);
        elseif a>=720 && a<900
            % If the minimum distance feedback comes from the 720 to 900,set
            % the velocity like the following 
                angular_velocity = -0.15;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                
            % Send the message to the robot
                send(robot,velmsg);
        elseif a>=900 && a<1080
            % If the minimum distance feedback comes from the 900 to 1080,set
            % the velocity like the following 
                angular_velocity = -0.1;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                
             % Send the message to the robot
                send(robot,velmsg);      
        end

    end
end

%% Task A:" random Walk"_using_Kinect
clear all
close all
clc

% This section using the same idea, but changing the LIDAR topic name
rosshutdown;
ipaddress='localhost';
rosinit(ipaddress);

reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

% This time, using the the '/kinect_scan' topic 
laser=rossubscriber('/kinect_scan');
laser_msg=rosmessage(laser);
laser_msg=receive(laser);

robot = rospublisher('/mobile_base/commands/velocity');
velmsg = rosmessage(robot);

velocity = 0.25;
velmsg.Linear.X = velocity;
velmsg.Angular.Z = 0;
send(robot,velmsg);

while(1) 
    laser_msg=receive(laser);
    laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
    dis = min(laser_msg.Ranges);
    range = laser_msg.Ranges;
    
    if (dis > 1)
        velocity = 0.25;
        velmsg.Linear.X = velocity;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);
      
    else 
        % Change the ridar detecting lines range, this type has 640 lines
        for i= 1:640
          if range(i,1)==dis
             a = i;
           end
        end
        % Because the detecting range is smaller than the hokuyo, I just
        % divied the range into three sections to change the robot velocity
        if a>=1 && a<300
                angular_velocity = 0.85;
                velocity = 0.25;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);
        elseif a>=320 && a<340
                angular_velocity = 1.4;
                velocity = 0.25;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);   
        elseif a>=340 && a<640
                angular_velocity = -0.85;
                velocity = 0.25;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);    
                    
        end

    end
end
%% Task B: Concave or U-shaped Trap using Hokuyo:
clear all
close all
clc

% The same idea as prior two, but the task B's world condition is different
% with the task A, so we adjusted the angular velocity to make sure it
% suitable to the second world conditions

rosshutdown;
ipaddress='localhost';
rosinit(ipaddress);

reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

% Using the topic of '/laserscan'
laser=rossubscriber('/laserscan');
laser_msg=rosmessage(laser);
laser_msg=receive(laser);

robot = rospublisher('/mobile_base/commands/velocity');
velmsg = rosmessage(robot);

velocity = 0.25;
velmsg.Linear.X = velocity;
velmsg.Angular.Z = 0;
send(robot,velmsg);

while(1) 
    laser_msg=receive(laser);
    laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
    dis = min(laser_msg.Ranges);
    range = laser_msg.Ranges;
    
    if (dis > 1)
        velocity = 0.25;
        velmsg.Linear.X = velocity;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);
      
    else 
        for i= 1:1080
          if range(i,1)==dis
             a = i;
           end
        end
        if a>=1 && a<180
                angular_velocity = 0.1;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);
        elseif a>=180 && a<360
                angular_velocity = 0.15;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);
        elseif a>=360 && a<720
                angular_velocity = 0.5;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);
        elseif a>=720 && a<900
                angular_velocity = -0.15;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);
        elseif a>=900 && a<1080
                angular_velocity = -0.1;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);      
        end

    end
end

%% Task B: Concave or U-shaped Trap using Kinect:
clear all
close all
clc

% The same idea as prior two, but the task B's world condition is different
% with the task A, so we adjusted the angular velocity to make sure it
% suitable to the second world conditions

rosshutdown;
ipaddress='localhost';
rosinit(ipaddress);

reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

% Using the topic of '/kinect_scan'
laser=rossubscriber('/kinect_scan');
laser_msg=rosmessage(laser);
laser_msg=receive(laser);

robot = rospublisher('/mobile_base/commands/velocity');
velmsg = rosmessage(robot);

velocity = 0.25;
velmsg.Linear.X = velocity;
velmsg.Angular.Z = 0;
send(robot,velmsg);

while(1) 
    laser_msg=receive(laser);
    laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
    dis = min(laser_msg.Ranges);
    range = laser_msg.Ranges;
    
    if (dis > 1)
        velocity = 0.5;
        velmsg.Linear.X = velocity;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);
      
    else 
        for i= 1:640
          if range(i,1)==dis
             a = i;
           end
        end
          if a>=1 && a<300
                angular_velocity = 0.85;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);
        elseif a>=320 && a<340
                angular_velocity = 1.4;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);   
        elseif a>=340 && a<640
                angular_velocity = 0.6;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                send(robot,velmsg);    
                    
          end
    end
end


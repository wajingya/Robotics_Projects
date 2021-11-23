%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Homework 8: Find the Door                               %
%Auther's name: Wang Jingya                              %
%Date:11/15/2019                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task A: Using the Hokuyo Lidar
% Setting the initial position as   
% position:
%       x: 2.4683
%       y: -4.5436
%       z: 0.0
% orientation:
%       x: -0.0029
%       y: -0.0028
%       z: -0.7175
%       w: -0.6965
% For this task, I set the Robot to the wrong direction; but it can also
% achieve the goal. So I put it as an comparing example compared with TaskB

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
laser = rossubscriber('/laserscan');

% Create the message with the right format for the topic
velmsg = rosmessage(robot);
pose = rosmessage(odom_subs);
model = rosmessage(model_subs);
laser_msg = rosmessage(laser);

% I set a begin signal to start the running
begin = 1;

% These values are used to used later, I give them the initial value as 0
sum1 = 0;
sum2 = 0;
sum3 = 0;

n1 = 0;
n2 = 0;
n3 = 0;

% Control the robot to move, give it an initial speed
velmsg.Linear.X = 0.15;
velmsg.Angular.Z = 0.35;
send(robot,velmsg);

% The value n is used to add the position array, because I didn't know how
% many steps including in the path, so that recording the position points
% and plotting the path figure in the end.

n = 1;

% This section is used to receive the position information from the
% model_state, in order to plot the trajectory figures.
model=receive(model_subs);
        
position_X(n) = model.Pose(22,1).Position.X;
position_Y(n) = model.Pose(22,1).Position.Y;
n=n+1;
 
% This section is used to make the robot run to the center of the
% obstacles; And the whole idea is firstly make the robot turn to the ideal
% direction and judge the Lidar feedback data. I divide the range into 
% three areas and then calculate the mean value of these three ranges.
% Then let each two among the three mean values do subtraction calculation. 
% Using the errors to judge. If the three errors are almost equal, then 
% define the situation as the robot is in the center point. Otherwise, 
% adjust the robot moving to make it run to the center point.

while begin==1
 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
   model=receive(model_subs);
        
   position_X(n) = model.Pose(22,1).Position.X;
   position_Y(n) = model.Pose(22,1).Position.Y;
   n=n+1;
        
    laser_msg=receive(laser);
    laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
    distance = laser_msg.Ranges;
   
 % Calculate the mean value from 1 to 270
 % During calculation, we should pay attention to the Infinite values, 
 % So, before adding, I judge whether the value is Infinite. If it is,
 % don't add that value. Additionally, as adding, recording how many
 % numbers have been added.
 
    for i1 = 1:270
        if distance(i1)~=Inf
            sum1 = sum1+distance(i1);
            n1 = n1+1;
        end
    end

     aver_dis1 = sum1/n1;
     
 % Calculate the mean value from 810 to 1080  
 % During calculation, we should pay attention to the Infinite values, 
 % So, before adding, I judge whether the value is Infinite. If it is,
 % don't add that value. Additionally, as adding, recording how many
 % numbers have been added.
 
    for i2 = 810:1080
        if distance(i2)~=Inf
            sum2 = sum2+distance(i2);
            n2 = n2+1;
        end
    end
    
     aver_dis2 = sum2/n2;
   
 % Calculate the mean value from 271 to 809 
 % During calculation, we should pay attention to the Infinite values, 
 % So, before adding, I judge whether the value is Infinite. If it is,
 % don't add that value. Additionally, as adding, record that how many
 % numbers have been added.
 
    for i3 = 271:809
        if distance(i3)~=Inf
            sum3 = sum3+distance(i3);
            n3 = n3+1;
        end
    end
    
     aver_dis3 = sum3/n3;
 
 % Make the differences calculation, in order that I can use these 
 % valuse to order the robot moving    
     error = aver_dis1-aver_dis2;
     error1 = aver_dis1-aver_dis3;
     error2 = aver_dis2-aver_dis3;
   
 % First, judge the differences between the left side and the right side.
 % If the left side average value is larger than the right side value, then
 % make the robot turn to the left. Otherwise, turn to the opposite.
 % If there is no huge difference between the left side mean value and the
 % right side mean value. Than Comparing the front side mean value with the
 % right side and the left side. For example, if the right side mean value
 % larger than the left side mean value, make the robot turn to the right.
 % Then same theroy used in the other directions.
 
 % If the robot almost reaches the center point, stop the robot and give
 % 'begin' the other value to make it jump out of the while loop
    if error >= 1.5
         velmsg.Linear.X = 0.15;
         velmsg.Angular.Z = -0.1;
         send(robot,velmsg);
    elseif error < -1.5
         velmsg.Linear.X = 0.15;
         velmsg.Angular.Z = 0.1;
         send(robot,velmsg);
    else
        if (abs(error1)-abs(error2))>= 1.2
            velmsg.Linear.X = 0.15;
            velmsg.Angular.Z = -0.1;
            send(robot,velmsg);
        elseif (abs(error1)-abs(error2))<= -1.2
            velmsg.Linear.X = 0.15;
            velmsg.Angular.Z = 0.1;
            send(robot,velmsg);
        elseif (abs(error1)-abs(error2))< 1.2 && (abs(error1)-abs(error2))>= 1.1
            velmsg.Linear.X = 0.15;
            velmsg.Angular.Z = 0;
            send(robot,velmsg);
        elseif (abs(error1)-abs(error2))> -1.2 && (abs(error1)-abs(error2))<= -1.1
            velmsg.Linear.X = 0.15;
            velmsg.Angular.Z = 0;
            send(robot,velmsg);    
        else
            velmsg.Linear.X = 0;
            velmsg.Angular.Z = 0;
            send(robot,velmsg);
            begin = 0;
        end
    end
    
end

% And the center point, the robot need to rotate one round and have two
% tasks: 1. Draw the obstacles maps and then 2.find the door on which side
% of the obstacles.

% Beginning to record the time(because the angular velocity is defined by
% me. So, I setting every four doors a value, the value represent its
% direction the robot should rotate to. For example, The robot should
% firstly rotate one circle to scan the whole area. So the rotating time is
% 360 degrees divided by angular velocity. And if the goal door is the
% upper door, if the robot want to through that door, it should first turn
% to that direction, it is 90 degrees, so the rotating time is 90 degrees
% divide the angular velocity.

tic 
time = 2*pi/0.1 +5;
t1 = pi/2/0.1;
t2 = pi/0.1;
t3 = 3*pi/2/0.1;

% The counter is used to recording the width of the door; If the LIDAR
% feedback value is Infinite, The counter should add one.
counter1 = 0;
counter2 = 0;
counter3 = 0;
counter4 = 0;

while begin == 0
 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);
        
        position_X(n) = model.Pose(22,1).Position.X;
        position_Y(n) = model.Pose(22,1).Position.Y;
        n=n+1; 
        
        t = toc;
        
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        range = laser_msg.Ranges;

% Because as the robot rotating, the head of the robot is pointing to the
% wall. So we should record the head LIDAR line's data in order to record
% the door's width.
        length = range(540);
        
% Recording the door's width: When the robot rotate less than 90 degrees,
% it is recording the first door's width. When the robot rotate larger than
% 90 degrees less than 180 degrees, it is recording the second door's
% width. And so on. I used the time to control the rotating degrees.
        if t<t1
             if length == Inf
                counter1 = counter1 + 1;
            end
        elseif t>=t1 && t<t2
            if length == Inf
                counter2 = counter2 + 1;
            end
        elseif t>=t2 && t<=t3
            if length == Inf
                counter3 = counter3 + 1;
            end
        elseif t>=t3 && t<time
            if length == Inf || length <3
                counter4 = counter4 + 1;
            end
        end
 
% This section is used to control the robot whole circle rotating: It also
% used the time to control the rotating. 
% Receive the current model_state position and using quaternion calculate
% the position angle. Using the angle to draw the world map.
% Using the LIDAR feedback data as the length, combined with the position
% angle, using trigonometric formula to calculate the obstacle coordinates
        model=receive(model_subs);
        quat = model.Pose(22,1).Orientation;
        
        theta = quat2eul([quat.W quat.X quat.Y quat.Z]);
        ob_X = length * cos(theta(1));
        ob_Y = length * sin(theta(1));
        
        figure(1)
        hold on
        plot(ob_X,ob_Y,'.');
        
        if t >= time
            velmsg.Linear.X = 0;
            velmsg.Angular.Z = 0;
            send(robot,velmsg);
            begin = 2;
        else
            velmsg.Linear.X = 0;
            velmsg.Angular.Z = 0.1;
            send(robot,velmsg);
        end
end

% Finding the maximum door, and according to the angle which I defined as
% its direction, rotating the robot to that direction 
counter = [counter1 counter2 counter3 counter4];
Max = max(counter);
if Max == counter1
    Direction = pi/2;
elseif Max == counter2
    Direction = pi;
elseif Max == counter3
    Direction = 3*pi/2;
else
    Direction = 0;
end

% Rotating the robot to that direction
while begin == 2
 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);
        
        position_X(n) = model.Pose(22,1).Position.X;
        position_Y(n) = model.Pose(22,1).Position.Y;
        n = n+1;
        
    velmsg.Linear.X = 0;
    velmsg.Angular.Z = -0.1;
    send(robot,velmsg);

    pose=receive(odom_subs);
    angle = pose.Pose.Pose.Orientation;
        
    rotation = quat2eul([angle.W angle.X angle.Y angle.Z]);

    if rotation(1) < 0
        rotation(1) = rotation(1) + 2*pi;
    else
        rotation(1) = rotation(1);
    end
    
    if abs(rotation(1)-Direction)<0.01
        begin = 3;
        velmsg.Linear.X = 0;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);
    end
end

velmsg.Linear.X = 0.15;
velmsg.Angular.Z = 0;
send(robot,velmsg);

% This section is used to control the robot to avoid the abstacles through
% the finding biggest door
while begin == 3
 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);
        
        position_X(n) = model.Pose(22,1).Position.X;
        position_Y(n) = model.Pose(22,1).Position.Y;
        n = n+1;
        
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        dis = min(laser_msg.Ranges);
        distance = laser_msg.Ranges;
    
        sum1 = 0;
        for i = (540-400):(540+400)
            if distance(i) == Inf
                distance(i)= 0;   
            else
                distance(i)= distance(i);
            end
            sum1 = sum1 + distance(i);
            length1 = sum1 / 801;
        end

        if length1<=0.009
            begin=4;     
        end
        
    if (dis > 1)
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        dis = min(laser_msg.Ranges);
        % The situation is safe, setting the robot to go straightly
        % set the velocity 
        velmsg.Linear.X = 0.25;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);% send the message
      
    else 
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        range = laser_msg.Ranges;
        dis = min(laser_msg.Ranges);
        
        % The condition is not safe, set the robot to rotate
        
        % Using the for loop to find the minimum distance's number is
        % which lines among the 1080 ridar lines
        for i= 1:1080
          if range(i) == dis
             a = i; % Get the sequence number
           end
        end
        
        % Using the sequence number to judge which range the number belongs
        % to,and depending on the range to judge the angular velocity

       if a>=180 && a<360
            % If the minimum distance feedback comes from the 180 to 360,set
            % the velocity like the following 
                angular_velocity = 0.01;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                
            % Send the message to the robot
                send(robot,velmsg);
        elseif a>=360 && a<720
            % If the minimum distance feedback comes from the 360 to 720,set
            % the velocity like the following 
                angular_velocity = -0.02;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
               
            % Send the message to the robot
                send(robot,velmsg);
        elseif a>=720 && a<900
            % If the minimum distance feedback comes from the 720 to 900,set
            % the velocity like the following 
                angular_velocity = -0.01;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                
            % Send the message to the robot
                send(robot,velmsg);
        else 
            % If the minimum distance feedback comes from the 900 to 1080,set
            % the velocity like the following 
                angular_velocity = 0;
                velocity = 0.15;
                velmsg.Linear.X = velocity;
                velmsg.Angular.Z = angular_velocity;
                
             % Send the message to the robot
                send(robot,velmsg);      
         end
    end
  
end

% Plotting the path figure
figure(2)
plot(position_X, position_Y,'b');

%% Task B:  Using the Kinect Lidar
% The whole idea is same as the Task A; Firstly, make the robot run to the 
% center of the enclosed area; Then, rotating a whole circle and drawing
% the area map. Additionaly, finding the widest door. Finally, running
% through the widest and avoiding the obstacles.

% The different part compared with Task A is that the robot using different
% method running to the center of the enclosed area. The robot first rotate
% to the destinate direction, then control the robot to run along the
% direction line. When the robot almost nearing the goal point, stoping the
% robot.

% Setting the initial position as   
% position:
%       x: 2.4683
%       y: -4.5436
%       z: 0.0
% orientation:
%       x: -0.0029
%       y: -0.0028
%       z: -0.7175
%       w: 0.6965
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
laser = rossubscriber('/kinect_scan');

% Create the message with the right format for the topic
velmsg = rosmessage(robot);
pose = rosmessage(odom_subs);
model = rosmessage(model_subs);
laser_msg = rosmessage(laser);

velmsg.Linear.X = 0;
velmsg.Angular.Z = -0.35;
send(robot,velmsg);

n = 1;
% This section is used to receive the position information from the
% model_state, in order to plot the trajectory figures.
model=receive(model_subs);
        
position_X(n) = model.Pose(22,1).Position.X;
position_Y(n) = model.Pose(22,1).Position.Y;

begin = 4;
tic
while begin == 4
        n = 1;
        % This section is used to receive the position information from the
        % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);
        
        position_X(n) = model.Pose(22,1).Position.X;
        position_Y(n) = model.Pose(22,1).Position.Y;
        
        pose=receive(odom_subs);
        odom_pose_X = pose.Pose.Pose.Position.X;
        odom_pose_Y = pose.Pose.Pose.Position.Y;
        odom_pose_angle = pose.Pose.Pose.Orientation;
        
        odom_pose_theta = quat2eul([odom_pose_angle.W odom_pose_angle.X odom_pose_angle.Y odom_pose_angle.Z]);
        
        if odom_pose_theta(1) <0
            odom_pose_theta(1) = odom_pose_theta(1) +2*pi;
        end
        
        ideal_theta = 3*pi/4;
        time = ideal_theta/0.15;
        t1=toc;
        
        parent_theta = abs(odom_pose_theta(1));
        
        del_theta = abs(parent_theta - ideal_theta);
        if del_theta < 1.4
            begin = 1;
        end
        
        if t1 <= time
            velmsg.Linear.X = 0;
            velmsg.Angular.Z = -0.35;
            send(robot,velmsg); 
        end     

end   
     
velmsg.Linear.X = 0.15;
velmsg.Angular.Z = 0.35;
send(robot,velmsg);

while begin==1
 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);

        n=n+1;
        position_X(n) = model.Pose(22,1).Position.X;
        position_Y(n) = model.Pose(22,1).Position.Y;

        pose=receive(odom_subs);
        odom_pose_X = pose.Pose.Pose.Position.X;
        odom_pose_Y = pose.Pose.Pose.Position.Y;
        odom_pose_angle = pose.Pose.Pose.Orientation;
        
        odom_pose_theta = quat2eul([odom_pose_angle.W odom_pose_angle.X odom_pose_angle.Y odom_pose_angle.Z]);
        
        if odom_pose_theta(1) <0
            odom_pose_theta(1) = abs(odom_pose_theta(1));
        end
        odom_pose_X = abs(odom_pose_X);
        odom_pose_Y = abs(odom_pose_Y);
        
        del_x = abs(odom_pose_X-3);
        del_y = abs(odom_pose_Y-3);

        if del_x<0.7 || del_y<0.7
            velmsg.Linear.X = 0;
            velmsg.Angular.Z = 0;
            send(robot,velmsg);
            begin = 0;
        end
        
        odom_pose_theta(1);
        ideal_theta =3*pi/4;
        
        if odom_pose_theta(1) < ideal_theta
            velmsg.Linear.X = 0.15;
            velmsg.Angular.Z = -0.15;
            send(robot,velmsg);
        elseif odom_pose_theta(1) > ideal_theta
            velmsg.Linear.X = 0.15;
            velmsg.Angular.Z = 0.15;
            send(robot,velmsg);
        else
            velmsg.Linear.X = 0.15;
            velmsg.Angular.Z = 0;
            send(robot,velmsg);
        end
        
end

tic 
time = 2*pi/0.1 +5;
t1 = pi/2/0.1;
t2 = pi/0.1;
t3 = 3*pi/2/0.1;

counter1 = 0;
counter2 = 0;
counter3 = 0;
counter4 = 0;

while begin == 0

 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);
        
        position_X(n) = model.Pose(22,1).Position.X;
        position_Y(n) = model.Pose(22,1).Position.Y;
        n=n+1; 
        
        t = toc;
        
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        range = laser_msg.Ranges;
        
        length = range(540);
        
        if t<t1
             if length == Inf
                counter1 = counter1 + 1;
            end
        elseif t>=t1 && t<t2
            if length == Inf
                counter2 = counter2 + 1;
            end
        elseif t>=t2 && t<=t3
            if length == Inf
                counter3 = counter3 + 1;
            end
        elseif t>=t3 && t<time
            if length == Inf || length <3
                counter4 = counter4 + 1;
            end
        end
        
        model=receive(model_subs);
        quat = model.Pose(22,1).Orientation;
        
        theta = quat2eul([quat.W quat.X quat.Y quat.Z]);
        ob_X = length * cos(theta(1));
        ob_Y = length * sin(theta(1));
        
        figure(1)
        hold on
        plot(ob_X,ob_Y,'.');
        
        if t >= time
            velmsg.Linear.X = 0;
            velmsg.Angular.Z = 0;
            send(robot,velmsg);
            begin = 2;
        else
            velmsg.Linear.X = 0;
            velmsg.Angular.Z = 0.1;
            send(robot,velmsg);
        end
end

counter = [counter1 counter2 counter3 counter4];
Max = max(counter);
if Max == counter1
    Direction = 3*pi/2;
elseif Max == counter2
    Direction = 0;
elseif Max == counter3
    Direction = pi/2;
else
    Direction = pi;
end

while begin == 2
 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);
        
        position_X(n) = model.Pose(22,1).Position.X;
        position_Y(n) = model.Pose(22,1).Position.Y;
        n = n+1;
        
    velmsg.Linear.X = 0;
    velmsg.Angular.Z = -0.1;
    send(robot,velmsg);

    pose=receive(odom_subs);
    angle = pose.Pose.Pose.Orientation;
        
    rotation = quat2eul([angle.W angle.X angle.Y angle.Z]);

    if rotation(1) < 0
        rotation(1) = abs(rotation(1)) ;
    else
        rotation(1) = rotation(1);
    end
    
    if abs(rotation(1)-Direction)<0.01
        begin = 3;
        velmsg.Linear.X = 0;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);
    end
end

velmsg.Linear.X = 0.15;
velmsg.Angular.Z = 0;
send(robot,velmsg);


while begin == 3
 % This section is used to receive the position information from the
 % model_state, in order to plot the trajectory figures.
        model=receive(model_subs);
        
        position_X(n) = model.Pose(22,1).Position.X;
        position_Y(n) = model.Pose(22,1).Position.Y;
        n = n+1;
        
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        dis = min(laser_msg.Ranges);
        distance = laser_msg.Ranges;
    
        sum1 = 0;
        for i = (320-300):(320+300)
            y1 = isnan(distance(i));
            if y1 == 1
                distance(i)= 0;   
            else
                distance(i)= distance(i);
            end
            sum1 = sum1 + distance(i);
            length1 = sum1 / 601;
        end

        if length1<=0.009
            begin=4;     
        end
        
    if (dis > 1)
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        dis = min(laser_msg.Ranges);
        % The situation is safe, setting the robot to go straightly
        % set the velocity 
        velmsg.Linear.X = 0.25;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);% send the message
      
    else 
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        range = laser_msg.Ranges;
        dis = min(laser_msg.Ranges);
        
        % The condition is not safe, set the robot to rotate
        
        % Using the for loop to find the minimum distance's number is
        % which lines among the 1080 ridar lines
        for i= 1:640
          if range(i) == dis
             a = i; % Get the sequence number
           end
        end
        
        % Using the sequence number to judge which range the number belongs
        % to,and depending on the range to judge the angular velocity
        if a>=1 && a<320
            % If the minimum distance feedback comes from the 1 to 180,set
            % the velocity like the following 
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = 0.25;
                
            % Send the message to the robot
                send(robot,velmsg);
        else
            % If the minimum distance feedback comes from the 360 to 720,set
            % the velocity like the following 
                velmsg.Linear.X = 0.15;
                velmsg.Angular.Z = -0.25;
               
            % Send the message to the robot
                send(robot,velmsg);
   
        end
    end
  
end

figure(2)
plot(position_X, position_Y,'b');


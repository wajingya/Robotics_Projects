%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AMR homework5
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
% reset the position 

model_subs=rossubscriber('/gazebo/model_states');

robot = rospublisher('/mobile_base/commands/velocity'); 
% Create a publisher

velmsg= rosmessage(robot);
% Create a message with the right format to the topic

odom_subs = rossubscriber('/odom');
%build a "odom" topic

tic
velmsg.Linear.X= 0.65;
velmsg.Angular.Z = 0;
send(robot,velmsg);

distance2 = 0;
i = 1;
a = 1;
while(a==1) 
    
    model = receive(model_subs);
    robot_modelstate_position = model.Pose(2,1).Position;
    robot_modelstate_angle = model.Pose(2,1).Orientation;
    X_I(1,i) = robot_modelstate_position.X;
    Y_I(1,i) = robot_modelstate_position.Y;
    % receive from the model_state 

    r_ms_W(1,i) = robot_modelstate_angle.W;
    r_ms_X(1,i) = robot_modelstate_angle.X;
    r_ms_Y(1,i) = robot_modelstate_angle.Y;
    r_ms_Z(1,i) = robot_modelstate_angle.Z;

    R_modelstate_angle = quat2eul([r_ms_W(1,i) r_ms_X(1,i) r_ms_Y(1,i) r_ms_Z(1,i)]);
    
    if R_modelstate_angle(1)<0
        current_theta = R_modelstate_angle(1,1)+2*pi;
    else
        current_theta = R_modelstate_angle(1,1);
    end
      
    theta = pi+atan((Y_I(1,i)-1)/(X_I(1,i)-6));
    
    distance1 = sqrt((X_I(1,i)-6)^2 + (Y_I(1,i)-1)^2);
    
    if  abs(current_theta-theta)>0.1
        axis equal
        hold on
        plot(X_I(1,i),Y_I(1,i),'.');
        diff_angle=(current_theta-theta);
        ka = change_velocity(diff_angle);
        velmsg.Angular.Z=ka*pi;
        velmsg.Linear.X= 0.5;
        v(1,i) = 0.5;
        send(robot,velmsg);
    
    else
      if distance1 <= 0.5
        stem(X_I(1,i),Y_I(1,i),'ro','MarkerSize',10);    
        a = 2;
      end
        axis equal
        hold on
        plot(X_I(1,i),Y_I(1,i),'.');
        

        pose = receive(odom_subs);
        robot_odm_position=pose.Pose.Pose.Position;
        %get the position that the robot begining
        robot_odm_angle=pose.Pose.Pose.Orientation;
        %get begin orientation to caculate the initial direction
        X_R(1,i) = robot_odm_position.X;
        Y_R(1,i) = robot_odm_position.Y;
        
        distance2 = sqrt((X_R(1,i)-X_R(1,i-1))^2 + (Y_R(1,i)-Y_R(1,i-1))^2)+distance2;
        fprintf(" The distance is %f\n:",distance2); 
        
        k = change_velocity1(distance1);
        velmsg.Linear.X= k*0.65;
        velmsg.Angular.Z = 0;
        v(1,i) = k*0.65;
        send(robot,velmsg);
    end 
    i = i+1;
end

b = 1;
while(b==1) 
    
    model = receive(model_subs);
    robot_modelstate_position = model.Pose(2,1).Position;
    robot_modelstate_angle = model.Pose(2,1).Orientation;
    X_I(1,i) = robot_modelstate_position.X;
    Y_I(1,i) = robot_modelstate_position.Y;
    % receive from the model_state 

    r_ms_W(1,i) = robot_modelstate_angle.W;
    r_ms_X(1,i) = robot_modelstate_angle.X;
    r_ms_Y(1,i) = robot_modelstate_angle.Y;
    r_ms_Z(1,i) = robot_modelstate_angle.Z;

    R_modelstate_angle = quat2eul([r_ms_W(1,i) r_ms_X(1,i) r_ms_Y(1,i) r_ms_Z(1,i)]);
    
    if R_modelstate_angle(1)<0
        current_theta = R_modelstate_angle(1,1)+2*pi;
    else
        current_theta = R_modelstate_angle(1,1);
    end
      
    theta = pi+atan((Y_I(1,i)-9)/(X_I(1,i)-1));
    
    distance1 = sqrt((X_I(1,i)-1)^2 + (Y_I(1,i)-9)^2);
    
    if  abs(current_theta-theta)>0.1
        axis equal
        hold on
        plot(X_I(1,i),Y_I(1,i),'.');
        diff_angle=(current_theta-theta);
        ka = change_velocity2(diff_angle);
        velmsg.Angular.Z=ka*pi;
        velmsg.Linear.X= 0.5;
        v(1,i) = 0.5;
        send(robot,velmsg);
    
    else
      if distance1 <= 0.5
        stem(X_I(1,i),Y_I(1,i),'ro','MarkerSize',10);    
        velmsg.Angular.Z = 0;
        velmsg.Linear.X= 0;
        v(1,i) = k*0.65;
        send(robot,velmsg);
        b = 2;
        end
        axis equal
        hold on
        plot(X_I(1,i),Y_I(1,i),'.');
        

        pose = receive(odom_subs);
        robot_odm_position=pose.Pose.Pose.Position;
        %get the position that the robot begining
        robot_odm_angle=pose.Pose.Pose.Orientation;
        %get begin orientation to caculate the initial direction
        X_R(1,i) = robot_odm_position.X;
        Y_R(1,i) = robot_odm_position.Y;
        
        distance2 = sqrt((X_R(1,i)-X_R(1,i-1))^2 + (Y_R(1,i)-Y_R(1,i-1))^2)+distance2;
        fprintf(" The distance is %f\n:",distance2); 
        
        k = change_velocity4(distance1);
        velmsg.Linear.X= k*0.65;
        velmsg.Angular.Z = 0;
        v(1,i) = k*0.65;
        send(robot,velmsg);
    end 
    i = i+1;
end
toc

figure
plot(v);



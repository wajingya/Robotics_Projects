clc
clear all
rosshutdown;
ipad='localhost';%get the address
rosinit(ipad);   %initialise
reset_odom=rospublisher('/mobile_base/commands/reset_odometry');%%reset Odometry
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);
robot=rospublisher('/mobile_base/commands/velocity');%build a velocity topic
velmsg=rosmessage(robot);%build a message about topic "rotob"
odom_subs = rossubscriber('/odom');%build a "odom" topic
pose = receive(odom_subs);%buid a message
robot_position_begin=pose.Pose.Pose.Position;%get the position that the robot begining
robot_angle=pose.Pose.Pose.Orientation;%get begin orientation to caculate the initial direction
angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);%caculate initial trend direction
hold on
t_begin=rostime('now');% the time begin to record
while 1 %the first "while" loop is used to run the longest edge
    pose =receive(odom_subs);%get the latest data
    robot_position=pose.Pose.Pose.Position;%position data that the beginning 
    robot_angle=pose.Pose.Pose.Orientation;%orientation data for caculate angle
    angle_change=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);%caculate angle
    distance=sqrt(5^2-2.5^2)*2;%the length of the longest edge
    if sqrt((robot_position_begin.X-robot_position.X)^2+(robot_position_begin.Y-robot_position.Y)^2) >= distance
        %caculate to get the distance that robot have run and judge if reach the aim distance
        velmsg.Linear.X=0;
        velmsg.Angular.Z=0;
        send(robot,velmsg); 
        break %if reach the aim stop the "while" loop
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if angle_begin==angle_change                       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    velmsg.Linear.X=0.3;                               %%%
    velmsg.Angular.Z=0;                                %%%  
    else                                               %%% adjust the routine to a
        if (angle_begin(1)>=0)&&(angle_change(1)>=0)   %%% straight line
            if angle_begin(1) > angle_change(1)        %%%
                 velmsg.Linear.X=0.3;                  %%% if the direction in operation if
                 velmsg.Angular.Z=0.05;                %%% different from the initial direction
            else                                       %%% add a tempary angular to fix it
                 velmsg.Linear.X=0.3;                  %%%
                 velmsg.Angular.Z=-0.05;               %%%
            end                                        %%% consider the data that
        elseif(angle_begin(1)>=0)&&(angle_change(1)<=0)%%% Positive and negative sign change
                 velmsg.Linear.X=0.3;                  %%%
                 velmsg.Angular.Z=-0.05;               %%%
        elseif(angle_begin(1)<=0)&&(angle_change(1)>=0)%%%
                 velmsg.Linear.X=0.3;                  %%%
                 velmsg.Angular.Z=-0.05;               %%%
        elseif(angle_begin(1)<=0)&&(angle_change(1)<=0)%%%
            if angle_begin(1) > angle_change(1)        %%%
                 velmsg.Linear.X=0.3;                  %%%
                 velmsg.Angular.Z=0.05;                %%%
            else                                       %%%
                 velmsg.Linear.X=0.3;                  %%%
                 velmsg.Angular.Z=-0.05;               %%%
            end                                        %%%
        end                                            %%%
    end                                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    send(robot,velmsg); %plot a figure to show the robot rout
    plot(robot_position.X,robot_position.Y,'.')
    drawnow
    axis equal
end
 pose = receive(odom_subs);%get the latest data
 robot_angle=pose.Pose.Pose.Orientation;%get orientation to caculate initial direction
 angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);%caculate initial direction
while 1
    pose = receive(odom_subs);%get the lastest data
    robot_angle=pose.Pose.Pose.Orientation;%get orientation to caculat initial ditrection
    angle_change=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);%caculat initial direction
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (angle_begin(1)>=0)&&(angle_change(1)>=0)           %%%
        angle=abs(angle_begin(1)-angle_change(1));         %%% this part is for turn around
    elseif(angle_begin(1)>=0)&&(angle_change(1)<=0)        %%% i use consider all the situation
        angle=(3.14-angle_begin(1))+(3.14+angle_change(1));%%% to deal with the problom of 
    elseif(angle_begin(1)<=0)&&(angle_change(1)>=0)        %%% positive and negative sign change
        angle=-angle_begin(1)+angle_change(1);             %%%
    elseif(angle_begin(1)<=0)&&(angle_change(1)<=0)        %%%
        angle=angle_change(1)-angle_begin(1);              %%%
    end                                                    %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    aim_angle=150; %the aim angle
    if angle >= ((aim_angle/360)*2*pi)%judge whether reach the aim angle
       velmsg.Linear.X=0;
       velmsg.Angular.Z=0;
       send(robot,velmsg); 
       break %if get the aim angle, stop "while" loop
    end
       velmsg.Linear.X=0;
       velmsg.Angular.Z=0.2;
       send(robot,velmsg);      
end
%%%%%%%%%%%%%% The below code is repaeting the above process, so not comment later%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pose = receive(odom_subs);
robot_position_begin=pose.Pose.Pose.Position;
robot_angle=pose.Pose.Pose.Orientation;
angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
while 1
    pose =receive(odom_subs);
    robot_position=pose.Pose.Pose.Position;
    robot_angle=pose.Pose.Pose.Orientation;
    angle_change=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
    distance=5;
    if sqrt((robot_position_begin.X-robot_position.X)^2+(robot_position_begin.Y-robot_position.Y)^2) >= distance
        velmsg.Linear.X=0;
        velmsg.Angular.Z=0;
        send(robot,velmsg); 
        break
    end
    if angle_begin==angle_change
    velmsg.Linear.X=0.3;
    velmsg.Angular.Z=0;
    else
        if (angle_begin(1)>=0)&&(angle_change(1)>=0)
            if angle_begin(1) > angle_change(1)
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=0.05;
            else
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=-0.05;
            end
        elseif(angle_begin(1)>=0)&&(angle_change(1)<=0)
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=-0.05;
        elseif(angle_begin(1)<=0)&&(angle_change(1)>=0)
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=-0.05;
        elseif(angle_begin(1)<=0)&&(angle_change(1)<=0)
            if angle_begin(1) > angle_change(1)
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=0.05;
            else
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=-0.05;
            end
         end
    end
    send(robot,velmsg); 
    plot(robot_position.X,robot_position.Y,'.')
    drawnow
     axis equal
end
 pose = receive(odom_subs);
 robot_angle=pose.Pose.Pose.Orientation;
 angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
while 1
    pose = receive(odom_subs);
    robot_angle=pose.Pose.Pose.Orientation;
    angle_change=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
    if (angle_begin(1)>=0)&&(angle_change(1)>=0)
        angle=abs(angle_begin(1)-angle_change(1));
    elseif(angle_begin(1)>=0)&&(angle_change(1)<=0)
        angle=(3.14-angle_begin(1))+(3.14+angle_change(1));
    elseif(angle_begin(1)<=0)&&(angle_change(1)>=0)
        angle=-angle_begin(1)+angle_change(1);
    elseif(angle_begin(1)<=0)&&(angle_change(1)<=0)
        angle=angle_change(1)-angle_begin(1);
    end
    aim_angle=60;
    if angle >= ((aim_angle/360)*2*pi)
       velmsg.Linear.X=0;
       velmsg.Angular.Z=0;
       send(robot,velmsg); 
       break
    end
       velmsg.Linear.X=0;
       velmsg.Angular.Z=0.1;
       send(robot,velmsg);      
end
pose = receive(odom_subs);
robot_position_begin=pose.Pose.Pose.Position;
robot_angle=pose.Pose.Pose.Orientation;
angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
while 1
    pose =receive(odom_subs);
    robot_position=pose.Pose.Pose.Position;
    robot_angle=pose.Pose.Pose.Orientation;
    angle_change=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
    distance=5;
    if sqrt((robot_position_begin.X-robot_position.X)^2+(robot_position_begin.Y-robot_position.Y)^2) >= distance
        velmsg.Linear.X=0;
        velmsg.Angular.Z=0;
        send(robot,velmsg); 
        break
    end
    if angle_begin==angle_change
    velmsg.Linear.X=0.3;
    velmsg.Angular.Z=0;
    else
        if (angle_begin(1)>=0)&&(angle_change(1)>=0)
            if angle_begin(1) > angle_change(1)
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=0.05;
            else
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=-0.05;
            end
        elseif(angle_begin(1)>=0)&&(angle_change(1)<=0)
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=-0.05;
        elseif(angle_begin(1)<=0)&&(angle_change(1)>=0)
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=-0.05;
        elseif(angle_begin(1)<=0)&&(angle_change(1)<=0)
            if angle_begin(1) > angle_change(1)
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=0.05;
            else
                 velmsg.Linear.X=0.3;
                 velmsg.Angular.Z=-0.05;
            end
         end
    end
    send(robot,velmsg); 
    plot(robot_position.X,robot_position.Y,'.')
    drawnow
    axis equal
end
t_finish=rostime('now');
time = t_finish-t_begin;
fprintf(" The running time is %d:",time); 
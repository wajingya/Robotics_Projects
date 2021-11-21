
% Because the logic and algrithm are both same as the second method, so
% this method will not be commented. The only different is that this method is that
% we receive the data from the 'model state topic'.

clc
clear all
rosshutdown;
ipad='localhost';%get the address
rosinit(ipad);   %initialise

reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

robot=rospublisher('/mobile_base/commands/velocity');%build a velocity topic
velmsg=rosmessage(robot);%build a message about topic "rotob"
model_subs=rossubscriber('/gazebo/model_states');
model = receive(model_subs);
robot_position_begin=model.Pose(2,1).Position;
robot_angle=model.Pose(2,1).Orientation;
angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
hold on
t_begin=rostime('now');
while 1
    model=receive(model_subs);
    robot_position=model.Pose(2,1).Position;
    robot_angle=model.Pose(2,1).Orientation;
    angle_change=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
    distance=sqrt(5^2-2.5^2)*2;
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
 model = receive(model_subs);
 robot_angle=model.Pose(2,1).Orientation;
 angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
while 1
    model = receive(model_subs);
    robot_angle=model.Pose(2,1).Orientation;
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
    aim_angle=150;
    if angle >= ((aim_angle/360)*2*pi)
       velmsg.Linear.X=0;
       velmsg.Angular.Z=0;
       send(robot,velmsg); 
       break
    end
       velmsg.Linear.X=0;
       velmsg.Angular.Z=0.2;
       send(robot,velmsg);      
end
model = receive(model_subs);
robot_position_begin=model.Pose(2,1).Position;
robot_angle=model.Pose(2,1).Orientation;
angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
while 1
    model=receive(model_subs);
    robot_position=model.Pose(2,1).Position;
    robot_angle=model.Pose(2,1).Orientation;
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
model = receive(model_subs);
 robot_angle=model.Pose(2,1).Orientation;
 angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
while 1
    model = receive(model_subs);
    robot_angle=model.Pose(2,1).Orientation;
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
       velmsg.Angular.Z=0.2;
       send(robot,velmsg);      
end
model = receive(model_subs);
robot_position_begin=model.Pose(2,1).Position;
robot_angle=model.Pose(2,1).Orientation;
angle_begin=quat2eul([robot_angle.W robot_angle.X robot_angle.Y robot_angle.Z]);
while 1
    model=receive(model_subs);
    robot_position=model.Pose(2,1).Position;
    robot_angle=model.Pose(2,1).Orientation;
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
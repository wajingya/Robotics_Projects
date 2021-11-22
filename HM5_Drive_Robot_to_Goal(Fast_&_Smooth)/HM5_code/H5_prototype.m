clc
clear all
rosshutdown;
ipaddress='localhost';
rosinit(ipaddress);
robot_speed = rospublisher('/mobile_base/commands/velocity');
speed= rosmessage(robot_speed);
robot_state=rossubscriber('/gazebo/model_states');
global controller; controller=1;
while controller<=2
    state=receive(robot_state);
    position=state.Pose(2,1).Position;
    angle=state.Pose(2,1).Orientation;
    angle_robot=quat2eul([angle.W angle.X angle.Y angle.Z]);
    if angle_robot(1)<0
       angle_robot(1)=angle_robot(1)+2*pi;
    end
    if controller==1
        aim=[6 1];
    else
        aim=[1 9];
    end
    angle_aim=function_angle_caculate(position.X,position.Y,aim(1),aim(2));
    [forwardVelocity,angularVelocity]=function_speed_angle_change(angle_aim,angle_robot(1),aim(1),aim(2),position.X,position.Y);
    speed.Linear.X=forwardVelocity;
    speed.Angular.Z=angularVelocity;
    send(robot_speed,speed);
end
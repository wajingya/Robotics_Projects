function [speed,angle] = function_speed_angle_change(angle_aim,angle_robot,aim_x,aim_y,postion_x,postion_y)
global controller;
if sqrt((aim_x-postion_x)^2+(aim_y-postion_y)^2)>2
    speed=1;
    if abs(angle_aim-angle_robot)>0.5
           if angle_aim>angle_robot
              angle=0.5;
           else
              angle=-0.5;
           end
    elseif abs(angle_aim-angle_robot)<0.01
        angle=0;
    else
        if angle_aim>angle_robot
            angle=0.05;
        else
            angle=-0.05;
        end      
    end
else
    speed=0.5;
    if abs(angle_aim-angle_robot)>0.5
           if angle_aim>angle_robot
              angle=0.2;
           else
              angle=-0.2;
           end
    elseif abs(angle_aim-angle_robot)<0.01
        angle=0;
    else
        if angle_aim>angle_robot
            angle=0.05;
        else
            angle=-0.05;
        end      
    end   
end
if sqrt((aim_x-postion_x)^2+(aim_y-postion_y)^2)<=0.5
    speed=0;
    angle=0;
    controller=controller+1;
end
end


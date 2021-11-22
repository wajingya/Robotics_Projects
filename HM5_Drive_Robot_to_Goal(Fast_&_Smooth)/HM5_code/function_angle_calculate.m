function [angle] = function_angle_calculate(robot_x,robot_y,aim_x,aim_y)
if(aim_x>=robot_x)&&(aim_y>=robot_y)
    angle=atan((aim_y-robot_y)/(aim_x-robot_x));
elseif(aim_x<=robot_x)&&(aim_y>=robot_y)
    angle=pi-atan((aim_y-robot_y)/(robot_x-aim_x));
elseif(aim_x<=robot_x)&&(aim_y<=robot_y)
    angle=pi+atan((robot_y-aim_y)/(robot_x-aim_x));
elseif(aim_x>=robot_x)&&(aim_y<=robot_y)
    angle=2*pi-atan((robot_y-aim_y)/(aim_x-robot_x));
end


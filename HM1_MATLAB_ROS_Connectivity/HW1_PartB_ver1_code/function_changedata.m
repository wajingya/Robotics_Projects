function [] = function_changedata(input1)
global linear_velocity;  %use global to change the data 
global angular_velocity; %use global to change the data 
global m;
    if input1<200     %first part to move as a part of circle
linear_velocity=0.5;
angular_velocity=0.06;
    end
    if input1>200     %second part to move as a part of circle
linear_velocity=0.25;
angular_velocity=0.3; 
    end
    if input1>316     %third part to move as a line
linear_velocity=0.5;
angular_velocity=0;
    end
    if input1>510     %fourth part to move as a part of circle
linear_velocity=0.5;
angular_velocity=-0.14;
    end
    if input1>550     %fiveth part to move as a part of circle
linear_velocity=0.25;
angular_velocity=-0.3;
    end
    if input1>680     %sixth part to move as a line
linear_velocity=0.5;
angular_velocity=0;
    end
    if input1>730     %seventh part to move as a part of circle
linear_velocity=0.5;
angular_velocity=0.14;
    end
    if input1>860     %stop the "while" loop and finish the program
        m=0;
    end
end


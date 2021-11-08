function [output_k] = change_velocity1 (input_distance)
%Using the distance to adjust the velocity

if input_distance <=0.5
    output_k = 0;
elseif input_distance <= 2.54 && input_distance > 0.5
    output_k = 0.2;
elseif input_distance <= 5.08 && input_distance > 2.54
    output_k = 0.5;
else
    output_k = 1;
end
end


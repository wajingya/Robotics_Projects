function [output_k] = change_velocity4 (input_distance)
%Using the distance to adjust the velocity

if input_distance <=0.5
    output_k = 0;
elseif input_distance <= 3.1447 && input_distance > 0.5
    output_k = 0.2;
elseif input_distance <= 6.29 && input_distance > 3.1447
    output_k = 0.5;
else
    output_k = 1;
end
end


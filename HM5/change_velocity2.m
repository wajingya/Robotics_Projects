function [k_output] = change_velocity2(inputAngle)
%using the function to adjust the angualar velocity

if inputAngle > 0
        k_output=-0.2;
elseif inputAngle < 0
        k_output = 0.2;
else
    k_output=0;
end
end


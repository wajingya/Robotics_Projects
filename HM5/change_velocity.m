function [k_output] = change_velocity(inputangle)
%using the function to adjust the angualar velocity

if inputangle > 0
        k_output=-0.2;
elseif inputangle < 0
        k_output = 0.2;
else
    k_output=0;
end
end


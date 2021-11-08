function [radius] = Radiusfunction()
%creat the radius matrix over there

scales = zeros(1,5);

for i = 1:1:5           %judge if the number of scales are all in 0 to 1
    a = rand(1); 
    if a>0 && a<1
        scales(1,i) = a;
    else 
        a = rand(1);
    end
end

radius = 4*scales; % radius matrix
end


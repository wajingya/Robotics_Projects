function [center] = Centerfuntion()
%create the center matrix over there
center = zeros(5,2);

center(1,1) = 0; % assume circle blue x=0;
center(1,2) = 6; % assume circle blue y=6;

center(2,1) = 6; % assume circle black x=6;
center(2,2) = 6; % assume circle black y=6;

center(3,1) = 12; % assume circle red x=12;
center(3,2) = 6; % assume circle red y=6;

center(4,1) = 3; % assume circle yellow x=3;
center(4,2) = 2; % assume circle yellow y=2;

center(5,1) = 9; % assume circle green x=9;
center(5,2) = 2; % assume circle green y=2;

end


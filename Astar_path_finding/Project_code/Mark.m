function [map] = Mark (close_list_num)
% Function:Mark the path on the map
% Input: close_list_num:the value number in the close list
% Output: The final map

n=close_list_num;

% Call the Closelist and map in the workspace
Closelist=evalin('base','Closelist');
map=evalin('base','Map');

% Closelist=assignin('base','Closelist');
for i=1:n
    cell_x=Closelist(i,1);
    cell_y=Closelist(i,2);
    
    map(cell_x,cell_y)=0.5;
    
    figure(1);
    pcolor(map)

    colormap summer
    
    drawnow
    pause(0.2)
end


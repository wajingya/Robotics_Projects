function [x] = function_plot(input1,input2,input3)%%plot one circle when excute this function
z=0:0.01:2*pi; 
x=input1(input3,1)+input2(input3)*cos(z);
y=input1(input3,2)+input2(input3)*sin(z);
plot(x,y,'.')%%plot circle
drawnow%%this code to show the figure  when procedure running;
hold on
end


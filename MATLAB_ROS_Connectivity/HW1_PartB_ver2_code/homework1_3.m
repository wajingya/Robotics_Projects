% Homework1
% Homework introduction: Homework1 plot a shape which like letter L;
clear all
clc

%this section code is to initialize ROS[1]
 rosshutdown  
 ipad='localhost';
 rosinit(ipad);
 
%create a publisher to the velocity topic[2]
 robot = rospublisher('/mobile_base/commands/velocity');
 
%create a message with the right format to the topic[2]
 velmsg = rosmessage(robot);
 
 %Assume the first function,which is a circle with (0,0) center and radius is 1
 center_Point = [0,0]; 
 radius = 1;
 
 %assume every step's {\delta x}=1
 mx = 1;

 %begin to record the time
 tic
 
 %The for loop is used to output the first section, and its caculate
 %equation is in calculatevelocity1 function file.
 for x1 = 0:0.001:0.393
    % input every x1 and calculate the slope of each point's differential
    % line segment  
    k1=calculatevelocity1(x1);  
    
    %calculate the each step {\delta x}
    my1 = mx*k1;
    
    %linear_velocity=\sqrt{\delta x^2+\delta y^2}
    linear_velocity1 = sqrt(my1^2+mx);
    
    %Attribute the desired values to the message[3]
    velmsg.Linear.X =mx;
    
    % because the verialble of message only want numberic value, otherwise it will say error happened
    % I will explain in the report detailed
    z11 = double(linear_velocity1);   %So I change the data type there
    %Attribute the desired values to the message[3]
    velmsg.Linear.Y =z11;
    
    %calculate the angle of each point's differential line segment  
    angular1 = atan(k1);
    %The reason is same as above, so change the data type
    z12=double(angular1);
    %Attribute the desired values to the message[3]
    velmsg.Angular.Z= z12;
    
    %publish the message
    send(robot,velmsg);
    
 end
 

 for x2 = 0.02:0.001:1
    % input every x2 and calculate the slope of each point's differential
    % line segment 
    k2 = calculatevelocity2(x2);
    
    %calculate the each step {\delta x}
    my2 = mx*k2;
    
    %linear_velocity=\sqrt{\delta x^2+\delta y^2}
    linear_velocity2 = sqrt(my2^2+mx^2);
    
    %Attribute the desired values to the message[3]
    velmsg.Linear.X = mx;
    %The same reason,change the data type there
    z21 = double(linear_velocity2);
    %Attribute the desired values to the message[3]
    velmsg.Linear.Y =z21;
    
    %The same reason,change the data type there
    angular2 = atan(k2);
    %Attribute the desired values to the message[3]
    z22=double(angular2);

    %Because sometimes the z22 is negative ,so angule result is not we
    %want( explain detailed in the report) , so we change the z22 value to positive and
    %then calculate the angle is want we want. Sometimes, we want z22
    %negative value ,but it is positive, so we shold also change it to
    %negative
    % The most important is: what's the range should we change the positive
    % to negative
    
    if z22 <0.5&&z22 >-0.5   %range of x2 is though we observe(explain detailed in the report)
        if x2 >=0.35  %range of x2 is though we observe(explain detailed in the report)
        velmsg.Angular.Z= -z22; %change the value into positive
        else
        %if not in the range, stay the positive z22 in initial value,and
        %change the negative one to positive
        velmsg.Angular.Z= abs(z22); 
        end
    else
        % In some cases, the angular velocity is very big, so we proportional reduce the value,
        if x2 >=0.35 
        % The coefficient is also determined by observe(explain detailed in
        % the report)
        velmsg.Angular.Z= -0.15*z22; %change the value into positive
        else
        %if not in the range, stay the positive z22 in initial value,and
        %change the negative one to positive
        velmsg.Angular.Z= abs(0.15*z22); 
        end
    end
    
    %publish the message[4]
    send(robot,velmsg);
 end
 
 %all the comments is same as the second part
 for x3 = 0.002:0.001:0.4
    k3 = calculatevelocity3(x3);
    
    my3 = mx*k3;

    linear_velocity3 = sqrt(my3^2+mx^2);
    
    velmsg.Linear.X = mx;
    
    z31 = double(linear_velocity3);
    velmsg.Linear.Y =z31;
    
    angular3 = atan(k3);
    z32=double(angular3);
    if z32 <0.5&&z32 >-0.5
        if x3 >=0.378
        velmsg.Angular.Z= -z32;
        else
        velmsg.Angular.Z= abs(z32);
        end
    else
        if x3 >=0.378
        velmsg.Angular.Z= -0.1*z32;
        else
        velmsg.Angular.Z= abs(0.1*z32); 
        end
    end
    send(robot,velmsg);
 end

 %Finished the recording of time and publish the time value
s = toc;
fprintf('The total time is %d s',s);


%%reference :  
% [1] Juliana Vilela, AMR Sections_Matlab+ ROSBasic Concepts, page 11
% [2] Juliana Vilela, AMR Sections_Matlab+ ROSBasic Concepts, page 12
% [3] Juliana Vilela, AMR Sections_Matlab+ ROSBasic Concepts, page 13
% [4] Juliana Vilela, AMR Sections_Matlab+ ROSBasic Concepts, page 13
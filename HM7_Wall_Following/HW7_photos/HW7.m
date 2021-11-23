clear all
close all
% rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, pose: { position: {x: 6, y: 7 , z: 0 }, orientation: { x: 0, y: 0 , z: 1, w: 0 } }, twist: { linear: {x: 0 , y: 0 , z: 0 } , angular: {x: 0 , y: 0 , z: 0 } } , reference_frame: world }}'

rosshutdown;%shut down the executing ros
%Initialize ROS
ipaddress='localhost';
rosinit(ipaddress);

%Reset Odometry
reset_odom=rospublisher('/mobile_base/commands/reset_odometry');
reset_msg=rosmessage(reset_odom);
send(reset_odom,reset_msg);

%create the publishers and subscribers
robot = rospublisher('/mobile_base/commands/velocity');
odom_subs = rossubscriber('/odom');
model_subs=rossubscriber('/gazebo/model_states');
laser=rossubscriber('/laserscan');

%create the message with the right format for the topic
velmsg = rosmessage(robot);
pose = rosmessage(odom_subs);
model=rosmessage(model_subs);
laser_msg=rosmessage(laser);

begin = 1;
while begin == 1
velmsg.Linear.X = 0.5;
velmsg.Angular.Z = 0.35;
send(robot,velmsg);

laser_msg=receive(laser);
laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
dis = min(laser_msg.Ranges);
distance = laser_msg.Ranges;

if dis<=3
    m=1;
    begin = 2;
end
end

index_incre = 270/1080;
index1 = 90/index_incre + 540;   

while m==1
    laser_msg=receive(laser);
    laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
    distance = laser_msg.Ranges;
     
    sum1 = 0;
for i = (index1-5):(index1+5)
    
    sum1=double(sum1);
    sum1 = sum1 + distance(i);
    length = sum1 / 11;
    length = double(length);
end
    
   if length>2
        velmsg.Linear.X = 0.2;
        velmsg.Angular.Z = -0.25;
        send(robot,velmsg);
   else
        velmsg.Linear.X = 0.2;
        velmsg.Angular.Z = 0;
        send(robot,velmsg);
        m=2;
   end

end


while m==2
        laser_msg=receive(laser);
        laser_msg.Ranges(laser_msg.Ranges==-Inf)=Inf;
        distance = laser_msg.Ranges;
        
        sum = 0;
        for i = (540-5):(540+5)
            sum = sum + distance(i);
            length1 = sum / 11;
        end
        
        if length1>2
            1
            sum2 = 0;
            for i = (index1-5):(index1+5)
                 sum2 = sum2 + distance(i);
                 length = sum2 / 11;
             end
        
%         theta = abs(a-540)*index_incre;
%         x = distance(a)*cos(theta);
%         y = distance(a)*sin(theta);

            if length == 1.5
                 velmsg.Linear.X = 0.2;
                 velmsg.Angular.Z = 0;
                 send(robot,velmsg);
            else
                if length<1.5
                    velmsg.Linear.X = 0.2;
                    velmsg.Angular.Z = -0.15;
                    send(robot,velmsg);
                else
                    velmsg.Linear.X = 0.2;
                    velmsg.Angular.Z = 0.15;
                    send(robot,velmsg);  
                end
            end 
        else
             velmsg.Linear.X = 0.2;
             velmsg.Angular.Z = -0.35;
             send(robot,velmsg);  
        end
end


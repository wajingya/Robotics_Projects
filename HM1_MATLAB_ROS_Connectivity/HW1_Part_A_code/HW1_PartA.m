%% Section1
rosshutdown
ipad='localhost';  %get address
rosinit(ipad);     %initialise
robot = rospublisher('/mobile_base/commands/velocity'); %build a velocity topic
velmsg= rosmessage(robot);  %build a message about velocity topic
forwardVelocity= 0.5; 
angularVelocity= 0.5;
velmsg.Linear.X= forwardVelocity;  %change spead 
velmsg.Angular.Z=angularVelocity;  %change palstance
while 1    %keep send message
send(robot,velmsg);  %send message
end
%% Section2
rosshutdown
ipad='localhost';
rosinit(ipad);
robot = rospublisher('/mobile_base/commands/velocity');
velmsg= rosmessage(robot);
forwardVelocity= 0.25;
angularVelocity= 0.125;
velmsg.Linear.X= forwardVelocity;
velmsg.Angular.Z=angularVelocity;
while 1
send(robot,velmsg);
end
%% Section 3
rosshutdown
ipad='localhost';
rosinit(ipad);
robot = rospublisher('/mobile_base/commands/velocity');
velmsg= rosmessage(robot);
forwardVelocity= 1;
angularVelocity= 1;
velmsg.Linear.X= forwardVelocity;
velmsg.Angular.Z=angularVelocity;
while 1
send(robot,velmsg);
end
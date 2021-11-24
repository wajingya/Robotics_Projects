***Description***

The project is to use Lidar and topics to detect the unknown environment in an enclosed area. 
We should firstly generate the the enclosed area' map. And Then find the widest opening, the drive the robot
out of the area from that opening.

***Broad Goals***

a) To construct an algorithm that requires the use of cognition techniques.

b) Specifically, to construct a program in MATLAB that drives a simulated Turtlebot (in Gazebo) 
out from an enclosed area through the widest opening (see Figure 1).

c) To accomplish this in two ways – with and without limited vision – by using the Kinect Lidar 
and the Hokuyo Lidar respectively

![The world firgure](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM8_Find_the_Door/world_map.png)

***The sepcific task***

- Design an algorithm that enables the Turtlebot to find its way out of the enclosed area 
through the widest opening.

- Do this first using the Kinect Lidar and then the Hokuyo Lidar to understand and be able to 
compensate for the effects of limited vision.

- Use the given Gazebo environment (“new_find_door.world”) specifically uploaded to 
Blackboard for this assignment. Instructions were provided in an earlier assignment on how 
to incorporate the specified Gazebo world.

- The presence of the obstacle (traffic cone) should not be considered as changing the 
width of the door opening!

- For any robot run that you execute, provide a plot of the robot path. Also, include (meaningful) videos.

- Choosing an initial pose for the robot that points it at the widest opening is not acceptable. 
Work with the given initial robot position.

This position can be set by using the following command: 

rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, pose: { position: { x: 2.4683, y: -4.5436 ,z: 0 }, orientation: {x: -0.0029, y: -0.0028, z: -0.7175, w: 0.6965} }, twist: { linear: {x: 0 , y: 0 ,z: 0 } , angular: { x: 0.0 , y: 0 , z: 0 } } , reference_frame: world } }'

- The robot is permitted to stop and look around (pivot), as part of a strategy to determine 
where the widest opening is.

***The scan world map and the robot choosing path***

![The Hokuyo Lidar scanning map](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM8_Find_the_Door/the_Hokuyo_Lidar_scanning_map.png)

![Robot choosing path by using Hokuyo Lidar](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM8_Find_the_Door/the_Hokuyo_Lidar_robot_path.png)

![The Kinect Lidar scanning map](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM8_Find_the_Door/the_Kinect_Lidar_scanning_map.png)

![Robot choosing path by using Kinect Lidar](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM8_Find_the_Door/the_Kinect_Lidar_robot_path.png)

***Files***

AMR Homework 8.pdf  : The project instruction.

HM8_report.pdf  : The project report

HM8_report_code.zip  : The report Latex code

homework8.m  : The code of the project

new_find_door.world  : The world file

the_Hokuyo_Lidar_robot_map.png  : The robot choosing path by using the Hokuyo Lidar

the_Hokuyo_Lidar_scanning_map.png  : The scanning map by using the Hokuyo Lidar

the_Kinect_Lidar_robot_path.png  : The robot choosing path by using the Kinect Lidar

the_Kinect_Lidar_scanning_map.png  : The scanning map by using the Kinect Lidar

Using_the_Hokuyo_Lidar.mp4  : The whole process of the robot running by using the Hokuyo Lidar

Using_the_Kinect_Lidar.mp4  : The whole process of the robot running by using the Kinect Lidar

world_map.png  : The map in Gaezbo
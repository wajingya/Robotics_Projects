***Description***

The project is to drive a robot around continuously, while avoiding obstacles in the creating world, with the help of LIDAR data.

***Goal***

- To understand the nature and structure of LIDAR data in general; to understand the specific 
difference between the Kinect Lidar and Hokuyo Lidar views.

- To drive a robot around continuously, while avoiding obstacles, with the help of LIDAR data; 
to understand the effect of parameter settings on the robot’s obstacle avoidance behavior.

- To accomplish the task while using both LIDAR units (Kinect & Hokuyo with field of views of 
+/- 300 and +/-1350 respectively) and observe the difference in robot behavior between the 
two.

- To learn how to create our own Gazebo world and use it for simulations.

***The specific Task***
The following is the obstacle avoid world.
- ![Map](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM6_Drive_Robot_to_Avoid_Obstacles/obstacle_map.png)

Task A: "Random Walk"

a) Construct a program in MATLAB that drives a simulated Turtlebot with a Hokuyo LIDAR
continuously around a Gazebo environment, while avoiding hitting any obstacles.

b) Repeat, this time using the Kinect LIDAR and the same starting pose.

c) Compare robot behavior corresponding to the two cases above. When comparing robot 
behavior for the two cases, it would make sense if the robots are allowed to run for the 
same length of time.

Task B: "Concave or U-shaped Trap"

d) Move over to the U-trap part of the course.

e) Use the Hokuyo LIDAR data and run the robot so that it is able to exit the U-trap

f) Repeat (e), this time using the Kinect LIDAR data. Again, the task is to exit the U-trap.

g) Compare robot behavior for parts (e) & (f).

***Execution***
Do the following first: 

- Locate the "turtlebot_gazebo" folder within your directory structure. 

- Within this folder there should be two directories – "launch" & "worlds". They should 
contain the "turtlebot_world.launch" file and the "empty.world" respectively.

- Copy the new world file for this assignment ("obstacle_avoid.world") to the "worlds" 
directory (using the "cp" command and appropriate path prefixes). You will need "sudo" 
permission to do this!

For taskA:

1. Open a treminal and enter the command 'roscore' to open the ROS environment.

2. Open a new terminal, and enter the command 'matlab' to open the MATLAB.

3. Use command 'cd ~/catkin_ws && catkin_make' to enter the catkin_ws folder and complie the workspace.

4. Use command 'source /opt/ros/indigo/setup.bash' to source the .bash file

5. Use command 'source <catkin_ws>/devel/setup.bash'  to source the setup.bash file

6. Open a new terminal, use command 'roslaunch turtlebot_gazebo obstacle_avoid.world' to launch the turtlebot in Gazebo

7. Open a new terminal, use command 'roslaunch turtlebot_rviz_launchers view_robot.launch' to launch the turtlebot simulation in Rviz

8. Set the initial position of the robot using the following command:
$ rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, 
pose: { position: {x: 6, y: 7 , z: 0 }, orientation: { x: 0, y: 0 , z: 1, w: 1 } }, twist: { linear: {x: 0 , y: 
0 , z: 0 } , angular: {x: 0 , y: 0 , z: 0 } } , reference_frame: world } }'

9. Back to the MATLAB, click Run. Then you can back to the Gazebo and Rviz windows to view the simulation of the turtlebot motion.

For taskB:

1. Open a treminal and enter the command 'roscore' to open the ROS environment.

2. Open a new terminal, and enter the command 'matlab' to open the MATLAB.

3. Use command 'cd ~/catkin_ws && catkin_make' to enter the catkin_ws folder and complie the workspace.

4. Use command 'source /opt/ros/indigo/setup.bash' to source the .bash file

5. Use command 'source <catkin_ws>/devel/setup.bash'  to source the setup.bash file

6. Open a new terminal, use command 'roslaunch turtlebot_gazebo obstacle_avoid.world' to launch the turtlebot in Gazebo

7. Open a new terminal, use command 'roslaunch turtlebot_rviz_launchers view_robot.launch' to launch the turtlebot simulation in Rviz

8. Set the initial position of the robot using the following command:
$ rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, 
pose: { position: {x: -9, y: -6 , z: 0 }, orientation: { x: 0, y: 0 , z: 0, w: 0 } }, twist: { linear: {x: 0 , 
y: 0 , z: 0 } , angular: {x: 0 , y: 0 , z: 0 } } , reference_frame: world } }

9. Back to the MATLAB, click Run. Then you can back to the Gazebo and Rviz windows to view the simulation of the turtlebot motion.

***Files***

Homework 6.pdf  : The project instruction.

HM6.m  : The whole peoject code.

HM6_report.pdf  : The project report

obstacle_avoid.world  : The testing world file

obstacle_map.png  : The above file running result in Gazebo

report_code.zip  : The report Latex code

TaskA_hokuyo_gazebo.mp4  : The taskA's Gazebo video which is driving the turtlebot by using Hokuyo Lidar.

TaskA_hokuyo_rviz.mp4  : The taskA's Rviz video which is driving the turtlebot by using Hokuyo Lidar.

TaskA_kinect_gazebo.mp4  : The taskA's Gazebo video which is driving the turtlebot by using Kinect Lidar.

TaskA_kinect_rviz.mp4 : The taskA's Rviz video which is driving the turtlebot by using Kinect Lidar.

TaskA_kitnect_problem.mp4  : The whole process recording in Gazebo.

TaskB_hokuyo_gazebo.mp4  : The taskB's Gazebo video which is driving the turtlebot by using Hokuyo Lidar.

TaskB_hokuyo_rviz.mp4  : The taskB's Rviz video which is driving the turtlebot by using Hokuyo Lidar.

TaskB_kinect_gazebo.mp4  : The taskB's Gazebo video which is driving the turtlebot by using Kinect Lidar.

TaskB_kinect_rviz.mp4 : The taskB's Rviz video which is driving the turtlebot by using Kinect Lidar.

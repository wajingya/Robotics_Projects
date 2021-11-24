***Description***

The object is to investigate the use of “wall following”, a very useful type of behavior in robotics, as 
navigational guidance for a robot. 

***Goal***

a) To do so with the use of motion feedback (output) rather than calculations based on drive 
commands (input); that is, we are required to construct a simple control algorithm to drive 
the robot using wall following. In this case, the motion feedback should be based on
sideways spacing of the robot to the wall.

b) To create a map of the outer perimeter of a structure, with the help of basic mapping 
concepts, while driving autonomously using wall following.

***The specific Tasks***

a) Design a control algorithm based on the wall-following algorithm to drive the Turtlebot 
around the outside of the given “island” structure(as shown in Figure 1). The robot needs to 
maintain an approximate spacing of 1.5 meters from the wall and keep the wall to the right.

!["Island"](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM7_Wall_Following/island.png)

b) Record and report the distance traveled by the robot over one full circuit around the island
using both model state and odometry. Also, plot the robot path around the island using 
both model state and odometry.

c) Repeat parts (a) & (b) keeping the wall on the left.

d) Repeat parts (a), (b), (c) by starting the robot on the inside of the wall (both ways – left wall 
following and right wall following). The purpose of this part of the exercise is to see whether 
we can follow the wall, while simultaneously avoiding hitting the wall if it curves sharply in 
front of the robot.

***The Execution***

Do the following first: 

- Locate the "turtlebot_gazebo" folder within your directory structure. 

- Within this folder there should be two directories – "launch" & "worlds". They should 
contain the "turtlebot_world.launch" file and the "empty.world" respectively.

- Copy the new world file for this assignment ("wall_following.world") to the "worlds" 
directory (using the "cp" command and appropriate path prefixes). You will need "sudo" 
permission to do this!

Task A(1): Outside of the given "island"- keep the wall to the right

1. Open a treminal and enter the command 'roscore' to open the ROS environment.

2. Open a new terminal, and enter the command 'matlab' to open the MATLAB.

3. Use command 'cd ~/catkin_ws && catkin_make' to enter the catkin_ws folder and complie the workspace.

4. Use command 'source /opt/ros/indigo/setup.bash' to source the .bash file

5. Use command 'source <catkin_ws>/devel/setup.bash'  to source the setup.bash file

6. Open a new terminal, use command 'roslaunch turtlebot_gazebo wall_following.world' to launch the turtlebot in Gazebo

7. Open a new terminal, use command 'roslaunch turtlebot_rviz_launchers view_robot.launch' to launch the turtlebot simulation in Rviz

8. Set the initial position of the robot using the following command:
$ rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, 
pose: { position: {x: -10.0, y: -6.0 , z: 0 }, orientation: { x: 0, y: 0 , z: 0.7, w: 0.7 } }, twist: { linear: {x: 0 , y: 
0 , z: 0 } , angular: {x: 0 , y: 0 , z: 0 } } , reference_frame: world } }'

9. Back to the MATLAB, click Run. Then you can back to the Gazebo and Rviz windows to view the simulation of the turtlebot motion.

TaskA(2): Outside of the given "island" - keep the wall to the left

1. Open a treminal and enter the command 'roscore' to open the ROS environment.

2. Open a new terminal, and enter the command 'matlab' to open the MATLAB.

3. Use command 'cd ~/catkin_ws && catkin_make' to enter the catkin_ws folder and complie the workspace.

4. Use command 'source /opt/ros/indigo/setup.bash' to source the .bash file

5. Use command 'source <catkin_ws>/devel/setup.bash'  to source the setup.bash file

6. Open a new terminal, use command 'roslaunch turtlebot_gazebo wall_following.world' to launch the turtlebot in Gazebo

7. Open a new terminal, use command 'roslaunch turtlebot_rviz_launchers view_robot.launch' to launch the turtlebot simulation in Rviz

8. Set the initial position of the robot using the following command:
$ rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, 
pose: { position: {x: -10.0, y: -6.0 , z: 0 }, orientation: { x: 0, y: 0 , z: -0.7, w: 0.7 } }, twist: { linear: {x: 0 , y: 
0 , z: 0 } , angular: {x: 0 , y: 0 , z: 0 } } , reference_frame: world } }'

9. Back to the MATLAB, click Run. Then you can back to the Gazebo and Rviz windows to view the simulation of the turtlebot motion.

TaskB(1): Inside of the given "island" - keep the wall to the left

1. Open a treminal and enter the command 'roscore' to open the ROS environment.

2. Open a new terminal, and enter the command 'matlab' to open the MATLAB.

3. Use command 'cd ~/catkin_ws && catkin_make' to enter the catkin_ws folder and complie the workspace.

4. Use command 'source /opt/ros/indigo/setup.bash' to source the .bash file

5. Use command 'source <catkin_ws>/devel/setup.bash'  to source the setup.bash file

6. Open a new terminal, use command 'roslaunch turtlebot_gazebo wall_following.world' to launch the turtlebot in Gazebo

7. Open a new terminal, use command 'roslaunch turtlebot_rviz_launchers view_robot.launch' to launch the turtlebot simulation in Rviz

8. Set the initial position of the robot using the following command:
$ rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, 
pose: { position: {x: 0.0, y: 0.0 , z: 0 }, orientation: { x: 0, y: 0 , z: 0.0, w: 0.0 } }, twist: { linear: {x: 0 , y: 
0 , z: 0 } , angular: {x: 0 , y: 0 , z: 0 } } , reference_frame: world } }'

9. Back to the MATLAB, click Run. Then you can back to the Gazebo and Rviz windows to view the simulation of the turtlebot motion.

TaskB(2): Inside of the given "island" - keep the wall to the right

1. Open a treminal and enter the command 'roscore' to open the ROS environment.

2. Open a new terminal, and enter the command 'matlab' to open the MATLAB.

3. Use command 'cd ~/catkin_ws && catkin_make' to enter the catkin_ws folder and complie the workspace.

4. Use command 'source /opt/ros/indigo/setup.bash' to source the .bash file

5. Use command 'source <catkin_ws>/devel/setup.bash'  to source the setup.bash file

6. Open a new terminal, use command 'roslaunch turtlebot_gazebo wall_following.world' to launch the turtlebot in Gazebo

7. Open a new terminal, use command 'roslaunch turtlebot_rviz_launchers view_robot.launch' to launch the turtlebot simulation in Rviz

8. Set the initial position of the robot using the following command:
$ rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, 
pose: { position: {x: 0.0, y: 0.0 , z: 0 }, orientation: { x: 0, y: 0 , z: 1.0, w: 0.0 } }, twist: { linear: {x: 0 , y: 
0 , z: 0 } , angular: {x: 0 , y: 0 , z: 0 } } , reference_frame: world } }'

9. Back to the MATLAB, click Run. Then you can back to the Gazebo and Rviz windows to view the simulation of the turtlebot motion.

***The generating maps***

!["Task A: Outside the wall and keep the wall to the left"](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM7_Wall_Following/TaskA_left_map.png)

!["Task A: Outside the wall and keep the wall to the right"](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM7_Wall_Following/TaskA_right_map.png)

!["Task B: Inside the wall and keep the wall to the left"](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM7_Wall_Following/TaskB_left_map.png)

!["Task B: Inside the wall and keep the wall to the right"](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM7_Wall_Following/TaskB_right_map.png)


***Files***

HW7_photos  : The projects' photo.

AMR Homework 7.pdf  : The instruction of the project.

homework7.m  : The code of the project.

Homework7_report.pdf  : The report of the project.

Homework7_reposrt_code.zip  : The report Latex code.

island.png  : The 'Island' general shape.

wall_following.world  : The world file.

inside_keep_the_wall_to_the_left.mp4  : The recording when running inside the wall and keep the wall to the left side.

inside_keep_the_wall_to_the_right.mp4  : The recodring when running inside the wall and keep the wall to the right side.

outside_keep_the_wall_to_the_left.mp4  : The recording when running outside the wall and keep the wall to the left side.

outside_keep_the_wall_to_the_right.mp4  : The recording when running outside the wall and keep the wall to the right side.

TaskA_left_map.png  : The generating map when the following wall running is outside the wall and keep the wall to the left side.

TaskA_right_map.png  : The generating map when the following wall running is outside the wall and keep the wall to the right side.

TaskB_left_map.png  : The generating map when the following wall running is inside the wall and keep the wall to the left side.

TaskB_right_map.png  : The generating map when the following wall running is inside the wall and keep the wall to the right side.










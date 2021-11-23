***Description***
The task is to drive the robot with the feedback of the topic '/gazebo/model_states', and adjust the robot by
the topic '/mobile_base/commands/velocity'.

***The goal***

a) To construct a program in MATLAB that drives a simulated Turtlebot (in Gazebo) smoothly 
and as fast as possible to a given goal through an intermediate waypoint. This assignment is 
a logical extension of an earlier assignment, where we made the robot drive a path contour, 
but there was no specific target position.

b) To do so with the use of motion feedback (output) rather than calculations based on drive 
commands (input).

c) To understand and deal with the wrap-around aspect of angle measurements in this task, 
due to their finite range of representation of (-p to +p).

***Specific Task Description***

a) Consider the available field to be a 10 m by 10 m square area. Think of it in terms of the 
"floor tiles" in Gazebo, each 1 m by 1 m. Remove all obstacles! The Turtlebot’s initial pose, 
intermediate waypoint and final goal are shown in Figure 1; it has to face to the right at start time.

- ![Map](https://github.com/Jingya9711/MATLAB_Projects/blob/master/HM5_Drive_Robot_to_Goal(Fast_and_Smooth)/map.png)

b) Drive the robot from the start position to the final goal position after going through the 
intermediate goal position. If the robot is within 0.5 m of a point, we can consider the point 
to be reached!

c) Do this as fast as possible and with as smoothly contoured a path as possible. The robot 
needs to be brought to a stop when it reaches the goal. Record the total transit time and 
report it.

f) Plot the path (x, y), the forward velocity, v(t), and the heading angle q(t), as a function of 
time during the robot travel.

***Execution***

1. Open one terminal, enter the command 'roscore' to open the ros environment

2. Use 'matlab' to open the MATLAB.

3. Use command 'cd ~/catkin_ws && catkin_make' to enter the catkin_ws folder and complie the workspace.

4. Use command 'source /opt/ros/indigo/setup.bash' to source the .bash file

5. Use command 'source <catkin_ws>/devel/setup.bash'  to source the setup.bash file

6. Open a new terminal, use command 'roslaunch turtlebot_gazebo turtlebot_empty_world.launch' to launch the turtlebot in Gazebo

7. Open a new terminal, use command 'roslaunch turtlebot_rviz_launchers view_robot.launch' to launch the turtlebot simulation in Rviz

8. Open a new terminal, use command --rostopic pub -r 10 /gazebo/set_model_state gazebo_msgs/ModelState '{ model_name: mobile_base, pose: { position: {x: 0, y: 0 , z: 0 }, orientation: { x: 0, y: 0 , z: 0.5, w: 0.5 } }, twist: { linear: {x: 0 , y: 0 , z: 0 } , angular: {x: 0 , y: 0 , z: 0} } , reference_frame: world } '
to set the robot face to right.

9. Back to the MATLAB, click Run. Then you can back to the Gazebo and Rviz windows to view the simulation of the turtlebot motion.


***Files***

HM5_code  : The code of the project

HM5_repostcode.zip  : The report Latex code

Homework 5.pdf  : The instruction of the project

map.png  : The figure of the general trajectory




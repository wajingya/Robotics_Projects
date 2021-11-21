***Description***
The aim of this assignment is to go one step beyond the project MATLAB_ROS_Connectivity by driving the robot using 
feedback to guide it. Drive the robot along a triangular path that is an isosceles triangle with 
angles of 30 degrees, 120 degrees & 30 degrees, with the equal sides being 5 meters each in length. To do a triangle 
you will need to use a stop-turn-go strategy. In the initial investigations do not attempt to close 
the triangle, if it is not closed!

***Pay attention***
The code should be run in Ubuntu14.0, with the ROS turtlebot kinetic or indigo package.
Since there is one topic called '/mobile_base/commands/velocity', this topic is under the kinetic turtlebot package.
In other version package, you might cannot find the topic.

***Excution***
1. Open terminal in Ubuntu, and enter "roscore", hit enter. (You should ensure that you have installed ROS, and ROS kinetic).
2. Open another terminal(Keep the first terminal running), first enter 'source /opt/ros/indigo/setup.bash';
Then, in the same terminal, enter command 'roslaunch turtlebot_gazebo turtlebot_empty_world.launch', to open the simulating environment.
3. Next , open a new terminal, enter the 'rviz' to open the RViz, and use RViz to visualize the path trajectory.
4. Finally, Open another terminal, enter matlab to open matlab, change the directory to the .m folder, the click run to see the Turtlebot running.

***Files***

Homework 2.pdf  : The instruction pdf

HW2_report.pdf  : The report

HW2repotcode.zip  : The report Letax code

model_states_topic.m  : The code of the task which is using the “model state” topic as feedback

time_to_drive_robot.m  : The code of the task which is driving using the time

using_odometory_feedback.m  : The code of the task which is driving using odometry feedback

video_model.mp4/video_model.avi  : The video of the task which is using the “model state” topic as feedback

video_odom.mp4/video_odom.avi  : The video of the task which is driving using odometry feedback

video_time.mp4/video_time.avi  : The video of the task which is driving using the time

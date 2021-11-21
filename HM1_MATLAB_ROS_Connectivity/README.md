***Description***
This homework aim is to practise how to connect to a ROS Network, and exchange Data with ROS publisher and subscribers. What's more, work wiht the
basic ROS message(The velocity message). Additionally, get started with Gazebo and a Simulated TurtleBot, and get familiar with Rviz.

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

Homework 1.pdf            : Including the project instruction

HW1_report.pdf             : The project's report

HW1_reportlatexcode.zip  : The report Latex code

HW1_Part_A_code               : Task A's code

HW1_PartB_ver1_code        : Task B's version1 code

HW1_PartB_ver2_code        : Task B's version2 code

HW1_picture                       : Whole task screenshot picture

HW1_video                         : All three tasks' video, The same name vedio's content are same, but maybe some computer cannot open one version, so I upload two Files with different suffixes.

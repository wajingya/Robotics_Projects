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
- ![Map]()

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


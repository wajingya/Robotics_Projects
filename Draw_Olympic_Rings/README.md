***Description***
The project is to plot a image which looks like Olympic rings, but it has following requirements.
1. The radius of each circle should be random, and it should be calculated by radius = 4*scale, scale is a number between 0 to 1. Additionally,the scales should be stored in a 1* 5 matrix.
2. The center of each circles should be fixed, what’s more, all the centers should be stored in a matrix which has 5 rows and 2 column;
3. The whole shape of the figure should be looked as a ”W”;
4. Not every circles should be intersect. The upper line circles should be connected to the under lines, however, the parallel line’s circle should not be connected.
For example, it should similar to the following figure. The blue one must intersect with the yellow one, and the yellow one must be intersect with the black one, 
however, the blue one should not be connected with black one.
- ![Olympic circles](https://github.com/Jingya9711/MATLAB_Projects/blob/master/Draw_Olympic_Rings/Olympic_circles.png)
5. The plotting should be done in the main program one circle at a time being added to the plot.

***Files***
Calculate.m              : According to the polar coordinate system, determine the position of each point on the circle.
Centerfuntion.m       : Confirm the five center of the five circles.
Olympic_Rings.m     : The main execution file.
Radiusfunction.m     : Generate the radius randomly, and judge whether the five radius are valid.
presentation.zip       : The running video.
final_figure.png       : The final result.

***Execution***
The final figure is different every time. Since the radius are generated randomly.
The following is one of my executing result. If you want to check the whole process, you can check the video in the folder.
- ![Final result](https://github.com/Jingya9711/MATLAB_Projects/blob/master/Draw_Olympic_Rings/final_figure.png)

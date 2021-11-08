function [input1,input2] = function_center_radius(input1,input2,input3)%%build the center and radius
z=0:0.01:2*pi; 
 input2(input3)=4*rand(1); %%get a random radius for one circle
 if input3==1%%the first circle begain at(0,0)
     input1(1,1)=0;
     input1(1,2)=0;
 end
if input3 >= 2  %%confirm a center for a circle
         if rem(input3,2)==0
            input1(input3,2)=-3.5;
         else 
            input1(input3,2)=0;
         end
         input1(input3,1)=input1(input3-1,1)+2.75;
  end
end


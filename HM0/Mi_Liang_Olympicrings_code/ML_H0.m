center=zeros(5,2); %%creact matrix for 5 center
radius=zeros(5,1); %%creact vector for 5 radius
m=1;%%uesed to control the "while"loop
f=0;%%used "f++" in loop to show the times has run 
while m
for i=1:5
    [center radius]=function_center_radius(center,radius,i);%this function is used to create center and radius matrix
    function_plot(center,radius,i);%%this function is uesd to draw the circle
    n=function_text_circle(radius,i);%%function ues to text plot(return a data n to contral the procedure)
    if n==1 %%build Olympic rings fail(get the wrong result)
        hold off %%clean the unqualified figure
        break%%restart "for" loop
    end
    if n==2%%get a suitable figure
        m=0;%%stop "while" loop and finish this procedure
    end
end
f=f+1;fprintf("The times fail:%d\n",f)%%show the times has run
end
axis equal%%adjust plot
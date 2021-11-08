function [n] = function_text_circle(radius,i,m)%%return n to contral the procedure
n=0;
if i>=2%%start at the second circle
       if radius(i-1)+radius(i)< 4.5 %%used R1+R2 to text if the two circles intersect
           n=1;
       end
end
    if i >=3
        if radius(i-2)+radius(i)>5.4 %%used to test whether the upper line circles are intersecting
           n=1;
        end
    end
    if i==5 && n==0%if this condition be ture, get a right result
       n=2; %%return back to stop the "while" and "for" loop
    end
end


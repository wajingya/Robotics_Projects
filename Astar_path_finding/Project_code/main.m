%%（x,y）开始坐标
clear all
clc
close all
n=0;
m=1;
z=1;
x_start= 3;
y_start= 5;
x_final= 21;
y_final= 21;
Map = map(x_start,y_start,x_final,y_final);
[map_size_x, map_size_y]=size(Map)
map_cell=zeros(map_size_x,map_size_y,6);
              %%MxMx6  1,2,3-- F,G,H, 4,5--father_cell_x,father_cell_y,
              %%6--characteristic--0为待计算open area，1为open list，2为close
              %%list,3 star,4 aim
%%用已知地图把障碍物/终点填充进map_cell,障碍物 F G H==INF 6--characteristic==INF
map_cell(:,:,1)=inf;
map_cell(x_start,y_start,6)=3;
map_cell(x_final,y_final,6)=4;

now_x=x_start;
now_y=y_start;

for i=1:map_size_x
    for j=1:map_size_y
        if Map(i,j)==1
            map_cell(i,j,:)=Inf;
        end
    end
end
%%loop update open list/close list

while   (abs(now_x-x_final)+abs(now_y-y_final))>1   
    
surrounding_cell=Surrounding_function(now_x,now_y); %%得到周围八个点坐标 [x,y+1;x,y-1;x+1,y;.......] 8x2

for i=1:1:8 %%caculate each cell
    
    cell_characteristic=map_cell(surrounding_cell(i,1),surrounding_cell(i,2),6); %%characteristic
    
    if cell_characteristic==0 %%三非 open area
        
         G=Gfunction(surrounding_cell(i,1),surrounding_cell(i,2),now_x,now_y,map_cell(now_x,now_y,2));
         H=Hfunction(surrounding_cell(i,1),surrounding_cell(i,2),x_final,y_final) ;
         F=G+H;
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),1)=F; %%F
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),2)=G; %%G
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),3)=H; %%H
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),4)=now_x; %%father_cell_x
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),5)=now_y; %%father_cell_y
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),6)=1;  %%mark as open list
         
    elseif cell_characteristic==1 %%open list
         G=Comparing_G_function(map_cell(surrounding_cell(i,1),surrounding_cell(i,2),2),...
              Gfunction(surrounding_cell(i,1),surrounding_cell(i,2),now_x,now_y,map_cell(now_x,now_y,2)));
         H=Hfunction(surrounding_cell(i,1),surrounding_cell(i,2),x_final,y_final);
         F=G+H;
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),1)=F; %%F
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),2)=G; %%G
         map_cell(surrounding_cell(i,1),surrounding_cell(i,2),3)=H; %%H
%          new_G=G_update (surrounding_cell(i,1),surrounding_cell(i,2));%%计算新的G 
%      
%             if (new_G<map_cell(surrounding_cell(i,1),surrounding_cell(i,2)，2))
%                 
%                 new_FGH=function F_update (surrounding_cell(i,1),surrounding_cell(i,2)) end%%计算新的F
%                 map_cell(surrounding_cell(i,1),surrounding_cell(i,2)，1)=new_FGH(1,1) %%F
%                 map_cell(surrounding_cell(i,1),surrounding_cell(i,2)，2)=new_FGH(1,2) %%G
%                 map_cell(surrounding_cell(i,1),surrounding_cell(i,2)，3)=new_FGH(1,3) %%H
%                 
%             else
%                 
%                     %% I don't care!
%             end
            
    elseif (cell_characteristic==2) %%close list
        
       %% I don't care!
       
    elseif (cell_characteristic==inf) %%obstacle
        
        %% I don't care!   
    end
end

   F_min=min(min(map_cell(:,:,1))); %min F
   [now_x,now_y]=find(map_cell(:,:,1)== F_min);
   if (length(now_x)~=1) 
      z=z+1
      x_y=now_x+now_y;
      position=find(x_y==max(x_y));
      now_x=now_x(position(1));
      now_y=now_y(position(1));

   end
   map_cell(now_x,now_y,6)=2;
    map_cell(now_x,now_y,1)=inf;
    Closelist(m,1)=now_x;
    Closelist(m,2)=now_y;
    m=m+1;

   n
   n=n+1;
   
   if n>500
       break
   end
   
end
    [lenx,leny]=size(Closelist);
    
    Mark(lenx);
 pause(3)
i=1;
x_trajectory=x_final-1;
y_trajectory=y_final-1;
judge=1;
 while judge
trajectory(i,1)=map_cell(x_trajectory,y_trajectory,4);
trajectory(i,2)=map_cell(x_trajectory,y_trajectory,5);
x_trajectory=trajectory(i,1);
y_trajectory=trajectory(i,2);
i=i+1;
 if i>100
     break
 end
 if (abs(x_trajectory-x_start)+abs( y_trajectory-y_start))<=1
     judge=0;
 end
 end
 Closelist=trajectory;
    [lenx,leny]=size(Closelist);
    
    Mark(lenx);
z
%Quiz 7
%Wang Jingya(T02157119)

clear all
clc
close all

L=500;

[Fb,Vb]=stlread_mod('base.stl')
[F1,V1]=stlread_mod('Part2.stl')
[F2,V2]=stlread_mod('Part3.stl')
[F3,V3]=stlread_mod('Part4.stl')
[F4,V4]=stlread_mod('Part5.stl')
[F5,V5]=stlread_mod('Part6.stl')
[F6,V6]=stlread_mod('Part7.stl')


[Fp,Vp]=stlread_mod('Project.stl')

T10=eye(4);
T21=eye(4);
T32=eye(4);
T43=eye(4);
T54=eye(4);
T65a=eye(4);
T65b=eye(4);

Tp=eye(4);

th1=90;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

th2=0;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=0;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4 = 0;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5 = 0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 0;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Tp(1:3,4)=[-124 -120 0]';

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

Vpmoved=Tp*Vp;
Vpmoved=Vpmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;

for th1=0:2:225
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

% th2 = 45 * sind(3*th1);
th2=0;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3 = 0;
% th3=0
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4 = 0;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5 = 0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 0;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th2=0:1:25
th1=225;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3 = 0;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4 = 0;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5 = 0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 0;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th3=0:2:110
 th1 = 225;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

th2=25;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4 = 0;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5 = 0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 0;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th4=0:2:45
th1 = 225;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

th2=25;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=110;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5 = 0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 0;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th5=0:2:90
th1 = 225;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

th2=25;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=110;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4=45;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 0;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for d6=-17.5:1:5
th1 = 225;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

th2=25;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=110;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4=45;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5=90;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

Tp6=eye(4);

for th1=225:2:360
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

th2=25;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=110;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4=45;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5=90;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 5;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Tp6(1:3,4)=[0 0 0]';
Tp0=T10*T21*T32*T43*T54*T65b*Tp6;

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

Vpmoved=Tp0*Vp;
Vpmoved=Vpmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for d6=5:1:17.5
th1=360;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

th2=25;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=110;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4=45;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5=90;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Tp6(1:3,4)=[0 0 0]';
Tp0=T10*T21*T32*T43*T54*T65b*Tp6;

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

Vpmoved=Tp0*Vp;
Vpmoved=Vpmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th5=90:2:180
th1=360;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=110;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4=45;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 17.5;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Tp0=eye(4);
cp=cosd(90);
sp=sind(90);
Rp =[cp -sp 0;sp cp 0;0 0 1];
Tp0(1:3,1:3)=Rp;
Tp0(1:3,4)=[174 0 0]';

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

Vpmoved=Tp0*Vp;
Vpmoved=Vpmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th4=45:-2:0
th1=360;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=110;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5=0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 17.5;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Tp0=eye(4);
cp=cosd(90);
sp=sind(90);
Rp =[cp -sp 0;sp cp 0;0 0 1];
Tp0(1:3,1:3)=Rp;
Tp0(1:3,4)=[174 0 0]';

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

Vpmoved=Tp0*Vp;
Vpmoved=Vpmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th3=110:-2:0
    th1=360;
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4=0;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5=0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 17.5;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Tp0=eye(4);
cp=cosd(90);
sp=sind(90);
Rp =[cp -sp 0;sp cp 0;0 0 1];
Tp0(1:3,1:3)=Rp;
Tp0(1:3,4)=[174 0 0]';

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

Vpmoved=Tp0*Vp;
Vpmoved=Vpmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th2=25:-2:0
 th1=360;   
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=0;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4=0;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5=0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 17.5;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Tp0=eye(4);
cp=cosd(90);
sp=sind(90);
Rp =[cp -sp 0;sp cp 0;0 0 1];
Tp0(1:3,1:3)=Rp;
Tp0(1:3,4)=[174 0 0]';

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

Vpmoved=Tp0*Vp;
Vpmoved=Vpmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end

for th1=360:-2:0
c1=cosd(th1); s1=sind(th1);
R10=[c1 -s1 0;s1 c1 0;0 0 1];  
T10(1:3,1:3)=R10; 
T10(3,4)=4;

th2=0;
c2=cosd(th2);
s2=sind(th2);
R21 =[c2 0 s2;0 1 0;-s2 0 c2];
T21(1:3,1:3)=R21;
T21(1:3,4)=[0 0 118]';
T20 = T10*T21;

th3=0;
c3=cosd(th3);
s3=sind(th3);
R32 =[c3 0 s3;0 1 0;-s3 0 c3];
T32(1:3,1:3)=R32;
T32(1:3,4)=[48 0 130]';
T30 = T10*T21*T32;

th4=0;
c4=cosd(th4);
s4=sind(th4);
R43 =[c4 0 s4;0 1 0;-s4 0 c4];
T43(1:3,1:3)=R43;
T43(1:3,4)=[0 0 102]';
T40 = T10*T21*T32*T43;

th5=0;
c5=cosd(th5);
s5=sind(th5);
R54 =[c5 -s5 0;s5 c5 0;0 0 1];
T54(1:3,1:3)=R54;
T54(1:3,4)=[-28 0 67]';
T50 = T10*T21*T32*T43*T54;

d6 = 17.5;
R65a =[1 0 0;0 1 0;0 0 1];
T65a(1:3,1:3)=R65a;
T65a(1:3,4)=[0 d6 54]';
T60a = T10*T21*T32*T43*T54*T65a;

cb=cosd(180);
sb=sind(180);
R65b =[cb -sb 0;sb cb 0;0 0 1];
T65b(1:3,1:3)=R65b;
T65b(1:3,4)=[0 -d6 54]';
T60b = T10*T21*T32*T43*T54*T65b;

Tp0=eye(4);
cp=cosd(90);
sp=sind(90);
Rp =[cp -sp 0;sp cp 0;0 0 1];
Tp0(1:3,1:3)=Rp;
Tp0(1:3,4)=[174 0 0]';

Vbmoved=Vb(1:3,:)';

V1moved=T10*V1;
V1moved=V1moved(1:3,:)';

V2moved=T20*V2;
V2moved=V2moved(1:3,:)';

V3moved=T30*V3;
V3moved=V3moved(1:3,:)';

V4moved=T40*V4;
V4moved=V4moved(1:3,:)';

V5moved=T50*V5;
V5moved=V5moved(1:3,:)';

V6amoved=T60a*V6;
V6amoved=V6amoved(1:3,:)';

V6bmoved=T60b*V6;
V6bmoved=V6bmoved(1:3,:)';

Vpmoved=Tp0*Vp;
Vpmoved=Vpmoved(1:3,:)';

cla
patch('faces',Fb,'vertices',Vbmoved,'FaceColor','y','EdgeColor','k')
patch('faces',F1,'vertices',V1moved,'FaceColor','r','EdgeColor','k')
patch('faces',F2,'vertices',V2moved,'FaceColor','b','EdgeColor','k')
patch('faces',F3,'vertices',V3moved,'FaceColor','g','EdgeColor','k')
patch('faces',F4,'vertices',V4moved,'FaceColor','m','EdgeColor','k')
patch('faces',F5,'vertices',V5moved,'FaceColor','c','EdgeColor','k')
patch('faces',F6,'vertices',V6amoved,'FaceColor','y','EdgeColor','k')
patch('faces',F6,'vertices',V6bmoved,'FaceColor','y','EdgeColor','k')

patch('faces',Fp,'vertices',Vpmoved,'FaceColor','y','EdgeColor','k')

view(3);
grid on;
xlabel('X');ylabel('Y');xlabel('Z');
axis equal;
axis([-L L -L L -L L]);

drawnow;
end


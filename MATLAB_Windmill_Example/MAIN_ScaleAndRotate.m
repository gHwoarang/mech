clear all
clc
close all

square = [0, 1, 1, 0, 0;  
    0, 0, 1, 1, 0;
   0, 0, 0, 0, 0;
   1, 1, 1, 1, 1];

% square = [-0.5, -0.5, 0.5, 0.5, -0.5;  
%     -0.5, 0.5, 0.5, -0.5, -0.5;
%    0, 0, 0, 0, 0;
%    1, 1, 1, 1, 1];

bsx = 2;
bsy = 4;
bsz = 0;
bscale = scale3D (bsx, bsy, bsz);

trX = 5;
trY = 2;
trZ = 0;
htrans = translate3D (trX, trY, 0);

angleZ = 30;
hrot = rotate3Dz (degree_to_radian (angleZ));


Scale = bscale*square;


% 2. Translate first, then rotate
Rotation = hrot*Scale;
TRANS = htrans*Rotation;

figure (1);
plot3(square(1,:),square(2,:),square(3,:))
axis equal
view([0,0,1])
hold on
plot3(Scale(1,:),Scale(2,:),Scale(3,:))

plot3(Rotation(1,:),Rotation(2,:),Rotation(3,:))
view([0,0,1])

plot3(TRANS(1,:),TRANS(2,:),TRANS(3,:))


% 1. Rotate first then translate
figure (2)

TRANS = htrans*Scale;
Rotation = hrot*TRANS;

plot3(square(1,:),square(2,:),square(3,:))
hold on
view([0,0,1])
axis equal
plot3(TRANS(1,:),TRANS(2,:),TRANS(3,:))
plot3(Rotation(1,:),Rotation(2,:),Rotation(3,:))


clear all
clc
close all
%==========================================================================
%                                DEFINITIONS
%==========================================================================
% 1. PURPOSE: Rigid-Body Transformation example -- Windmill

% -INPUT PARAMETERS
% cube      : coordinates of a unit cube
% square    : coordinates of a unit square
% cone      : coordiantes of a unit cone
% house_rot : house rotation angle
% prop_rot  : propeller rotation angle

% -OUTPUT PARAMETERS
% Plots of the Windmill

% 2. REFERENCES:
% [1]. David W. Rosen, Georgia Institute of Technology, ME6103 Course Notes

% 3. OTHERS:
% Modifed Date: 05/03/2018
% By : Recep M. Gorguluarslan

%==========================================================================
%                              FUNCTION BODY
%==========================================================================
%  Primitive shapes: square, cube, cone.
cube = [-0.5, -0.5, -0.5, -0.5, -0.5,  0.5, 0.5, 0.5,  0.5,  0.5, 0.5, -0.5, -0.5, 0.5,  0.5, -0.5;
           0,    0,    1,    1,    0,    0,   0,   1,    1,    0,   0,    0,    1,   1,    1,    1;
        -0.5,  0.5,  0.5, -0.5, -0.5, -0.5, 0.5, 0.5, -0.5, -0.5, 0.5,  0.5,  0.5, 0.5, -0.5, -0.5;
           1,    1,    1,    1,    1,    1,   1,   1,    1,    1,   1,    1,    1,   1,    1,    1];

square = [-0.5, -0.5, 0.5,  0.5, -0.5;  
          -0.5,  0.5, 0.5, -0.5, -0.5;
             0,    0,   0,    0,    0;
             1,    1,   1,    1,    1];

shaft = circle(0.5,0,0,18);


%% Cone
nsegs = 20;
cone = circle (1.0, 0.0, 0.0, nsegs);
cone(1,nsegs+2) = 0.0;		cone(1,nsegs+6) = 0.0;
cone(2,nsegs+2) = 0.0;		cone(2,nsegs+6) = 0.0;
cone(3,nsegs+2) = 1.0;		cone(3,nsegs+6) = 1.0;
cone(4,nsegs+2) = 1.0;		cone(4,nsegs+6) = 1.0;
cone(1,nsegs+3) = -1.0;		cone(1,nsegs+7) = 0.0;
cone(2,nsegs+3) = 0.0;		cone(2,nsegs+7) = 1.0;
cone(3,nsegs+3) = 0.0;		cone(3,nsegs+7) = 0.0;
cone(4,nsegs+3) = 1.0;		cone(4,nsegs+7) = 1.0;
cone(1,nsegs+4) = 0.0;
cone(2,nsegs+4) = 0.0;
cone(3,nsegs+4) = 1.0;
cone(4,nsegs+4) = 1.0;
cone(1,nsegs+5) = 0.0;
cone(2,nsegs+5) = -1.0;
cone(3,nsegs+5) = 0.0;
cone(4,nsegs+5) = 1.0;
    
%  House rotation, propeller rotation.
house_rot = 10;
prop_rot = 30;

%  Plot 3D Isometric view of the Windmill.
figure(1);
axis ('equal');
view([1,1,1])
grid on
hold on
val_xlim = 15; val_ylim = 15; val_zlim = 20;
% xlim([-val_xlim val_xlim]); ylim([-val_ylim val_ylim]) ; zlim([0 val_zlim])

% Plot global coordinate system
GCSx = [0 1; 0 0; 0 0];
GCSy = [0 0; 0 1; 0 0];
GCSz = [0 0; 0 0; 0 1];
GCS = [GCSx;GCSy;GCSz];
quiver3 (GCSx(1,1), GCSx(2,1), GCSx(3,1), val_xlim*GCSx(1,2), GCSx(2,2), GCSx(3,2), 'k');
quiver3 (GCSy(1,1), GCSy(2,1), GCSy(3,1), GCSy(1,2), val_ylim*GCSy(2,2), GCSy(3,2), 'k');
quiver3 (GCSz(1,1), GCSz(2,1), GCSz(3,1), GCSz(1,2), GCSz(2,2), val_zlim*GCSz(3,2), 'k');
text(val_xlim*1.01,val_ylim*0.1,val_zlim*0.1,'X')
text(0,val_ylim,1,'Y')
text(0,2,val_zlim-2,'Z')


%%  Base of windmill
% Dimensions of Base
bsx = 4.0;
bsy = 4.0;
bsz = 5.0;

%Scale, Translation and Rotation Matrices of Base
Sb = scale3D (bsx, bsy, bsz);
thetabase = 0;
Tb = translate3D(0,0,0);
Rxb = rotate3Dz(degree_to_radian(thetabase));

%  Transformation Matrix of Base of windmill
B = Tb*Rxb;

%Generating Transformed model of the Base
BASE = B * Sb * cone;

% Plot Transformed Base
plot3 (BASE (1,:), BASE (2,:), BASE(3,:), 'k');


%%  House of windmill	
% Dimensions of House
hsx = 10.0;
hsy = 15.0;
hsz = 10.0;

%Scale, Translation and Rotation Matrices of House
Sh = scale3D (hsx, hsy, hsz);
Th = translate3D(0,0,bsz);
Rhx = rotate3Dx(degree_to_radian(90));

%  Transformation Matrix of House
H = Th*Rhx;

%Transformation of House with respect to House
% HOUSEwrtB = H*Sh*cube;
% HOUSE = B*H*Sh*cube;
Ralpha = rotate3Dy(degree_to_radian(house_rot));

%Generating Transformed model of House
HOUSE = B*H*Ralpha*Sh*cube;

% Plot transformed House
plot3 (HOUSE (1,:), HOUSE (2,:), HOUSE(3,:), 'b');


%% Shaft
% Plot Shaft without transformation
plot3(shaft(1,:),shaft(2,:),shaft(3,:))

%Scale, Translation and Rotation Matrices of Shaft
Ts = translate3D(0, 2*hsy/3, -hsz/2);
Rsx = rotate3Dx(degree_to_radian(180));

%Transformation matrix of Shaft
S = Ts*Rsx;

%%Generating Transformed model of Shaft with respect to previous components
SHAFT = B*H*Ralpha*S*shaft;

%Plot transformed shaft
plot3 (SHAFT(1,:),SHAFT (2,:), SHAFT(3,:), 'r');


%%  Blades of propeller.
% Dimensions of Propeller
bladesx = 7.0;
bladesy = 0.5;

%Scale, Translation and Rotation Matrices of Propeller
blade_scale = scale3D (bladesx, bladesy, 0.0);
blade1 = blade_scale * square;

blade_orientz = rotate3Dz (degree_to_radian (90.0));
blade2 = blade_orientz* blade_scale * square;

% Plot Propeller without transformation
plot3 (blade1(1,:), blade1 (2,:), blade1(3,:), 'r');
plot3 (blade2(1,:), blade2 (2,:), blade2(3,:), 'r');

% PROPELLER TRANSFORMATIONS
Rzbeta = rotate3Dz(degree_to_radian(prop_rot));

PROP1 = B*H*Ralpha*S*Rzbeta*blade1;
PROP2 = B*H*Ralpha*S*Rzbeta*blade2;

%Plot transformed propeller
plot3 (PROP1(1,:),PROP1(2,:), PROP1(3,:), 'r');
plot3 (PROP2(1,:),PROP2(2,:), PROP2(3,:), 'r');

% axis ('square');
% figure (2)
% plot3 (SHAFT(1,:),SHAFT (2,:), SHAFT(3,:), 'r');


%% Animate rotation of propeller
prop_rot1 = 0:10:360;
for i = 1:size(prop_rot1,2)
    prop_rot = prop_rot1(1,i);
    % PROPELLER TRANSFORMATIONS
    Rzbeta = rotate3Dz(degree_to_radian(prop_rot));

    PROP1 = B*H*Ralpha*S*Rzbeta*blade1;
    PROP2 = B*H*Ralpha*S*Rzbeta*blade2;
    
    clf
    figure (2);
    axis ('equal');
    hold on
    view([0,1,0])
    grid on
    quiver3 (GCSx(1,1), GCSx(2,1), GCSx(3,1), val_xlim*GCSx(1,2), GCSx(2,2), GCSx(3,2), 'k');
    quiver3 (GCSy(1,1), GCSy(2,1), GCSy(3,1), GCSy(1,2), val_ylim*GCSy(2,2), GCSy(3,2), 'k');
    quiver3 (GCSz(1,1), GCSz(2,1), GCSz(3,1), GCSz(1,2), GCSz(2,2), val_zlim*GCSz(3,2), 'k');
    text(val_xlim*1.01,val_ylim*0.1,val_zlim*0.1,'X')
    text(0,val_ylim,1,'Y')
    text(0,2,val_zlim-2,'Z')
    plot3 (BASE (1,:), BASE (2,:), BASE(3,:), 'k');
    plot3 (HOUSE (1,:), HOUSE (2,:), HOUSE(3,:), 'b');
    plot3 (SHAFT(1,:),SHAFT (2,:), SHAFT(3,:), 'r');
    plot3 (PROP1(1,:),PROP1(2,:), PROP1(3,:), 'r');
    plot3 (PROP2(1,:),PROP2(2,:), PROP2(3,:), 'r');
    drawnow
    pause(0.2)
    
end

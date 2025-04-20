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
cube = [-0.5, -0.5, -0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, ...
   -0.5, -0.5, 0.5, 0.5, -0.5;
   0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1;
   -0.5, 0.5, 0.5, -0.5, -0.5, -0.5, 0.5, 0.5, -0.5, -0.5, 0.5, 0.5, ...
   0.5, 0.5, -0.5, -0.5;
   1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

square = [-0.5, -0.5, 0.5, 0.5, -0.5;  
    -0.5, 0.5, 0.5, -0.5, -0.5;
   0, 0, 0, 0, 0;
   1, 1, 1, 1, 1];
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
house_rot = 30.0;
prop_rot = 30.0;

%  Define viewing angles.
vroll = degree_to_radian (0.0);
vpitch = degree_to_radian (0.0);
vyaw = degree_to_radian (0.0);
g = rotate3Dz (vroll) * rotate3Dy (vpitch) * rotate3Dx (vyaw);

%  Base of windmill
bsx = 4.0;
bsy = 4.0;
bsz = 5.0;
bscale = scale3D (bsx, bsy, bsz);
base = g * bscale * cone;

%  House of windmill	
hsx = 10.0;
hsy = 15.0;
hsz = 10.0;
hscale = scale3D (hsx, hsy, hsz);
hrot = rotate3Dz (degree_to_radian (house_rot));
horient = rotate3Dx (degree_to_radian (90.0));
htrans = translate3D (0.0, 0.0, bsz);
house_orient = g * htrans * hrot;
house = house_orient * horient * hscale * cube;

%  Blades of propeller.
shaft_axis = translate3D (0.0, -0.5*hsz-1.0, 0.66667*hsy);
bladesx = 7.0;
bladesy = 0.5;
blade_scale = scale3D (bladesx, bladesy, 0.0);
prop_mat = rotate3Dy (degree_to_radian (prop_rot));
blade_orientx = rotate3Dx (degree_to_radian (90.0));
blade_trans = translate3D (0.5*bladesx, 0.0, 0.0);
blade_xform = house_orient * shaft_axis * prop_mat * blade_orientx;
blade_pts = blade_scale * square;
blade1 = blade_xform * blade_trans * blade_pts;
blade_fan = rotate3Dz (degree_to_radian (90.0));
blade2 = blade_xform * blade_fan * blade_trans * blade_pts;
blade_fan = rotate3Dz (degree_to_radian (180.0));
blade3 = blade_xform * blade_fan * blade_trans * blade_pts;
blade_fan = rotate3Dz (degree_to_radian (270.0));
blade4 = blade_xform * blade_fan * blade_trans * blade_pts;

%  Plot 2D Top view of the Windmill.
figure(1);
axis ('square');
plot (base (1,:), base (2,:), 'k');
hold on;
plot (house (1,:), house (2,:), 'b');
plot (blade1 (1,:), blade1 (2,:), 'r');
plot (blade2 (1,:), blade2 (2,:), 'r');
plot (blade3 (1,:), blade3 (2,:), 'r');
plot (blade4 (1,:), blade4 (2,:), 'r');
hold off;
grid on;

%  Plot 3D Isometric view of the Windmill.
figure(2);
axis ('equal');
plot3 (base (1,:), base (2,:), base(3,:), 'k');
hold on;
plot3 (house (1,:), house (2,:), house(3,:), 'b');
plot3 (blade1 (1,:), blade1 (2,:), blade1(3,:), 'r');
plot3 (blade2 (1,:), blade2 (2,:), blade2(3,:), 'r');
plot3 (blade3 (1,:), blade3 (2,:), blade3(3,:), 'r');
plot3 (blade4 (1,:), blade4 (2,:), blade4(3,:), 'r');
hold off;



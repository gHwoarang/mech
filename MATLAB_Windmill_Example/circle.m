function [coord] = circle(r,xcoord,ycoord, n)
%==========================================================================
%                                DEFINITIONS
%==========================================================================
% 1. PURPOSE: Computes a series of points around a circle centered at 
% (xcoord, ycoord). Circle lies in the XY plane.

% -INPUT PARAMETERS
% r      : the radius of the circle
% xcoord : the xcoordinate of the circle
% ycoord : the ycoordinate of the circle
% n      : number of circle segments to create

% -OUTPUT PARAMETERS
% coord  : Coord a 90 element matrix of points that form a circle

% 2. REFERENCES:
% [1]. David W. Rosen, Georgia Institute of Technology, ME6103 Course Notes

% 3. OTHERS:
% Modifed Date: 05/03/2018
% By : Recep M. Gorguluarslan

%==========================================================================
%                              FUNCTION BODY
%==========================================================================
j=0;
incr = 360.0/n;
for i = 0:incr:360
   ang = i*(pi/180);
   j=j+1;
   coord(1,j)= (r*cos(ang))+xcoord;
   coord(2,j)= (r*sin(ang))+ycoord;
   coord(3,j) = 0.0;
   coord(4,j) = 1.0;
end



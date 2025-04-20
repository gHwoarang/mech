function M = scale3D (scalex, scaley, scalez)
%%   Returns a matrix that performs scaling along the X, Y, and Z axes
%   
M = eye(4);
M(1,1) = scalex;
M(2,2) = scaley;
M(3,3) = scalez;

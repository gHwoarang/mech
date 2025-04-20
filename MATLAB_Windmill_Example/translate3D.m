function M = translate3D (x, y, z)
%
%   Returns a matrix that performs a 3-D translation.
%  
M = eye(4);
M(1,4) = x;
M(2,4) = y;
M(3,4) = z;

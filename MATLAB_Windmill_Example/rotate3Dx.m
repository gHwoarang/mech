function M = rotate3Dx(theta)
%
%   Returns a matrix that performs a rotation about the X axis
%   3-D rotation matrix
M = eye(4);
M(2,2) = cos(theta);
M(3,3) = M(2,2);
M(2,3) = - sin(theta);
M(3,2) = - M(2,3);

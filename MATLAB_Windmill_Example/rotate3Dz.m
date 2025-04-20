function M = rotate3Dz(theta)
%
%   Returns a matrix that performs a rotation about the Z axis
%   3-D rotation matrix
M = eye (4);
M(1,1) = cos(theta);
M(2,2) = M(1,1);
M(1,2) = - sin(theta);
M(2,1) = - M(1,2);

function M = rotate3Dy(theta)
%
%   Returns a matrix that performs a rotation about the Y axis
%   3-D rotation matrix
M = eye (4);
M(1,1) = cos(theta);
M(3,3) = M(1,1);
M(1,3) = sin(theta);
M(3,1) = - M(1,3);

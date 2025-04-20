function [axesX, axesY, axesZ] = unitAxis()
% Creates an orthogonal unit axis
    point0 = [0;0;0];
    pointX = [1;0;0];
    pointY = [0;1;0];
    pointZ = [0;0;1];
    
    lineX = [point0, pointX];
    lineY = [point0, pointY];
    lineZ = [point0, pointZ];

%     plot(lineX(1,:), lineX(2,:), lineX(3,:),"k")
%     plot(lineY(1,:), lineY(2,:), lineY(3,:),"r")
%     plot(lineZ(1,:), lineZ(2,:), lineZ(3,:),"b")
    
    axesX = lineX;
    axesY = lineY;
    axesZ = lineZ;
end
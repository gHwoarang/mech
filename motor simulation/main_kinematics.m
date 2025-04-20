[axesX, axesY, axesZ] = unitAxis();

figure(1)
hold on
plot3(axesX(1,:), axesX(2,:), axesX(3,:),"k")
plot3(axesY(1,:), axesY(2,:), axesY(3,:),"k")
plot3(axesZ(1,:), axesZ(2,:), axesZ(3,:),"k")
hold off

axis equal

xlim([-10, 10])
ylim([-10, 10])
zlim([-10, 10])

view(45,20)

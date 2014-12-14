%% Problem1
%
C = [8*200 0 400; 0 8*200 300; 0 0 1];

%% part (b).

%% Quaternion
rotate = makehgtform('axisrotate',[3/sqrt(26),4/sqrt(26),-1/sqrt(26)],pi/3);
% for translation 
rotate(:,4) = [0 0 10 1];
Q = rotate;

% (As discussed with professor) converting to camera external paramerters after multiplying
% to identity matrix so that it becomes 3X4 

WM =  [1 0 0 0; 0 1 0 0; 0 0 1 0] * Q
%% Part C

% Cube coordinates (cc) are along the center (0,0,0)
cc = [-1 -1 -1 1; 1 -1 -1 1; -1 1 -1 1; 1 1 1 1; -1 1 1 1; 1 -1 1 1; 1 1 -1 1; -1 1 -1 1];
pixel_coordinates = C * WM * cc';

%% converting to homogeneous form
for i = 1:8
    pixel_coordinates(1,i) = pixel_coordinates(1,i)/pixel_coordinates(3,i);
    pixel_coordinates(2,i) = pixel_coordinates(2,i)/pixel_coordinates(3,i);
    pixel_coordinates(3,i) = pixel_coordinates(3,i)/pixel_coordinates(3,i);
    
end

pixel_coordinates

%% plotting the points with line and plot3
figure;
for i = 1:8
    x = [cc(i,1) pixel_coordinates(1,i)];
    y = [cc(i,2) pixel_coordinates(2,i)];
    z = [0 pixel_coordinates(3,i)];
    plot3(x,y,z)
    line(x,y,z);
    hold on
end

%% plot with plot3
figure;
imshow('figure_with_plot.jpg')

%% part d

%% taking point X at infinity by taking high values of X ~ 10^20 and y=1 z =1

pixel_coordinates_infinity_x = C * WM * [10^10 1 1 1]';
pixel_coordinates_infinity_x(1,1) = pixel_coordinates_infinity_x(1,1)/pixel_coordinates_infinity_x(3,1);
pixel_coordinates_infinity_x(2,1) = pixel_coordinates_infinity_x(2,1)/pixel_coordinates_infinity_x(3,1);
pixel_coordinates_infinity_x(3,1) = pixel_coordinates_infinity_x(3,1)/pixel_coordinates_infinity_x(3,1);
pixel_coordinates_infinity_x

%% taking point Y at infinity by taking high values of Y ~ 10^10 and x=1 z =1

pixel_coordinates_infinity_y = C * WM * [1 10^10 1 1]';
pixel_coordinates_infinity_y(1,1) = pixel_coordinates_infinity_y(1,1)/pixel_coordinates_infinity_y(3,1);
pixel_coordinates_infinity_y(2,1) = pixel_coordinates_infinity_y(2,1)/pixel_coordinates_infinity_y(3,1);
pixel_coordinates_infinity_y(3,1) = pixel_coordinates_infinity_y(3,1)/pixel_coordinates_infinity_y(3,1);
pixel_coordinates_infinity_y

%% taking point Z at infinity by taking high values of z ~ 10^10 and x=1 z =1

pixel_coordinates_infinity_z = C * WM * [1 1 10^10 1]';
pixel_coordinates_infinity_z(1,1) = pixel_coordinates_infinity_z(1,1)/pixel_coordinates_infinity_z(3,1);
pixel_coordinates_infinity_z(2,1) = pixel_coordinates_infinity_z(2,1)/pixel_coordinates_infinity_z(3,1);
pixel_coordinates_infinity_z(3,1) = pixel_coordinates_infinity_z(3,1)/pixel_coordinates_infinity_z(3,1);
pixel_coordinates_infinity_z

%% taking point at X, Y , Z at infinity by taking high values of x, y, z

pixel_coordinates_infinity_xyz = C * WM * [10^10 10^10 10^10 1]';
pixel_coordinates_infinity_xyz(1,1) = pixel_coordinates_infinity_xyz(1,1)/pixel_coordinates_infinity_xyz(3,1);
pixel_coordinates_infinity_xyz(2,1) = pixel_coordinates_infinity_xyz(2,1)/pixel_coordinates_infinity_xyz(3,1);
pixel_coordinates_infinity_xyz(3,1) = pixel_coordinates_infinity_xyz(3,1)/pixel_coordinates_infinity_xyz(3,1);
pixel_coordinates_infinity_xyz
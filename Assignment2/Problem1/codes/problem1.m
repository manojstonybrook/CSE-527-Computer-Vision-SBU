
%% Problem1 Sift Feature Calculation
startup;
I = imread('dog.jpg');

if (size(I,3) ~= 1)
   I = rgb2gray(I);    
end

I = im2double(I);

%%  Part1
[ pos, scale, orient, desc ] = SIFT( I, 4, 2, ones(size(I)), 0.02, 10, 2);
 
%  [ pos, scale, orient, desc ] = SIFT( I, 4, 2, ones(size(I)), 0.02, 10, 1);

%%  Part2

 database = add_descriptors_to_database( I, pos, scale, orient, desc);


%% Part3

  rot = [cos(pi/6) -sin(pi/6) 0; sin(pi/6) cos(pi/6) 0];
  [rotImage, mA] = imWarpAffine(I, rot, 1);
  [ pos1, scale1, orient1, desc1 ] = SIFT( rotImage, 4, 2, ones(size(I)), 0.02, 10, 2);
%   [ pos1, scale1, orient1, desc1 ] = SIFT( rotImage, 4, 2, ones(size(I)), 0.02, 10, 1);
 
%% Part4

  [IM_IDX, TRANS, THETA, RHO, DESC_IDX, NN_IDX, WGHT] = hough( database, pos1, scale1, orient1, desc1);

%% Part 5

[m,ind] = max(WGHT)


%% PART 6

A = fit_robust_affine_transform(pos1(DESC_IDX{ind},:)', pos(NN_IDX{ind},:)')








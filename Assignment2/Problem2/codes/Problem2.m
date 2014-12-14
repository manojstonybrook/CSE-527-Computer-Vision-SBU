
%% Problem2 Scene Matching
startup;
I_left = imread('wadham001.pgm');
I_right = imread('wadham004.pgm');

if (size(I_left,3) ~= 1)
   I_left = rgb2gray(I_left);
   I_right = rgb2gray(I_right);   
end

I_left = imresize(im2double(I_left), [256,256]);
I_right = imresize(im2double(I_right),[256,256]);


%%  Part1
% [ pos, scale, orient, desc ] = SIFT( I, 4, 2, ones(size(I)), 0.02, 10, 2);
 
  [ pos, scale, orient, desc ] = SIFT( I_left, 4, 2, ones(size(I_left)), 0.02, 10, 1);

%%  Part2

 database = add_descriptors_to_database( I_left, pos, scale, orient, desc);


%% Part3

 [ pos1, scale1, orient1, desc1 ] = SIFT( I_right, 4, 2, ones(size(I_right)), 0.02, 10, 1);
%   [ pos1, scale1, orient1, desc1 ] = SIFT( rotImage, 4, 2, ones(size(I)), 0.02, 10, 1);
 
%% Part4

 [IM_IDX, TRANS, THETA, RHO, DESC_IDX, NN_IDX, WGHT] = hough( database, pos1, scale1, orient1, desc1);

%% Part 5

[m,ind] = max(WGHT);


%% PART 6

A = fit_robust_affine_transform(pos1(DESC_IDX{ind},:)', pos(NN_IDX{ind},:)')


%% Problem 2

aligned =  imWarpAffine(I_left, A, 1);
size(aligned)
imshow(abs(aligned-I_right))













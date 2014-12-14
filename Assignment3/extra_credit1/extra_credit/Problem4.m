%%%Points 
I_left = imread('1.jpg');
I_right = imread('2.jpg');
[m n]=size(I_left);


if (size(I_left,3) ~= 1)
   I_left = rgb2gray(I_left);    
end

I_right = im2double(I_right);

%%  Part1
[ pos, scale, orient, desc ] = SIFT( I_left, 4, 2, ones(size(I_left)), 0.02, 10, 2);
 
%  [ pos, scale, orient, desc ] = SIFT( I, 4, 2, ones(size(I)), 0.02, 10, 1);

%%  Part2

 database = add_descriptors_to_database( I, pos, scale, orient, desc);


%% Part3

  [ pos1, scale1, orient1, desc1 ] = SIFT( I_right, 4, 2, ones(size(I)), 0.02, 10, 2);
%   [ pos1, scale1, orient1, desc1 ] = SIFT( rotImage, 4, 2, ones(size(I)), 0.02, 10, 1);
 
%% Part4

  [IM_IDX, TRANS, THETA, RHO, DESC_IDX, NN_IDX, WGHT] = hough( database, pos1, scale1, orient1, desc1);

%% Part 5

[m,ind] = max(WGHT)


img1pts = pos(NN_IDX{ind},:)';
img2pts = pos1(DESC_IDX{ind},:)';


%%RANSAC randomly selecting 6 points upto 100 iteration
min_points = 0;
min_err = 0;
selected = [];
condition = false;
for i = 1:100
 left = [];
 right = [];
 points = [];
 count = 0;
 while(1)
 
  j = floor(10 * rand + 1);
  if(length(points) == 0)
    points = [points;j];
    count = count+1;
  else  
   for k = 1:length(points)
      if(points(k) == j)
	 condition = true;
      	end
    end
     if(condition == false)
      points = [points;j];
      count = count + 1;
   end
  end
  
   if (count == 6)
    break;
   end
   condition = false;	   

end


 for k = 1 : length(points)
  left = [left; img1pts(points(k),:)];
  right = [right; img2pts(points(k),:)];
 end 

 H = ComputeWarpMapping(left, right);
total_e = 0;
 for k = 1 : length(img1pts)
   trans = img1pts(k,:) * H;
   orig = img2pts(k,:);
   total_e = total_e + sum((trans - orig).^2);
 end 
 total_e
if (min_err == 0)
  min_err = total_e;
  min_points = points;
elseif total_e < min_err
   min_err = total_e;
  min_points = points;    
end

end

min_err
left = [];
right = [];
 for i = 1 : length(min_points)
  left = [left; img1pts(min_points(i),:)];
  right = [right; img2pts(min_points(i),:)];
 end

size(left)
size(right)
H = ComputeWarpMapping(left, right);
warpimag1 = WarpImage(I_left, H);
warpimag2 = merge(warpimag1, I_right, H);
figure;
imshow(warpimag2)


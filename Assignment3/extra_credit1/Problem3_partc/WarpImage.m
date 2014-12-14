function [img1warp] = WarpImage(img1, A)

[m n c] = size(img1)

%%cornor cases calculation
img1 = im2double(img1);
boundary_points = [1 1 1; n 1 1; 1 m 1; n m 1];
boundary_corners = [];

for i = 1:size(boundary_points,1)
  points =  boundary_points(i,:)*A;
  boundary_corners = [boundary_corners; points];
end

min_x = min(boundary_corners(:,1));
max_x = max(boundary_corners(:,1));
min_y = min(boundary_corners(:,2));
max_y = max(boundary_corners(:,2));

%if(min_x > 0)
%  min_x = 0;
%end

%if(max_x < 1280)
%  max_x = 1280;
%end

%if(min_y > 0)
%  min_y = 0;
%end

%if(max_y < 960)
%  max_y = 960;
%end

min_x = floor(min_x);
max_x = ceil(max_x);
min_y = floor(min_y);
max_y = ceil(max_y);

warpsize = [ceil(max_y-min_y) ceil(max_x-min_x) c]
img1warp = zeros(warpsize(1), warpsize(2), 3);

%%Forward Mapping
%for row = 1:m
%  for col = 1:n
%	pts = [col row 1];
%	transform_point = pts * A;
%	for channel = 1:3  
%	  img1warp(ceil(transform_point(2)-min_y), ceil(transform_point(1)-min_x), channel) = img1(row, col, channel);
%	end 
%   end
%end

 
A = inv(A);
%%Backward Mapping
for row = ceil(min_y):ceil(max_y)
   for col = ceil(min_x):ceil(max_x)
	pts = [col row 1];
	transform_point = pts * A;

	transform_point(1) = ceil(transform_point(1)/transform_point(3));
	transform_point(2) = ceil(transform_point(2)/transform_point(3));

	if(transform_point(1) > 1 && transform_point(1) < n && transform_point(2) > 1 && transform_point(2) < m)
	  for channel = 1:3  
	    img1warp(ceil(row-min_y), ceil(col-min_x), channel) = img1(transform_point(2), transform_point(1), channel);
	  end 
	end

   end
end

save 'prevdata.mat' min_x min_y max_x max_y
end



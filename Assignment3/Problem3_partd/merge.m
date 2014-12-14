function [warpimag2] = merge(warpimg1, img1, A)

load 'prevdata.mat'

[m n c] = size(img1);
img1 = im2double(img1);

for row = 1:m
   for col = 1:n
	for channel = 1:3  
	  if(warpimg1(ceil(row-min_y), ceil(col-min_x), channel)~=0) 
	    warpimg1(ceil(row-min_y), ceil(col-min_x), channel)	= warpimg1(ceil(row-min_y), ceil(col-min_x), channel)/4+3*img1(row, col, channel)/4;
	    %warpimg1(ceil(row-min_y), ceil(col-min_x), channel)	= (warpimg1(ceil(row-min_y), ceil(col-min_x), channel)+img1(row, col, channel))/2;
	  else
	    warpimg1(ceil(row-min_y), ceil(col-min_x), channel)	= img1(row, col, channel);		
	  end

	end 
   end
end

warpimag2 = warpimg1;
end

function [vector] = vector_training(I, r)
     cellsize = [3 3;4 4;6 6;8 8];
     block_size = [6 6;8 8;12 12;16 16];
     block_stride = [2 2;2 4;4 4;4 8];
     detecter_stride = [1 1;2 2;4 4;8 8];
     orientations = [9 9 9 18];
     R = 4; %% number of resolutions
     width = 64;
     height = 128;
     trainvector = [];
     margin = 16;
     margin_det = 3;

     scale = 2^(R-r);
     I1 = imresize(I, 1.0/scale);
     width1 = width/scale; %% Detecter size
     height1 = height/scale;
     	[h1 w1 c1] = size(I1);
     vector = [];
     cell = block_size(r,1)/cellsize(r,1);

     for block_y = margin/scale:block_stride(r,2):margin/scale+height1-block_size(r,2)
       for block_x = margin/scale:block_stride(r,1):margin/scale+width1-block_size(r,1)
         block = I1(block_y:block_y+block_size(r,2)-1,block_x:block_x+block_size(r,1)-1,1:3);
         block = im2single(block);
	 hogblock = vl_hog(block, cell, 'numOrientations', orientations(r));
         reshape_hogblock = reshape(hogblock, [], 1);
	 vector = [vector; reshape_hogblock];
       end
     end
     
end


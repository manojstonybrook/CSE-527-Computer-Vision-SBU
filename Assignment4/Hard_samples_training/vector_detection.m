function [found] = vector_detection(I, r, train_mat)
     cellsize = [3 3;4 4;6 6;8 8];
     block_size = [6 6;8 8;12 12;16 16];
     block_stride = [2 2;2 4;4 4;4 8];
     detecter_stride = [1 1;2 2;4 4;8 8];
     orientations = [9 9 9 18];
     theta_r = [0 0 0 0];
     alpha = 2;
     R = 4; %% number of resolutions
     width = 64;
     height = 128;
     trainvector = [];
     margin = 16;
     margin_det = 3;

     scale = alpha^(R-r);
     I1 = imresize(I, 1.0/scale);
     width1 = width/scale; %% Detecter size
     height1 = height/scale;
     [h1 w1 c1] = size(I1);
     vector = [];
     cell = block_size(r,1)/cellsize(r,1);
     res_loc = alpha;
     offset_x = 0;
     offset_y = 0;
     if(width1 >= w1)
	offset_x = 1;
     end
     if(height1 >= h1)
	offset_y = 1;
     end
      found = 0;
      for det_y = 1:detecter_stride(r,2):h1-height1+offset_y
       for det_x = 1:detecter_stride(r,1):w1-width1+offset_x
	      detector = I1(det_y:det_y+height1-1, det_x:det_x+width1-1, 1:3); 
              vector = [];        
	      for block_y = 1:block_stride(r,2):height1-block_size(r,2)+1
		for block_x = 1:block_stride(r,1):width1-block_size(r,1)+1
		  block = detector(block_y:block_y+block_size(r,2)-1,block_x:block_x+block_size(r,1)-1,1:3);
		  block = im2single(block);
		  hogblock = vl_hog(block, cell, 'numOrientations', orientations(r));
		  reshape_hogblock = reshape(hogblock, [], 1);
		  vector = [vector; reshape_hogblock];		     
		end
	      end
		
	      score = train_mat{r}.weight' * vector + train_mat{r}.bais;
		
	      if(score > theta_r(r))				 
	 	found = 1;
              end
	
       end
     end                
     
end


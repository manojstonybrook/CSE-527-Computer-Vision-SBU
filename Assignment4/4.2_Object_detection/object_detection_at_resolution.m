cellsize = [3 3;4 4;6 6;8 8];
block_size = [6 6;8 8;12 12;16 16];
block_stride = [2 2;2 4;4 4;4 8];
detecter_stride = [1 1;2 2;4 4;8 8];
orientations = [9 9 9 18];
theta_r = [0 0 0 0];
Images_to_detect = 100;
R = 4; %% number of resolutions

alpha = 2
beta = 1.2;

width = 64;
height = 128;
margin = 3;
result_display = 1;
load train_matrix.mat;
labels = [];
predicted = [];
fid = fopen('pos_fullImage.lst');

for j=1:Images_to_detect
 tline = fgetl(fid);
 locations = 0;

 I = imread(tline);
 [orig_height orig_width c] = size(I);
 for r = 1:R %lowest to highest

  res = [];
  Y{r}{1} = zeros(floor(orig_height/(alpha^(R-r))), floor(orig_width/(alpha^(R-r))));
    
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

      for det_y = 1:detecter_stride(r,2):h1-height1+offset_y
       for det_x = 1:detecter_stride(r,1):w1-width1+offset_x
	     if(r==1 || Y{r-1}{1}(floor((det_y+res_loc-1)/res_loc), floor((det_x+res_loc-1)/res_loc)) == 1)
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
	 	Y{r}{1}(det_y, det_x) = 1;   % Y{r}{s} Resolution scale space
		if(r == R)
		  locations = locations+1;
		end
              end
	   end	

	
       end
     end                

  end

   if(result_display)
      if(locations > 0)
       I = imread(tline);
       [h w c] = size(I);
       imshow(I);
       hold on;
       [r c] = size(Y{R}{1});
       for row = 1:r 
	 for col = 1:c
	 if(Y{R}{1}(row,col) == 1)
           rectangle('Position',[col row 64 128], 'LineWidth',0.5, 'EdgeColor','b');
	 end
         end
       end
     
     pause(0.01);
    end			
  end

  if(locations > 0)
    predicted = [predicted 1];
  else
    predicted = [predicted 0];	
  end  

  labels = [labels 1];

end


error = abs(labels - predicted);
total_error = sum(sum(error))
  
fclose(fid);   

%clear;

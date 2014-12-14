cellsize = [3 3;4 4;6 6;8 8];
block_size = [6 6;8 8;12 12;16 16];
block_stride = [2 2;2 4;4 4;4 8];
detecter_stride = [1 1;2 2;4 4;8 8];
orientations = [9 9 9 18];
theta_r = [0.05 0.1 0.2 0.3];
Images_to_detect_pos = 100;
Images_to_detect_neg = 100;
R = 4; %% number of resolutions
S = 1; %% number of scales;
detecter_width = 64;
detecter_height = 128;
margin = 3;
result_display = 0;
load train_matrix.mat;
labels = [];
predicted = [];
alpha = 2;
beta = 3;

for p = 1:-2:-1
 
 if (p == 1)
   fid = fopen('test.lst');
   Images_to_detect = Images_to_detect_pos;
 else
   Images_to_detect = Images_to_detect_neg;
   fid = fopen('neg_test.lst');
 end


for j=1:Images_to_detect

 tline = fgetl(fid); 
 locations = 0;
 I = imread(tline);
 [orig_height orig_width c] = size(I);
 beta_test = beta;
 while((orig_height/beta_test) > detecter_height && (orig_width/beta_test) > detecter_width)
   S = S+1;
   beta_test = beta_test^beta;
 end

 %disp('Number of scales possible');
 %disp(S);
 for r = 1:R %lowest to highest

  scale = alpha^(R-r);
  width1 = detecter_width/scale;   %% Detecter size fixed for all the scales
  height1 = detecter_height/scale;
     
  for s = 1:S % Number os scales possible

  res = [];
  
  scale_res = alpha^(R-r) * beta^(S-s);
  Y{r}{s} = zeros(floor(orig_height/scale_res), floor(orig_width/(scale_res)));
    
     
     I1 = imresize(I, 1.0/scale_res);
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
	     if(r==1 || Y{r-1}{s}(floor((det_y+res_loc-1)/res_loc), floor((det_x+res_loc-1)/res_loc)) == 1)
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
	 	Y{r}{s}(det_y, det_x) = 1;   % Y{r}{s} Resolution scale space
		if(r == R)
		  locations = locations+1;
		end
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
	%I = imresize(I, 1.0/alpha^(R-1));
        window_width = detecter_width; %/alpha^(R-1);
	window_height = detecter_height; %/alpha^(R-1);
	imshow(I);
         hold on;         
       for s = 1:S
         [r1 c1] = size(Y{R}{s});
         for row = 1:r1
	   for col = 1:c1
	   if(Y{R}{s}(row,col) == 1)
             rectangle('Position',[floor(col*beta^(S-s)) floor(row*beta^(S-s)) floor(window_width*beta^(S-s))  floor(window_height*beta^(S-s))], 'LineWidth',0.5, 'EdgeColor','b');
	  end
          end
        end
       end
     pause(0.01);
    end			
  end

  if(p==1)
     if(locations > 0)
       predicted = [predicted 1];
     else
       predicted = [predicted 0];	
     end
     labels = [labels 1];  
  else
    if(locations > 0)
       predicted = [predicted 0];
     else
       predicted = [predicted -1];	
     end
     labels = [labels -1]; 
  end

  
end


  
fclose(fid);   
end

%predicted
%labels
error = abs(labels - predicted);
pos_error = sum(error(1:Images_to_detect_pos))
neg_error = sum(error(Images_to_detect_pos+1:Images_to_detect_pos+Images_to_detect_neg))
total_error = sum(error)
percent_accuracy = (((Images_to_detect_pos+Images_to_detect_neg) - (total_error))/(Images_to_detect_pos+Images_to_detect_neg)) * 100 

%clear;

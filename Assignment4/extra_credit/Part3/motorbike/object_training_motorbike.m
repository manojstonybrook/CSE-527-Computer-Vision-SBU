cellsize = [3 3;5 4;6 6;8 8];
block_size = [6 6;10 8;12 12;16 16];
block_stride = [3 2;4 3;6 4;8 4];
detecter_stride = [1 1;2 2;4 4;8 8];
orientations = [9 15 18 18];
Images_to_train = 30;
detecter_size = [15 10;30 20;60 40;120 80];

R = 4; %% number of resolutions
width = 120;
height = 80;
trainvector = [];
margin = 16;
 
%% Number of Resolutions
for r = 1:R %lowest to highest

vector_reso = [];
label_reso = [];

%% loop for number of negative and positive images
fid = fopen('motorbike_train.txt');
    
 for j=1:Images_to_train

   tline = fgetl(fid);
   image = ['/PNGImages/' tline(1:6) '.png'];
   p = str2num(tline(8:9));
 
     I = imread(image);
     I = imresize(I, [80+32 120+32]);
     scale = 2^(R-r);
     I1 = imresize(I, 1.0/scale);
     width1 = detecter_size(r,1); %% Detecter size
     height1 = detecter_size(r,2);
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

     vector_reso = [vector_reso vector];
     label_reso = [label_reso p];  %% positive +1 and negative -1 
     
end
fclose(fid);   
[W, B] = vl_svmtrain(vector_reso, label_reso, 0.0001);
train_mat{r}.weight = W;
train_mat{r}.bais = B;
%score = W' * vector_reso + B
 
end

save 'train_matrix_motorbike_50.mat' train_mat
clear;

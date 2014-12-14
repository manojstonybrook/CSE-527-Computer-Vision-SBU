cellsize = [3 2;4 3;6 4;8 6];
block_size = [6 4;8 6;12 8;16 12];
block_stride = [2 1;3 2;4 4;8 4];
detecter_stride = [1 1;2 2;4 4;8 8];
orientations = [9 18 18 18];
Images_to_train = 50;
detecter_size = [13 7;26 14;52 28;104 56];

R = 4; %% number of resolutions
width = 104;
height = 56;
trainvector = [];
margin = 16;
 
%% Number of Resolutions
for r = 1:R %lowest to highest

vector_reso = [];
label_reso = [];

%% loop for number of negative and positive images
fid = fopen('car_train.txt');
    
 for j=1:Images_to_train

   tline = fgetl(fid);
   image = ['/PNGImages/' tline(1:6) '.png'];
   p = str2num(tline(8:9));
 
     I = imread(image);
     I = imresize(I, [88 136]);
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

save 'train_matrix_car_1250.mat' train_mat
clear;

cellsize = [3 3;4 4;6 6;8 8];
block_size = [6 6;8 8;12 12;16 16];
%% changed for  extra credit problem
block_stride = [6 6;8 8;12 12;4 8];
detecter_stride = [1 1;2 2;4 4;8 8];
orientations = [9 9 9 18];

Images_to_train = 100; % 100 positive and 100 negative
hard_samples_to_test = 50;
R = 4; %% number of resolutions
width = 64;
height = 128;
trainvector = [];
margin = 16;
margin_det = 3;
fid_pos = fopen('pos.lst');
fid_neg = fopen('create_neg.lst');


%% Number of Resolutions
for r = 1:R %lowest to highest

vector_reso = [];
label_reso = [];

%% loop for number of negative and positive images 
for j=1:Images_to_train
  for p = 1:-2:-1
   if (p == 1)
     tline = fgetl(fid_pos);
   else
    tline = fgetl(fid_neg);
   end

     I = imread(tline);
     vector = vector_training(I, r);
     vector_reso = [vector_reso vector];
     label_reso = [label_reso p];  %% positive +1 and negative -1 
 end
 
end

%% Adding Hard samples
if(r>1)
 fid_hard_samples = fopen('hard_samples_set.lst');
  count = 0;
 for hard = 1:hard_samples_to_test
 tline1 = fgetl(fid_hard_samples);
 I = imread(tline1);    
 found = vector_detection(I, r-1, train_mat);
 %% If hard sample gives positive than add it to training set
 if found == 1
    count = count+1
    vector = vector_training(I, r);  
    vector_reso = [vector_reso vector];
    label_reso = [label_reso -1]; 
 end

 end 
 fclose(fid_hard_samples);
end 

[W, B] = vl_svmtrain(vector_reso, label_reso, 0.000001);
train_mat{r}.weight = W;
train_mat{r}.bais = B;
%score = W' * vector_reso + B
end 

fclose(fid_pos);   
fclose(fid_neg);  
save 'train_matrix_100_hard_samples.mat' train_mat
clear;

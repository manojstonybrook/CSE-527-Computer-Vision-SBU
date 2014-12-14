%% Problem1 Sift Feature Calculation
startup;

phone_ref = imread('phone0003.pgm');
book_ref = imread('nutshell0003.pgm');

if (size(phone_ref,3) ~= 1)
   phone_ref = rgb2gray(phone_ref);
   book_ref = rgb2gray(book_ref);
end

phone_ref = imresize(im2double(phone_ref));
book_ref = imresize(im2double(book_ref));

%%  Part1 SIFT of Reference points
%[ pos, scale, orient, desc ] = SIFT( I, 4, 2, ones(size(I)), 0.02, 10, 2);
 
 [ pos_phone, scale_phone, orient_phone, desc_phone ] = SIFT( phone_ref, 4, 2, ones(size(phone_ref)), 0.02, 10, 1);
 [ pos_book, scale_book, orient_book, desc_book ] = SIFT( phone_ref, 4, 2, ones(size(book_ref)), 0.02, 10, 1);
 
%%  Part2 adding to database all ref images

 database = add_descriptors_to_database( phone_ref, pos_phone, scale_phone, orient_phone, desc_phone);
 database = add_descriptors_to_database( book_ref, pos_book, scale_book, orient_book, desc_book);
 
 
 %% Test Cases
 I1 = imread('phone0005.pgm');
 I1 = imresize(im2double(I1), [256,256]);
 objectrecognition(database, I1, pos_phone, pos_book);

 
 I1 = imread('phone0007.pgm');
 I1 = imresize(im2double(I1), [256,256]);
 objectrecognition(database, I1, pos_phone, pos_book);

 I1 = imread('phone0016.pgm');
 I1 = imresize(im2double(I1), [256,256]);
 objectrecognition(database, I1, pos_phone, pos_book);

 I1 = imread('phone0017.pgm');
 I1 = imresize(im2double(I1), [256,256], pos_phone, pos_book);
 objectrecognition(database, I1);

 I1 = imread('phone0018.pgm');
 I1 = imresize(im2double(I1), [256,256]);
 objectrecognition(database, I1);

 
 
%  [ pos1, scale1, orient1, desc1 ] = SIFT( I1, 4, 2, ones(size(I1)), 0.02, 10, 1);
%  
%  [IM_IDX, TRANS, THETA, RHO, DESC_IDX, NN_IDX, WGHT] = hough( database, pos1, scale1, orient1, desc1);
%  [m,ind] = max(WGHT)
%  A = fit_robust_affine_transform(pos1(DESC_IDX{ind},:)', pos(NN_IDX{ind},:)')
%  aligned =  imWarpAffine(phone_ref, A, 1);
%  imshow((I1+aligned)/2)


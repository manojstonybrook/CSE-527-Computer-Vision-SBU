function [] = objectrecognition(database, I, pos_phone, pos_book)


 [ pos1, scale1, orient1, desc1 ] = SIFT( I1, 4, 2, ones(size(I1)), 0.02, 10, 1);
 [IM_IDX, TRANS, THETA, RHO, DESC_IDX, NN_IDX, WGHT] = hough( database, pos1, scale1, orient1, desc1);
 
 [m,ind] = max(WGHT)
 if(IM_IDX == 1)
     A = fit_robust_affine_transform(pos1(DESC_IDX{ind},:)', pos_phone(NN_IDX{ind},:)')
 else
     A = fit_robust_affine_transform(pos1(DESC_IDX{ind},:)', pos_book(NN_IDX{ind},:)')
 end
     aligned =  imWarpAffine(I, A, 1);
     imshow(aligned)
 
end

%% Problem 2

% Forming the equation in n*n form in this case n = 6; and equation it
% forms is AX=0 so we have to find the null space of A which we can do in two ways
% 1). By SVD 
% 2). By zero Eigen Value and with corresponding eigen vector 
A1 = [500 1 0  0 -50000 -100; 
    0  0 500  1 -125000 -250;
    100  1 0  0 -14000 -140; 
    0  0 100  1 -34000 -340;
    200  1 0  0 -40000 -200; 
    0  0 200  1 -90000 -450];

%% SVD of matrix
[U S V] = svd(A1)

%% Eigen values and vector

[V1 D1] = eigs(A1)

%%
m = V(:,end);
M = reshape(m,2,3)';
abs_lambda=sqrt(M(3,2)^2 + M(3,1)^2);
M = M / abs_lambda;

%% calibration parameter
M

%% eigen vector corresponding to minimum eigen value

eigenV = V1(:,6)
eigenV  = reshape(eigenV ,2,3)';
abs_lambda=sqrt(eigenV(3,1)^2 + eigenV(3,2)^2);
eigenV  = eigenV  / abs_lambda;

%% new heights
pM = pinv(M);
peigen = pinv(eigenV);

%% first Point
  p1_m = pM * [130; 310; 1];
  p1_m(1,1) = p1_m(1,1)/p1_m(2,1);
  p1_m(2,1) = p1_m(2,1)/p1_m(2,1);

  p1_e = peigen * [130; 310; 1];
  p1_e(1,1) = p1_e(1,1)/p1_e(2,1);
  p1_e(2,1) = p1_e(2,1)/p1_e(2,1);
  
  p1_m(1,1)
  
  %% Second Point
  p1_m = pM * [170; 380; 1];
  p1_m(1,1) = p1_m(1,1)/p1_m(2,1);
  p1_m(2,1) = p1_m(2,1)/p1_m(2,1);

  p1_e = peigen * [170; 380; 1];
  p1_e(1,1) = p1_e(1,1)/p1_e(2,1);
  p1_e(2,1) = p1_e(2,1)/p1_e(2,1);
  
  p1_m(1,1)
  
  %% 3rd Point
  p1_m = pM * [190; 300; 1];
  p1_m(1,1) = p1_m(1,1)/p1_m(2,1);
  p1_m(2,1) = p1_m(2,1)/p1_m(2,1);

  p1_e = peigen * [190; 300; 1];
  p1_e(1,1) = p1_e(1,1)/p1_e(2,1);
  p1_e(2,1) = p1_e(2,1)/p1_e(2,1);
  
  p1_m(1,1)
%% Problem 4

gauss = gaussian_kernel(11,1);
laplacian_kernel = [0,1,0;1,-4,1;0,1,0];
conv  = conv2(gauss, laplacian_kernel,'same');
mesh(conv);
% x = -15 : 0.1 : 15;
% y = -15 : 0.1 : 15; 
% plot3(x,y, conv);
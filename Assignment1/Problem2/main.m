%% Problem2


%%
M2 = gaussian_kernel_two_dimension(5,1);
M_X = gaussian_kernel_single_dimension(5,1);
M_Y = M_X';

lena = im2double(imread('../hw1_images/lena.bmp'));

%%  Lena
lena_conv2 = conv2(lena,M2, 'same');
lena_conv_X = conv2(lena,M_X, 'same');
lena_conv_Y = conv2(lena_conv_X, M_Y, 'same');

figure;
subplot(2,2,1), subimage(lena);
title('Original Lena')
axis off

subplot(2,2,2), subimage(lena_conv2);
title('Lena conv 2 DIM')
axis off


subplot(2,2,3), subimage(lena_conv_Y)
title('Lena X')
axis off

%% Difference of images
diff = abs(lena_conv2-lena_conv_Y);

subplot(2,2,4), subimage(diff)
title('difference of one and two dimensions')
axis off
%sum is Zero
output = sum(sum(diff))

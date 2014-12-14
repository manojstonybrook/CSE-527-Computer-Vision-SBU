%%Problem 1

%%

M5 = gaussian_kernel(5,1);
M11 = gaussian_kernel(11,3);

lena = im2double(imread('../hw1_images/lena.bmp'));
lena_noise = im2double(imread('../hw1_images/lena_noise.bmp'));

barbara = im2double(imread('../hw1_images/barbara.bmp'));
barbara_noise = im2double(imread('../hw1_images/barbara_noise.bmp'));

mandrill = im2double(imread('../hw1_images/mandrill.bmp'));
mandrill_noise = im2double(imread('../hw1_images/mandrill_noise.bmp'));


%%  Lena
lena_conv_sigma1 = conv2(lena,M5,'same');
lena_conv_sigma3 = conv2(lena,M11,'same');

figure;
subplot(2,2,1.5), subimage(lena);
title('Original Lena')
axis off
subplot(2,2,3), subimage(lena_conv_sigma1)
title('Gaussian 5X5, sigma = 1')
axis off

subplot(2,2,4), subimage(lena_conv_sigma3)
title('Gaussian 11x11, sigma = 3')
axis off

%% Lena Noise
lena_noise_conv_sigma1 = conv2(lena_noise,M5, 'same');
lena_noise_conv_sigma3 = conv2(lena_noise,M11, 'same');

figure;
subplot(2,2,1.5), subimage(lena_noise);
title('Original Lena')
axis off
subplot(2,2,3), subimage(lena_noise_conv_sigma1)
title('Gaussian 5X5, sigma = 1')
axis off
imwrite(lena_noise_conv_sigma1, 'lena_5x5_sigma_1.bmp')

subplot(2,2,4), subimage(lena_noise_conv_sigma3)
title('Gaussian 11x11, sigma = 3')
axis off
imwrite(lena_noise_conv_sigma3, 'lena_11x11_sigma_3.bmp')

%%  Barbara
barbara_conv_sigma1 = conv2(barbara,M5,'same');
barbara_conv_sigma3 = conv2(barbara,M11,'same');

figure;
subplot(2,2,1.5), subimage(barbara);
title('Original Barbara')
axis off
subplot(2,2,3), subimage(barbara_conv_sigma1)
title('Gaussian 5X5, sigma = 1')
axis off

subplot(2,2,4), subimage(barbara_conv_sigma3)
title('Gaussian 11x11, sigma = 3')
axis off


%%  Barbara Noise

barbara_noise_conv_sigma1 = conv2(barbara_noise,M5,'same');
barbara_noise_conv_sigma3 = conv2(barbara_noise,M11,'same');

figure;
subplot(2,2,1.5), subimage(barbara_noise);
title('Noise barbara')
axis off
subplot(2,2,3), subimage(barbara_noise_conv_sigma1)
title('Gaussian 5X5, sigma = 1')
axis off
imwrite(barbara_noise_conv_sigma1, 'barbara_5x5_sigma_1.bmp')

subplot(2,2,4), subimage(barbara_noise_conv_sigma3)
title('Gaussian 11x11, sigma = 3')
axis off
imwrite(barbara_noise_conv_sigma3, 'barbara_11x11_sigma_3.bmp')


%%  Mandrill
mandrill_conv_sigma1 = conv2(mandrill,M5,'same');
mandrill_conv_sigma3 = conv2(mandrill,M11,'same');

figure;
subplot(2,2,1.5), subimage(mandrill);
title('Original mandrill')
axis off
subplot(2,2,3), subimage(mandrill_conv_sigma1)
title('Gaussian 5X5, sigma = 1')
axis off

subplot(2,2,4), subimage(mandrill_conv_sigma3)
title('Gaussian 11x11, sigma = 3')
axis off


%%  Mandrill Noise

mandrill_noise_conv_sigma1 = conv2(mandrill_noise,M5,'same');
mandrill_noise_conv_sigma3 = conv2(mandrill_noise,M11,'same');

figure;
subplot(2,2,1.5), subimage(mandrill_noise);
title('Noise mandrill')
axis off

subplot(2,2,3), subimage(mandrill_noise_conv_sigma1)
title('Gaussian 5X5, sigma = 1')
axis off
imwrite(mandrill_noise_conv_sigma1, 'mandrill_5x5_sigma_1.bmp')

subplot(2,2,4), subimage(mandrill_noise_conv_sigma3)
title('Gaussian 11x11, sigma = 3')
axis off
imwrite(mandrill_noise_conv_sigma3, 'mandrill_11x11_sigma_3.bmp')

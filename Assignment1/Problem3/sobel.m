%% Problem 3

function [magnitude, direction] = sobel(I, th)

I = im2double(I);
kernel_x = [-1, 0, +1; -2, 0, +2; -1, 0, +1];
kernel_y = [+1, +2, +1; 0, 0, 0; -1, -2, -1];

sobel_x = conv2(I, kernel_x, 'same');
sobel_y = conv2(I, kernel_y, 'same');

magnitude = sqrt(sobel_x.^2 + sobel_y.^2);
%Normalize
magnitude = magnitude/max(max(magnitude));

direction = atan2(sobel_y, sobel_x);

threshold = (magnitude > th);  
threshold = threshold.* magnitude; 

result = im2uint8(threshold);
figure;
imwrite(result, 'sobel_th_1.5.bmp');

figure;
subplot(2,2,1), imshow(abs(magnitude));
title('magnitude')

subplot(2,2,2),imshow(threshold);
title('threshold')

subplot(2,2,3.5),imshow(direction);
title('direction')


  end

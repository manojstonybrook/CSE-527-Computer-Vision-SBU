% Problem 7
%% After Hysterisis and non maximal supression
I = imread('../hw1_images/lena.bmp');
w = 23;
var = 2;
th_low = 0.07;
th_high = 0.2;

%function [magnitude] = canny(I, w, var, th_low, th_high)
I = im2double(I);
gauss = gaussian_kernel_single_dimension(w,var);
IX = conv2(I, gauss, 'same');
IY = conv2(I, gauss', 'same');
% kernel_x = [-2, 0, +2];
% kernel_y = [-2, 0, +2]';

% grad_x = conv2(IX, kernel_x, 'same');
% grad_y = conv2(IY, kernel_y, 'same');
grad_x = gradient(IX);
grad_y = gradient(IY);


magnitude = sqrt(grad_x.^2 + grad_y.^2);
magnitude = magnitude/max(max(magnitude));

% figure;
% subplot(2,2,1), imshow(abs(grad_x));
% title('grad_x')
% 
% subplot(2,2,2),imshow(abs(grad_y));
% title('grad_y')
% 
% subplot(2,2,3),imshow(magnitude);
% title('magnitute')

non_max = magnitude;
%% Non maximal Supression
for i = 2 : size(magnitude,1)-1
    for j = 2 : size(magnitude,2)-1
%90 degree

        tangent = grad_y(i,j)/grad_x(i,j);
        
        if(grad_x(i,j) == 0)
            if((magnitude(i,j) < magnitude(i-1,j) || magnitude(i,j) < magnitude(i+1,j)))
                non_max(i,j)=0.0;
            end
        
        elseif(tangent == 0)
            if((magnitude(i,j) < magnitude(i,j-1) || magnitude(i,j) < magnitude(i,j+1)))
                non_max(i,j) = 0.0;        
            end
             
        
        elseif(tangent > 0 && tangent <= 1)
            inter1 = tangent * magnitude(i-1,j+1) + (1-tangent)*magnitude(i,j+1);
            inter2 = tangent * magnitude(i+1,j-1) + (1-tangent)*magnitude(i,j-1);
     
            if(magnitude(i,j) < inter1 || magnitude(i,j) < inter2)
                non_max(i,j) = 0.0;
%                 non_max(i,j)
            end
             
        elseif(tangent > 0 && tangent >= 1)
            inter1 = (1/tangent) * magnitude(i-1,j+1) + (1-(1/tangent))*magnitude(i-1,j);
            inter2 = (1/tangent) * magnitude(i+1,j-1) + (1-tangent)*magnitude(i+1,j);
     
            if(magnitude(i,j) < inter1 || magnitude(i,j) < inter2)
                non_max(i,j) = 0.0;
%                 non_max(i,j)
            end
        
        elseif(tangent < 0 && abs(tangent) < 1)
            inter1 = tangent * magnitude(i+1,j+1) + (1-tangent)*magnitude(i,j+1);
            inter2 = tangent * magnitude(i-1,j-1) + (1-tangent)*magnitude(i-1,j);
            
            if(magnitude(i,j) < inter1 || magnitude(i,j) < inter2)
                non_max(i,j) = 0.0;
%                 non_max(i,j)
            end
            
        elseif(tangent < 0 && abs(tangent) > 1)
            inter1 = (1/tangent) * magnitude(i+1,j+1) + (1-(1/tangent))*magnitude(i+1,j);
            inter2 = (1/tangent) * magnitude(i-1,j-1) + (1-(1/tangent))*magnitude(i-1,j);
            
            if(magnitude(i,j) < inter1 || magnitude(i,j) < inter2)
                non_max(i,j) = 0.0;
            end    
        end
                
    end
end
% non_max = im2uint8(non_max);

% subplot(2,2,4),imshow(non_max);
% title('non max')

result1 = (non_max > th_low);
figure;
imshow(result1);

%%
hesterisis = non_max;

hesterisis_low = (hesterisis > th_low);
hesterisis_high = (hesterisis > th_high);
% % figure;
% % subplot(2,2,1), imshow(hesterisis_low)
% % subplot(2,2,2), imshow(hesterisis_high)
% 
final = hesterisis_high;

for r = 2: size(hesterisis_high,1)-1
    for c = 2: size(hesterisis_high,2)-1
        if(hesterisis_high(r,c))
            final(r,c) = 1;
        
        elseif(final(r-1,c) || final(r,c-1) || final(r-1,c+1)|| final(r-1,c-1)|| final(r,c+1) || final(r+1,c-1)||final(r+1,c)||final(r+1,c+1))
             if(hesterisis_low(r,c)~=0)
                final(r,c)=1;
             end
        end    
    end
end
% % % subplot(2,2,3),imshow(non_max);
% % % subplot(2,2,4), imshow(final)
% % 
figure;
imshow(final);
final = im2uint8(final);
imwrite(final, 'hesterisis.bmp');

figure;
imshow(result1);
figure;
imshow('barbara.bmp');
title('barbara')

figure;
imshow('lena_23_2_0.07.bmp');
title('lena')

figure;
imshow('baboon.bmp');
title('mandrill')

figure;
imshow('building.bmp');
title('building')

figure;
imshow('barbara_noise_23_1_0.07.bmp');
title('barbara noise')

figure;
imshow('mandrill_50_1.5_0.3.bmp');
title('mandrill noise')

figure;
imshow('lena_noise_23_2.5_0.2.bmp');
title('mandrill noise')

% imshow(post_hysteresis)
% end

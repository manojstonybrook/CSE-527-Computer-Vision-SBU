%% Problem 5

 function [zcd1] = main(I,th)
I = im2double(I);
log = log_kernel(11,1);
zcd = conv2(I, log,'same');

zcd1 = zeros(512,512);
% row
for i = 2:size(zcd,1)-1   
% col
    for j = 2:size(zcd,2)-1
        if(( (zcd(i-1,j)* zcd(i+1,j)<0) &&  abs(zcd(i-1,j)-zcd(i+1,j)) > th) || ((zcd(i,j-1)* zcd(i,j+1)<0) && abs(zcd(i,j-1)-zcd(i,j+1))>th))
            zcd1(i,j) = 1;
        end
    end
end

% zcd1 = im2uint8(zcd1);
figure;
imshow(zcd1);
imwrite(zcd1, 'zcd_th0.08.bmp');


 end

function [matrix] = gaussian_kernel(w, s)

j = double(floor(w/2));
matrix = zeros(w,w);

for x = -j:1:j
    for y = -j:1:j
        matrix(y+j+1,x+j+1) = (1/(2*pi*s^2))* exp((-1*(x^2+y^2))/(2*s^2));
    end
end
matrix = matrix/sum(sum(matrix));
   
end
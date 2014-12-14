function [matrix] = gaussian_kernel_single_dimension(w, s)

j = double(floor(w/2));
matrix = zeros(w);

for x = -j:1:j
        matrix(x+j+1) = (1/sqrt(2*pi*s^2))* exp((-1*(x^2))/(2*s^2));
end    
matrix = matrix/(sum(matrix));
   
end
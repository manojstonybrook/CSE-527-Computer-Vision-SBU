fid = fopen('neg.lst');
fid1 = fopen('create_neg.lst','w');
tline = fgetl(fid)
rng(0,'twister');

tline_write = [];
%For 200 images
for i =1:200

    I1 = imread(tline);
    [r c m] = size(I1);
    for k = 1:length(tline)
       if tline(k) == '/'
          pos = k;
       end
    end

    for j = 1:10 % 10 random samples from each image
      a = 1;
      b = r - 160;
      a1 = 1;
      b1 = c - 96;
      r1 = floor((b-a)*rand(1) + a);
      c1 = floor((b1-a1)*rand(1) + a1);
      tline_write = ['negativesamples/neg_' int2str(j) '_' tline(pos+1:length(tline))];
      I2 = I1([r1:r1+160-1],[c1:c1+96-1],:);
      imwrite(I2, tline_write);
      fwrite(fid1, tline_write);
      fprintf(fid1, '\n');
      
    end
    tline = fgetl(fid);
end

fclose(fid);
fclose(fid1);

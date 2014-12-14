
fid = fopen('pos.lst');
tline = fgetl(fid);

%while ischar(tline)
for i =1:200
    disp(tline)
    I1 = imread(tline);
    imshow(I1([16:160-16],[16:96-16],:))
    tline = fgetl(fid);
    waitforbuttonpress;
end

fclose(fid);

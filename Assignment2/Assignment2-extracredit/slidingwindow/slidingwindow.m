% origimage = ['orig01.jpg';'orig02.jpg';'orig03.jpg';'orig04.jpg';'orig05.jpg';'orig06.jpg';'orig07.jpg';'orig08.jpg';'orig09.jpg';
%     'orig10.jpg';'orig11.jpg';'orig12.jpg';'orig13.jpg';'orig14.jpg';'orig15.jpg';'orig16.jpg';'orig17.jpg';'orig18.jpg';'orig19.jpg';'orig20.jpg';
%     'orig21.jpg';'orig22.jpg';'orig23.jpg';'orig24.jpg';'orig25.jpg';'orig26.jpg';'orig27.jpg';'orig28.jpg';'orig29.jpg';
%     'orig30.jpg';'orig31.jpg';'orig31.jpg';'orig31.jpg';'orig32.jpg';'orig33.jpg';'orig34.jpg';'orig35.jpg'];
% 
% refimage = ['res01.jpg';'res02.jpg';'res03.jpg';'res04.jpg';'res05.jpg';'res06.jpg';'res07.jpg';'res08.jpg';'res09.jpg';
%     'res10.jpg';'res11.jpg';'res12.jpg';'res13.jpg';'res14.jpg';'res15.jpg';'res16.jpg';'res17.jpg';'res18.jpg';'res19.jpg';'res20.jpg';
%     'res21.jpg';'res22.jpg';'res23.jpg';'res24.jpg';'res25.jpg';'res26.jpg';'res27.jpg';'res28.jpg';'res29.jpg';
%     'res30.jpg';'res31.jpg';'res31.jpg';'res31.jpg';'res32.jpg';'res33.jpg';'res34.jpg';'res35.jpg'];

origimage = ['orig01.jpg';'orig02.jpg';'orig03.jpg';'orig04.jpg';'orig05.jpg';'orig21.jpg';'orig22.jpg';'orig23.jpg';'orig24.jpg';'orig25.jpg'];
refimage = ['res36.jpg';'res37.jpg';'res38.jpg';'res39.jpg';'res40.jpg';'res41.jpg';'res42.jpg';'res43.jpg';'res44.jpg';'res45.jpg'];
I = imread('res36.jpg');
refsize = size(I);

cellsize = 32;
% length(refimage)
for j=2:2

trainvector = [];
label = [];

for  i = 1:length(refimage)
   if(i==j)
        continue;
   end
    
   I = imread(refimage(i,:));
   I = im2single(I);
   
   hogimage = vl_hog(I,cellsize);
   
   reshape_hogimage = reshape(hogimage, [], 1);
   
   trainvector = [trainvector reshape_hogimage];
   if(i <= 5)
       label = [label 1];
   else
       label = [label 2];
   end
       
end

[W, B] = vl_svmtrain(trainvector, label, 0.1);


testimage = imread(origimage(j,:));
testimage = im2single(testimage);
    
% Extracting HOG features
% testimagehog = vl_hog(testimage, cellsize);

% sliding window to calculate scores
 maxr=1;
 maxc=1;
 maxscore = -1;
 refsize(1) = size(testimage,1)/2+size(testimage,1)/4;
 refsize(2) = size(testimage,2)/2+size(testimage,2)/4;
 blocksize = 32;
 for r = 1:blocksize:size(testimage,1)-refsize(1)
  for c = 1:blocksize:size(testimage,2)-refsize(2)
    window = imresize(testimage(r:r+refsize(1)-1, c:c+refsize(2)-1, :),[256 256]);
    testimagehog = vl_hog(window, cellsize);  
    % imshow(testimage);hold on; rectangle('Position',[r c 1024 1024], 'LineWidth',2, 'EdgeColor','b');
    scores = W'*reshape(testimagehog,[],1) + B;
    if(scores > maxscore)
       maxscore = scores;
       maxr = r;
       maxc = c;
    end
  end
 end
 
 figure,imshow(testimage);hold on; rectangle('Position',[maxc maxr  refsize(2)  refsize(1)], 'LineWidth',2, 'EdgeColor','b');

% saving the scores

 fileID = fopen('scores.txt','a');
% %fprintf(fileID,'%6s %20s\n','TestImage','Score');
 fprintf(fileID,'%6s %24f\n',refimage(j,:), maxscore);
 fclose(fileID);
end


%% HOG refimage

% 
% for j=1:length(refimage)
%    I = imread(refimage(i,:));
%    I = im2single(I);
%    
%    hogimage = vl_hog(I,cellsize);
%    
%    imhogimage = vl_hog('render', hogimage, 'verbose');
%    title = ['hog_' refimage(j,:)];
%    imwrite(imhogimage, title);
% end

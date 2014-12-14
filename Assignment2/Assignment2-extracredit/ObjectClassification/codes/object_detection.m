refimage = ['res01.jpg';'res02.jpg';'res03.jpg';'res04.jpg';'res05.jpg';'res06.jpg';'res07.jpg';'res08.jpg';'res09.jpg';
    'res10.jpg';'res11.jpg';'res12.jpg';'res13.jpg';'res14.jpg';'res15.jpg';'res16.jpg';'res17.jpg';'res18.jpg';'res19.jpg';'res20.jpg';
    'res21.jpg';'res22.jpg';'res23.jpg';'res24.jpg';'res25.jpg';'res26.jpg';'res27.jpg';'res28.jpg';'res29.jpg';
    'res30.jpg';'res31.jpg';'res31.jpg';'res31.jpg';'res32.jpg';'res33.jpg';'res34.jpg';'res35.jpg'];

cellsize = 32;
for j=1:length(refimage)

testimage = imread(refimage(j,:));
testimage = im2single(testimage);
    
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
   if(i <= 20)
       label = [label 1];
   else
       label = [label -1];
   end
       
end

[W, B] = vl_svmtrain(trainvector, label, 0.001);

% Extracting HOG features
testimagehog = vl_hog(testimage, cellsize);

% sliding window to calculate scores
scores = W'*reshape(testimagehog,[],1) + B;


% saving the scores

 fileID = fopen('scores.txt','a');
% %fprintf(fileID,'%6s %20s\n','TestImage','Score');
 fprintf(fileID,'%6s %24f\n',refimage(j,:), scores);
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

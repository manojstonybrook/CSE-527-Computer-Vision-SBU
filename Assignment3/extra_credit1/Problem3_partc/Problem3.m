%%%
Images_left = ['humanity01.JPG'; 'humanity02.JPG'; 'humanity03.JPG'];
Images_right = ['humanity02.JPG'; 'humanity03.JPG'; 'humanity04.JPG'];

points_left = [];
points_right = [];

ptsa1 = [830,467,1];  %bucket above cycle
ptsa2 = [767,516,1];  %cycle seat
ptsa3 = [1170,370,1]; %blue light
ptsa4 = [1219,500,1]; %right pole
ptsa5 = [1158,133,1]; %roof top
ptsa6 = [872,433,1];  %chatri corner

img1pts = [ptsa1; ptsa2;ptsa3;ptsa4;ptsa5;ptsa6];
points_left = [points_left;img1pts];
ptsb1 = [212,449,1];
ptsb2 = [143,492,1];
ptsb3 = [545,349,1];
ptsb4 = [583,477,1];
ptsb5 = [537,132,1];
ptsb6 = [254,421,1];

img2pts = [ptsb1; ptsb2;ptsb3;ptsb4;ptsb5;ptsb6];
points_right = [points_right;img2pts];

ptsa1 = [1337,284,1];  %bucket above cycle
ptsa2 = [1459,552,1];  %cycle seat
ptsa3 = [1416,318,1]; %blue light
ptsa4 = [1422,379,1]; %right pole
ptsa5 = [1708,330,1]; %roof top
ptsa6 = [1599,99,1];  %chatri corner

img3pts = [ptsa1; ptsa2;ptsa3;ptsa4;ptsa5;ptsa6];
points_left = [points_left;img3pts];


ptsb1 = [89,245,1];
ptsb2 = [226,520,1];
ptsb3 = [174,275,1];
ptsb4 = [192,341,1];
ptsb5 = [476,315,1];
ptsb6 = [374,76,1];

img4pts = [ptsb1; ptsb2;ptsb3;ptsb4;ptsb5;ptsb6];
points_right = [points_right;img4pts];


ptsa1 = [1668,216,1];  %bucket above cycle
ptsa2 = [2293,634,1];  %cycle seat
ptsa3 = [1767,450,1]; %blue light
ptsa4 = [2376,582,1]; %right pole
ptsa5 = [2249,458,1]; %roof top
ptsa6 = [2440,594,1];  %chatri corner

img3pts = [ptsa1; ptsa2;ptsa3;ptsa4;ptsa5;ptsa6];
points_left = [points_left;img3pts];


ptsb1 = [63,38,1];
ptsb2 = [713,480,1];
ptsb3 = [186,291,1];
ptsb4 = [785,430,1];
ptsb5 = [679,305,1];
ptsb6 = [850,446,1];

img4pts = [ptsb1; ptsb2;ptsb3;ptsb4;ptsb5;ptsb6];
points_right = [points_right;img4pts];



for i = 1:1
I_left = imread(Images_left(i,:));
I_right = imread(Images_right(i,:));
if(i>1)
 I_left = warpimag2;
end 
H = ComputeWarpMapping(points_left(6*(i-1)+1:6*(i-1)+6,:), points_right(6*(i-1)+1:6*(i-1)+6,:));
warpimag1 = WarpImage(I_left, H);
%warpimag2 = merge(warpimag1, I_right, H);
figure;
imshow(warpimag2)
end

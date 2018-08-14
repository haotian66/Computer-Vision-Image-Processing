% Haotian Jiang, HW4
a=imread('C:\Users\Administrator\Desktop\tools.pgm');
t=graythresh(a);% get the threshold value of image
a=im2bw(a,t);% convert image to binary
%creat struct element se
se=strel('disk',3);% define structuring element
se2=strel('disk',1);
b=imopen(a,se);% conduct opening
c=imerode(b,se2);% conduct erosion
figure();
imshow(c); 
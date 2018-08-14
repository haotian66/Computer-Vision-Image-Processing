function[y]=backgroundsub(string)
% Haotian Jiang, HW3

v=VideoReader(string);  %read video
i=1;
b=1;
c=1;
p=cell(1,100); %define a cell to store 100 images
while i<=100
    a=read(v,i); % read each of the 100 images
    [l,m,n]=size(a); %get the size of original images
    o=zeros(l,m); %define a new matrix to store the transformed images
    o=uint8(o); %convert the format of numbers to show the image
    while b<=l
        while c<=m
           g=round((double(a(b,c,1))+double(a(b,c,2))*2+double(a(b,c,3)))/double(4)); %compute the value of greyscale images
           o(b,c)=g;
           c=c+1;
        end
        b=b+1;
        c=1;
    end
    p{i}=o;
    i=i+1;
    b=1;
    c=1;
end
i=1;
b=1;
c=1;
l=480;
m=640;
o1=zeros(l,m);% define a matrix to store the average image

while i<=100
   a1=p{i};
   while b<=l
      while c<=m
         o1(b,c)=o1(b,c)+double(a1(b,c))/double(100); %compute each pixel value in avarage image
         c=c+1;
      end
      b=b+1;
      c=1;
   end
   i=i+1;
   b=1;
   c=1;
end

o1=uint8(o1);
imshow(o1);

i1=1;
i2=10;
b=1;
c=1;
l=480;
m=640;
judge=int16(0);
p1=cell(1,10);
while i1<=10
    a2=p{i1*i2};  %choose ten pictures
    while b<=l
      while c<=m
         judge=double(a2(b,c))-double(o1(b,c));% compute the difference
         if judge>=20  % thresholding
             a2(b,c)=255;
         else
             a2(b,c)=0;
         end
         c=c+1;
      end
      b=b+1;
      c=1;
    end
    p1{i1}=a2;
    i1=i1+1;
    b=1;
    c=1; 
end
i1=1;
while i1<=10  %show ten original images and background subtraction images
figure;
imshow(p{i1*i2});
figure;
imshow(p1{i1});
i1=i1+1;
end
end




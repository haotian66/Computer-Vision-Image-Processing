function[y]=regiongrow_seg(a)
% Haotian Jiang, HW4


[l,m]=size(a);% get the size of a
i=100; % set the position of first seed pixel
j=100;
repeat=0;
s=double(a(i,j)); %define the sum of pixel values in a region
s1=double(double(a(i,j))^2)+10; %define the sum of the squares of pixel values in a region
num=double(1);% define the number of pixels in a region
r=double(2.7);%define the threshold tool 2.5, flower 2.7,swan2.3
color1=unidrnd(255);% generate the first color
color2=unidrnd(255);
color3=unidrnd(255);
b=zeros(l,m); % define a matrix to store values judging whether a pixel has been changed
a1=zeros(l,m,3);% define matrix to store the output image
a1=uint8(a1); % transform a to the image format
w=[]; % define a matrix to store the coordinates of frontier pixels of a seed pixel
w(1,1)=i; % store the first seed value in w 
w(2,1)=j;
bre=0;% define a variable to find whether a figured has been totally filled
while  find(b==0)~=0
while  (bre==0)
    [w,a1,b,bre,s,s1,num,repeat]=seg(w,a,a1,b,color1,color2,color3,bre,s,s1,r,num,repeat); % continously conducting floodfill
end
bre=0;
[i1,j1]=find(b==0);% find a pixel in another figure which has not been filled yet
if isempty(i1) % if the image has been completely filled, leave the loops
    break;
end
i=i1(1,1);
j=j1(1,1);
[o1,o2]=size(a);
w=[];
w(1,1)=i;
w(2,1)=j;
s=double(a(i,j));
s1=double(double(a(i,j))^2)+10;
num=double(1);
r=double(2.7);
color1=unidrnd(255);
color2=unidrnd(255);
color3=unidrnd(255);

end
figure;
imshow(a1);
figure;
imshow(a);
y=a1;



function [r1,r2,r3,r4,r5,r6,r7,r8]=seg(x,a,a1,b,c1,c2,c3,bre,s,s1,r,num,repeat) %floodfill function
o=1;
[l1,m1]=size(x);

if b(x(1,o),x(2,o))==repeat & l1==2 & m1==1
    b(x(1,o),x(2,o))=1;
end
repeat=b(x(1,o),x(2,o));
[o1,o2]=size(a);
w1=[];% define matrix to store the coordinates of frontier pixels
while o<=m1
if(x(1,o)>1) & (x(1,o)<o1) & (x(2,o)>1) & (x(2,o)<o2) % make sure pixels are not out of bounds
k=[]; % define matrix to store the values of frontier pixels
k1=[];% define matrix to store the row coordinate of frontier pixels
k2=[];% define matrix to store the colum coordinate of frontier pixels
if (b(x(1,o)-1,x(2,o))==0)% judge if the frontier pixel has been changed
k=[k,a(x(1,o)-1,x(2,o))];
k1=[k1,x(1,o)-1];
k2=[k2,x(2,o)];
end
if (b(x(1,o)+1,x(2,o))==0) 
k=[k,a(x(1,o)+1,x(2,o))];
k1=[k1,x(1,o)+1];
k2=[k2,x(2,o)];
end
if (b(x(1,o)-1,x(2,o)+1)==0) 
k=[k,a(x(1,o)-1,x(2,o)+1)];
k1=[k1,x(1,o)-1];
k2=[k2,x(2,o)+1];
end
if (b(x(1,o)-1,x(2,o)-1)==0) 
k=[k,a(x(1,o)-1,x(2,o)-1)];
k1=[k1,x(1,o)-1];
k2=[k2,x(2,o)-1];
end
if (b(x(1,o)+1,x(2,o)+1)==0) 
k=[k,a(x(1,o)+1,x(2,o)+1)];
k1=[k1,x(1,o)+1];
k2=[k2,x(2,o)+1];
end
if (b(x(1,o)+1,x(2,o)-1)==0) 
k=[k,a(x(1,o)+1,x(2,o)-1)];
k1=[k1,x(1,o)+1];
k2=[k2,x(2,o)-1];
end
if (b(x(1,o),x(2,o)+1)==0) 
k=[k,a(x(1,o),x(2,o)+1)];
k1=[k1,x(1,o)];
k2=[k2,x(2,o)+1];
end
if (b(x(1,o),x(2,o)-1)==0) 
k=[k,a(x(1,o),x(2,o)-1)];
k1=[k1,x(1,o)];
k2=[k2,x(2,o)-1];
end
[m2,m3]=size(k) ;% get the number of pixels in k
m=1;
n=1;
w=[];
if isempty(k) % if on the boundary, leave the loops
    b(x(1,o),x(2,o))=1; %indicate that the pixel has been changed
end
while m<=m3
    kk=double(k(1,m));
    miu=double(s)/double(num); %compute miu
    sig=double(s1)/double(num)-miu^2;% compute sigma square
   % abs(1/(sqrt(2*pi*s1))*exp((kk-s)^2/(-2*s1))-s)/sqrt(s1)  (kk-miu)^2<=(r^2*sig)
    if ((kk-miu)^2<=(r^2*sig)) % judge if the frontier belong to the region
        w(1,n)=k1(1,m);
        w(2,n)=k2(1,m);
        a1(w(1,n),w(2,n),1)=c1; % assign new colors
        a1(w(1,n),w(2,n),2)=c2;
        a1(w(1,n),w(2,n),3)=c3;
        b(w(1,n),w(2,n))=1;
        n=n+1;
        s=double(s)+kk;
        s1=double(s1)+kk^2;
        num=double(num)+1;
    end
    m=m+1;
end
w1=[w1,w];
else
    b(x(1,o),x(2,o))=1;% if no frontiers, indicate the pixel has been changed
end
o=o+1;
end
if isempty(w1) % if the figure has been completely filled, leave the loops
    bre=1;
end
r1=w1;% assign outputs
r2=a1;
r3=b;
r4=bre;
r5=s;
r6=s1;
r7=num;
r8=repeat;
end

end






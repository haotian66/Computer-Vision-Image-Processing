function[y]=color_objects(a)
% Haotian Jiang, HW4

[l,m]=size(a);% get the size of a
i=10; % set the position of first seed pixel
j=10;
b=zeros(l,m); % define a matrix to store values judging whether a pixel has been changed
a1=zeros(l,m,3);% define matrix to store the output image
a1=uint8(a1); % transform a to the image format
p=1;% define the loop variables
p1=1;
w=[]; % define a matrix to store the coordinates of frontier pixels of a seed pixel
w(1,1)=i; % store the first seed value in w 
w(2,1)=j;
bre=0;% define a variable to find whether a figured has been totally filled
color=[80,60,40;80,100,120;160,120,140;170,160,0;180,200,220;240,43,255;150,100,50;70,140,210;0,200,100;78,13,236];% define different colors
while p<=10
while (p1<=2000000) & (bre==0)
    [w,a1,b,bre]=sub1(w,a,a1,b,color(p,1),color(p,2),color(p,3),bre); % continously conducting floodfill
    p1=p1+1;
end
bre=0;
[i1,j1]=find(b==0);% find a pixel in another figure which has not been filled yet

i=i1(1,1);
j=j1(1,1);
w=[];
w(1,1)=i;
w(2,1)=j;
p=p+1;
p1=1;

end
imshow(a1);
y=a1;

function [r,s,t,u]=sub1(x,a,a1,b,c1,c2,c3,bre) %floodfill function
o=1;
[l1,m1]=size(x); % find the number of pixels in frontier matrix
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
[m2,m3]=size(k); % get the number of pixels in k
m=1;
n=1;
w=[];
while m<=m3
    if (k(1,m)==a(x(1,o),x(2,o))) % judge if the frontier pixel need a new color
        w(1,n)=k1(1,m);
        w(2,n)=k2(1,m);
        a1(w(1,n),w(2,n),1)=c1; % assign new colors
        a1(w(1,n),w(2,n),2)=c2;
        a1(w(1,n),w(2,n),3)=c3;
        b(w(1,n),w(2,n))=1;
        n=n+1;
    end
    m=m+1;
end
w1=[w1,w];
end
o=o+1;
end
if isempty(w1) % if the figure has been completely filled, leave the loops
    bre=1;
end
r=w1;% assign outputs
s=a1;
t=b;
u=bre;
end
end






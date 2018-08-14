function [y]=flipim(a)
% Haotian Jiang, HW1

[l,m,n]=size(a);% Get the width and length of the image's matrix 
l1=floor(l/2); % Divide the width of the image
m1=floor(m/2);% Divide the length of the image
s=a;% Copy the orignial image
a(1:l1,1:m1,1:n)=s(l-l1+1:l,m-m1+1:m,1:n);% Let section 1 of returned image be section 4 of original image
a(l-l1+1:l,m-m1+1:m,1:n)=s(1:l1,1:m1,1:n);% Let section 4 of returned image be section 1 of original image

a(1:l1,m-m1+1:m,1:n)=s(l-l1+1:l,1:m1,1:n);% Let section 3 of returned image be section 2 of original image
a(l-l1+1:l,1:m1,1:n)=s(1:l1,m-m1+1:m,1:n);% Let section 2 of returned image be section 3 of original image
y=a;
end
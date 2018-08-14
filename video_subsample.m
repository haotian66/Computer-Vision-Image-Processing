function[frames_input,frames_output]=videosubsamp(inputstring,outputstring,samp_rate)
% Haotian Jiang, HW3

video=VideoReader(inputstring);%read video
video1=read(video); % read all the images in the video
[l,m,n,frames_input]=size(video1);% get the size of video1
frames_output=floor(double(frames_input)/double(samp_rate));% compute the number of frames of output video
i=1;
p=cell(1,frames_output); %define a cell to store the images of output video
while i<=frames_output
    p{i}=read(video,i*3);%read images from input video
    i=i+1;
end
w=VideoWriter(outputstring);%define output video
open(w);
for i=1:frames_output
frame=p{i};
writeVideo(w,frame);%write images to form output video
end
close(w);
end

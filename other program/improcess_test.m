clc
clear all;
a=imread('D:\experiment data\new\imagines\1.jpg');
level=graythresh(a);  
b=imbinarize(a,level);  
se=strel('disk',2);  
c=imopen(b,se);
figure(1);
subplot(2,2,1),imshow(a)
subplot(2,2,2),imshow(b)
c=bwareaopen(b,3000);
subplot(2,2,3),imshow(c)
subplot(2,2,4),imshow(c)
[d,l]=bwboundaries(c,'noholes');  %搜索物体的外边界 
imshow(label2rgb(l,@jet,[.5 .5 .5])); %以不同的颜色标记不同的区域，0像素点用0.50.050.5标记
hold on;
for k=1:length(d)
    boundary=c{k};  %取出每一个线条的坐标画在在图像上
    plot(boundary(:,2),boundary(:,1),'w','LineWidth',3);
end

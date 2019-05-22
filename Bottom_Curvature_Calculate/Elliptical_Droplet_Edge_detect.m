clc
clear all;
close all;
%检测椭圆边界曲线并且拟合底部图片
I= imread('raw_picture.jpg');
m=size(I,1);
n=size(I,2);
I=rgb2gray(I);
t=graythresh(I);
I_bw=imbinarize(I,t);
I_open=bwareaopen(I_bw,2000);
I_edge=edge(I_open,'Canny',0.8);
[B,L]=bwboundaries(I_edge,'noholes');

figure(1);
subplot(221)
imshow(I);
title('Raw image');

subplot(222)
imshow(I_bw);
title('Binarize image');

subplot(223)
imshow(I_open)
title('High light kill')

subplot(224)
imshow(I_edge)
title('Edge detect')

%将灰度图转化为彩色图
I_red(:,:,1)=I;
I_red(:,:,2)=I;
I_red(:,:,3)=I;

location=cell2mat(B(1,1)); % 边界点的坐标
for i=1:size(location,1)
        I_red(location(i,1),location(i,2),1)=255;
        I_red(location(i,1),location(i,2),2)=0;
        I_red(location(i,1),location(i,2),3)=0;
end
figure(2);
imshow(I_red)

%x方向直径与y方向直径（像素点数）
D_x=max(location(:,1))-min(location(:,1))+1;
D_y=max(location(:,2))-min(location(:,2))+1;

%取液滴直径的下半部分边界点进行拟合
y_mid=ceil((max(location(:,2))+min(location(:,2)))/2);
location_bottom_half=[];
for i=1:size(location,1)
    if location(i,2)>=y_mid
        location_bottom_half=[location_bottom_half;location(i,:)];
    end
end
figure(3)
plot(location_bottom_half(:,1),location_bottom_half(:,2),'g*')
title('bottom half drop')

%拟合边界点
[p,S]=polyfit(location_bottom_half(:,1),location_bottom_half(:,2),6);
fitval=polyval(p,location_bottom_half(:,1));
hold on;
plot(location_bottom_half(:,1),fitval,'r','linewidth',2)
legend('original point','fit line')
hold off
dp=polyder(p);
dpp=polyder(dp);
R=abs(((1+polyval(dp,location_bottom_half(:,1)).^2).^1.5)./polyval(dpp,location_bottom_half(:,1)));
figure(4)
plot(location_bottom_half(:,1),R,'bD')
xlabel('坐标像素位置')
ylabel('曲率半径大小（像素点）')
clc
clear all;
close all;
%�����Բ�߽����߲�����ϵײ�ͼƬ
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

%���Ҷ�ͼת��Ϊ��ɫͼ
I_red(:,:,1)=I;
I_red(:,:,2)=I;
I_red(:,:,3)=I;

location=cell2mat(B(1,1)); % �߽�������
for i=1:size(location,1)
        I_red(location(i,1),location(i,2),1)=255;
        I_red(location(i,1),location(i,2),2)=0;
        I_red(location(i,1),location(i,2),3)=0;
end
figure(2);
imshow(I_red)

%x����ֱ����y����ֱ�������ص�����
D_x=max(location(:,1))-min(location(:,1))+1;
D_y=max(location(:,2))-min(location(:,2))+1;

%ȡҺ��ֱ�����°벿�ֱ߽��������
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

%��ϱ߽��
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
xlabel('��������λ��')
ylabel('���ʰ뾶��С�����ص㣩')
%% 读取图片
clc
clear all
a=imread('D:\to Lang Luo\2014-09-28\imgine_1\88.jpg');      %需要处理的图片文件路径
n=size(a);
area_lindi=0;
area_caodi=0;
shibiedu=input('请输入颜色区分值:  ');   %该值为黑白边界判别值，小于该值即为黑色，大于该值即为黄色。
imshow(a)
n
%% 处理文件
for i=1:n(1)
 for j=1:n(2)
    if a(i,j,1)<shibiedu&&a(i,j,2)<shibiedu&&a(i,j,3)<shibiedu
        a(i,j,1)=0;
        a(i,j,2)=0;
        a(i,j,3)=0;
    else
        a(i,j,1)=255;
        a(i,j,2)=255;
        a(i,j,3)=255;
    end
 end
end
%% 找出刻度线的位置
weizhi =input('请输入刻度线的像素点坐标值：');
leiji=0;%用于计数
pix_number1=0;
pix_number2=0;
length=1100;
%% 记录每一毫米的像素点个数
for k=1:n(2)
    if a(weizhi,k,1)==255&&leiji<2&&length>1100
        pix_number1=weizhi;
        length=pix_number1-pix_number2
        pix_number2=pix_number1;
        leiji=leiji+1;
    end
    a(weizhi,k,1)=255;
    a(weizhi,k,2)=0;
    a(weizhi,k,3)=0;
end
length
figure;
imshow(a)

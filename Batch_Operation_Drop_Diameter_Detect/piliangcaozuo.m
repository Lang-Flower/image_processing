%对一个文件夹内的液滴图片的横纵直径以及直径比进行计算。
%需要对应的液滴图片。
%与液滴图片编号对应的放大倍数的excel文件。
%需要根据相机型号在程序中修改单位像素点的长度。
%得到的直径文件放置在para矩阵里。
%需要将文件名排序子程序sort_nat放置在同一文件夹下
clc;
clear all;
close all;
all_file=dir('E:\20190716\实验数据处理\液滴图片\*.bmp'); %所有文件的信息
num=length(all_file);%文件个数

nameCell = cell(num,1);
for i = 1:num
    nameCell{i} = all_file(i).name;
end
name=sort_nat(nameCell);
magnification=xlsread('E:\20190716\实验数据处理\液滴图片\对应放大倍数.xlsx','sheet1','B1:B148');  %每个图片对应的放大倍率，用于计算单位像素点的长度
para=zeros(num,4);

for i=1:num
    full_path=strcat(all_file(i).folder,'\',name{i});
    I= imread(full_path);
    m=size(I,1);
    n=size(I,2);
    I=rgb2gray(I);
    t=graythresh(I);
    I_bw=imbinarize(I,t);
    I_open=bwareaopen(I_bw,1000);
    I_edge=edge(I_open,'Canny',0.9);
    [B,L]=bwboundaries(I_edge,'noholes');
    location=cell2mat(B(1,1)); % 边界点的坐标
    l_p=20;%单位像素点长度
    mag=magnification(i);
    pixel=l_p/mag; %真实单位像素点长度
    %x方向直径与y方向直径（像素点数）
    D_y=(max(location(:,1))-min(location(:,1))+1)*pixel/1000;
    D_x=(max(location(:,2))-min(location(:,2))+1)*pixel/1000;
    D_ef=(D_x*D_y^2)^(1/3);
    alpha=D_y/D_x;
%     disp('横向直径、纵向直径、有效直径、长宽比(单位：mm)')
    para(i,:)=[D_x D_y D_ef alpha];
end
figure(1);
subplot(221)
plot([1:1:num],para(:,1),'rD','markersize',5)
hold on
plot([1:1:num],para(:,1),'b')
hold off
legend('水平直径')
subplot(222)
plot([1:1:num],para(:,2),'bp','markersize',5)
hold on
plot([1:1:num],para(:,2),'r')
hold off
legend('竖直直径')
subplot(223)
plot([1:1:num],para(:,3),'rD','markersize',5)
hold on
plot([1:1:num],para(:,3),'b')
hold off
legend('等效直径')
subplot(224)
plot([1:1:num],para(:,4),'bp','markersize',5)
hold on
plot([1:1:num],para(:,4),'r')
hold off
legend('纵宽比')
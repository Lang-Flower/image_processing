%��һ���ļ����ڵ�Һ��ͼƬ�ĺ���ֱ���Լ�ֱ���Ƚ��м��㡣
%��Ҫ��Ӧ��Һ��ͼƬ��
%��Һ��ͼƬ��Ŷ�Ӧ�ķŴ�����excel�ļ���
%��Ҫ��������ͺ��ڳ������޸ĵ�λ���ص�ĳ��ȡ�
%�õ���ֱ���ļ�������para�����
%��Ҫ���ļ��������ӳ���sort_nat������ͬһ�ļ�����
clc;
clear all;
close all;
all_file=dir('E:\20190716\ʵ�����ݴ���\Һ��ͼƬ\*.bmp'); %�����ļ�����Ϣ
num=length(all_file);%�ļ�����

nameCell = cell(num,1);
for i = 1:num
    nameCell{i} = all_file(i).name;
end
name=sort_nat(nameCell);
magnification=xlsread('E:\20190716\ʵ�����ݴ���\Һ��ͼƬ\��Ӧ�Ŵ���.xlsx','sheet1','B1:B148');  %ÿ��ͼƬ��Ӧ�ķŴ��ʣ����ڼ��㵥λ���ص�ĳ���
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
    location=cell2mat(B(1,1)); % �߽�������
    l_p=20;%��λ���ص㳤��
    mag=magnification(i);
    pixel=l_p/mag; %��ʵ��λ���ص㳤��
    %x����ֱ����y����ֱ�������ص�����
    D_y=(max(location(:,1))-min(location(:,1))+1)*pixel/1000;
    D_x=(max(location(:,2))-min(location(:,2))+1)*pixel/1000;
    D_ef=(D_x*D_y^2)^(1/3);
    alpha=D_y/D_x;
%     disp('����ֱ��������ֱ������Чֱ���������(��λ��mm)')
    para(i,:)=[D_x D_y D_ef alpha];
end
figure(1);
subplot(221)
plot([1:1:num],para(:,1),'rD','markersize',5)
hold on
plot([1:1:num],para(:,1),'b')
hold off
legend('ˮƽֱ��')
subplot(222)
plot([1:1:num],para(:,2),'bp','markersize',5)
hold on
plot([1:1:num],para(:,2),'r')
hold off
legend('��ֱֱ��')
subplot(223)
plot([1:1:num],para(:,3),'rD','markersize',5)
hold on
plot([1:1:num],para(:,3),'b')
hold off
legend('��Чֱ��')
subplot(224)
plot([1:1:num],para(:,4),'bp','markersize',5)
hold on
plot([1:1:num],para(:,4),'r')
hold off
legend('�ݿ��')
%��ÿ���߶ȵ��ٶ���ʵ�������е�ײ���߶Ƚ���ƥ��
%
clc
clear all
close all;
vis_2cst=xlsread('E:\20190928_1\ʵ�����ݴ���.xlsx','ײ���ٶ�','A3:G30');
vis_5cst=xlsread('E:\20190928_1\ʵ�����ݴ���.xlsx','ײ���ٶ�','I3:O31');
vis_10cst=xlsread('E:\20190928_1\ʵ�����ݴ���.xlsx','ײ���ٶ�','Q3:W40');
h_2cst=vis_2cst(:,1);
h_5cst=vis_5cst(:,1);
h_10cst=vis_10cst(:,1);
vel_2cst=vis_2cst(:,3);
vel_5cst=vis_5cst(:,3);
vel_10cst=vis_10cst(:,3);
i_h_5cst=xlsread('E:\20190906\ʵ�����ݴ���\5cstҺ��ͼƬ\5cstҺ��ײ������.xlsx',...
    'sheet1','B2:B159');
i_h_10cst=xlsread('E:\20190906\ʵ�����ݴ���\10cstҺ��ͼƬ\10 cStҺ��ײ��ʵ������.xlsx',...
    'sheet1','B2:B163');
i_h_2cst=xlsread('E:\20190716\ʵ�����ݴ���\Һ��ײ��ʵ������.xlsx','sheet1','F2:F149');
vv_2cst=zeros(size(i_h_2cst));
vv_5cst=zeros(size(i_h_5cst));
vv_10cst=zeros(size(i_h_10cst));
for i=1:size(i_h_2cst,1)
    for j=1:size(h_2cst,1)
    if i_h_2cst(i,1)==h_2cst(j,1)
        vv_2cst(i)=vel_2cst(j,1);
    end
    end
end
for i=1:size(i_h_5cst,1)
    for j=1:size(h_5cst,1)
    if i_h_5cst(i,1)==h_5cst(j,1)
        vv_5cst(i)=vel_5cst(j,1);
    end
    end
end

for i=1:size(i_h_10cst,1)
    for j=1:size(h_10cst,1)
    if i_h_10cst(i,1)==h_10cst(j,1)
        vv_10cst(i)=vel_10cst(j,1);
    end
    end
end       
%将每个高度的速度与实验数据中的撞击高度进行匹配
%
clc
clear all
close all;
vis_2cst=xlsread('E:\20190928_1\实验数据处理.xlsx','撞击速度','A3:G30');
vis_5cst=xlsread('E:\20190928_1\实验数据处理.xlsx','撞击速度','I3:O31');
vis_10cst=xlsread('E:\20190928_1\实验数据处理.xlsx','撞击速度','Q3:W40');
h_2cst=vis_2cst(:,1);
h_5cst=vis_5cst(:,1);
h_10cst=vis_10cst(:,1);
vel_2cst=vis_2cst(:,3);
vel_5cst=vis_5cst(:,3);
vel_10cst=vis_10cst(:,3);
i_h_5cst=xlsread('E:\20190906\实验数据处理\5cst液滴图片\5cst液滴撞击数据.xlsx',...
    'sheet1','B2:B159');
i_h_10cst=xlsread('E:\20190906\实验数据处理\10cst液滴图片\10 cSt液滴撞击实验数据.xlsx',...
    'sheet1','B2:B163');
i_h_2cst=xlsread('E:\20190716\实验数据处理\液滴撞击实验数据.xlsx','sheet1','F2:F149');
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
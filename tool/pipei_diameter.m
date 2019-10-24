%将每个高度的液滴底部曲率半径与实验数据匹配
clc
clear all
close all;
h_2=xlsread('E:\最近工作\实验进展\实验报告\最新2,5,10cst撞击实验数据.xlsx','2cst','B2:B149');
h_5=xlsread('E:\最近工作\实验进展\实验报告\最新2,5,10cst撞击实验数据.xlsx','5cst','B2:B159');
h_10=xlsread('E:\最近工作\实验进展\实验报告\最新2,5,10cst撞击实验数据.xlsx','10cst','B2:B163');
%读底部曲率半径
data=xlsread('E:\20190928_1\硅油撞击实验液滴底部曲率半径.xlsx','sheet1','A2:G96');
hr_2=data(1:28,1);
hr_5=data(29:57,1);
hr_10=data(58:95,1);
r_2=data(1:28,2:7);
r_5=data(29:57,2:7);
r_10=data(58:95,2:7);
rr_2=[];
rr_5=[];
rr_10=[];
for i=1:size(h_2,1)
    for j=1:size(hr_2,1)
        if h_2(i,1)==hr_2(j,1)
            rr_2=[rr_2;r_2(j,:)];
        end
    end
end
for i=1:size(h_5,1)
    for j=1:size(hr_5,1)
        if h_5(i,1)==hr_5(j,1)
            rr_5=[rr_5;r_5(j,:)];
        end
    end
end
for i=1:size(h_10,1)
    for j=1:size(hr_10,1)
        if h_10(i,1)==hr_10(j,1)
            rr_10=[rr_10;r_10(j,:)];
        end
    end
end
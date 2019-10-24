clc
clear all
close all
h=xlsread('E:\20190928_1\硅油撞击实验液滴底部曲率半径.xlsx','sheet1','A2:A96');
rb=xlsread('E:\20190928_1\硅油撞击实验液滴底部曲率半径.xlsx','sheet1','G2:G96');
figure('color',[1 1 1]);
plot(h(1:28)/100,rb(1:28),'rd-',h(29:57)/100,rb(29:57),'bs-',h(58:95)/100,rb(58:95),'mp-',...
    'Markersize',10,'Linewidth',2)
set(gca,'box','on','Linewidth',2)
le=legend('2 cst','5 cst','10 cst');
xla=xlabel('H');
yla=ylabel('Rb');
set(le,'box','off','Fontsize',15)

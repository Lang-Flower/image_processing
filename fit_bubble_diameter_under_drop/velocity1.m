clc
clear all;
close all;
load('Velocity');
figure('color',[1 1 1])
plot(v_cal,'rp','Markersize',10)
axis([0 150 0.5 4.5])
hold on
errorbar(v_ex,err.*v_ex,'bd','Markersize',5,'Linewidth',1)
yla=ylabel('Velocity');
set(gca,'LineWidth',1.5) %设置边框
la=legend('Calculate data','Experiment data');
set([yla la],'Fontname','Times New Roman','FontWeight','Bold','FontSize',10)
% set(la,'box','off')

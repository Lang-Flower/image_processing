clc
clear all;
close all;
load('Velocity');
figure('color',[1 1 1])
plot(v_cal,'g+','Markersize',5)
errorbar(v_ex,err.*v_ex,'bd','Markersize',5,'Linewidth',1)
yla=ylabel('velocity');
set(yla,'Fontname','Times New Roman','FontWeight','Bold','FontSize',10)
set(gca,'LineWidth',1.5) %…Ë÷√±ﬂøÚ
% la=legend('experiment');
% set(la,'box','off')
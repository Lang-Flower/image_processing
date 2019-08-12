clc
clear all
close all;
time=(1:1:30)'*33.3;
d=[33,49,66,78,89,99,107,116,124,131,138,144,150,156,162,166,172,176,181,186,190,194,198,202,206,210,214,218,222,225]';
time=time/(2.21/1.55*1000);
d=d*20/0.8/(2.21*1000)/2;
syms t
f=fittype('sqrt(a*t)','independent','t','coefficients',{'a'});
cfun=fit(time,d,f);
time_fit=time;
d_fit=cfun(time_fit);
figure('color',[1 1 1])
plot(time_fit,d_fit,'b-','Linewidth',1.5);
er=6*ones(1,30)'*20/0.8/2.21/1000; %误差
hold on
errorbar(time,d,er,'rd','Linewidth',1.5,'Markersize',5) %误差棒
xla=xlabel('tU/D');
yla=ylabel('R/D');
l1=legend('fit data','experiment data');
set([xla yla l1],'Fontname','Times New Roman','FontWeight','Bold','FontSize',10) %设置字体格式大小
set(gca,'LineWidth',1.5) %设置边框
hold off
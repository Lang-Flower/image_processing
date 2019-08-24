clc
clear all
close all;
D=2.21*10^-3;
U=3.71;
g=9.81;
syms t
r1=sqrt(2.175*D*U*t);
r2=sqrt(2.432*D*U*t);
v1=diff(r1,t);
v2=diff(r2,t);
f1=matlabFunction(v1);
f2=matlabFunction(v2);
figure('color',[1 1 1])
fplot({f1,f2},[0.05*10^-3 0.9*10^-3],'b','LineWidth',2)
axis([0.05*10^-4 1*10^-3 2 10])
xla=xlabel('t(ms)');
yla=ylabel('V(s)');
set([xla yla],'Fontname','Times New Roman','FontWeight','Bold','FontSize',10)%设置字体格式大小
set(gca,'LineWidth',1.5,'Fontsize',15) %设置边框

%绘制液滴纵宽比与曲率半径的实验数据
clc
clear all
close all
data=xlsread('E:\20190928_1\硅油撞击实验液滴底部曲率半径.xlsx','sheet1','A2:H96');
%撞击高度
h_2=data(1:28,1);
h_5=data(29:57,1);
h_10=data(58:95,1);
%直径纵宽比
a_2=data(1:28,5);
a_5=data(29:57,5);
a_10=data(58:95,5);
%椭圆假设计算得到液滴底部的曲率直径
db_2=data(1:28,6);
db_5=data(29:57,6);
db_10=data(58:95,6);
%2次拟合得到底部曲率直径
db2_2=data(1:28,7);
db2_5=data(29:57,7);
db2_10=data(58:95,7);
%3次拟合得到的底部曲率直径
db3_2=data(1:28,8);
db3_5=data(29:57,8);
db3_10=data(58:95,8);
h_2=h_2/100-0.0043-0.0023;
t_2=(4.995^2/9.81)*acosh(exp(9.81*h_2/4.995^2));
ft_2=fittype('(1+a*cos(w*t+p))/(1-a/2*cos(w*t+p))','independent','t','coefficients',{'a','w','p'});
cfun_2=fit(t_2(3:19),a_2(3:19),ft_2,'startpoint',[0.2,0.3,0.4]);
a_2_fit=cfun_2(t_2);
figure(1)
plot(h_2,t_2,'rd')
figure(2)
hold on
plot(h_2,a_2,'rd-');
fplot(@(x)(1+0.162*cos(208.6*x-132/180*3.1415))/(1-0.162/2*cos(208.6*x-132/180*3.1415)),[0.03,0.8])

% figure(1)
% set(gca,'color',[1 1 1])
% plot(h_2,a_2,'rd-',h_5,a_5,'bp',h_10,a_10,'ms')
% figure(2)
% plot(h_2,db_2,'rd-',h_5,db_5,'bp',h_10,db_10,'ms')

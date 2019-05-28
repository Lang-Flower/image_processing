clc
clear all;
close all;
H=0:0.002:0.7;
Vt=8.52;
g=9.81;
t=(Vt/g)*acosh(exp(g.*H/(Vt)^2));
a=0.162;
w=33.2*2*3.1415926;
phi=-132*3.1415926/180;
alpha=(1+a*cos(w.*t+phi))./(1-a/2*cos(w.*t+phi));
plot(H,alpha,'rD')
hold on;
plot(H,alpha,'b')

%自定义拟合
sym t
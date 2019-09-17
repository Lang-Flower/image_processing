clc
clear all
close all
% g=9.81;
% h0=7.218e-3;
% d=2.3e-3;
h_1=[0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;1];
v_1=[1.25;1.8;2.21;2.53;2.82;3.07;3.27;3.47;3.64;3.83];
syms vt
f=fittype('vt*sqrt(1-exp(-2*9.81*(H-2.3e-3-7.218e-3)/vt^2))','independent','H','coefficients',{'vt'});
cfun=fit(h_1,v_1,f);
f_fit=cfun(h_1);
plot(h_1,v_1,'bd',h_1,f_fit,'b-','Linewidth',1.5);

clc
clear all
close all;
syms t r
h=0.39/(t+0.25)^2*exp(-2.34*r^2/(t+0.25)^2);
f=matlabFunction(h);
figure('color',[1 1 1])
hold on
i=1;
le=cell(1,8);
for t=0.25:0.25:2
    fplot(f(r,t),[0,2],'Linewidth',1.5);
    le{1,i}=strcat('t=',num2str(t));
    i=i+1;
end
set(gca,'box','on')
legend(le)
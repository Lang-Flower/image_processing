clc
clear all;
close all;
D=xlsread('717液滴撞击实验数据.xlsx','sheet1','D2:D149');
hf=xlsread('717液滴撞击实验数据.xlsx','sheet1','H2:H149');
derta=hf./D/1000;
[K,sta]=xlsread('717液滴撞击实验数据.xlsx','sheet1','K2:L149');
err=xlsread('717液滴撞击实验数据.xlsx','sheet1','Q2:Q149');
figure('color',[1 1 1])
hold on
for i=1:size(K,1)
    if all(sta{i}=='SS')==1
        %plot(derta(i),K(i),'b+','Markersize',10)
        le1=errorbar(derta(i),K(i),err(i),'rs','Markersize',7);
    elseif all(sta{i}=='PS')==1
        %plot(derta(i),K(i),'bx','Markersize',10)
        le2=errorbar(derta(i),K(i),err(i),'gd','Markersize',7);
    elseif all(sta{i}=='CS')==1
        %plot(derta(i),K(i),'bo','Markersize',10)
        le3=errorbar(derta(i),K(i),err(i),'bo','Markersize',7);
    else
        %plot(derta(i),K(i),'bd','Markersize',10)
        le4=errorbar(derta(i),K(i),err(i),'c.','Markersize',7);
    end
end
syms derta1
K1=(2100+2000*derta1^1.44)^1.25;
le5=fplot(K1,[0 0.15],'m:','Linewidth',1.5);
set(gca,'box','on','Linewidth',1.5)
xla=xlabel('$$\delta=h_{f}/D$$');
yla=ylabel('$$K=WeRe^{0.5}$$');
axis([-0.005 0.15 0 120000])
% str='$$K=2100+5880\times\delta^{1.44}$$';
% set(str,'Interpreter','Latex')
leg=legend([le1 le2 le3 le4 le5],'Spreading','Prompt splash','Corona splash','Worthington jet','$$K=2100+5880\times\delta^{1.44}$$');
set([leg xla yla],'Interpreter','Latex','Fontsize',12)
hold off
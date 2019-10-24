clc
clear all
close all
data_2=xlsread('E:\20190928_1\硅油撞击实验速度计算.xlsx','撞击速度','A3:G30');
data_5=xlsread('E:\20190928_1\硅油撞击实验速度计算.xlsx','撞击速度','I3:O31');
data_10=xlsread('E:\20190928_1\硅油撞击实验速度计算.xlsx','撞击速度','Q3:W40');
h0_2=0.001*xlsread('E:\20190928_1\硅油撞击实验速度计算.xlsx','pinch_off_length','C3:C3');
h0_5=0.001*xlsread('E:\20190928_1\硅油撞击实验速度计算.xlsx','pinch_off_length','C7:C7');
h0_10=0.001*xlsread('E:\20190928_1\硅油撞击实验速度计算.xlsx','pinch_off_length','C11:C11');
D_2=data_2(:,5)/1000;
D_5=data_5(:,5)/1000;
D_10=data_10(:,5)/1000;
h_2=data_2(:,1)/100;
h_5=data_5(:,1)/100;
h_10=data_10(:,1)/100;
v_2=data_2(:,3);
v_5=data_5(:,3);
v_10=data_10(:,3);
% ft_2=fittype('vt*sqrt(1-exp(-2*9.81*(H-0.0043-0.0023)/vt^2))','independent','H','coefficients',{'vt'});
% cfun_2=fit(h_2,v_2,ft_2,'startpoint',0.02);
% v_2_fit=cfun_2(h_2);
% ft_5=fittype('vt*sqrt(1-exp(-2*9.81*(H-0.0043-0.0023)/vt^2))','independent','H','coefficients',{'vt'});
% cfun_5=fit(h_5,v_5,ft_5,'startpoint',0.02);
% v_5_fit=cfun_5(h_5);
% ft_10=fittype('vt*sqrt(1-exp(-2*9.81*(H-0.0045-0.0023)/vt^2))','independent','H','coefficients',{'vt'});
% cfun_10=fit(h_10,v_10,ft_10,'startpoint',0.02);
% v_10_fit=cfun_10(h_10);
figure('color',[1 1 1])
hold on
plot(h_2,v_2,'rp','Markersize',10,'Linewidth',2)
plot(h_5,v_5,'bd','Markersize',10,'Linewidth',2)
plot(h_10,v_10,'ms','Markersize',10,'Linewidth',2)
fplot(@(x) sqrt(2*9.81*(x-0.0066)),[0.01 1.4],'Linewidth',2)
le=legend('2 cSt Experiment',...
    '5 cSt Experiment',...
    '10 cSt Experiment','theoretical speed');
set(gca,'Box','on','Linewidth',2)
set(le,'box','off')
xlabel('H')
ylabel('V')

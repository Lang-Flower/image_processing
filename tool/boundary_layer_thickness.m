clc
clear all
close all
figure('color',[1 1 1])
hold on
fplot(@(x)2.3*10^3/sqrt(x),[1192,4109],'Linewidth',2)
xlabel('Re');
ylabel('¦Ä')
set(gca,'box','on','Linewidth',2)
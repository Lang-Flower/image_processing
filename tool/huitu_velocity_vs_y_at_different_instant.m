clc
clear all
close all
v=2e-6;
figure('color',[1 1 1])
for i=10:50:500
fplot(@(y) erf(y/sqrt(v*(i*1e-6))),[0 90e-6])
hold on
end
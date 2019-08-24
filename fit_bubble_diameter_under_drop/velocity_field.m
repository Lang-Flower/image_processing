clc
clear all;
close all;
% D=2.21;
% U=2.05;
% t=0.1:0.1:1;
% r=sqrt(D*10^-3*U*t*10^-6);
% h=0.39./(t+0.25).^2.*exp(-2.34*r.^2./(t+0.25).^2);
r=(33:2:100)*20/0.8;
h=(1:8/size(r,2):9)*20/0.8;
[rr,hh]=meshgrid(r,h);
for i=1:size(rr,1)
    for j=1:size(hh,2)
        vr(i,j)=rr(i,j);
        vz(i,j)=-2*hh(i,j);
    end
end
quiver(rr,hh,vr,vz)

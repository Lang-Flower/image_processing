clc
clear all
a=dir('E:\20190906\');
a_real(1:320,1)=a(3:322,1);
n=size(a_real,1);
num=zeros(size(a_real));
for i=1:n
    len=length(a_real(i).name);
    t=findstr(a_real(i).name,'h');
    num(i)=str2num(a_real(i).name(t+1:len));
end
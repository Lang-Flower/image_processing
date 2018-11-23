clc;
clear all;
flag=1;
a=imread('42.jpg');
b=rgb2gray(a);
bw=edge(b,'canny',0.5);
c=size(bw);
point(5,2)=0;
for i=1:c(1)/2
    for j=c(2):-1:1
        if flag<=20&&bw(i,j)==1
            flag=flag+1;
            point(flag,1)=i;
            point(flag,2)=j;
            continue
        end
    end
end
point;
plot(point(:,1),point(:,2))

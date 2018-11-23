%This is a matlab image processing program for experimental data;
%use pendant drop method to detect the surface tension of drop;
%%
%surface detection through imagine processing
%method by <http://www.maist.com.cn/new/methods/Pendant-Drop.html>
%procedure:kill blank area of drop==>obtain boundary location of the bottom
%half of drop==>fit this data with curve==>get the carvasture of ...
%...curve-->cacultate and obtain the surface tenetion
clc
clear all
im=imread('water1.jpg');
im_gray=rgb2gray(im);
%im_edge_gray=edge(im_gray,'canny',0.8);
%figure(1);imshow(im_edge_gray)
sh=graythresh(im_gray);
im_bw=imbinarize(im_gray,sh);
%imshow(im_bw);
im_nb=bwareaopen(im_bw,1000);%no blank area in object
%imshow(im_nb);
%figure(2);imshow(im_nb);
%im_edge=bwperim(im_nb); %edge of binarized imagine's boundary
%imshow(im_edge);
%%
%caculate the maximum curvature radius of the bottom point
sizz=size(im_bw);
dx=zeros(sizz(1),2);
dy=zeros(sizz(1),2);
%location of left boundary
for i=1:sizz(1)
    for j=1:sizz(2)
        if im_bw(i,j)==0 && dx(i,1)==0
            dx(i,1)=j;
            dy(i,1)=i;
        end
    end
end
%location of right boundary
for i=1:sizz(1)
    for j=1:sizz(2)
        if im_bw(i,sizz(2)-j+1)==0 && dx(i,2)==0
            dx(i,2)=sizz(2)-j+1;
            dy(i,2)=i;
        end
    end
end
de=max(abs(dx(:,1)-dx(:,2)))+1;
%[rows,cols]=find(abs(dx(:,1)-dx(:,2))==max(abs(dx(:,1)-dx(:,2))));%loaction of de
bot=zeros(1,2);
%determin the origin of coordinate
for i=1:sizz(1)
    if abs(dx(i,1)-dx(i,2))==0 && bot(1,1)==0
        bot(1,1)=i-1;%location y of drop bottom
        bot(1,2)=fix((dx(i-1,2)+dx(i-1,1))/2.0);%location x of drop bottom
    end
end
%determin the location of maximum diameter
bot_max=0;
for i=1:sizz(1)
    if abs(dx(i,1)-dx(i,2))==max(abs(dx(:,1)-dx(:,2)))
        bot_max=i;
    end
end
%cut 1/20 half drop and fit the boundary with polynomial function
tri=bot(1,1)-(fix((bot(1,1)-bot_max)/10));%reduce amount of data point
data(:,1)=[dx(tri:bot(1,1),1);flipud(dx(tri:bot(1,1),2))];
data(:,2)=[dy(tri:bot(1,1),1);flipud(dy(tri:bot(1,1),2))];
p=polyfit(data(:,1),data(:,2),2);
nihe=polyval(p,data(:,1));
%plot(data(:,1),nihe,'b',data(:,1),data(:,2),'r*')
dp=polyder(p);
cv=abs(polyder(dp));%curvature of curve
radii_b=(1+(dp(1)*bot(1,2)+dp(2))^2)^1.5/cv;%Curvature radius b
% choose 3 points and thier respective vicinal 10 points to calculate...
% ...carvature radius R
h=fix((bot(1,1)-bot_max)/4);
points=zeros(3,2);
for i=1:3
    points(i,1)=dy(bot_max+h*i,1);
    points(i,2)=dx(bot_max+h*i,2);
end
p2=[];
dp2=[];
cv2=[];
radii_R=zeros(3,1);
phi=zeros(3,1);
dot=30;%nearby dots to fit
data2=zeros(dot*2+1,2);
for i=1:3
    data2(:,1)=dx(bot_max+h*i-dot:bot_max+h*i+dot,1);%fit 20 nearby points
    data2(:,2)=dy(bot_max+h*i-dot:bot_max+h*i+dot,2);
    p2=polyfit(data2(:,1),data2(:,2),2);
    dp2=polyder(p2);
    cv2=abs(polyder(dp2));
    phi(i,1)=atan(abs(dp2(1)));
    radii_R(i,1)=(1+(dp2(1)*data2(dot+1,1)+dp2(2))^2)^1.5/cv2;
end
pixel=1/54*10^(-3);
z=(bot(1,1)-points(:,1))*pixel;
x=(points(:,2)-bot(1,2))*pixel;
drou=998-1.29; %density difference
g=9.81;%givity acceleration
bottom=2-radii_b./radii_R-radii_b.*sin(phi)./radii_R;
sigema=drou*g.*radii_b.*z./bottom*pixel;
figure(1)
subplot(1,2,1),imshow(im),title('origin imagine');
subplot(1,2,2),imshow(im_nb),title('detected boundary');
figure(2)
subplot(1,2,1),plot(data(:,1),nihe,'b',data(:,1),data(:,2),'r*'),title('bottom curvature');
subplot(1,2,2),plot(dx(1:bot(1,1),2),dy(1:bot(1,1),2),'b+',points(:,2),points(:,1),'r*'),title('points to calculate');
fprintf('drop surface tension is %e %n',sigema(1));

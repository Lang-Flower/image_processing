function [y_center,x_center]=center(img)
%程序用于计算图像中形状的质心位置,程序调用格式为[y_center,x_center]=center(img)
%x_center,y_center为图像中质点的位置位置.
%%
%首先判断图像为彩图或者灰度图
sz=size(img,3);
pixel_num=size(img,1)*size(img,2);
if sz==1&(sum(img)<=pixel_num)
    %灰度图
    img_bw=img;
else
    %按照彩色图处理
    img_gray=rgb2gray(img);
    level=graythresh(img_gray);
    %计算图像I_gray的全局阈值，level为标准化灰度值，其范围为[0 1]
    img_bw=imbinarize(img_gray,level);
end
[height,width]=size(img_bw);%计算灰度图像的长宽    

  
img_bw=~img_bw; %%反色  
  
[L,num]=bwlabel(img_bw,8);%bwlabel标注二值图像I_bw中的目标物体，返回标识矩阵Ｌ和I_bw中目标物体的数量num，８表示连通数．  
x_center=zeros(1,num);%%zeros(m,n)产生m×n的全0矩阵．用于记录质心位置的横坐标  
y_center=zeros(1,num);%zeros(m,n)产生m×n的全0矩阵．用于记录质心位置的纵坐标  
  
for k=1:num  %%num个区域依次统计质心位置      
    sum_x=0;    sum_y=0;    area=0; %初始化  
    for i=1:height     
        for j=1:width   
            if L(i,j)==k       
                sum_x=sum_x+i;  %计算第Ｋ区域的横坐标总和  
                sum_y=sum_y+j;  %计算第Ｋ区域的纵坐标总和   
                area=area+1;    %计算第Ｋ区域的由多少个坐标点表示  
            end  
        end  
    end  
    x_center(k)=fix(sum_x/area);  %计算第Ｋ区域的质心横坐标  
    y_center(k)=fix(sum_y/area);%计算第Ｋ区域的质心纵坐标  
end  
%figure(1);
%subplot(1,2,1),imshow(img_bw);%显示二值图像（背景为白色）
%subplot(1,2,2),imshow(img_bw);%显示取反后的二值图像（背景为黑色）
%figure(2);
%imshow(img);%原始图像
%figure(3);
%imshow(img_bw);%显示取反后的二值图像（背景为黑色）,并在图上标注质心点位置  
%for i=1:num  
%  hold  on  
%  plot(y_center(i) ,x_center(i), '+') 
%end
end

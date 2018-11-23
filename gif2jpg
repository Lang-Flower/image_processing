clc
clear all;
%% 在当前路径下创建文件夹gif2im
[gif,map]=imread('F:\matlab\bin\chengxu\contact_angle.gif','gif'); %读入gif图片
if exist('gif2im')         %查询当前路径下是否存在gif2im文件夹
    rmdir('gif2im\','s')      %删除当前路径下的gif2im文件夹
else
     mkdir('gif2im');    %当前路径下创建gif2im文件
end
mkdir('gif2im')
%% 将图片保存到创建的文件夹下
sizegif=size(gif);
amount_im=sizegif(1,4);  %gif中图片的数量
current_folder=cd;
current_folder=strcat(current_folder,'\','gif2im');
for i=1:amount_im       %将图片转化为RGB类型的图保存在文件夹中
    image_name=strcat(current_folder,'\',num2str(i),'.jpg');
    im=ind2rgb(gif(:,:,:,i),map);
    imwrite(im,image_name) % 保存的图片类型为rgb型
end
%% 图片进行处理获取动态接触角的变化过程
point_pick(5,2)=0;        %定义一个采集接触角边界坐标的变量，矩阵维数与采集点的个数有关 
p(amount_im,2)=0;           %每一帧图片中接触角的值
for i=1:amount_im
    flag=0;                                    %记录接触角取的点的个数
    im_gray=ind2gray(gif(:,:,:,i),map);    %将索引图转换为灰度图
    bw=edge(im_gray,'canny',0.5);          %边缘检测，参数可根据效果调节。
    image_name=strcat(current_folder,'\','bw',num2str(i),'.jpg');
    size_bw=size(bw);
    horizon_bw=size_bw(1);                 %横向像素
    vertical_bw=size_bw(2);                %纵向像素点
    for j=vertical_bw:-1:1
        for k=1:horizon_bw/2
            if bw(k,j)==1&&flag<=5
                flag=flag+1;
                point_pick(flag,1)=k;
                point_pick(flag,2)=vertical_bw-j;
            end
        end
    end
    point_pick
    p(i,:)=polyfit(point_pick(:,1),point_pick(:,2),1);
end

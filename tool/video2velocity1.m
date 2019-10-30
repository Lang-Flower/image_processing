clc
clear all;
close all
%% 读取视频
[video_name, video_file] = uigetfile( ...
{  '*.avi','videofile'; ... %不同的文件格式用分号隔开
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');
fprintf('%s\n%s\n','video_file=',video_file)
fprintf('%s\n%s\n','video_name=',video_name)
video_all=sprintf('%s/%s',video_file,video_name);%路径+文件名+文件类型,注意sprintf中文件格式需要用反斜杠
video=VideoReader(video_all);%将视频文件读取为对象文件OBJ
frame_number=floor(video.Duration * video.FrameRate);%获得视频的帧数
%% 获取每张图片液滴的直径并计算液滴撞击速度
velocity=zeros(frame_number,1);
fprintf('frame number:\n%d\n',frame_number)
mass_center=zeros(frame_number,2);%每帧图片的质心位置
alpha=zeros(frame_number,1);%每帧图片的纵宽比
logic=0;%判断多连通域质心数量，一旦连通域数量大于1，则变成1不再统计质心的数量
img_1=read(video,1); %读取第一帧背景图
img_1=img_1(1:800,250:1040);
% h=waitbar(0,'处理图片中，请稍后');
for i=2:frame_number
    %     waitbar(i/frame_number)
    if mod(i,floor(frame_number/5))==0
        fprintf('图片处理进度:%d/%d\n',i,frame_number)
    end
    area=0;
    sum_x=0;
    sum_y=0;
    img=read(video,i);%读出图片i
    img=img(1:800,250:1040);%裁剪图片，比如视频中出现的拍摄信息
    img=img_1-img;
    if size(img,3)>1
    img=rgb2gray(img);
    end
    t=graythresh(img);
    img_bw=imbinarize(img,t);
    img_open=bwareaopen(img_bw,3000);
    if sum(img_open(:))==0
        continue %识别图中无液滴
    else
        img_open=bwareaopen(~img_open,3000);
    end
    img_edge=edge(img_open,'Canny',0.9);
    %计算纵宽比
    [ro,co]=find(img_edge);
    dx=max(ro)-min(ro)+1;
    dy=max(co)-min(co)+1;
    if dx~=0
    alpha(i)=dy/dx;
    end
    fig1=figure(1);
    imshow(img_edge)
    str=['Frame:',num2str(i)];
    text(15,30,str,'Fontsize',20,'Color','White')
    %     if i==50
    %         figure(1)
    %         subplot(121)
    %         imshow(img_open);
    %         subplot(122)
    %         imshow(img_bw)
    %         figure(2)
    %         imshow(img_edge);
    %         return
    %     end
    %求液滴质心位置
    img_center=(~img_open);
    area=sum(img_center(:));
    [height,width]=size(img_center);
    for j=1:height
        for k=1:width
            if img_center(j,k)==1
                sum_x=sum_x+j;
                sum_y=sum_y+k;
            end
        end
    end
    %%质心坐标
    mass_center(i,1)=fix(sum_x/area);
    mass_center(i,2)=fix(sum_y/area);
end
% close(h)
close(fig1)
figure(3);
plot(mass_center(1:frame_number,1),'*')
grid on
st=input('输入计算速度段起始帧:\n');
ed=input('输入计算速度段结束帧:\n');
% ma=input('放大倍数:\n');
pixel=28;
ma=1.25;
period=50;
fprintf('********************\n********************\n')
fprintf('放大倍数为:X1X%3.2fX1.6\n单个像素尺寸为:%d μm\n每帧图时间间隔:%d μs\n',ma,pixel,period)
time=(st:1:ed);
time=time';
p=polyfit(time.*period,mass_center(st:ed,1).*pixel/1/1.6/ma,1);
fprintf('********************\n********************\n')
fprintf('液滴撞击速度为:%3.2f m/s\n',p(1))
figure(4);
title('Dy/Dx')
plot(alpha,'bd')
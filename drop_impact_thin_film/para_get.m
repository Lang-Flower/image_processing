% obtain drop diameter and velocity
% 2018年11月23日21点30分
% version 1.0
clc
clear all;
% find video
[video_name, video_file] = uigetfile( ...
{  '*.avi','videofile'; ... %不同的文件格式用分号隔开
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');
fprintf('%s\n%s\n','video_file=',video_file)
fprintf('%s\n%s\n','video_name=',video_name)
video_all=sprintf('%s/%s',video_file,video_name);%路径+文件名+文件类型,注意sprintf中文件格式需要用反斜杠
video=VideoReader(video_all);%将视频文件读取为对象文件OBJ
frame_number=floor(video.Duration * video.FrameRate);%获得视频的帧数;%获得视频的帧数
fprintf('%d\n',frame_number)
%% 
velocity=zeros(frame_number,1);
mass_center=zeros(frame_number,2);

%截取要进行操作的区域
h1=questdlg('截取画面中包含信息的区域','消息提示','确定');
test=read(video,100);
figure(1);
imshow(test);
set(gcf,'outerposition',get(0,'screensize'));%使该图显示最大化，便于取点  
%鼠标取点，取区域左上和右下两个点，回车键结束。
h2=questdlg('取区域左上角点','消息提示','确定');
[x_lu,y_lu]=ginput(1);
h3=questdlg('取区域右下角点','消息提示','确定');
[x_rd,y_rd]=ginput(1);
x_lu=floor(x_lu);
y_lu=floor(y_lu);
x_rd=ceil(x_rd);
y_rd=ceil(y_rd);
close(figure(1))

%处理后的图片数据存放。
img_store=zeros(frame_number,x_rd-x_lu+1,y_rd-y_lu+1);
bottom=zeros
for i=1:frame_number
    img=read(video,i);%读出图片i
    if i==50
        figure(2)
        imshow(img)
    end
    
    %取液滴所在位置区域，消除边角黑影，第一项为图片垂直方向，第二项为水平方向。
    img=img(y_lu:y_rd,x_lu:x_rd);
    
    %图像二值化
    level=graythresh(img);
    img_bw=imbinarize(img,level);
    
    %去掉图像中噪点不必要的连通域。
    img_open=kill_blank(img_bw);
    for j=1:y_rd-y_lu+1
        for k=1:x_rd-x_lu+1
            img_open
            %%%%%%%%%%%%%
            %%%%%%%未完待续
            %%%%%%%%%%%%
        end
    end
    if mod(i,50)==0
        st=sprintf('now frame is %d,total frames are %d',i,frame_number);
        disp(st)
    end
end

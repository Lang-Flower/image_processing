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

%采集拍摄的频率，放大倍数，相机单位像素的原始长度
collect=inputdlg({'拍摄帧率fps','放大倍数','相机单位像素原始长度μm/pixel'},'拍摄参数',[1 10;1 5;1 7]);
fps=str2double(collect{1,1});
magnification=str2double(collect{2,1});
len_pixel=str2double(collect{3,1});

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
bottom=zeros(frame_number,1);

hh=waitbar(0,'please wait');
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
    
    %去掉图像杂点
    img_open=kill_blank(img_bw);
    
    if i==50
        figure(3)
        subplot(1,2,1),
        imshow(img);
        title('imgage trim')
        subplot(1,2,2)
        imshow(img_open)
        title('img open');
    end
    
    %计算液滴底部y坐标并放入bottom
    for j=1:y_rd-y_lu+1
        for k=1:x_rd-x_lu+1
            if img_open(j,k)==0
                bottom(i,1)=j;
            end
            %%%%%%%%%%%%%
            %%%%%%%未完待续
            %%%%%%%%%%%%
        end
    end
   
    %时间尺
    str=['程序运行中',num2str(i/frame_number*100),'%'];
    waitbar(i/frame_number,hh,str)
%     if mod(i,50)==0
%         st=sprintf('now frame is %d,total frames are %d',i,frame_number);
%         disp(st)
%     end
end
delete(hh);
figure(4)
plot((1:frame_number)',bottom(:,1))

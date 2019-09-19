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
mass_center=zeros(frame_number,2);
logic=0;%判断多连通域质心数量，一旦连通域数量大于1，则变成1不再统计质心的数量
img_1=read(video,1); %读取第一帧背景图
img_1=img_1(88:542,160:720);
% h=waitbar(0,'处理图片中，请稍后');
for i=2:200
%     waitbar(i/frame_number)
    area=0;
    sum_x=0;
    sum_y=0;
    img=read(video,i);%读出图片i
    img=img(88:542,160:720);%裁剪图片，比如视频中出现的拍摄信息
    img=img_1-img;
    t=graythresh(img);
    img_bw=imbinarize(img,t);
    img_open=bwareaopen(img_bw,3000);
    if sum(img_open(:))==0
        continue %识别图中无液滴
    else
    img_open=bwareaopen(~img_open,3000);
    end
    img_edge=edge(img_open,'Canny',0.9);
%     if i==30
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
    if mod(i,floor(frame_number/10))==0
        fprintf('图片处理进度:%d/%d\n',i,200)
    end
end
% close(h)
figure;
plot(mass_center(1:200,1),'*')
grid on
pause;
st=input('速度段起始帧:\n');
ed=input('速度段结束帧:\n');
ma=input('放大倍数:\n');
time=(st:1:ed);
time=time';
p=polyfit(time.*0.5,mass_center(st:ed,1).*20/0.5/1.6/ma,1);
p
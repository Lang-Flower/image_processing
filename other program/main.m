%大程序，主要用于计算液滴直径，液滴撞击速度
%程序思路：读取视频——>图像取灰度值-->二值化——>填充反光区域——>获取质心——>液滴撞击速度。
clc
clear all;
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
mass_center=zeros(frame_number,2);
fprintf('%d\n',frame_number)
for i=1:frame_number
    img=read(video,i);%读出图片i
    %img=img(233:504,212:723);%裁剪图片，比如视频中出现的拍摄信息
    img_bao=kill_blank(img);
    [x,y]=center(img_bao);
    if sum(size(y))>2
     mass_center(i,1)=x(1);
     mass_center(i,2)=y(1);
      fprintf('%d\n',i)
    end
end
plot(mass_center(:,1),mass_center(:,2),'*')

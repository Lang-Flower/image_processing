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
fprintf('%d\n',frame_number)
mass_center=zeros(frame_number,2);
logic=0;%判断多连通域质心数量，一旦连通域数量大于1，则变成1不再统计质心的数量
for i=1:frame_number
    img=read(video,i);%读出图片i
    img=img(233:504,212:723);%裁剪图片，比如视频中出现的拍摄信息
    img=200-img;
    img_edge=edge_detection(img,0.5);
    level=graythresh(img_edge);
    img_bw=imbinarize(img_edge,level);
    img_bw=~img_bw;
    img_bwareaopen=bwareaopen(img_bw,8000);
    img_cleanborder=imclearborder(~img_bwareaopen);%去除与边界相连的区域
    se=strel('disk',5);
    img_open=imopen(img_cleanborder,se);%去除小区域
    imshow(img_open)
    [x,y]=center(~img_open);
    if size(x,2)<=1&&logic==0
    mass_center(i,1)=x;
    mass_center(i,2)=y;
    else
        logic=1;
    end
    
    if mod(i,floor(frame_number\10))==0
        fprintf('%d',i)
    end
end
figure;
plot(mass_center(:,1),mass_center(:,2),'*')

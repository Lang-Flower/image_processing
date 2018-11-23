clc
clear all
%% 将视频转化为图片并保存于一个文件夹
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
folder_name='imagines';%在视频所在文件夹下创建名为imagines的新文件夹
%%%%%%%%%先判断元件件夹是否存在
if ~exist(sprintf('%s%s%',video_file,folder_name),'dir')==0
    mkdir(sprintf('%s%s%',video_file,folder_name));%创建文件夹imagines用于放置
else
    disp('there have exist "imagines"  folder');%w文件夹存在则报错
    rmdir(sprintf('%s%s%',video_file,folder_name));%删除文件夹
    mkdir(sprintf('%s%s%',video_file,folder_name));%再创建文件夹imagines
end

for i=1:frame_number
    image_name=strcat(sprintf('%s/%s/',video_file,folder_name),num2str(i),'.jpg');%存储的图片路径可根据需要更改
    I=readframe(video,i);                               %读出图片
    imwrite(I,image_name,'jpg');                   %写图片
    I=[];
end

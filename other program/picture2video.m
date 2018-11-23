clc
clear all
%%图片转化为视频
%framesPath :图像序列所在路径，同时要保证图像大小相同
%video_name:  表示将要创建的视频文件的名字
%quality:    生成视频的质量 0-100
%Compressed: 压缩类型， 'Indeo3'（默认）, 'Indeo5', 'Cinepak', 'MSVC', 'RLE' or 'None'
%fps: 帧率
%startFrame ,endFrame ;表示从哪一帧开始，哪一帧结束
startframe=input('input the startframe:\n');
endframe=input('input endframe:\n');
fps=input('input the frame per second:\n');
imagin_path=input('input the path of the pictures folder:\n','s');
video_name=input('input the name of video you want made:\n','s');
video_name=sprintf('%s%s',video_name,'.avi');
quality=input('input the name of quality of the video 0-100');
compressed='none';
if(exist('video_name','file'))   %表示当前文件夹
    delete video_name.avi
end
%%生成视频的参数设定
avifile=avifile(video_name);  %创建一个avi视频文件对象，开始时其为空
avifile.Quality=quality;%视频文件的质量0-100
avifile.Fps=fps;%
avifile.compression=compressed;
%%读入图片
for i=startframe:endframe
    video_name=sprintf('%s%d','processed',i);    %根据文件名而定
    frames=imread([imagin_path,video_name,'.jpg']);
    avifile=addframe(avifile,uint8(frames));
end
avifile=close(avifile); % 关闭创建视频

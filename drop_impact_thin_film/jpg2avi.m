function []=jpg2avi(img_store)
%%图片转化为视频
%[avi]=jpg2avi(img_store,frame_number,fps)
%video_name:  表示将要创建的视频文件的名字
%quality:    生成视频的质量 0-100
%Compressed: 压缩类型， 'Indeo3'（默认）, 'Indeo5', 'Cinepak', 'MSVC', 'RLE' or 'None'
%fps: 帧率
%startFrame ,endFrame ;表示从哪一帧开始，哪一帧结束
frame_num=size(img_store,1);
para=inputdlg({'视频名称','开始帧','结束帧','播放速度','视频质量1~100'},...
    sprintf('总帧数 %d',frame_num),[1 10;1 5;1 5;1 5;1 5]);
video_name=para{1};
startframe=str2num(para{2});
endframe=str2num(para{3});
fps=str2num(para{4});
quality=str2num(para{5});
compressed='none';
if(exist('video_name','file'))   %表示当前文件夹
    delete video_name.avi
end
%%生成视频的参数设定
aa=cd;
video_name=sprintf(aa,'\',video_name,'.avi');
avifile=avifile(video_name);  %创建一个avi视频文件对象，开始时其为空
avifile.Quality=quality;%视频文件的质量0-100
avifile.Fps=fps;%
avifile.Compression=compressed;
%%读入图片
frames=zeros(size(img_store,2),size(img_store,3));
for i=startframe:endframe
    video_name=sprintf('%s%d','processed',i);    %根据文件名而定
    frames(:,:)=img_store(i,:,:);
    avifile=addframe(avifile,uint8(frames));
end
avifile=close(avifile); % 关闭创建视频

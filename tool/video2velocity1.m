clc
clear all;
close all
%% ��ȡ��Ƶ
[video_name, video_file] = uigetfile( ...
{  '*.avi','videofile'; ... %��ͬ���ļ���ʽ�÷ֺŸ���
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file', ...
   'MultiSelect', 'on');
fprintf('%s\n%s\n','video_file=',video_file)
fprintf('%s\n%s\n','video_name=',video_name)
video_all=sprintf('%s/%s',video_file,video_name);%·��+�ļ���+�ļ�����,ע��sprintf���ļ���ʽ��Ҫ�÷�б��
video=VideoReader(video_all);%����Ƶ�ļ���ȡΪ�����ļ�OBJ
frame_number=floor(video.Duration * video.FrameRate);%�����Ƶ��֡��
%% ��ȡÿ��ͼƬҺ�ε�ֱ��������Һ��ײ���ٶ�
velocity=zeros(frame_number,1);
fprintf('frame number:\n%d\n',frame_number)
mass_center=zeros(frame_number,2);%ÿ֡ͼƬ������λ��
alpha=zeros(frame_number,1);%ÿ֡ͼƬ���ݿ��
logic=0;%�ж϶���ͨ������������һ����ͨ����������1������1����ͳ�����ĵ�����
img_1=read(video,1); %��ȡ��һ֡����ͼ
img_1=img_1(1:800,250:1040);
% h=waitbar(0,'����ͼƬ�У����Ժ�');
for i=2:frame_number
    %     waitbar(i/frame_number)
    if mod(i,floor(frame_number/5))==0
        fprintf('ͼƬ�������:%d/%d\n',i,frame_number)
    end
    area=0;
    sum_x=0;
    sum_y=0;
    img=read(video,i);%����ͼƬi
    img=img(1:800,250:1040);%�ü�ͼƬ��������Ƶ�г��ֵ�������Ϣ
    img=img_1-img;
    if size(img,3)>1
    img=rgb2gray(img);
    end
    t=graythresh(img);
    img_bw=imbinarize(img,t);
    img_open=bwareaopen(img_bw,3000);
    if sum(img_open(:))==0
        continue %ʶ��ͼ����Һ��
    else
        img_open=bwareaopen(~img_open,3000);
    end
    img_edge=edge(img_open,'Canny',0.9);
    %�����ݿ��
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
    %��Һ������λ��
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
    %%��������
    mass_center(i,1)=fix(sum_x/area);
    mass_center(i,2)=fix(sum_y/area);
end
% close(h)
close(fig1)
figure(3);
plot(mass_center(1:frame_number,1),'*')
grid on
st=input('��������ٶȶ���ʼ֡:\n');
ed=input('��������ٶȶν���֡:\n');
% ma=input('�Ŵ���:\n');
pixel=28;
ma=1.25;
period=50;
fprintf('********************\n********************\n')
fprintf('�Ŵ���Ϊ:X1X%3.2fX1.6\n�������سߴ�Ϊ:%d ��m\nÿ֡ͼʱ����:%d ��s\n',ma,pixel,period)
time=(st:1:ed);
time=time';
p=polyfit(time.*period,mass_center(st:ed,1).*pixel/1/1.6/ma,1);
fprintf('********************\n********************\n')
fprintf('Һ��ײ���ٶ�Ϊ:%3.2f m/s\n',p(1))
figure(4);
title('Dy/Dx')
plot(alpha,'bd')
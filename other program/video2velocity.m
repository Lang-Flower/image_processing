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
mass_center=zeros(frame_number,2);
logic=0;%�ж϶���ͨ������������һ����ͨ����������1������1����ͳ�����ĵ�����
img_1=read(video,1); %��ȡ��һ֡����ͼ
img_1=img_1(88:542,160:720);
% h=waitbar(0,'����ͼƬ�У����Ժ�');
for i=2:200
%     waitbar(i/frame_number)
    area=0;
    sum_x=0;
    sum_y=0;
    img=read(video,i);%����ͼƬi
    img=img(88:542,160:720);%�ü�ͼƬ��������Ƶ�г��ֵ�������Ϣ
    img=img_1-img;
    t=graythresh(img);
    img_bw=imbinarize(img,t);
    img_open=bwareaopen(img_bw,3000);
    if sum(img_open(:))==0
        continue %ʶ��ͼ����Һ��
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
    if mod(i,floor(frame_number/10))==0
        fprintf('ͼƬ�������:%d/%d\n',i,200)
    end
end
% close(h)
figure;
plot(mass_center(1:200,1),'*')
grid on
pause;
st=input('�ٶȶ���ʼ֡:\n');
ed=input('�ٶȶν���֡:\n');
ma=input('�Ŵ���:\n');
time=(st:1:ed);
time=time';
p=polyfit(time.*0.5,mass_center(st:ed,1).*20/0.5/1.6/ma,1);
p
clc;
clear all;
%%
%[image_name, image_file] = uigetfile( ...
%{  '*.jpg','picture'; ... %不同的文件格式用分号隔开
%   '*.*',  'All Files (*.*)'}, ...
%   'Pick a file', ...
%   'MultiSelect', 'on');
%abs_path=strcat(image_file,image_name);
%%
abs_path='D:\experiment data\new\imagines\20.jpg';
img=imread(abs_path);
img=100-img;
img_edge=edge_detection(img,0.5);
level=graythresh(img_edge);
img_bw=imbinarize(img_edge,level);
img_bw=~img_bw;
img_bwareaopen=bwareaopen(img_bw,8000);
img_cleanborder=imclearborder(~img_bwareaopen);%去除与边界相连的区域
se=strel('disk',5);
img_open=imopen(img_cleanborder,se);%去除小区域
figure(1);
imshow(img)
figure(2);
subplot(2,2,1),imshow(img_edge),title('edge detection');
subplot(2,2,2),imshow(img_bwareaopen),title('after bwareaopen 8000');
subplot(2,2,3),imshow(img_cleanborder),title('img_cleanborder');
subplot(2,2,4),imshow(img_open),title('open');

function [img_bwareaopen]=kill_blank(img_bw)
%去掉小面积的多连通域部分
se=strel('disk',3); %去掉连通域
img_open=imopen(img_bw,se);
img_bwareaopen_1=bwareaopen(img_open,2000);
img_bwareaopen=1-bwareaopen(1-img_bwareaopen_1,10);
end

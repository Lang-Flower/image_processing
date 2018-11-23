function [img_bwareaopen]=kill_blank(img)
%去掉小面积的多连通域部分
level=graythresh(img);  
img_bw=imbinarize(img,level);
se=strel('disk',15); %去掉连通域
img_open=imopen(img_bw,se);
img_bwareaopen=bwareaopen(img_open,8000);
end

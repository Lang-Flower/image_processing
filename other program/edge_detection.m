function [img_prewitt]=edge_detection(img,sigma)
%主要对图片进行边缘检测
%图片的参数解释
%
%%
%通过计算图片矩阵的维数来判断彩图或者灰度图（黑白图）
sz=size(img,3);
if sz==1
    %按照黑白或者灰度处理
    img_gray=img;
else
    %按照彩色图处理
    img_gray=rgb2gray(img);
end
J=imadjust(img_gray,[0.1 0.9],[0 1],1);%用于调节灰度图像的亮度
%%
%对图片进行滤波：此处使用模板[5,5]的高斯滤波 
%根据此算子得到模板的系数，σ越大，生成的系数差异越小，σ越小，生成的平均系数差距越大。
gausFilter = fspecial('gaussian', [5,5], sigma);
%进行高斯滤波处理
img_gaus= imfilter(img_gray, gausFilter, 'replicate');
%imfilter命令细节参见https://studytech.wordpress.com/2012/05/10/imfilter/
%%
%对图像进行边缘检测
img_bd=edge(img_gaus,'Canny',sigma);
img_prewitt=im2uint8(img_bd)+J;
%figure(1);
%subplot(1,3,1),imshow(J),title('original imagine');
%subplot(1,3,2),imshow(img_prewitt),title('edge detection');
%subplot(1,3,3),imshow(img_bd),title('afer gauss wavepass');
%figure(2);
%imshow(img_prewitt),title('edge detection')
end

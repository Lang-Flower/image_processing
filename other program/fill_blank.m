%%去掉液滴中心反光部分的操作
a=imread('D:\experiment data\new\imagines\15.jpg');
level=graythresh(a);  
b=imbinarize(a,level); 
se=strel('disk',20);
c=imopen(b,se);
d=bwareaopen(c,8000);
e=bwperim(c,8);
figure(1);
subplot(2,2,1),imshow(a),title('origin')
subplot(2,2,2),imshow(b),title('binarized')
subplot(2,2,3),imshow(c),title('open')
subplot(2,2,4),imshow(d),title('bwareaopen')
figure(2);
imshow(e)

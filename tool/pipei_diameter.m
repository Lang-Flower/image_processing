%��ÿ���߶ȵ�Һ�εײ����ʰ뾶��ʵ������ƥ��
clc
clear all
close all;
h_2=xlsread('E:\�������\ʵ���չ\ʵ�鱨��\����2,5,10cstײ��ʵ������.xlsx','2cst','B2:B149');
h_5=xlsread('E:\�������\ʵ���չ\ʵ�鱨��\����2,5,10cstײ��ʵ������.xlsx','5cst','B2:B159');
h_10=xlsread('E:\�������\ʵ���չ\ʵ�鱨��\����2,5,10cstײ��ʵ������.xlsx','10cst','B2:B163');
%���ײ����ʰ뾶
data=xlsread('E:\20190928_1\����ײ��ʵ��Һ�εײ����ʰ뾶.xlsx','sheet1','A2:G96');
hr_2=data(1:28,1);
hr_5=data(29:57,1);
hr_10=data(58:95,1);
r_2=data(1:28,2:7);
r_5=data(29:57,2:7);
r_10=data(58:95,2:7);
rr_2=[];
rr_5=[];
rr_10=[];
for i=1:size(h_2,1)
    for j=1:size(hr_2,1)
        if h_2(i,1)==hr_2(j,1)
            rr_2=[rr_2;r_2(j,:)];
        end
    end
end
for i=1:size(h_5,1)
    for j=1:size(hr_5,1)
        if h_5(i,1)==hr_5(j,1)
            rr_5=[rr_5;r_5(j,:)];
        end
    end
end
for i=1:size(h_10,1)
    for j=1:size(hr_10,1)
        if h_10(i,1)==hr_10(j,1)
            rr_10=[rr_10;r_10(j,:)];
        end
    end
end
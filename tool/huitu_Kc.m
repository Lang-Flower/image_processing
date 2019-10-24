%底部曲率直径计算K值
clc
clear all
close all
[data_2,state_2]=xlsread('E:\最近工作\实验进展\实验报告\最新2,5,10cst撞击实验数据.xlsx','2cst','B2:P145');
[data_5,state_5]=xlsread('E:\最近工作\实验进展\实验报告\最新2,5,10cst撞击实验数据.xlsx','5cst','B2:P153');
[data_10,state_10]=xlsread('E:\最近工作\实验进展\实验报告\最新2,5,10cst撞击实验数据.xlsx','10cst','B2:P163');
figure('color',[1 1 1])
for i=1:size(data_2,1)
    if ~(isempty(state_2{i,2})) && all(state_2{i,2}=='Nu')
    elseif ~(isempty(state_2{i,2})) && all(state_2{i,2}=='SS')
        ss_2=loglog(data_2(i,9)/data_2(i,8)/1000,data_2(i,13),'rs','Markersize',7,'Linewidth',2);
        hold on
    elseif ~(isempty(state_2{i,2})) && all(state_2{i,2}=='CS')
        cs_2=loglog(data_2(i,9)/data_2(i,8)/1000,data_2(i,13),'ro','Markersize',7,'Linewidth',2);
        hold on
    elseif ~(isempty(state_2{i,2})) && all(state_2{i,2}=='WS')
        ws_2=loglog(data_2(i,9)/data_2(i,8)/1000,data_2(i,13),'r+','Markersize',7,'Linewidth',2);
        hold on
    end
end
hf_2=unique(data_2(:,9));
hf_2(find(hf_2==0))=[];
min_data_2=zeros(size(hf_2,1),2);
min_data_2(:,1)=max(data_2(:,13));
min_data_2(:,2)=hf_2/2.3/1000;
for i=1:size(hf_2,1)
    for j=1:size(data_2,1)
        if data_2(j,9)==hf_2(i,1) && (all(state_2{j,2}=='CS')|| ...
                all(state_2{j,2}=='WS'))
            min_data_2(i,1)=min(min_data_2(i,1),data_2(j,13));
        end
    end
end
loglog(min_data_2(:,2),min_data_2(:,1),'r-','Markersize',7,'Linewidth',2.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(data_5,1)
    if ~(isempty(state_5{i,2})) && all(state_5{i,2}=='Nu')
    elseif ~(isempty(state_5{i,2})) && all(state_5{i,2}=='SS')
        ss_5=loglog(data_5(i,9)/data_5(i,8)/1000,data_5(i,13),'ms','Markersize',7,'Linewidth',2);
        hold on
    elseif ~(isempty(state_5{i,2})) && all(state_5{i,2}=='CS')
        cs_5=loglog(data_5(i,9)/data_5(i,8)/1000,data_5(i,13),'mo','Markersize',7,'Linewidth',2);
        hold on
    elseif ~(isempty(state_5{i,2})) && all(state_5{i,2}=='WS')
        ws_5=loglog(data_5(i,9)/data_5(i,8)/1000,data_5(i,13),'m+','Markersize',7,'Linewidth',2);
        hold on
    end
end
hf_5=unique(data_5(:,9));
hf_5(find(hf_5==0))=[];
min_data_5=zeros(size(hf_5,1),2);
min_data_5(:,1)=max(data_5(:,13));
min_data_5(:,2)=hf_5/2.3/1000;
for i=1:size(hf_5,1)
    for j=1:size(data_5,1)
        if data_5(j,9)==hf_5(i,1) && (all(state_5{j,2}=='CS')|| ...
                all(state_5{j,2}=='WS'))
            min_data_5(i,1)=min(min_data_5(i,1),data_5(j,13));
        end
    end
end
loglog(min_data_5(:,2),min_data_5(:,1),'m-','Markersize',7,'Linewidth',2.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(data_10,1)
    if ~(isempty(state_10{i,2})) && all(state_10{i,2}=='Nu')
    elseif ~(isempty(state_10{i,2})) && all(state_10{i,2}=='SS')
        ss_10=loglog(data_10(i,9)/data_10(i,8)/1000,data_10(i,13),'bs','Markersize',7,'Linewidth',2);
        hold on
    elseif ~(isempty(state_10{i,2})) && all(state_10{i,2}=='CS')
        cs_10=loglog(data_10(i,9)/data_10(i,8)/1000,data_10(i,13),'bo','Markersize',7,'Linewidth',2);
        hold on
    elseif ~(isempty(state_10{i,2})) && all(state_10{i,2}=='WS')
        ws_10=loglog(data_10(i,9)/data_10(i,8)/1000,data_10(i,13),'b+','Markersize',7,'Linewidth',2);
        hold on
    end
end
hf_10=unique(data_10(:,9));
hf_10(find(hf_10==0))=[];
min_data_10=zeros(size(hf_10,1),2);
min_data_10(:,1)=max(data_10(:,13));
min_data_10(:,2)=hf_10/2.3/1000;
for i=1:size(hf_10,1)
    for j=1:size(data_10,1)
        if data_10(j,9)==hf_10(i,1) && (all(state_10{j,2}=='CS')|| ...
                all(state_10{j,2}=='WS'))
            min_data_10(i,1)=min(min_data_10(i,1),data_10(j,13));
        end
    end
end
loglog(min_data_10(:,2),min_data_10(:,1),'b-','Markersize',7,'Linewidth',2.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel('δ');
ylabel('K')
axis([0,0.15,0,50000])
set(gca,'box','on','position',[0.1 0.15 0.6 0.8])
legend([ss_2,cs_2,ws_2,ss_5,cs_5,ss_10,cs_10],{'2 cst drop spreading',...
    '2 cst corona splashing','2 cst Washington jet',...
    '5 cst drop spreading','5 cst corona splashing',...
    '10 cst drop spreading','10 cst corona splashing'})

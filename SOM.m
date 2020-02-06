%%
clear all
clc

%%
% load 4DData.mat
[num] = xlsread('C:\Users\左天宇\Desktop\JCLP\Code\Cluster_3\SOM_2.xlsx');
Data_4D = num';

%% 数据归一化
Data_4D = mapminmax(Data_4D);

%% 训练集
P_train = Data_4D;

%% 创建网络
net = newsom(P_train,[3,5]);    

%% 网络训练步数
net.trainParam.epochs = 500;

%% 训练网络
net = train(net,P_train);

%% 输出分类结果
t_sim_sofm_1 = sim(net,P_train);
T_sim_sofm_1 = vec2ind(t_sim_sofm_1);

result_sofm_1 = [P_train' T_sim_sofm_1'];


%%
clear all
clc

%%
% load 4DData.mat
[num] = xlsread('C:\Users\������\Desktop\JCLP\Code\Cluster_3\SOM_2.xlsx');
Data_4D = num';

%% ���ݹ�һ��
Data_4D = mapminmax(Data_4D);

%% ѵ����
P_train = Data_4D;

%% ��������
net = newsom(P_train,[3,5]);    

%% ����ѵ������
net.trainParam.epochs = 500;

%% ѵ������
net = train(net,P_train);

%% ���������
t_sim_sofm_1 = sim(net,P_train);
T_sim_sofm_1 = vec2ind(t_sim_sofm_1);

result_sofm_1 = [P_train' T_sim_sofm_1'];


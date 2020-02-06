%% 
clear all
clc
%% ����׼��
C = 15;
b = 2.5;
[num] = xlsread('C:\Users\������\Desktop\JCLP\Code\Cluster_3\FCM��ʼ��������.xlsx');
M = num;
[num] = xlsread('C:\Users\������\Desktop\JCLP\Code\Cluster_3\AVE.xlsx');
C_Data = num;
Miu = zeros(C,size(C_Data,2));
ThresholdValue = 0.001;
Flage = 1;
FFlage = 1;
n = size(C_Data,2);
Distance = zeros(size(M,2),size(C_Data,2));
Var = 0;
%% FCM
while Flage && FFlage
    
    %������ͻ������������ĵľ���
    for i=1:size(M,2)
        for j=1:size(C_Data,2)
            Distance(i,j) = norm(C_Data(:,j)-M(:,i),2)^2;
        end
    end
    
    %���������Ⱦ���
    for i=1:C
        for j=1:size(C_Data,2)
            Var = Distance(:,j).^((-1)/(b-1));
            Var = sum(Var);
            Miu(i,j) = (Distance(i,j).^((-1)/(b-1)))/Var;
        end
    end
    
    %�����������
    for i=1:C
        Var_M_1 = 0;
        Var_M = sum((Miu(i,:)).^b);
        for j=1:size(Miu,2)
            Var_M_1 = Var_M_1 + (Miu(i,j)^b * C_Data(:,j));
        end
        M(:,i) = Var_M_1/Var_M;
    end
    
    %�����ֵ����
    J = 0;
    for i=1:C
        for j=1:size(C_Data,2)
            J = J + (Miu(i,j)^b) * Distance(i,j);
        end
    end
    
    if Flage == 1
        History_J = J;
    else
        Delta = History_J - J;
        History_J = J;
    end
    
    if Flage ~= 1
        if abs(Delta) < ThresholdValue
            FFlage = 0;
        end
    end
    
    Flage = Flage + 1;
end
%%
VAR2 = zeros(1,size(Miu,2));
for i=1:size(Miu,2)
    VAR = Miu(:,i);
    [VAR1,VAR2(i)] = max(VAR);
end




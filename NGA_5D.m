%% 
clear all
clc
load Fun.mat
% figure(1);
% ezmesh(fun,[0,10,0,10],100);
% hold on;
%% �������
iterMax = 250;
M = 100;
N = 25;
ChromLength = 4;    %����������Ҫ�����
Pc = 0.95;
Pm = 0.1;
j = 1;
L = 6;
Penalty = 0.1;
traceMAXVlaue = zeros((ChromLength+1),iterMax);

Niche_Operation_Chrom_Fitness = zeros(M+N,ChromLength+1);
Niche_Operation_Chrom = zeros(M+N,ChromLength);

GA_Operation_Chrom_Fitness = zeros(M-N,ChromLength+1);
GA_Operation_Chrom = zeros(M-N,ChromLength);

Next_Generation_Chrom_Fitness = zeros(M,ChromLength+1);
Next_Generation_Chrom = zeros(M,ChromLength);
%% ��ʼ����Ⱥ
Chrom = 10*rand(M,ChromLength);
Fitness = fun(Chrom(:,1),Chrom(:,2),Chrom(:,3),Chrom(:,4));   %����������Ҫ�������
Chrom_Fitness = Chrom;
Chrom_Fitness(:,ChromLength+1) = Fitness;
Chrom_Fitness = sortrows(Chrom_Fitness,-(ChromLength+1));
Chrom = Chrom_Fitness(:,1:ChromLength);
Fitness = Chrom_Fitness(:,ChromLength+1);
%���С��������������Ŵ��������
for i=1:N
    Niche_Operation_Chrom_Fitness(i,:) = Chrom_Fitness(i,:);
end
for i=N+1:M
    GA_Operation_Chrom_Fitness(j,:) = Chrom_Fitness(i,:);
    j = j+1;
end
Niche_Operation_Chrom = Niche_Operation_Chrom_Fitness(:,1:ChromLength);
GA_Operation_Chrom = GA_Operation_Chrom_Fitness(:,1:ChromLength);
j = 1;
%% GA
for i=1:iterMax
    
    a = (iterMax - i)/iterMax;
    
    %Select��ʼ
    for x=1:M
        Var1 = GA_Operation_Chrom_Fitness(randi(M-N),:);
        Var2 = GA_Operation_Chrom_Fitness(randi(M-N),:);
        if Var1(1,ChromLength+1) >= Var2(1,ChromLength+1)
           Next_Generation_Chrom(x,:) = Var1(1,1:ChromLength);
        else
           Next_Generation_Chrom(x,:) = Var2(1,1:ChromLength);
        end
    end
    %Select����
    
    %Crossover��ʼ
    RandNum = randperm(M);  %������� �������
    for x=1:2:(M-1)
        if rand() <= Pc
            Next_Generation_Chrom(RandNum(x),:) = a*Next_Generation_Chrom(RandNum(x),:) + (1-a)* Next_Generation_Chrom(RandNum(x+1),:);
            Next_Generation_Chrom(RandNum(x+1),:) = a*Next_Generation_Chrom(RandNum(x+1),:) + (1-a)* Next_Generation_Chrom(RandNum(x),:);
        else
            continue;
        end
    end
    %Crossover����
    
    %Muti��ʼ
    for x=1:M
        if rand() <= Pm
            Next_Generation_Chrom(x,randi(ChromLength)) = 0 + rand()*10;
        else
            continue;
        end
    end
    %Muti����
   
    %NicheԤ������ʼ
        %������Ӧ��
    Next_Generation_Chrom_Fitness(:,1:ChromLength) = Next_Generation_Chrom; %����������Ҫ�������
    Next_Generation_Chrom_Fitness(:,ChromLength+1) = fun(Next_Generation_Chrom(:,1),Next_Generation_Chrom(:,2),Next_Generation_Chrom(:,3),Next_Generation_Chrom(:,4));    
        %�ϲ�����Niche��������(M+N)
    Niche_Operation_Chrom_Fitness(N+1:M+N,1:ChromLength+1) = Next_Generation_Chrom_Fitness;
    Niche_Operation_Chrom(:,:) = Niche_Operation_Chrom_Fitness(:,1:ChromLength);
    %NicheԤ��������
    
    %Niche��̭���㿪ʼ
    for x=1:(M+N)-1
        for y=(x+1):(M+N)   %����������Ҫ�������
            distance = sqrt((Niche_Operation_Chrom(x,1)-Niche_Operation_Chrom(y,1))^2 + (Niche_Operation_Chrom(x,2)-Niche_Operation_Chrom(y,2))^2 + (Niche_Operation_Chrom(x,3)-Niche_Operation_Chrom(y,3))^2 + (Niche_Operation_Chrom(x,4)-Niche_Operation_Chrom(y,4))^2);
            if distance <= L
                if Niche_Operation_Chrom_Fitness(x,ChromLength+1) >= Niche_Operation_Chrom_Fitness(y,ChromLength+1)
                    Niche_Operation_Chrom_Fitness(y,ChromLength+1) = Niche_Operation_Chrom_Fitness(y,ChromLength+1)*Penalty;
                else
                    Niche_Operation_Chrom_Fitness(x,ChromLength+1) = Niche_Operation_Chrom_Fitness(x,ChromLength+1)*Penalty;
                end
            else
                continue;
            end
        end
    end
    %Niche��̭�������
    
    %�������Ż��ƿ�ʼ
    Niche_Operation_Chrom_Fitness = sortrows(Niche_Operation_Chrom_Fitness,-(ChromLength+1));
        %׼����һ��
    Niche_Operation_Chrom(1:N,1:ChromLength) = Niche_Operation_Chrom_Fitness(1:N,1:ChromLength);
    GA_Operation_Chrom = Niche_Operation_Chrom_Fitness(1:M,1:ChromLength);
    GA_Operation_Chrom_Fitness = Niche_Operation_Chrom_Fitness(1:M,:);
    Niche_Operation_Chrom_Fitness(N+1:N+M,:) = 0;
        %׼�����
    %�������Ż��ƽ���
    
    %�洢����ֵ                              %����������Ҫ���������
    traceMAXVlaue(1:ChromLength,i) = Niche_Operation_Chrom_Fitness(1,1:ChromLength);
    traceMAXVlaue(ChromLength+1,i) = fun(Niche_Operation_Chrom_Fitness(1,1),Niche_Operation_Chrom_Fitness(1,2),Niche_Operation_Chrom_Fitness(1,3),Niche_Operation_Chrom_Fitness(1,4));
end
%% ��ͼ %����������Ҫ������(ȫ��)
% plot3(traceMAXVlaue(1,:),traceMAXVlaue(2,:),fun(traceMAXVlaue(1,:),traceMAXVlaue(2,:)),'bo');   %����ÿ�������ŵ�
% grid on;
% plot3(Niche_Operation_Chrom_Fitness(:,1),Niche_Operation_Chrom_Fitness(:,2),fun(Niche_Operation_Chrom_Fitness(:,1),Niche_Operation_Chrom_Fitness(:,2)),'bo');
% hold off;

figure(1);
plot(1:iterMax,fun(traceMAXVlaue(1,:),traceMAXVlaue(2,:),traceMAXVlaue(3,:),traceMAXVlaue(4,:)));
grid on;

AB = unique(traceMAXVlaue','rows','stable');








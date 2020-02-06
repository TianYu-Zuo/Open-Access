%% 
clear all
clc
load Fun_50.mat
figure(1);
ezmesh(fun,[0,10,0,10],100);
hold on;
%% 定义参数
iterMax = 300;
M = 50;
N = 15;
ChromLength = 2;    %换函数，就要改这里！
Pc = 0.95;
Pm = 0.1;
j = 1;
L = 1;
Penalty = 0.1;
traceMAXVlaue = zeros((ChromLength+1),iterMax);

Niche_Operation_Chrom_Fitness = zeros(M+N,ChromLength+1);
Niche_Operation_Chrom = zeros(M+N,ChromLength);

GA_Operation_Chrom_Fitness = zeros(M-N,ChromLength+1);
GA_Operation_Chrom = zeros(M-N,ChromLength);

Next_Generation_Chrom_Fitness = zeros(M,ChromLength+1);
Next_Generation_Chrom = zeros(M,ChromLength);
%% 初始化种群
Chrom = 10*rand(M,ChromLength);
Fitness = fun(Chrom(:,1),Chrom(:,2));   %换函数，就要改这里！←
%整理Chrom与Fitness
Chrom_Fitness = Chrom;
Chrom_Fitness(:,ChromLength+1) = Fitness;
Chrom_Fitness = sortrows(Chrom_Fitness,-(ChromLength+1));
Chrom = Chrom_Fitness(:,1:ChromLength);
Fitness = Chrom_Fitness(:,ChromLength+1);
%存放小生境个体矩阵与遗传个体矩阵
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
    
    %Select开始
    for x=1:M
        Var1 = GA_Operation_Chrom_Fitness(randi(M-N),:);
        Var2 = GA_Operation_Chrom_Fitness(randi(M-N),:);
        if Var1(1,ChromLength+1) >= Var2(1,ChromLength+1)
           Next_Generation_Chrom(x,:) = Var1(1,1:ChromLength);
        else
           Next_Generation_Chrom(x,:) = Var2(1,1:ChromLength);
        end
    end
    %Select结束
    
    %Crossover开始
    RandNum = randperm(M);  %随机分组 两两配对
    for x=1:2:(M-1)
        if rand() <= Pc
            Next_Generation_Chrom(RandNum(x),:) = a*Next_Generation_Chrom(RandNum(x),:) + (1-a)* Next_Generation_Chrom(RandNum(x+1),:);
            Next_Generation_Chrom(RandNum(x+1),:) = a*Next_Generation_Chrom(RandNum(x+1),:) + (1-a)* Next_Generation_Chrom(RandNum(x),:);
        else
            continue;
        end
    end
    %Crossover结束
    
    %Muti开始
    for x=1:M
        if rand() <= Pm
            Next_Generation_Chrom(x,randi(ChromLength)) = 0 + rand()*10;
        else
            continue;
        end
    end
    %Muti结束
   
    %Niche预处理开始
        %计算适应度
    Next_Generation_Chrom_Fitness(:,1:ChromLength) = Next_Generation_Chrom; %换函数，就要改这里！↓
    Next_Generation_Chrom_Fitness(:,ChromLength+1) = fun(Next_Generation_Chrom(:,1),Next_Generation_Chrom(:,2));    
        %合并生成Niche操作矩阵(M+N)
    Niche_Operation_Chrom_Fitness(N+1:M+N,1:ChromLength+1) = Next_Generation_Chrom_Fitness;
    Niche_Operation_Chrom(:,:) = Niche_Operation_Chrom_Fitness(:,1:ChromLength);
    %Niche预处理结束
    
    %Niche淘汰运算开始
    for x=1:(M+N)-1
        for y=(x+1):(M+N)   %换函数，就要改这里！↓
            distance = sqrt((Niche_Operation_Chrom(x,1)-Niche_Operation_Chrom(y,1))^2 + (Niche_Operation_Chrom(x,2)-Niche_Operation_Chrom(y,2))^2);
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
    %Niche淘汰运算结束
    
    %保留最优机制开始
    Niche_Operation_Chrom_Fitness = sortrows(Niche_Operation_Chrom_Fitness,-(ChromLength+1));
        %准备下一代
    Niche_Operation_Chrom(1:N,1:ChromLength) = Niche_Operation_Chrom_Fitness(1:N,1:ChromLength);
    GA_Operation_Chrom = Niche_Operation_Chrom_Fitness(1:M,1:ChromLength);
    GA_Operation_Chrom_Fitness = Niche_Operation_Chrom_Fitness(1:M,:);
    Niche_Operation_Chrom_Fitness(N+1:N+M,:) = 0;
        %准备完毕
    %保留最优机制结束
    
    %存储最优值                              %换函数，就要改这里！↓↓
    traceMAXVlaue(1:ChromLength,i) = Niche_Operation_Chrom_Fitness(1,1:ChromLength);
    traceMAXVlaue(ChromLength+1,i) = fun(Niche_Operation_Chrom_Fitness(1,1),Niche_Operation_Chrom_Fitness(1,2));
end
%% 画图 %换函数，就要改这里(全改)
plot3(traceMAXVlaue(1,:),traceMAXVlaue(2,:),fun(traceMAXVlaue(1,:),traceMAXVlaue(2,:)),'bo');   %画出每代的最优点
grid on;
plot3(Niche_Operation_Chrom_Fitness(:,1),Niche_Operation_Chrom_Fitness(:,2),fun(Niche_Operation_Chrom_Fitness(:,1),Niche_Operation_Chrom_Fitness(:,2)),'bo');
hold off;

figure(2);
plot(1:iterMax,fun(traceMAXVlaue(1,:),traceMAXVlaue(2,:)));
grid on;










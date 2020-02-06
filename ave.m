%%
clear all
clc
%%
Flage = 0;
[num] = xlsread('C:\Users\◊ÛÃÏ”Ó\Desktop\JCLP\Code\Cluster_3\À„AVE”√.xlsx');
AVE = num;
for i=1:4
    for j=1:size(AVE,2)
        Ave(i,j) = (AVE(i,j)+AVE(i+4,j))/2;
        if (AVE(i+4,j)-AVE(i,j))==0 || (AVE(i+4,j)-AVE(i,j))==3
            Flage = Flage + 1;
        end
    end
end
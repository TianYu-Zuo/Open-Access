%%
clear all
clc
%%
[num] = xlsread('C:\Users\×óÌìÓî\Desktop\JCLP\Code\Cluster_3\ËãAVEÓÃ.xlsx');
Var = num;
R = zeros(4,size(Var,2));
R(:,:) = 0.11;
s = 0;
%%
for i=1:4
    for j=1:size(Var,2)
        if (Var(i+4,j)-Var(i,j)) == 2
            R(i,j) = 0.3850;
            s = s + 1;
        end
        if (Var(i+4,j)-Var(i,j)) ~=1 && (Var(i+4,j)-Var(i,j)) ~=2
            break;
        end
    end
end
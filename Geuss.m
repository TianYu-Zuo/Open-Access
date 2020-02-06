%%
clear all
clc
%%
[num] = xlsread('C:\Users\×óÌìÓî\Desktop\JCLP\Code\Cluster_3\AVE.xlsx');
AVE = num;
[num] = xlsread('C:\Users\×óÌìÓî\Desktop\JCLP\Code\Cluster_3\VAR.xlsx');
VAR = num;

syms  x y u v ;
%%
for i=1:size(AVE,2)
    if i == 1
        miu = [AVE(1,i),AVE(2,i),AVE(3,i),AVE(4,i)];
        sigma2 = [VAR(1,i),VAR(2,i),VAR(3,i),VAR(4,i)];
        EVMat = diag(sigma2);
        w =  exp( (-1/2)*((((u - AVE(1,i)).^2)/(VAR(1,i))) + (((v - AVE(2,i)).^2)/(VAR(2,i)))+ (((x - AVE(3,i)).^2)/(VAR(3,i)))+ (((y - AVE(4,i)).^2)/(VAR(4,i))))); 
        
    else
        miu = [AVE(1,i),AVE(2,i),AVE(3,i),AVE(4,i)];
        sigma2 = [VAR(1,i),VAR(2,i),VAR(3,i),VAR(4,i)];
        EVMat = diag(sigma2);
        w =  w + exp( (-1/2)*((((u - AVE(1,i)).^2)/(VAR(1,i))) + (((v - AVE(2,i)).^2)/(VAR(2,i)))+ (((x - AVE(3,i)).^2)/(VAR(3,i)))+ (((y - AVE(4,i)).^2)/(VAR(4,i))))); 
    end
end
%%
fun = matlabFunction(w);
save Fun;



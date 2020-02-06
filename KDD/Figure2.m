[num] = xlsread('C:\Users\左天宇\Desktop\JCLP\客户需求矩阵\AVE.xlsx');
AVE = num;
[num] = xlsread('C:\Users\左天宇\Desktop\JCLP\客户需求矩阵\VAR.xlsx');
VAR = num;

syms x y;
%%
for i=1:50
    if i == 1
        miu = [AVE(1,i),AVE(2,i)];
        sigma2 = [VAR(1,i),VAR(2,i)];
        EVMat = diag(sigma2);
        f =  (1/(((2*pi)^2)*(sqrt(det(EVMat)))))*exp( (-1/2)*((((x - AVE(1,i)).^2)/(VAR(1,i))) + (((y - AVE(2,i)).^2)/(VAR(2,i)))+ (((y - AVE(3,i)).^2)/(VAR(3,i)))+ (((y - AVE(4,i)).^2)/(VAR(4,i))))); 
    else
        miu = [AVE(1,i),AVE(2,i)];
        sigma2 = [VAR(1,i),VAR(2,i)];
        EVMat = diag(sigma2);
        f =  f + (1/(((2*pi)^2)*(sqrt(det(EVMat)))))*exp( (-1/2)*((((x - AVE(1,i)).^2)/(VAR(1,i))) + (((y - AVE(2,i)).^2)/(VAR(2,i)))+ (((y - AVE(3,i)).^2)/(VAR(3,i)))+ (((y - AVE(4,i)).^2)/(VAR(4,i)))));
    end
end
%%
clear all

syms x y;
fun_2_1 = exp( (-1/2)*(((((x - 5).^2)/0.11)) + (((y - 10).^2)/0.11)));
fun_3_1 = exp( (-1/2)*(((((x - 5).^2)/0.11)) + (((y - 5).^2)/0.11)));

sigma2 = [0.11,0.11];
EVMat = diag(sigma2);
fun_2 =  (1/(((2*pi)^2)*(sqrt(det(EVMat)))))*exp( (-1/2)*(((((x - 5).^2)/0.11)) + (((y - 10).^2)/0.11)));

sigma2 = [0.385,0.385];
EVMat = diag(sigma2);
fun_3 =  (1/(((2*pi)^2)*(sqrt(det(EVMat)))))*exp( (-1/2)*(((((x - 5).^2)/0.11)) + (((y - 5).^2)/0.11)));

Fun_2_1 = matlabFunction(fun_2_1);
Fun_3_1 = matlabFunction(fun_3_1);
Fun_2 = matlabFunction(fun_2);
Fun_3 = matlabFunction(fun_3);

x = 3:0.1:7;
y = 0:0.1:15;
[x,y] = meshgrid(x,y);
axis([3,7,0,15,0,0.1]);
z = Fun_2(x,y);
mesh(x,y,z);
hold on;

x = 3:0.1:7;
y = 0:0.1:10;
[x,y] = meshgrid(x,y);
z = Fun_3(x,y);
mesh(x,y,z);

figure(2);
x = 3:0.1:7;
y = 0:0.1:15;
[x,y] = meshgrid(x,y);
axis([3,7,0,15,0,1]);
z = Fun_2_1(x,y);
mesh(x,y,z);
hold on;

x = 3:0.1:7;
y = 0:0.1:10;
[x,y] = meshgrid(x,y);
z = Fun_3_1(x,y);
mesh(x,y,z);
%%
figure(1);
fplot(Fun_1);
figure(2);
ezmesh(Fun_2);


x = 0:0.1:10;
y = 0:0.1:10;
[x,y] = meshgrid(x,y);
z = Fun_2(x,y);
axis([0,5,0,10,0,1.5]);
hold on;
mesh(x,y,z);

x = 0:0.5:10;
y = 0:0.5:10;
[x,y] = meshgrid(x,y);
z = Fun_1(x,y);
mesh(x,y,z);



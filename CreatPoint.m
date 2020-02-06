%%
clear all
clc
%%
Num = 48;
C = zeros(4,Num);
%%
A1 = randi([1, 5], 1, Num);
A2 = randi([1, 5], 1, Num);

B1 = randi([1, 5], 1, Num);
B2 = randi([1, 5], 1, Num);
%%
C(1,:) = A1(1,:);
C(2,:) = A2(1,:);
C(3,:) = B1(1,:);
C(4,:) = B2(1,:);
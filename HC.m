%%
clear all
clc
%%
load Cell.mat;



Avelinkage = zeros(size(Cell,2),size(Cell,2));
AAAAA = zeros(1,3);
%%
for i=1:size(Cell,2)-1
    for j=i+1:size(Cell,2)
        Var = 0;
        Var1 = Cell{1,i};
        Var2 = Cell{1,j};
        for k=1:size(Var1,1)
            for l=1:size(Var2,1)
                Var = Var + norm(Var1(k,:)-Var2(l,:),2);
                
            end
        end
        Value = Var/(size(Var1,1)*size(Var2,1));
        Avelinkage(i,j) = Value;
    end
end

Avelinkage(Avelinkage == 0) = 100;
[AAAAA(1),AAAAA(2)] = find(Avelinkage == min(min(Avelinkage)));
AAAAA(3) = min(min(Avelinkage));

Cell{1,AAAAA(1)} = cat(1,Cell{1,AAAAA(1)},Cell{1,AAAAA(2)});
Cell(AAAAA(2)) = [];
clearvars -except Cell;




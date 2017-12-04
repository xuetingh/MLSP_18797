function result = testEval(V,ml)
fileID = fopen('../../hw3bmaterials/problem2/data/Eval/Eval.txt');
C = textscan(fileID,'%f');
fclose(fileID);
EVAL = normr(reshape(double(C{1,1}), [600,size(C{1,1},1)/600])');
result = zeros(2400,1);
for i = 1:2400
    [~, index] = sort(ml'*normc(V'*EVAL(i,:)'),'descend');
    result(i,1) = index(1);
end

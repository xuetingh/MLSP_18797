function acc = testDev(V,ml)
num = 24;
DEV = [];
for i = 1:num
    fileID = fopen(['../../hw3bmaterials/problem2/data/DEV/class_',num2str(i),'.txt']);
    C = textscan(fileID,'%f');
    fclose(fileID);
    dev = reshape(double(C{1,1}), [600,size(C{1,1},1)/600])';
    DEV{i} = normr(dev);
end
accuracy = 0;
sum = 0;
for i = 1:num
    for j = 1: size(DEV{i}, 1)
        [~, index] = sort(ml'*normc(V'*DEV{i}(j,:)'),'descend');
        if index(1) == i
            accuracy=accuracy + 1;
        end
        sum = sum + 1;
    end
end
acc = accuracy/sum;

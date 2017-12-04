data = [];
w = zeros(1,600);
for i = 1:24
    fileID = fopen(['../../hw3bmaterials/problem2/data/Train/class_' num2str(i) '.txt']);
    C = textscan(fileID,'%f');
    fclose(fileID);
    row = size(C{1,1},1) / 600;
    I = reshape(double(C{1,1}), [600, row]);
    % data{i} is a matrix for class i, each row is an I vector, containing
    % 600 features
    data{i} = normr(I');
end
[V,ml] = trainLDAclass(data,24);
acc = testDev(V,ml);
result = testEval(V,ml);
save('results/evalResults.mat','result')
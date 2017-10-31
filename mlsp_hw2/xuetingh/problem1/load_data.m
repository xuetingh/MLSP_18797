function [T_norm, V] = load_data(path)
filenames = dir([path '*.jpg']);
nimages = length(filenames);
for i = 1:nimages
    % T is traing data set
    T(:,:,i) = double(imread([path num2str(i) '.jpg']));
end
%% Compute K eigen faces for each group using Training Set
% size of row and column
r = size(T,1);
c = size(T,2);
% reshape
T = double(reshape(T, [r*c nimages]));
% centralize
T_norm = bsxfun(@minus, T, mean(T,2));
% get covirance
s = cov(T_norm');
% get eigenvalue and eigenvector
[V,D] = eig(s);
% start from the more dominant eigenface to the least dominant eigen- face
V = fliplr(V);

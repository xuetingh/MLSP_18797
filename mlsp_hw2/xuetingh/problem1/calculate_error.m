function error = calculate_error(T, eigenface)
mse = 0;
mean_face = mean(T,2);
for i = 1:2500
    diff = T(:, i) - mean_face;
    proj = eigenface * eigenface'*diff + mean_face;
    mse = mse + diff' * diff - diff' * proj; 
end
error = mse / 2500;
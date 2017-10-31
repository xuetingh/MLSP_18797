function error = calculate_error(recon, test)
mse = 0;
for i = 1:31
    diff = recon(:,i) - test(:,i);
    mse = mse + diff' * diff;
end
error = mse / 31;
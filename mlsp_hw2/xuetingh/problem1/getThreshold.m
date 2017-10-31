function [threshold,error,greaterThan] = getThreshold(featValues,dweights,Y_tr)
N = length(featValues);
% two lists
errN = zeros(N,1);
greaterThanN = zeros(N,1);
thres = zeros(N,1);

% sort by feature values, lable and dataweights change order accordingly
[input,I] = sort(featValues);

labels = Y_tr(I);
weights = dweights(I);

% calculate initial Error, threshold < smallest feature value
% all samples predicted as +1
err_label_g = 0.5 * (1 - (labels .* ones(N,1)));

err_g = sum(weights .* err_label_g);

thres(1) = input(1) - 1;

if err_g <= 0.5
    errN(1) = err_g;
    greaterThanN(1) = 1;
else
    errN(1) = 1 - err_g;
    greaterThanN(1) = -1;
end

for n = 2:N
    % threshold between n and n+1
    err_g = err_g + weights(n - 1) * labels(n - 1);
    if err_g <= 0.5
        errN(n) = err_g;
        greaterThanN(n) = 1;
    else
        errN(n) = 1 - err_g;
        greaterThanN(n) = -1;
    end
    thres(n) = (input(n) + input(n - 1)) / 2;
end
% too slow!!!!
% for n = 1:N
%     % threshold between n and n+1
%     err_vec_g = 0.5 * (1 - (labels .* [-ones(n-1, 1);ones(N + 1 - n,1)]));
%     err_g = sum(weights .* err_vec_g);
%     
%     if err_g <= 0.5
%         errN(n) = err_g;
%         greaterThanN(n) = 1;
%     else
%         errN(n) = 1 - err_g;
%         greaterThanN(n) = -1;
%     end
%     if n > 1
%         thres(n) = (input(n) + input(n - 1)) / 2;
%     else
%         thres(n) = input(n) - 1;
%     end
% end
[error, idx] = min(errN);
greaterThan = greaterThanN(idx);
threshold = thres(idx);
end
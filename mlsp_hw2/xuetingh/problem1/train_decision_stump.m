function [dweights, threshold] = train_decision_stump(X_tr, Y_tr, dweights)
nFeatures = size(X_tr, 2);
% a vector records threshold for each feature, until choose one as stump
thres = zeros(nFeatures,1);
% a vector records error for each feature,
err = zeros(nFeatures,1);
% a mark to decide threshold direction
greaterThan = zeros(nFeatures,1);
for f = 1:nFeatures
    featValues = X_tr(:,f);
    [t,e,g] = getThreshold(featValues,dweights,Y_tr);
    thres(f) = t;
    err(f) = e;
    greaterThan(f) = g;
end
[error, idx] = min(err);
% feature index
threshold(1) = idx;
% threshold value
threshold(2) = thres(idx);
% direction
threshold(3) = greaterThan(idx);
% alpha
threshold(4) = 0.5 * log((1-error) / (error));
predictions = predict(X_tr, threshold(1:3));
dweights = dweights .* exp(-1 * threshold(4) * Y_tr .* predictions);
% normalize
dweights = dweights / sum(dweights);
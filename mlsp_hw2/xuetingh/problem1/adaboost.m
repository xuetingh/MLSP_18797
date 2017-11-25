function [pred_tr, pred_te] = adaboost(X_tr, Y_tr, T, X_te)
% Input:
%   X_tr: a N x M matrix, where each row corresponds to a data sample with
%           M dimensions. This is the training data.
%   Y_tr: a N x 1 matrix, which contains 1s and -1s only. This vector
%           defines the class label. The i-th component is the class
%           corresponding to the i-th row of X_tr.
%   T: a integer number. It defines the number of weak classifiers used.
%   X_te: a P x M matrix, where each row corresponds to a data sample with
%           M dimensions.
%
% Output:
%   pred_te: a P x 1 matrix, where each component can be either 1 or -1.
%           The i-th component is the prediction for the i-th row of X_te.
N = length(Y_tr);
% data_weights
dweights = (1 / N) * ones(N,1);
% this struc records parameters need for, the 4 cols are: feature index;
% threshold value; isGreaterthan ; alpha -- weight for each weak classifier
thres = zeros(T, 4);
for t = 1:T
    [dweights, threshold] = train_decision_stump(X_tr, Y_tr, dweights);
    thres(t,:) = threshold;
end
disp(T);
pred_te = zeros(size(X_te,1),1);
pred_tr = zeros(size(X_tr,1),1);
for c = 1:T
    alpha = thres(c,4);
    pred_te = (pred_te + alpha * predict(X_te, thres(c,1:3)));
    pred_tr = (pred_tr + alpha * predict(X_tr, thres(c,1:3)));
end
pred_te = sign(pred_te);
pred_tr = sign(pred_tr);

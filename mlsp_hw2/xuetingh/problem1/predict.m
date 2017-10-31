function labelsPredict = predict(X_te, thres)
labelsPredict = zeros(size(X_te,1),1);
if(sign(thres(3)) == 1)
    idx = logical(X_te(:,thres(1)) >= thres(2));
    labelsPredict(idx) = 1;
    labelsPredict(~idx) = -1;
else
    idx = logical(X_te(:,thres(1)) < thres(2));
    labelsPredict(idx) = 1;
    labelsPredict(~idx) = -1;
end
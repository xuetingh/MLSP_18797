function F = iht(P,R,K,n,niter)
N = size(R, 2);
R = normc(R);
% initialize F = 0
F = zeros(N, 1);
for i = 1 : niter
    error = (norm(P-R*F,2)^2);
    fprintf('%4d %15.5e\n',i, error);
    F = F+ n * R'*(P-R*F);
    [~, index] =  sort(abs(F));
    for j = 1 : (N - K)
        F(index(j)) = 0;
    end
end
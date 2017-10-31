function H = ica(M)
% Input: 
%   M: 2 x K matrix containing the concatenation of two mixed signals
%
% Output:
%   H: 2 x K matrix containing the extracted independent components.
[E, S, ] = svd(M * M');
C = S ^ (-0.5) * E';
X = C * M;
D = zeros(2,2);
for k = 1:size(X,2)
    D = D + norm(X(:,k)) ^ 2 * X(:,k) * X(:,k)';
end
[ U, T, B] = svd(D);
H = B * C * M;
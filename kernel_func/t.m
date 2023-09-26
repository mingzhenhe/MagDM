function [K] = t(X)
%input: X:d*N, sigma；scale
[d, N] = size(X);
D = pdist2(X.', X.');
K = (1+D.^2).^(-1);
Ksum = sum(K,2)-1;
Ksum = repmat(Ksum, 1, N);

K = K./Ksum;
end


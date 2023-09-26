function [K] = SNE(X,sigma)
%input: X:d*N, sigma；scale
[d, N] = size(X);
D = pdist2(X.', X.');
K = exp(-0.5* D.^2/sigma /sigma);
Ksum = sum(K,2)-1;
Ksum = repmat(Ksum, 1, N);

K = K./Ksum;
end


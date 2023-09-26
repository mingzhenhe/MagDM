function [DM, u] = diff_map(K, maxInd, freq,T)
%DM for hermitian matrix of the asymmetric kernel matrix.
% K: kernel matrix. R^{n \times n}
% maxInd: number of eigs used in DMs.
% q frequency coefficient
if nargin > 3
    T = T;
else
    T = 1;
end

N = size(K,1);

%%=== Hermitian kernel matrix
S = 0.5 * (K + K.');
A = -(K - K.');

D = diag( sum(S,1) );
% H = (S .* exp(2i*pi*freq * A));
H =  D^(-0.5) * (S .* exp(2i*pi*freq * A)) * D^(-0.5);
H  = 0.5 * (H  + H');

H = H^T;

% [uu,ee] = eig(exp(2i*pi*freq * A));
% kkk = H^3;
% kkk = 0.5*(kkk+kkk');
% 特征根有正有负， 我要取绝对值最大的哇
[u, lambda] = eig(H);
% lambda = lambda^T;

lambda = diag(lambda);
[vv,I] = sort(abs(lambda),'descend'); %eigs doesn't return the values sorted 
Lambda     = lambda(I(1:maxInd));
u          = u(:,I(1:maxInd));

dim_lambda = Lambda;
max(max(abs(A)));
Lambda.';
DM = u*diag(Lambda);
end


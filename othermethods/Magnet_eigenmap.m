function [DM] = Magnet_eigenmap(K, maxInd, freq, T)
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
% diffusion Time
K = K^T;
%%=== Hermitian kernel matrix
S = 0.5 * (K + K.');
A = -(K - K.');
D = diag( sum(S,1) );

L = D - S .* exp(2i*pi*freq * A);
Ln =  D^(-0.5) *  L * D^(-0.5);


Ln = 0.5 * (Ln + Ln');

[u, lambda] = eig(Ln);
[lambda, I] = sort(diag(lambda),'ascend'); %eigs doesn't return the values sorted 
Lambda     = lambda(1:maxInd);
u          = u(:, I(1:maxInd));

if Lambda(1) <= 1e-6
    u = u(:,2:end);
end
Lambda;
DM = u;
% %after revised
% DM = u*diag(Lambda);
end


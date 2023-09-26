function [DM] = diff_map_svd(K, maxInd,T)
% K: kernel matrix.
% maxInd: number of eigs used in DMs.
if nargin > 2
    T = T;
else
    T = 1;
end

N = size(K,1);

%%===Diffusion Time
K = K^T;
%%== normalization
%=== Din^-1 K Dout ^-1, 还是-1/2？ 可以推下公式看看哪个合适。
Din = diag( sum(K,2) );
Dout = diag( sum(K,1) );

% G = Din^-1 * K * Dout^-1;
% G = Din^-0.5 * K * Dout^-0.5;
G = K;
%==self-looped normalized adjacency matrix
% G = (Din+eye(N))^-0.5 * (K+eye(N)) * (Dout+eye(N))^-0.5;

[u,lambda,v] = svd(G);
[lambda,I] = sort(diag(lambda),'descend'); %eigs doesn't return the values sorted 
Lambda     = lambda(1:maxInd);
u          = u(:,I(1:maxInd));
v          = v(:,I(1:maxInd));

DM = [u*diag(Lambda), v*diag(Lambda)];
end


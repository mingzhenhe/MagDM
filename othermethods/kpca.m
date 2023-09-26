function [Y, eigVector, eigValue] = kpca(K,d,T)

if nargin > 2
    T = T;
else
    T = 1;
end
K = K^T;
N=size(K,1);
K0 = K;
oneN=ones(N,N)/N;
K=K0-oneN*K0-K0*oneN+oneN*K0*oneN;

% eigenvalue analysis
[V,D]=eig(K/N);
eigValue=diag(D);
[~,IX]=sort(eigValue,'descend');
eigVector=V(:,IX);
eigValue=eigValue(IX);

% normailization
norm_eigVector=sqrt(sum(eigVector.^2));
eigVector=eigVector./repmat(norm_eigVector,size(eigVector,1),1);

% dimensionality reduction
eigVector=eigVector(:,1:d);
Y=K0*eigVector;
end


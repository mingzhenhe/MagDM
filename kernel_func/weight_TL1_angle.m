function [K] = weight_TL1_angle(X,rho)
%input: X:d*N, rho；scale
[d, N] = size(X);
D = pdist2(X.', X.','cityblock');
K =zeros(N);
prop = 0.1;
%====example: direction in angular of x-y plane
R = zeros(N,N);
complex_plane = X(1,:) + 1i*X(2,:);
complex_angle = angle(complex_plane);
complex_angle(complex_angle<0) = complex_angle(complex_angle<0) + 2*pi;
% 小误差使得错误归纳不同的角度, 舍去
for ind = 1:length(complex_angle)
    complex_angle(ind) = vpa(complex_angle(ind),4);
end
% 2pi --> 0
min_zeros_ind = find(complex_angle==0);
complex_angle(1:min_zeros_ind-1) = 0;
[uniq_value,~,ic] = unique(complex_angle.','rows');
%========
for i = 1:length(complex_angle)
    angle_i = complex_angle(i);
    diff_angle = complex_angle - angle_i;
    rho_list = sign(diff_angle);
    rho_list_nonneg = find(rho_list>=0);
    rho_list_neg = find(rho_list<0);
    rho_list(rho_list_nonneg) = rho;
    rho_list(rho_list_neg) = prop*rho;
    K(i,:) = max(rho_list - D(i,:),0);
end
[max(max(D)) 1/2/max(max(abs(K-K.')))]
end


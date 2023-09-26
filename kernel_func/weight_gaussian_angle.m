function [K] = weight_gaussian_angle(X,sigma)
%input: X:d*N, sigma；scale
[d, N] = size(X);
D = pdist2(X.', X.');
K =zeros(N);
prop = 5;
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
    sigma_list = sign(diff_angle);
    sigma_list_nonneg = find(sigma_list>=0);
    sigma_list_neg = find(sigma_list<0);
    sigma_list(sigma_list_nonneg) = prop*sigma*sigma;
    sigma_list(sigma_list_neg) = sigma*sigma;
    K(i,:) = exp(-0.5* D(i,:).^2 ./ sigma_list);
end
[max(max(D)) 1/2/max(max(abs(K-K.')))]
end


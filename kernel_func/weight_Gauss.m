function [K] = weight_Gauss(X,sigma)
%input: X:d*N, sigma；scale
[d, N] = size(X);
D = pdist2(X.', X.');
K = exp(-0.5* D.^2/sigma /sigma);

% %====example in AA's work 
% R = zeros(N,N);
% complex_plane = X(1,:) + 1i*X(2,:);
% complex_angle = angle(complex_plane);
% complex_angle(complex_angle<0) = complex_angle(complex_angle<0) + 2*pi;
% for i = 1:N
%     for j = 1:N
%         diff = complex_angle(i) - complex_angle(j);
%         if diff >= 0
%             R(i,j) = 1;
%         elseif diff < 0
%             R(i,j) = 0;
%         end
%     end
% end
%======

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
% without self loop
for item = 1:length(uniq_value)-1
    fitst_item = find(ic == item);
    netx_item = find(ic == item+1);
    R(fitst_item, netx_item) = 1;
    %==self-loop
    R(fitst_item, fitst_item) = 1;
end
% ==self-loop
R(netx_item, netx_item) = 1;
% % last --> first
% first_item = find(ic == 1);
% R(netx_item, first_item) = 1;

%=====
K = K.*R;
end


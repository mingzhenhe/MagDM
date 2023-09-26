function [K,C] = artificial_net_1(n_perclass, p)
Class = 3;
N = Class * n_perclass;
K = zeros(N, N);
C = [];
% 1-n_perclass: class1
% n_perclass+1 : 2 * n_perclass :class2 ...
p_forward = 0.5;
for class = 1:Class
    ind_first_class = (class-1) * n_perclass + (1:n_perclass);
    if class ~= Class
        ind_next_class = n_perclass + ind_first_class;
    elseif class == Class
        ind_next_class = (1:n_perclass); % i.e., First class
    end
    otherset = setdiff( (1:N) , ind_first_class);
    for i = 1 : n_perclass
        ind_third_class = setdiff(otherset, ind_next_class);
        Probability = rand(1, length(ind_first_class));
        K( ind_first_class(i), ind_first_class ) = double(Probability>=0.5); 
        
        Probability = rand(1, length(ind_next_class));
        K( ind_first_class(i), ind_next_class ) = double(Probability>=p_forward); %0.5
        
        Probability = rand(1, length(ind_third_class));
        % E(right direct) /  E (wrong direct) = 9
        K( ind_first_class(i), ind_third_class ) = double(Probability>=1-(-0.5*p+0.5)); %1-(-0.5*p+0.5) 此时p的增大 最混乱的时候可以分析一下
    end
end
% delete self-loop
% for i = 1:N
%     K(i,i) = 0;
% end

C = [C; repmat([0 0 1],n_perclass,1)]; %蓝色
C = [C; repmat([0 1 0],n_perclass,1)]; %绿色
C = [C; repmat([1 0 0],n_perclass,1)]; %红色   [1 0.5 0] %黄色
max(max(abs(K-K.')));
end


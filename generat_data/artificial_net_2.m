function [K,Color] = artificial_net_2()
% Four classes
% % A -> (B<->C) -> D || A -> D
% n_C = 14; n_B = 14;
% n_A = 2; n_D = 2;
num_base = 50;
n_C = num_base*2; n_B = num_base*2;
n_A = num_base; n_D = num_base; %4
N = n_A + n_B + n_C + n_D;
K = zeros(N, N);
Color = [];
% coloring
Color = [Color; repmat([0 1 0],n_A,1)]; %绿色 
Color = [Color; repmat([0 0 1],n_B,1)]; % 蓝色
Color = [Color; repmat([1 0 0],n_C,1)]; %红色
Color = [Color; repmat([1 0.5 0],n_D,1)]; %黄色
% index
index_A = (1:n_A); index_B = n_A + (1:n_B);
index_C = n_A + n_B + (1:n_C); index_D = n_A + n_B + n_C + (1:n_D);

% first params 0.5,0.75,0.2
self_loop_inten = 0.5;% 0.5
strong_inten = 0.75; % 0.75
BC_inten = 0.5; % 0.5
CB_inten = 0; % 0
weak_inten = 0.4; % 0.2
%connecting A
for i = 1:length(index_A)
    % self connection
    Probability = rand(1, length(index_A));
    K( index_A(i), index_A ) = double(Probability>=1-self_loop_inten);
    Probability = rand(1, length(index_B));
    K( index_A(i), index_B ) = double(Probability>=1-strong_inten);
    Probability = rand(1, length(index_C));
    K( index_A(i), index_C ) = double(Probability>=1-strong_inten);
    Probability = rand(1, length(index_D));
    K( index_A(i), index_D ) = double(Probability>=1-strong_inten);  %1 - strong_inten
end
% connection B
for i = 1:length(index_B)
    % self connection
    Probability = rand(1, length(index_B));
    K( index_B(i), index_B ) = double(Probability>=self_loop_inten);
    Probability = rand(1, length(index_C));
    K( index_B(i), index_C ) = double(Probability>=1-BC_inten);
    Probability = rand(1, length(index_D));
    K( index_B(i), index_D ) = double(Probability>=1-strong_inten);
end

% connection C
for i = 1:length(index_C)
    % self connection
    Probability = rand(1, length(index_C));
    K( index_C(i), index_C ) = double(Probability>=self_loop_inten);
    Probability = rand(1, length(index_B));
    K( index_C(i), index_B ) = double(Probability>=1-CB_inten);
    Probability = rand(1, length(index_D));
    K( index_C(i), index_D ) = double(Probability>=1-strong_inten);
end

for i = 1:length(index_D)
    % self connection
    Probability = rand(1, length(index_D));
    K( index_D(i), index_D ) = double(Probability>=self_loop_inten);
    Probability = rand(1, length(index_A));
    K( index_D(i), index_A ) = double(Probability>=1-weak_inten);
end

end


function draw_p(plist, ind)
q= 1/4; %paper 1/4
p = plist(ind);
diff_dim = 10;
num_perclass = 30;
[K,C] = artificial_net_1(num_perclass,p);
dimx = 1; dimy = 2;
%====hermitian matrix
[DM_hermitian, ~] = diff_map(K, diff_dim, q);
realpart_x = real(DM_hermitian(:,dimx));
realpart_y = real(DM_hermitian(:,dimy));
imagpart_x = imag(DM_hermitian(:,dimx));
imagpart_y = imag(DM_hermitian(:,dimy));
phase_x = angle(DM_hermitian(:,dimx));
phase_y = angle(DM_hermitian(:,dimy));
%====AA's work
[DM] = diff_map_svd(K, diff_dim);
aax = DM(:,dimx);
aay = DM(:,dimy);
%===kpca
% K = 0.5*(K+K.');
KPCA = K*K.';
[Y, eigVector, eigValue] = kpca(KPCA,diff_dim);
%===Magnetic Eigenmap
[ME] = Magnet_eigenmap(K, diff_dim, q);
ME_real_x = real(ME(:,dimx));
ME_imag_x = imag(ME(:,dimx));
ME_real_y = real(ME(:,dimy));
ME_imag_y = imag(ME(:,dimy));

%===Markov Magnetic Eigenmap
[MME] = Markov_Magnet_eigenmap(K, diff_dim, q);
MME_real_x = real(MME(:,dimx));
MME_imag_x = imag(MME(:,dimx));
MME_real_y = real(MME(:,dimy));
MME_imag_y = imag(MME(:,dimy));

phasemark = -pi:pi/4:pi;
phasemark_label = {'-\pi','-3\pi/4','-\pi/2','-\pi/4','0','\pi/4','\pi/2','3\pi/4','\pi'};

halfphasemark = -pi:pi/2:pi;
halfphasemark_label = {'-\pi','-\pi/2','0','\pi/2','\pi'};

subplot(length(plist),3,1+(ind-1)*3)
scatter(angle(ME(:,dimx)),angle(ME(:,dimy)),[],C)
xlabel('ME phase \phi_1^{(q)}')
ylabel('ME phase \phi_2^{(q)}')

set(gca,'Ytick',halfphasemark)
set(gca,'Yticklabel',halfphasemark_label)
if max(angle(ME(:,dimx)))-min(angle(ME(:,dimy))) > pi/2
set(gca,'Xtick',halfphasemark)
set(gca,'Xticklabel',halfphasemark_label)
end

subplot(length(plist),3,2+(ind-1)*3)
scatter(angle(MME(:,dimx)),angle(MME(:,dimy)),[],C)
xlabel('MME phase \phi_1^{(q)}')
ylabel('MME phase \phi_2^{(q)}')
set(gca,'Ytick',halfphasemark)
set(gca,'Yticklabel',halfphasemark_label)
if max(angle(MME(:,dimx)))-min(angle(MME(:,dimy))) > pi/2
set(gca,'Xtick',halfphasemark)
set(gca,'Xticklabel',halfphasemark_label)
end
% title(['Backward flow probability P=',num2str(P_reverse)])
subplot(length(plist),3,3+(ind-1)*3)
scatter(phase_x,phase_y,[],C)
xlabel('MagDM phase \phi_1^{(q)}') 
ylabel('MagDM phase \phi_2^{(q)}')

set(gca,'Ytick',halfphasemark)
set(gca,'Yticklabel',halfphasemark_label)
if max(angle(phase_x))-min(angle(phase_x)) > pi/2
set(gca,'Xtick',halfphasemark)
set(gca,'Xticklabel',halfphasemark_label)
end

% Expand_axis_fill_figure( gcas1 )
% Expand_axis_fill_figure( gcas2 )
% Expand_axis_fill_figure( gcas3 )

function [ ] = Expand_axis_fill_figure( axis_handle )  %函数定义
% TightInset的位置
inset_vectior = get(axis_handle, 'TightInset');
inset_x = inset_vectior(1);
inset_y = inset_vectior(2);
inset_w = inset_vectior(3);
inset_h = inset_vectior(4);

% OuterPosition的位置
outer_vector = get(axis_handle, 'OuterPosition');
pos_new_x = outer_vector(1) + inset_x; % 将Position的原点移到到TightInset的原点
pos_new_y = outer_vector(2) + inset_y;
pos_new_w = outer_vector(3) - inset_w - inset_x; % 重设Position的宽
pos_new_h = outer_vector(4) - inset_h - inset_y; % 重设Position的高

% 重设Position
set(axis_handle, 'Position', [pos_new_x, pos_new_y, pos_new_w, pos_new_h]);
end

end


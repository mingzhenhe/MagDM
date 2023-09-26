diff_dim = 10;
q =1/3; %paper 1/3

[K,C] = artificial_net_2();
%===force-direct layout
set(gca,'Position',[0 0 1 1]);
Graph = digraph(K,'omitselfloops');
h = plot(Graph,'Layout','force','EdgeColor',[0.76275 0.76275 0.76275]); %  ,'UseGravity',true
[uniq, ia, ic ] = unique(C,'row');
for i = 1:max(ic)
    class_i = find(ic==i);
    highlight(h,class_i,'NodeColor',uniq(i,:)) 
end
hold on;
%====hermitian matrix
[DM_hermitian, ~] = diff_map(K, diff_dim, q);
realpart_x = real(DM_hermitian(:,1));
realpart_y = real(DM_hermitian(:,2));
imagpart_x = imag(DM_hermitian(:,1));
imagpart_y = imag(DM_hermitian(:,2));
phase_x = angle(DM_hermitian(:,1));
phase_y = angle(DM_hermitian(:,2));
%====classic DM
[DM, ~] = diff_map(K, diff_dim, 0);
CDMx = DM(:,1);
CDMy = DM(:,2);
%====AA's work
[DM] = diff_map_svd(K, diff_dim);
aax = DM(:,1);
aay = DM(:,2);
%===kpca
% K = 0.5*(K+K.');
KPCA = K*K.';
KPCA = 0.5 * (K+K.');
[Y, eigVector, eigValue] = kpca(KPCA,diff_dim);
%===Magnetic Eigenmap
[ME] = Magnet_eigenmap(K, diff_dim, q);
ME_real_x = real(ME(:,1));
ME_imag_x = imag(ME(:,1));
ME_real_y = real(ME(:,2));
ME_imag_y = imag(ME(:,2));

%===Markov Magnetic Eigenmap
[MME] = Markov_Magnet_eigenmap(K, diff_dim, q);
MME_real_x = real(MME(:,1));
MME_imag_x = imag(MME(:,1));
MME_real_y = real(MME(:,2));
MME_imag_y = imag(MME(:,2));
 
% Draw_plane = figure(2);
% set(Draw_plane,'Position',[100,100,1200,400])
% subplot(1,3,1)
% h = plot(Graph,'Layout','force','EdgeColor',[0.76275 0.76275 0.76275]); %  ,'UseGravity',true
% highlight(h,(1:4),'NodeColor',[0 1 0],'Marker',"o")  % 
% highlight(h,4+(1:20),'NodeColor',[1 0 0])
% highlight(h,24+(1:20),'NodeColor',[0 0 1])
% highlight(h,44+(1:4),'NodeColor',[1 0.5 0])
% subplot(1,3,2)
% scatter(aax,aay,[],C); % ,'filled'
% xlabel('ADM first')
% ylabel('ADM second')
% subplot(1,3,3)
% scatter(Y(:,1),Y(:,2),[],C)
% xlabel('kpca x')
% ylabel('kpca y')
% hold on


phasemark = -pi:pi/4:pi;
phasemark_label = {'-\pi','-3\pi/4','-\pi/2','-\pi/4','0','\pi/4','\pi/2','3\pi/4','\pi'};

halfphasemark = -pi:pi/2:pi;
halfphasemark_label = {'-\pi','-\pi/2','0','\pi/2','\pi'};

Draw_plane = figure(3);
set(Draw_plane,'Position',[0,0,800,600])
subplot(4,3,1)
scatter(CDMx,CDMy,[],C);
xlabel('DM \phi_1')
ylabel('DM \phi_2')
subplot(4,3,2)
scatter(aax,aay,[],C);
xlabel('ADM \phi_1')
ylabel('ADM \phi_2')
subplot(4,3,3)
scatter(Y(:,1),Y(:,2),[],C)
xlabel('KPCA \phi_1')
ylabel('KPCA \phi_2')

subplot(4,3,4)
scatter(angle(ME(:,1)),angle(ME(:,2)),[],C)
xlabel('ME phase \phi_1^{(q)}')
ylabel('ME phase \phi_2^{(q)}')

set(gca,'Ytick',halfphasemark)
set(gca,'Yticklabel',halfphasemark_label)
set(gca,'Xtick',halfphasemark)
set(gca,'Xticklabel',halfphasemark_label)

subplot(4,3,5)
scatter(ME_real_x, ME_imag_x,[],C)
xlabel('ME Re \phi_1^{(q)}')
ylabel('ME Im \phi_1^{(q)}')
subplot(4,3,6)
scatter(ME_real_y, ME_imag_y,[],C)
xlabel('ME Re \phi_2^{(q)}')
ylabel('ME Im \phi_2^{(q)}')
subplot(4,3,7)
scatter(angle(MME(:,1)),angle(MME(:,2)),[],C)
xlabel('MME phase \phi_1^{(q)}')
ylabel('MME phase \phi_2^{(q)}')
set(gca,'Ytick',halfphasemark)
set(gca,'Yticklabel',halfphasemark_label)
% set(gca,'Xtick',halfphasemark)
% set(gca,'Xticklabel',halfphasemark_label)
subplot(4,3,8)
scatter(MME_real_x, MME_imag_x,[],C)
xlabel('MME Re \phi_1^{(q)}')
ylabel('MME Im \phi_1^{(q)}')
subplot(4,3,9)
scatter(MME_real_y, MME_imag_y,[],C)
xlabel('MME Re \phi_2^{(q)}')
ylabel('MME Im \phi_2^{(q)}')
subplot(4,3,10)
scatter(phase_x,phase_y,[],C)
xlabel('MagDM phase \phi_1^{(q)}')
ylabel('MagDM phase \phi_2^{(q)}')
set(gca,'Ytick',halfphasemark)
set(gca,'Yticklabel',halfphasemark_label)
set(gca,'Xtick',halfphasemark)
set(gca,'Xticklabel',halfphasemark_label)
subplot(4,3,11)
scatter(realpart_x,imagpart_x,[],C)
xlabel('MagDM Re \phi_1^{(q)}')
ylabel('MagDM Im \phi_1^{(q)}')
subplot(4,3,12)
scatter(realpart_y,imagpart_y,[],C)
xlabel('MagDM Re \phi_2^{(q)}')
ylabel('MagDM Im \phi_2^{(q)}')
hold on



% 
% subplot(3,3,1)
% scatter(aax,aay,[],C); % ,'filled'
% xlabel('ADM first')
% ylabel('ADM second')
% subplot(3,3,2)
% scatter(Y(:,1),Y(:,2),[],C)
% xlabel('kpca x')
% ylabel('kpca y')
% subplot(3,3,3)
% scatter(ME_real_x, ME_imag_x,[],C)
% xlabel('MagEig real')
% ylabel('MagEig imag')
% subplot(3,3,4)
% scatter(angle(ME(:,1)),angle(ME(:,2)),[],C)
% xlabel('MagEig phase x')
% ylabel('MagEig phase y')
% 
% % subplot(3,3,5)
% % scatter(realpart_x,realpart_y,[],C)
% % xlabel('real first')
% % ylabel('real second')
% % subplot(3,3,6)
% % scatter(imagpart_x,imagpart_y,[],C)
% % xlabel('imag first')
% % ylabel('imag second')
% subplot(3,3,5)
% scatter(MME_real_x, MME_imag_x,[],C)
% xlabel('Markov MagEig real')
% ylabel('Markov MagEig imag')
% subplot(3,3,6)
% scatter(angle(MME(:,1)),angle(MME(:,2)),[],C)
% xlabel('Markov MagEig phase 1')
% ylabel('Markov MagEig phase 2')
% subplot(3,3,7)
% scatter(phase_x,phase_y,[],C)
% xlabel('Our phase first')
% ylabel('Our phase second')
% subplot(3,3,8)
% scatter(realpart_x,imagpart_x,[],C)
% xlabel('Our real first')
% ylabel('Our imag first')
% subplot(3,3,9)
% scatter(realpart_y,imagpart_y,[],C)
% xlabel('Our real second')
% ylabel('Our imag second')
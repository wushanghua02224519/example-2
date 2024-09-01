clear
clc

%%%%%%%%%plant parameters
global P
global B
global J
global psi_f
global L
global R
P=2;
B=2e-3;
J=8e-4;
psi_f=0.945;
L=0.1875; 
R=12.5;

% PMSMquan
% 控制器ud参数
global k4
global c
global n1
global n2
global a
global T
k4=240;
c=0.6;
n1=0.9;
n2=0.7  ;
a=0.3;
T=0.1;

% % 控制器uq参数
global k1
global k2
global k3
global a11
global a21
global a12
global a22
global l1
global l2
global th
k1=240;
k2=240;
k3=240;
a11=48;
a21=13;
a12=48;
a22=13;
l1=0.15;
l2=0.15;
th=0.001;


% 预设性能参数
global Tf
global rho0
global rho00
global rhoTf
global S
global X
global rh0
global l
global v
global v0
Tf=3;
rho00=0.6;
rhoTf=0.1;
rh0=0.8;
S=2;
X=2;
l=0.8;
v0=2.5;
% rho0=0.6;初始数据，上面为改变初始值后修改
% rhoTf=0.1;
% rh0=0.8;
% S=2;
% X=2;
% l=0.8;
% v=2.2;

% 预设性能函数对比
global Tf1
global rho01
global rhoTf1
global rh01
global ta
global f
Tf1=2.8597;
rho01=0.6;
rhoTf1=0.1;
rh01=0.8;
ta=0.3;
f=1;
global Tfe
global rho0e
global rhoTfe
Tfe=4;
rho0e=0.6;
rhoTfe=0.1;


% % 干扰观测器参数
global v11
global v12
global v13
global v1
global v2
global v3
global T1
v11=1.4;
v12=2;
v13=10;
v1=14;
v2=80;
v3=20;
T1=0.4;

% 预设性能参数
global Tfc
global rho0c
global rhoTfc
global rh0c
Tfc=3.8;
rho0c=0.5;
rhoTfc=0.1;
rh0c=0.9;


% % 对比仿真
global K1
global K2
global K3
global K4
global L1
global L2
global L3
global L4
K1=220;
K2=220;
K3=220;
K4=220;
L1=1;
L2=1;
L3=1;
L4=1;
% % 有限时间干扰观测器参数
global vd1
global vd2
global vd3
global v4
global v5
global v6
vd1=20;
vd2=40;
vd3=100;
v4=200;
v5=100;
v6=200;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          PBS-PSO算法程序
% %初始化粒子群参数
% w=0.8;
% c_1=1.49445;%学习因子
% c_2=1.49445;%学习因子
% D=8;%搜索空间维度
% kdd=0.03;%微分系数
% alf=0.9;%微分衰减系数
% popsize=100;%粒子群规模
% maxiter=100;%最大迭代次数
% minfitness=0.001;%允许的最小适应度值
% popmax=[8000 8000 8000 8000 8000 8000 8000 8000];%位置上限
% popmin=[0.001 0.05 0.001 0.001 0.001 0.001 0.001 0.001];%位置下限
% vmax=0.15*(popmax-popmin);%速度上限
% vmin=-vmax;%速度下限
% 
% %初始化粒子群
% range=ones(popsize,1)*(popmax-popmin);%100*3的矩阵，每一行为每一位置维度的取值范围
% rangev=ones(popsize,1)*(vmax-vmin);%100*3的矩阵，每一行为每一速度维度的取值范围
% pop=rand(popsize,D).*range+ones(popsize,1)*popmin;%初始化粒子位置，100*23的矩阵，表示100个位置23维粒子(点乘表示对应相乘)
% v=rand(popsize,D).*rangev+ones(popsize,1)*vmin;%初始化粒子速度，100*23的矩阵，表示100个速度23维的粒子
% weifen=rand(popsize,D);%随机初始化微分项,100*23的矩阵
% fit=zeros(popsize,1);%适应度值清零，100*1的列向量
% 
% %计算每个粒子的适应度值
% for i=1:popsize 
%     K1=pop(i,1);
%     K2=pop(i,2);
%     K3=pop(i,3);
%     K4=pop(i,4);
%     L1=pop(i,5);
%     L2=pop(i,6);
%     L3=pop(i,7);
%     L4=pop(i,8);
% %     k11=pop(i,1);
% %     k22=pop(i,2);
% %     k33=pop(i,3);
% %     k44=pop(i,4);
% %     Y1=pop(i,5);
% %     Y2=pop(i,6);
% %     Y3=pop(i,7);
% %     Y4=pop(i,8);
% %     tao11=pop(i,9);
% %     tao22=pop(i,10);
% %     cons=pop(i,11);
% %     cons1=pop(i,12);
% %     cons2=pop(i,13);
% %     k4=pop(i,14);
% %     tao4=pop(i,15);
% %     k1=pop(i,16);
% %     k2=pop(i,17);
% %     k3=pop(i,18);
% %     tao1=pop(i,19);
% %     tao2=pop(i,20);
% %     tao3=pop(i,21);
% %     p1=pop(i,22);
% %     p2=pop(i,23);
% %     v1=pop(i,24);
% %     v2=pop(i,25);
% %     v3=pop(i,26);
% %     v4=pop(i,27);
%     
%     try        
%         sim('initial_parameters_1st',[0,10]);
%         fit(i)=fitness(end,1);
%     catch
%         fit(i)=100+rand;
%     end        
% end
% 
% %计算个体最优和全局最优
% [bestfit,bestindex]=min(fit);%求适应度值的最小值并返回值和索引
% pbest=pop;%个体最优位置
% gbest=pop(bestindex,:);%全局最优位置
% fitpbest=fit;%个体最优适应度值
% fitgbest=bestfit;%全局最优适应度值
% 
% %开始迭代前初始化
% iter=0;%初始化迭代次数为0
% gbested=0;%上一代的全局最优位置
% y_fitness=zeros(1,maxiter);
% K_1=zeros(1,maxiter);
% K_2=zeros(1,maxiter);
% K_3=zeros(1,maxiter);
% K_4=zeros(1,maxiter);
% L_1=zeros(1,maxiter);
% L_2=zeros(1,maxiter);
% L_3=zeros(1,maxiter);
% L_4=zeros(1,maxiter);
% % tao_11=zeros(1,maxiter);
% % tao_22=zeros(1,maxiter);
% % cons_=zeros(1,maxiter);
% % cons_1=zeros(1,maxiter);
% % cons_2=zeros(1,maxiter);
% % k_4=zeros(1,maxiter);
% % tao_4=zeros(1,maxiter);
% % k_1=zeros(1,maxiter);
% % k_2=zeros(1,maxiter);
% % k_3=zeros(1,maxiter);
% % tao_1=zeros(1,maxiter);
% % tao_2=zeros(1,maxiter);
% % tao_3=zeros(1,maxiter);
% % p_1=zeros(1,maxiter);
% % p_2=zeros(1,maxiter);
% % v_1=zeros(1,maxiter);
% % v_2=zeros(1,maxiter);
% % v_3=zeros(1,maxiter);
% % v_4=zeros(1,maxiter);
% 
% 
% %迭代开始
% while((iter<maxiter)&&(fitgbest>minfitness))
%     for j=1:popsize
%         %粒子速度更新
% %       h=pi*iter/(2*maxiter);
% %       w=rand*wmin*(1-cos(h))+wmax*cos(h);
%         v(j,:)=w*v(j,:)+c_1*rand*(pbest(j,:)-pop(j,:))+c_2*rand*(gbest-pop(j,:));
%         %粒子速度越界处理
%         if v(j,:)>vmax,v(j,:)=vmax;end
%         if v(j,:)<vmin,v(j,:)=vmin;end
%         %微分项更新
%         weifen(j,:)=alf*weifen(j,:)+(gbest-gbested);
%         gbested=gbest;
%         %粒子位置更新
%         pop(j,:)=pop(j,:)+v(j,:)+kdd*weifen(j,:);
%         if pop(j,1)<pop(j,2),pop(j,1)=10;pop(j,2)=0.05;end
%         if pop(j,4)<pop(j,5),pop(j,4)=10;pop(j,5)=2;end
% %         if pop(j,7)<pop(j,8),pop(j,7)=10;pop(j,8)=2;end
% %         if pop(j,14)<pop(j,15),pop(j,14)=10;pop(j,15)=0.005;end
% %         if pop(j,17)<pop(j,18),pop(j,17)=10;pop(j,18)=2;end
%         %粒子位置越界处理
%         for k=1:D
%             if pop(j,k)>popmax(k),pop(j,k)=popmax(k);end
%             if pop(j,k)<popmin(k),pop(j,k)=popmin(k);end
%         end 
%         K1=pop(i,1);
%         K2=pop(i,2);
%         K3=pop(i,3);
%         K4=pop(i,4);
%         L1=pop(i,5);
%         L2=pop(i,6);
%         L3=pop(i,7);
%         L4=pop(i,8);
% %         k11=pop(i,1);
% %         k22=pop(i,2);
% %         k33=pop(i,3);
% %         k44=pop(i,4);
% %         Y1=pop(i,5);
% %         Y2=pop(i,6);
% %         Y3=pop(i,7);
% %         Y4=pop(i,8);
% %         tao11=pop(i,9);
% %         tao22=pop(i,10);
% %         cons=pop(i,11);
% %         cons1=pop(i,12);
% %         cons2=pop(i,13);
% %         k4=pop(i,14);
% %         tao4=pop(i,15);
% %         k1=pop(i,16);
% %         k2=pop(i,17);
% %         k3=pop(i,18);
% %         tao1=pop(i,19);
% %         tao2=pop(i,20);
% %         tao3=pop(i,21);
% %         p1=pop(i,22);
% %         p2=pop(i,23);
% %         v1=pop(i,24);
% %         v2=pop(i,25);
% %         v3=pop(i,26);
% %         v4=pop(i,27);
%         
%         try
%             sim('initial_parameters_1st',[0,10]);
%             fit(j)=fitness(end,1);%求适应度值
%         catch
%             fit(j)=100+rand;
%         end
%         %个体最优位置和个体最优适应度值更新
%         if fit(j)<fitpbest(j)
%             pbest(j,:)=pop(j,:);
%             fitpbest(j)=fit(j);
%         end
%         %全局最优位置和全局最优适应度值更新
%         if fit(j)<fitgbest
%             gbest=pop(j,:);
%             fitgbest=fit(j);
%         end                                   
%     end                 %for循环结束，即迭代完成一次
%     iter=iter+1;        %迭代次数加1
%     y_fitness(1,iter)=fitgbest;
%     K_1(1,iter)=gbest(1);
%     K_2(1,iter)=gbest(2);
%     K_3(1,iter)=gbest(3);
%     K_4(1,iter)=gbest(4);
%     L_1(1,iter)=gbest(5);
%     L_2(1,iter)=gbest(6);
%     L_3(1,iter)=gbest(7);
%     L_4(1,iter)=gbest(8);
% %     k_11(1,iter)=gbest(1);
% %     k_22(1,iter)=gbest(2);
% %     k_33(1,iter)=gbest(3);
% %     k_44(1,iter)=gbest(4);
% %     Y_1(1,iter)=gbest(5);
% %     Y_2(1,iter)=gbest(6);
% %     Y_3(1,iter)=gbest(7);
% %     Y_4(1,iter)=gbest(8);
% %     tao_11(1,iter)=gbest(9);
% %     tao_22(1,iter)=gbest(10);
% %     cons_(1,iter)=gbest(11);
% %     cons_1(1,iter)=gbest(12);
% %     cons_2(1,iter)=gbest(13);
% %     k_4(1,iter)=gbest(14);
% %     tao_4(1,iter)=gbest(15);
% %     k_1(1,iter)=gbest(16);
% %     k_2(1,iter)=gbest(17);
% %     k_3(1,iter)=gbest(18);
% %     tao_1(1,iter)=gbest(19);
% %     tao_2(1,iter)=gbest(20);
% %     tao_3(1,iter)=gbest(21);
% %     p_1(1,iter)=gbest(22);
% %     p_2(1,iter)=gbest(23);
% %     v_1(1,iter)=gbest(24);
% %     v_2(1,iter)=gbest(25);
% %     v_3(1,iter)=gbest(26);
% %     v_4(1,iter)=gbest(27);
%       
%    
% end                     %while循环结束，即达到结束条件结束
% 
% % figure(1)
% % plot(y_fitness,'LineWidth',2)
% % title('最优个体适应度','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('适应度值','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(2)
% % plot(k_11,'LineWidth',2)
% % title('k11','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('k11','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(3)
% % plot(k_22,'LineWidth',2)
% % title('k22','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('k22','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(4)
% % plot(k_33,'LineWidth',2)
% % title('k33','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('k33','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(5)
% % plot(k_44,'LineWidth',2)
% % title('k44','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('k44','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(6)
% % plot(Y_1,'LineWidth',2)
% % title('Y1','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('Y1','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(7)
% % plot(Y_2,'LineWidth',2)
% % title('Y2','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('Y2','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(8)
% % plot(Y_3,'LineWidth',2)
% % title('Y3','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('Y3','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(9)
% % plot(Y_4,'LineWidth',2)
% % title('Y4','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('Y4','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(10)
% % plot(tao_11,'LineWidth',2)
% % title('tao11','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('tao11','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(11)
% % plot(tao_22,'LineWidth',2)
% % title('tao22','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('tao22','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(12)
% % plot(cons_,'LineWidth',2)
% % title('cons','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('cons','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(13)
% % plot(cons_1,'LineWidth',2)
% % title('cons1','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('cons1','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% % figure(14)
% % plot(cons_2,'LineWidth',2)
% % title('cons2','fontsize',12);
% % xlabel('迭代次数','fontsize',12);ylabel('cons2','fontsize',12);
% % set (gcf,'Position',[100,100,300,200], 'color','w')
% figure(2)
% plot(K_1,'LineWidth',2)
% title('K1','fontsize',12);
% xlabel('迭代次数','fontsize',12);ylabel('K1','fontsize',12);
% set (gcf,'Position',[100,100,300,200], 'color','w')
% figure(3)
% plot(K_2,'LineWidth',2)
% title('K2','fontsize',12);
% xlabel('迭代次数','fontsize',12);ylabel('K2','fontsize',12);
% set (gcf,'Position',[100,100,300,200], 'color','w')
% figure(4)
% plot(K_3,'LineWidth',2)
% title('K3','fontsize',12);
% xlabel('迭代次数','fontsize',12);ylabel('K3','fontsize',12);
% set (gcf,'Position',[100,100,300,200], 'color','w')
% figure(5)
% plot(K_4,'LineWidth',2)
% title('K4','fontsize',12);
% xlabel('迭代次数','fontsize',12);ylabel('K4','fontsize',12);
% set (gcf,'Position',[100,100,300,200], 'color','w')
% figure(6)
% plot(L_1,'LineWidth',2)
% title('L1','fontsize',12);
% xlabel('迭代次数','fontsize',12);ylabel('L1','fontsize',12);
% set (gcf,'Position',[100,100,300,200], 'color','w')
% figure(7)
% plot(L_2,'LineWidth',2)
% title('L2','fontsize',12);
% xlabel('迭代次数','fontsize',12);ylabel('L2','fontsize',12);
% set (gcf,'Position',[100,100,300,200], 'color','w')
% figure(8)
% plot(L_3,'LineWidth',2)
% title('L3','fontsize',12);
% xlabel('迭代次数','fontsize',12);ylabel('L3','fontsize',12);
% set (gcf,'Position',[100,100,300,200], 'color','w')
% figure(9)
% plot(L_4,'LineWidth',2)
% title('L4','fontsize',12);
% xlabel('迭代次数','fontsize',12);ylabel('L4','fontsize',12);
% set (gcf,'Position',[100,100,300,200], 'color','w')


% % %step
% % 控制器ud参数
% global k4
% global tao4
% global c
% global n
% global K
% k4=1000;
% tao4=0.5;
% c=0.6;
% n=0.2;
% K=0.6;
% 
% % % 控制器uq参数
% global k1
% global k2
% global k3
% global tao1
% global tao2
% global tao3
% global G
% global Y
% global Q
% global p1
% global p2
% global l1
% global l2
% global l3
% k1=1000;
% k2=1000;
% k3=1000;
% tao1=0.5;
% tao2=0.5;
% tao3=0.5;
% G=0.6;
% Y=0.6;
% Q=0.6;
% p1=500;
% p2=500;
% l1=0.05;
% l2=0.05;
% l3=0.05;

% 
% % 预设性能参数
% global Tf
% global rho0
% global rhoTf
% global S
% global X
% global rh0
% global l
% global ta
% global f
% Tf=2.8597;
% rho0=0.6;
% rhoTf=0.1;
% rh0=0.8;
rho0=10.6;
v=42.2;
% S=2;
% X=2;
% l=0.8;
% ta=0.3;
% f=1;
% 
% % % 有限时间干扰观测器参数
% global v1
% global v2
% global v3
% global v4
% v1=100;
% v2=200;
% v3=100;
% v4=200;

nx=1000;
nt=50;

X=linspace(0,1,nx);
T=linspace(0,1,nt);
dt=diff(T);

Var=5;
noisescale=.05;


%[noise,covd]=make_corr_noise(X,0*X,Var,noisescale,nt);
noise=sqrt(Var)*randn(nx,nt);
%shifts=repmat(randn(1,nt),nx,1);
%noise=noise+shifts;

G=eye(nt);
G=G-circshift(G,[0,1]);
G=-G(1:end-1,:);

ints=G*noise';
ci=cov(ints');

covi=G*(Var*eye(nt))*G';

Gavg=dt';
Ggavg=inv(Gavg'*Gavg)*Gavg';
Vs=Ggavg*ints;
var(Vs)
covm=Ggavg*covi*Ggavg'
covibad=diag(diag(covi))/2;
covm2=Ggavg*covibad*Ggavg'

return

Gr10=G;
Gr10(end+1,1)=1;
Gg10=inv(Gr10'*Gr10)*G';

Grm0=G;
Grm0(end+1,:)=1;
Ggm0=inv(Grm0'*Grm0)*G';

Gavg=dt';
Ggavg=inv(Gavg'*Gavg)*Gavg';


def10=Gg10*ints; %first point set to 0
defm0=Ggm0*ints; %mean set to 0  Gives you same value as if you take out mean


%fit a line to TS
Gl=[T' ones(nt,1)];
Ggl=inv(Gl'*Gl)*Gl';

mod10=Ggl*def10;
modm0=Ggl*defm0;
modavg=Ggavg*ints;


%figures
pflag=0;
figure
plot(X,noise(:,1),'linewidth',2)
xlabel('distance')
title('one noisy dataset')
if(pflag), print -dpng figures/noise.png, end
pause

figure
plot(X,covd(1,:),'linewidth',2)
xlabel('distance')
ylabel('covariance')
if(pflag), print -dpng figures/cov.png, end
pause

figure
imagesc(noise')
xlabel('distance')
ylabel('time')
title('all dates vs. distance')
if(pflag), print -dpng figures/allnoise.png, end
pause

figure
imagesc(ints)
xlabel('distance')
ylabel('interferogram #')
title('all sequential interferograms')
if(pflag), print -dpng figures/allints.png, end
pause

figure
plot(T,def10(:,1),'linewidth',2)
hold on
plot(T,defm0(:,1),'linewidth',2)
plot(T,modavg(1)*T,'linewidth',2)
plot(T,noise(1,:),'--','linewidth',2)
legend('D1 0','mean all 0','avg ints','true')
xlabel('time')
title('inferred displacement vs. time')
if(pflag), print -dpng figures/mods.png, end
pause

figure
plot(X,def10(2,:),'linewidth',2)
hold on
plot(X,defm0(2,:),'linewidth',2)
plot(X,noise(:,2)-noise(:,1),'--','linewidth',1)
legend('D1=0','mean all=0','n2-n1')
xlabel('distance')
title('Impact of regul. on 2nd date')
if(pflag), print -dpng figures/mods_dist.png, end
pause

figure
plot(X,mod10(1,:),'linewidth',2)
hold on
plot(X,modavg,'linewidth',2)
plot(X,def10(end,:)-def10(1,:),'--','linewidth',2)
xlabel('distance')
title('inferred average rate')
legend(['fit line to TS, \sigma=' num2str(std(mod10(1,:)))],['avg ints \sigma=' num2str(std(modavg))],'first,last dates')
if(pflag), print -dpng figures/ratecompare.png, end

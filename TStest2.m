nx=100;
nt=50;

X  = linspace(0,1,nx);
T  = linspace(0,1,nt);
dt = diff(T);
dz = linspace(0,2,nx);
dz(X>0.5)=0;
bp = randn(1,nt);
bp = bp-bp(1);


Var=2;
noisescale=.05;


[noise,covd] = make_corr_noise(X,0*X,Var,noisescale,nt);
demerr       = dz'*bp;
data         = [noise+demerr]; %observed ground def+noise+demerror

G     = eye(nt);
G     = circshift(G,[0,1])-G;
G     = G(1:end-1,:);
ints  = G*data';


%regularize so that first pt is 0 (this does not affect rate)
Gr10 = G;
Gr10(end+1,1)=1;
Gg10 = inv(Gr10'*Gr10)*G'; 

ints  = G*data';
def10 = Gg10*ints; 

%fit a line to TS
Gl    = [ones(nt,1) T'];
Ggl   = inv(Gl'*Gl)*Gl';

%fit line and dem error
Gd    = [ones(nt,1) T' bp']; %inverts time series for intercept,rate,dem error
Ggd   = inv(Gd'*Gd)*Gd';

%solve for avg rate and dem error directly from interferograms
Givd   = [diff(T') diff(bp')];
Ggivd  = inv(Givd'*Givd)*Givd';
%or JUST the dem error
Gid    = [diff(bp')];
Ggid   = inv(Gid'*Gid)*Gid';


mod10  = Ggl*def10;  %note, same as Ggl*Gg10*ints
modd   = Ggd*def10; %dem error
modivd = Ggivd*ints; %just from ints
modid  = Ggid*ints; %just ints, just dem error



figure
subplot(1,3,1)
plot(X,mod10(1,:),'b')
hold on
plot(X,modd(1,:),'r')
plot(X,0*X,'k')
title('intercept')
legend('no dem error','dem error')

subplot(1,3,2)
plot(X,mod10(2,:),'b')
hold on
plot(X,modd(2,:),'r')
plot(X,modivd(1,:),'g')
plot(X,0*X,'k')
title('slope')
legend('no dem error','dem error','invints')


subplot(1,3,3)
plot(X,modd(3,:),'r')
hold on
plot(X,modivd(2,:),'g')
plot(X,modid(1,:),'c')
plot(X,dz,'k')
title('DEM error')
legend('dem error','invints','invintsjustdem','true')




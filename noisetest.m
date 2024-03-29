t=[0 1 2 3 4]'*2;
nt=length(t);
v=1;
Var=2;


G=[-1 1 0 0 0;0 -1 1 0 0;0 0 -1 1 0; 0 0 0 -1 1]; 
Ga=G;
Ga(end+1,1)=1;
Gg=inv(Ga'*Ga)*G';

G1=[diff(t)];
Gg1a=inv(G1'*G1)*G1';

G2=[t ones(size(t))];
Gg2=inv(G2'*G2)*G2';


covd=diag(ones(nt,1))*Var;
covi=covd(2:end,2:end)*2-diag(ones(nt-2,1),1)*Var-diag(ones(nt-2,1),-1)*Var;
% 
W=inv(covi);
Gg1b=inv(G1'*W*G1)*G1'*W;
% 

numnoise=1;
for i=1:numnoise
    noise=sqrt(Var)*randn(size(t));
    d(:,i)=v*t+noise;
end

ints=G*d;

mod1=Gg2*Gg*ints;
mod2=Gg1a*ints;
mod3=Gg1b*ints;

figure
plot(t,d-d(1),'ko','markersize',14,'markerfacecolor','k')
hold on
plot(t,v*t,'k-')
grid on
set(gca,'fontsize',14)
xlabel('Time')
ylabel('Displacement')
%plot(t,mod1(1)*t+mod1(2),'r-','linewidth',4)
print -dpng panel1.png
plot(t,mod2*t,'r-','linewidth',4)
print -dpng panel2.png
plot(t,mod3*t+mod1(2),'b-','linewidth',4)
print -dpng panel3.png

%legend('data','True','stack','weightstack')
%grid on
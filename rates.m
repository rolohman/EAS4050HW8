n=2:50;
nd=10000;
Var=1;
for i=1:length(n)
    dat=rand(n(i),nd);
    ts=linspace(0,1,n(i));
    G=[ts' ones(size(ts'))];
   	Gg=inv(G'*G)*G';
    mods=Gg*dat;
    rate(i,:)=mods(1,:);
end


for i=1:length(n)
    tmp=rate(i,:);
    m(i)=mean(tmp);
    stds(i)=std(tmp);
end

plot(n,m,'r','linewidth',3)
hold on
plot(n,m+stds,'k--','linewidth',2)
plot(n,m-stds,'k--','linewidth',2)
grid on
box on
set(gca,'fontsize',14)
xlabel('Number of dates')
ylabel('Inferred rate')
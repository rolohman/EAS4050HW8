def(:,1)=[1 3 4 2 6 4 5]';
def(:,2)=[2 4 5 1 6 5 6]';
def(:,3)=[2 1 2 3 5 4 6]';
def(:,4)=[7 6 8 5 3 1 2]';
G=[-1 1 0 0 0 0 0; 
    0 -1 1 0 0 0 0;
    0 0 -1 1 0 0 0;
    0 0 0 -1 1 0 0;
    0 0 0 0 -1 1 0;
    0 0 0 0 0 -1 1];
G2=[G;1 0 0 0 0  0 0];
inv(G2'*G2)*G2'


order1=[1 2 3 4];
order2=[3 2 4 1];
figure('position',[2 400 1000 350])
js=1:4;
names1={'A','B','C','D'};
names2={'a','b','c','d'};
for j=1:length(js)
    subplot(2,4,j)
    plot(def(:,order1(j))-def(1,order1(j)),'o-','markersize',12,'linewidth',2)
    hold on
    text(6.5,-7,names1{j},'fontweight','bold','fontsize',12)
    axis([1 7 -8 6])
    grid on
    set(gca,'xtick',[1:7])
    xlabel('Time')
    ylabel('Deformation')
    subplot(2,4,4+j)
    for i = 1:6
        ints=G*def(:,order2(j));
        id=find(abs(G(i,:))==1);
        plot([id(1) id(2)],[ints(i) ints(i)],'r.-','linewidth',2)
        hold on
    end
    hold on
    text(6.5,-8,names2{j},'fontweight','bold','fontsize',14)
    
    grid on
    set(gca,'xtick',[1:7])
    xlabel('Time')
    ylabel('InSAR def')
    axis([1 7 -10 7])
end
print -dpng HW1.png


def(:,1)=[6 3 5 2 7 5 1]';
def(:,2)=[1 3 4 2 1 3 5]';
def(:,3)=[5 5 3 2 4 5 6]';
def(:,4)=[1 3 5 6 6 3 2]';

G=[-1 0 0 1 0 0 0; 
    -1 0 1 0 0 0 0;
    0 0 0 0 -1 1 0;
    0 0 -1 0 1 0 0;
    0 -1 0 0 0 1 0;
    0 0 0 0 -1 0 1];
G2=[G;1 0 0 0 0  0 0];
inv(G2'*G2)*G2';

order1=[1 2 3 4];
order2=[4 1 2 3];
figure('position',[2 400 1000 350])
js=1:4;
names1={'A','B','C','D'};
names2={'a','b','c','d'};
for j=1:length(js)
    subplot(2,4,j)
    plot(def(:,order1(j))-def(1,order1(j)),'o-','markersize',12,'linewidth',2)
    hold on
    text(6.5,-7,names1{j},'fontweight','bold','fontsize',12)
    axis([1 7 -8 6])
    grid on
    set(gca,'xtick',[1:7])
    xlabel('Time')
    ylabel('Deformation')
    subplot(2,4,4+j)
    for i = 1:6
        ints=G*def(:,order2(j));
        id=find(abs(G(i,:))==1);
        plot([id(1) id(2)],[ints(i) ints(i)],'r.-','linewidth',2)
        hold on
    end
    hold on
    text(6.5,-8,names2{j},'fontweight','bold','fontsize',14)
    
    grid on
    set(gca,'xtick',[1:7])
    xlabel('Time')
    ylabel('InSAR def')
    axis([1 7 -10 7])
end
print -dpng HW2.png

return





G=[-1 0 0 1 0 0 0; 
   -1 0 1 0 0 0 0;
    0 0 0 0 -1 1 0;
    0 0 -1 1 0 0 0;
    0 -1 1 0 0 0 0;
    0 0 0 0 -1 0 1];
G2=[G;1 0 0 0 0  0 0];
inv(G2'*G2)*G2'


figure
for j=1:length(js)
    subplot(2,3,j)
    plot(def(:,js(j))-def(1,js(j)),'.-')
    axis([1 7 -8 6])
    subplot(2,3,3+j)
    for i = 1:length(ints)
        ints=G*def(:,js(j));
        id=find(abs(G(i,:))==1);
        plot([id(1) id(2)],[ints(i) ints(i)],'r')
        hold on
    end
    axis([1 7 -10 7])
end
print -dpng HW3.png
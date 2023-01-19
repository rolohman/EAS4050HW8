def(:,1)=[5 10 3 4 6 -2 1]';
def(:,2)=[3 4 5 2 1 7 6]';
def(:,3)=[2 2 5 6 3 2 1]';
def(:,4)=[7 6 3 4 1 2 1]';
G=[-1 1 0 0 0 0 0; 
    0 -1 1 0 0 0 0;
    0 0 -1 1 0 0 0;
    0 0 0 -1 1 0 0;
    0 0 0 0 -1 1 0;
    0 0 0 0 0 -1 1];
G2=[G;1 0 0 0 0  0 0];
inv(G2'*G2)*G2'


figure
js=2:4;
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
print -dpng classfigsb.png


G=[-1 0 0 1 0 0 0; 
    -1 0 1 0 0 0 0;
    0 0 0 0 -1 1 0;
    0 0 -1 0 1 0 0;
    0 -1 0 0 0 1 0;
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
print -dpng classfigs2b.png






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
print -dpng classfig3b.png
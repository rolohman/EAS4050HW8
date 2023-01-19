nx=256;
ny=256;
numdat = 20;
n=20;
[X,Y]=meshgrid(1:nx,1:ny);
X=X-mean(X(:));
Y=Y-mean(Y(:));

rampmag=1*randn(1,numdat);
bixmag = 5/nx*randn(1,numdat);
biymag = 5/ny*randn(1,numdat);
noise=zeros(ny*2,nx*2,numdat);
z = fspecial('gaussian', [30 30], 4);
z2=zeros(nx*2,ny*2);
z2(1:30,1:30)=z*10;


scales=logspace(0,1,n);
for i=1:n
    tmp=spatialPattern([ny*2 nx*2 numdat],-scales(i)-1.5);
    noise=noise+tmp/std(tmp(:))+z2;    
end

ids=randperm(numdat);
noise=noise(1:ny,1:nx,ids);
for i=1:numdat
    noise(:,:,i)=noise(:,:,i)+bixmag(i)*X+biymag(i)*Y;
end

figure('position',[13 337 513 468])
for i=1:numdat
    colormap('jet')
    tmp=squeeze(noise(:,:,i));
    tmp=tmp-mean(tmp(:));
    imagesc(tmp)
    set(gca,'position',[0 0 1 1],'xtick',[],'ytick',[])
    caxis([-15 15])
    M(i)=getframe;
end
movie2gif(M,'~/Desktop/mygif.gif','DelayTime',0.5,'LoopCount',Inf);
imagesc(mean(noise,3))
caxis([-15 15])
print -dpng slopefig2D.png


imagesc(noise(:,:,1)-noise(:,:,end))
caxis([-15 15])
print -dpng stackfig.png
return
%now filter all the noises
D=2
for i=1:numdat
    n1=squeeze(noise(:,:,i));
    ft=fftshift(fft2(n1));
    [x y ~] = size(ft);
    mask = fspecial('disk', D) == 0;
    mask = imresize(padarray(mask, [floor((x/2)-D) floor((y/2)-D)], 1, 'both'), [x y]);
    masked_ft = ft .* mask;
    filtered_image = ifft2(ifftshift(masked_ft), 'symmetric');
    filtnoise(:,:,i)=filtered_image;
end


return
figure('position',[13 337 513 468])
for i=1:numdat
    colormap('jet')
    tmp=squeeze(noise(:,:,i));
    tmp=tmp-mean(tmp(:))+rampmag(i);
    imagesc(tmp)
    set(gca,'position',[0 0 1 1],'xtick',[],'ytick',[])
    caxis([-20 20])
    M(i)=getframe;
end


for i=1:numdat
    colormap('jet')
    tmp=squeeze(filtnoise(:,:,i));
    imagesc(tmp)
    set(gca,'position',[0 0 1 1],'xtick',[],'ytick',[])
    caxis([-20 20])
    M2(i)=getframe;
end

movie2gif(M,'~/Desktop/mygif.gif','DelayTime',1,'LoopCount',Inf);
movie2gif(M2,'~/Desktop/filtgif.gif','DelayTime',1,'LoopCount',Inf);
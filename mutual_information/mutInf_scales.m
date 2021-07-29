U=permute(U,[1 3 2 4 5]);

[comps,sY,sX,sZ,timesteps]=size(U);

nu=5e-5;

dt=0.0065;

T=dt*(timesteps-1);

t=0:dt:T;


mU=tAvg(U,t,T);

fU=zeros(comps,sY,sX,sZ,timesteps);

for i=1:timesteps
    
   fU(:,:,:,:,i)=U(:,:,:,:,i)-mU;
   
end

dx=diff(x);
dx=[dx;dx(length(dx))];
dy=diff(y);
dy=[dy;dy(length(dy))];
dz=diff(z);
dz=[dz;dz(length(dz))];

kz1 = mod(1/2 + (0:(sZ-1))/sZ, 1 ) - 1/2;
kz1=kz1';
ky1 = mod(1/2 + (0:(sY-1))/sY, 1 ) - 1/2;
ky1=ky1';
kx1 = mod(1/2 + (0:(sX-1))/sX, 1 ) - 1/2;
kx1=kx1';
kz  = kz1.*(2*pi./dz); % wavenumbers
ky  = ky1.*(2*pi./dy); % wavenumbers
kx  = kx1.*(2*pi./dx); % wavenumbers
[KX,KY,KZ] = meshgrid(kx,ky,kz);

KK=sqrt(KX.^2 +KY.^2 +KZ.^2);

uk1=fftn(squeeze(fU(1,:,:,:,1)));
kMax=max(KK,[],'all');
kf=linspace(1,kMax);
for i=1:length(kf)
    tic
    maskLow=KZ.^2 + KY.^2 + KZ.^2 <=kf(i)^2;
    maskHigh=KZ.^2 + KY.^2 + KZ.^2 >kf(i)^2;
    maskHigh=double(maskHigh);
    maskLow=double(maskLow);
    ukLow=uk1.*maskLow;
    ukHigh=uk1.*maskHigh; 
    uLow=real(ifftn(ukLow));
    uHigh=real(ifftn(ukHigh));
    data1=reshape(uHigh,[],1);
    data2=reshape(uLow,[],1);
    data=[data1 data2];
    [b1,pdf,X,Y]=kde2d(data,2^10);
    mInf(i)=mutualInf(X,Y,pdf);
    toc
end







%%
semilogy(xpdf1,pdf1,'b','linewidth',1)
hold on
semilogx(xpdf2,pdf2,'r','linewidth',1)
legend('Escalas pequeñas','Escalas grandes','Location','NorthEast')




figure
surf(squeeze(fU(1,:,:,50,1)))
view(2)
shading interp
colorbar

figure
surf(squeeze(uLow(:,:,50)+uHigh(:,:,50)))
view(2)
shading interp
figure(1)
colorbar

figure
surf(abs(squeeze(fU(1,:,:,50,1))-squeeze(uLow(:,:,50)+uHigh(:,:,50))))
view(2)
shading interp
colorbar

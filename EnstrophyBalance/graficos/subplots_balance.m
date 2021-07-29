%en y+ en {5,10,40,70} i en {18,25,48,63}

V=Dw;
C=1000;

subplot(2,2,1)
surf(squeeze(X(18,:,:)),squeeze(Z(18,:,:)),squeeze(V(18,:,:)))
title('y^+ = 5')
view(2)
shading interp
xlim([min(x) max(x)])
ylim([min(z) max(z)])
xlabel('x')
ylabel('z')
caxis([-C C])


subplot(2,2,2)
surf(squeeze(X(25,:,:)),squeeze(Z(25,:,:)),squeeze(V(25,:,:)))
title('y^+ = 10')
view(2)
shading interp
xlim([min(x) max(x)])
ylim([min(z) max(z)])
xlabel('x')
ylabel('z')
caxis([-C C])


subplot(2,2,3)
surf(squeeze(X(48,:,:)),squeeze(Z(48,:,:)),squeeze(V(48,:,:)))
title('y^+ = 40')
view(2)
shading interp
xlim([min(x) max(x)])
ylim([min(z) max(z)])
xlabel('x')
ylabel('z')
caxis([-C C])

subplot(2,2,4)
surf(squeeze(X(63,:,:)),squeeze(Z(63,:,:)),squeeze(V(63,:,:)))
view(2)
shading interp
title('y^+ = 70')
xlim([min(x) max(x)])
ylim([min(z) max(z)])
xlabel('x')
ylabel('z')
caxis([-C C])
h = colorbar;

for i=1:timesteps

end 


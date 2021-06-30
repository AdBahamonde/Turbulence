function vort = fluidVort(S)


%calculo de la vorticidad a partir del tensor de gradiente de velocidades
vort(1,:,:,:,:)=squeeze(S(3,2,:,:,:,:)-S(2,3,:,:,:,:));
vort(2,:,:,:,:)=squeeze(S(1,3,:,:,:,:)-S(3,1,:,:,:,:));
vort(3,:,:,:,:)=squeeze(S(2,1,:,:,:,:)-S(1,2,:,:,:,:));


end


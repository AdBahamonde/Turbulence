function S = varGradient(U,dx,dy,dz)
%Esta función nos entrega el tensor de gradiente de velocidades


[comps,sY,sX,sZ,timesteps]=size(U);

S=zeros(3,3,sY,sX,sZ,timesteps);

L=zeros(3,3,sY,sX,sZ);

for j=1:timesteps
   
        [L(1,1,:,:,:),L(1,2,:,:,:),L(1,3,:,:,:)]=gradient(squeeze(U(1,:,:,:,j)));
        [L(2,1,:,:,:),L(2,2,:,:,:),L(2,3,:,:,:)]=gradient(squeeze(U(2,:,:,:,j)));
        [L(3,1,:,:,:),L(3,2,:,:,:),L(3,3,:,:,:)]=gradient(squeeze(U(3,:,:,:,j)));
        
        S(:,:,:,:,:,j)=coorChange(L,sY,sX,sZ,dx,dy,dz);

end


%Ahora debemos cambiar las coordenadas de la derivada (dado que la malla 
%en la dirección y no es uniforme)




end


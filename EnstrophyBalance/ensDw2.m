function Dw = ensDw2(vort,sY,sX,sZ,timesteps,dx,dy,dz,t,T,nu)
%Este término tiene la forma nu*d_i*d_i*w_j*w_j por lo que debemos calcular el gradiente 
%de mean(w_iw_i), que es una cantidad escalar 





S=0;
for i=1:3

    S=S+squeeze(vort(i,:,:,:,:).^2);

end


%Calculamos el valor medio


%Debemos calcular el gradiente de esta cantidad 
size(S)
for j=1:timesteps
    [gCww(1,:,:,:,j),gCww(2,:,:,:,j),gCww(3,:,:,:,j)]=gradient(S(:,:,:,j));

end

%cambio de coordenadas

for l=1:timesteps
for j=1:sY
    for k=1:sZ
        
        %derivadas en x
          
        gCww(1,j,:,k,l)=squeeze(gCww(1,j,:,k,l))./dx; 
      
                         
    end
end

for i=1:sX
    for k=1:sZ
        %derivadas en y
    
        
        gCww(2,:,i,k,l)=squeeze(gCww(2,:,i,k,l))./dy';
        
    end
end

for i=1:sX
    for j=1:sY
        
         %derivadas en z
         gCww(3,j,i,:,l)=squeeze(gCww(3,j,i,:,l))./dz;
    
    end
end
end

%ahora tenemos una cantidad vectorial, a la cual le podemos calcular
%nuevamente el gradiente


ggCww=varGradient(gCww,dx,dy,dz);


%Calculamos el promedio de esta cantidad 

ggCww=tAvg(ggCww,t,T);


%Contraemos sobre los primeros dos indices
Dw=0;
for i=1:3
   Dw=Dw+squeeze(ggCww(i,i,:,:,:)); 
end

Dw=nu*0.5*Dw;

end


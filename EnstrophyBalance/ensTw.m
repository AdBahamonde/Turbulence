function Tw = ensTw(fU,fVort,dx,dy,dz,t,T)
%Este termino tiene la forma d_j u'_j w'_i w'_i. Podemos crear un tensor de
%rango 3 con los terminos u'_j w'_i w'_k y contraerlo en los segundos 2
%indices para obtener un tensor de rango 1, luego creamos con este tensor
%contraido otro tensor de rango 2 d_i u'_j (w'_k w'_k) y lo contraemos
%sobre i j.


Cuww=Corruvw(fU,fVort,fVort);

size(Cuww)
%Contracción sobre los indices 2 y 3,

S=0;
for i=1:3
    S=S+squeeze(Cuww(:,i,i,:,:,:,:));
end
%ahora calculamos el tensor de segundo orden que es el gradiente del
%anterior,

size(S)

gCuww=varGradient(S,dx,dy,dz); 

%Este deberia tener dimensiones (3,3,256,11,31,200), contraemos sobre los primeros 
%dos indices

Tw=0;
for i=1:3
    Tw=Tw+squeeze(gCuww(i,i,:,:,:,:));
end
%Calculamos el valor medio,


Tw=-0.5*tAvg(Tw,t,T);

end


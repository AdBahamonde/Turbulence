function Pm = ensPm(fVort,Sfluc,mVort,t,T)
%Contracción del tensor de correlación  de fluctuacion de vorticidad con fluctuación de vorticidad

%este tensor tiene la forma mean(w_i).*mean(w'_jS'_{i,j})
%Para calcular la segunda parte primero y luego sacar su promedio, debemos
%multiplicar para cada indice i la fluctuacion de la vorticidad, w_j con la
%fluctuación del gradiente de velocidades y luego realizar la contracción
%sobre el indice j, que es el primer indice del arreglo que contiene la fluctuación 
%de la velocidad


for i=1:3  
    CvfSf(i,:,:,:,:)=squeeze(sum(fVort.*squeeze(Sfluc(i,:,:,:,:,:)),1));
end

%Calculamos el medio en el tiempo

CvfSf=tAvg(CvfSf,t,T);


%Ahora se contrae el segundo indice con la vorticidad media

Pm=squeeze(sum(mVort.*CvfSf,1));

end


%este es un script para determinar todas las componentes del balance de
%enstrofia

%asumimos que empezamos con un conjunto de datos de velocidad de la forma 
%U(Componentes,X,Y,Z,T) 


%Primero determinamos los tamaños

U=permute(U,[1 3 2 4 5]);

[comps,sY,sX,sZ,timesteps]=size(U);

%[comps,sY,sX,sZ]=size(U);

%timesteps=1;

%Ahora separamos ésta velocidad entre sus fluctuaciones y su valor medio,
%para cada componente y en cada instante de tiempo, esto se denota por:

%mU: valor medio
%fU: fluctuacion


%se debe ingresar el timestep y el tiempo total de simulación, para el
%canal 

nu=5e-5;

dt=0.0065;

T=dt*(timesteps-1);

t=0:dt:T;


mU=tAvg(U,t,T);

fU=zeros(comps,sY,sX,sZ,timesteps);

for i=1:timesteps
    
   fU(:,:,:,:,i)=U(:,:,:,:,i)-mU;
   
end

%para calcular el balance de enstrofía también necesitaremos la vorticidad,
%para esto calculamos el gradiente de velocidad 





dx=diff(x);
dx=[dx;dx(length(dx))];
dy=diff(y);
dy=[dy;dy(length(dy))];
dz=diff(z);
dz=[dz;dz(length(dz))];

S=varGradient(U,dx,dy,dz);

%Deebemos notar que los gradientes son calculados con respecto a una
%diferencia unitaria, por lo que debemos adaptarlos según los intervalos
%utilizados en la simulación 



%A partir del tensor de gradiente de velocidades podemos calcular las
%componentes de la vorticidad,


vort=fluidVort(S);



mVort=trapz(t,vort,5)/T;

fVort=zeros(comps,sY,sX,sZ,timesteps);

for i=1:timesteps
    
   fVort(:,:,:,:,i)=vort(:,:,:,:,i)-mVort;
   
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%ahora calcularemos el balance para cada uno de los términos, para esto
%necesitamos calcular varios tensores, primero la correlación entre la
%fluctuación de la velocidad y la fluctuación de la vorticidad, Cuv

Pw=ensPw(fU,fVort,vort,t,T,dx,dy,dz);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Calculamos la producción turbulenta,

%Para esto primero debemos determinar la fluctuación del gradiente de
%velocidad,


Smean=tAvg(S,t,T);

for i=1:3
    for j=1:3
        for k=1:timesteps
            Sfluc(i,j,:,:,:,k)=squeeze(S(i,j,:,:,:,k))-squeeze(Smean(i,j,:,:,:));
        end
    end
end


%turbulent production

Pt=0;
for i=1:3
    for j=1:3
    Pt=Pt+squeeze(fVort(i,:,:,:,:)).*squeeze(fVort(j,:,:,:,:)).*squeeze(Sfluc(i,j,:,:,:,:));
    end
end

Pt=tAvg(Pt,t,T);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%mixed production



Pm = ensPm(fVort,Sfluc,mVort,t,T);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Production by mean gradient

Pmg = ensPmg(fVort,Smean,t,T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Disipación de Enstrophy: 


Dens = ensDens(fVort,dx,dy,dz,nu,t,T);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Transporte por fluctuaciones de la velocidad 

Tw = ensTw(fU,fVort,dx,dy,dz,t,T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Transporte viscoso

Dw=ensDw(fVort,sY,sX,sZ,timesteps,dx,dy,dz,t,T,nu);





plot(y,mean(Pw,[2 3]),'-^','Color','k','MarkerIndices', 1:5:length(y))
hold on
plot(y,mean(Pt,[2 3]),'-+','Color','k','MarkerIndices', 1:5:length(y))
plot(y,mean(Pm,[2 3]),'-s','Color','k','MarkerIndices', 1:5:length(y))
plot(y,mean(Pmg,[2 3]),'-o','Color','k','MarkerIndices', 1:5:length(y))
plot(y,mean(-Dens,[2 3]),'-x','Color','k','MarkerIndices', 1:5:length(y))
plot(y,mean(Tw,[2 3]),'-v','Color','k','MarkerIndices', 1:5:length(y))
plot(y,mean(Dw,[2 3]),'-v','MarkerEdgeColor','black',...
    'MarkerFaceColor','black','Color','black','MarkerIndices', 1:5:length(y))
xlim([-1 -0.8])
    ylim([-1000 1000])

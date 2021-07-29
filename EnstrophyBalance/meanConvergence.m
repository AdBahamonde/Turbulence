%Chequeo de convergencia del valor medio para Pw,


%este es un script para determinar todas las componentes del balance de
%enstrofia

%asumimos que empezamos con un conjunto de datos de velocidad de la forma 
%U(Componentes,X,Y,Z,T) 


%Primero determinamos los tamaños

U=permute(U,[1 3 2 4 5]);

Us=U;

[comps,sY,sX,sZ,Tsteps]=size(U);

%valor inicial Pwp
Pwp=0;

I=0;
for timesteps=2:100:4000
    
    I=I+1
tic
    U=Us(:,:,:,:,1:timesteps);



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

difMeanPw(I)=mean(Pw-Pwp,'all');
lineData(:,I)=Pw(:,5,5);


Pwp=Pw;
toc
end
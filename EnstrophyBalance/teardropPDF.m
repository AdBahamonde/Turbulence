%script para calcular el patron de Teardrop en la pdf de las invariantes
%del tensor de gradiente de velocidades R-Q 



%Solo necesitaremos el gradiente de velocidad y la vorticidad

U=permute(U,[1 3 2 4 5]);
dx=diff(x);
dx=[dx;dx(length(dx))];
dy=diff(y);
dy=[dy;dy(length(dy))];
dz=diff(z);
dz=[dz;dz(length(dz))];

S=varGradient(U,dx,dy,dz);

%se determina la parte simetrica del tensor de gradiente de velocidades
Ssym=symVelGrad(S);

Ssym=Ssym.^2;
%valor medio de Ssym

Ssym=mean(Ssym,'all');

%calcualmos la vorticidad


%calculamos las invariantes, lo que haremos a continuación es mantener
%distintos rangos de valores de ambas invariantes, con esto lo que buscamos
%es ver como afecta la pdf conjunta el agregar valores mas extremos,
%mantendremos valores desde [mean-std,mean+std] hasta [mean-4*std,mean+4*std]
%guardaremos el resultado en un video, se calcularan 60 intervalos

len=linspace(1,10,600);

VID=VideoWriter('velFilter.avi','Uncompressed AVI');
open(VID)

Qmain=Q_invariant(S,vort,Ssym);

Rmain=R_invariant(S,vort,Ssym);



for i=1:600
tic

R=Rmain;
Q=Qmain;

R=reshape(R,[],1);
Q=reshape(Q,[],1);

R(R<mean(R)+len(i)*std(R)==0)=[];
R(R>mean(R)-len(i)*std(R)==0)=[];

Q(Q<mean(Q)+len(i)*std(Q)==0)=[];
Q(Q>mean(Q)-len(i)*std(Q)==0)=[];

s=min(length(Q),length(R));

if s==length(Q)
    R=R(1:s);
else
    Q=Q(1:s);
end

data=[R Q];




[bandwidth,density,X,Y]=kde2d(data);
contour3(X,Y,density,20)
view(2)
xlim([-15 15])
ylim([-15 15])
frame=getframe(gcf);
writeVideo(VID,frame);
toc
end

close(VID)
function Pw = ensPw(fU,fVort,vort,t,T,dx,dy,dz)



gVm=varGradient(vort,dx,dy,dz);

gVm=tAvg(gVm,t,T);

Cuv=Corruv(fU,fVort);
Cuv=tAvg(Cuv,t,T);




%Ahora podemos determinar la producción debido al gradiente, Pw 
% (Gradient production)

Pw=0;
for i=1:3
    for j=1:3
    Pw=Pw+squeeze(Cuv(i,j,:,:,:)).*squeeze(gVm(j,i,:,:,:));
    end
end

Pw=-squeeze(Pw);


end


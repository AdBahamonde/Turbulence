function Dens = ensDens(fVort,dx,dy,dz,nu,t,T)

%Se calcula a partir del gradiente de la
%fluctuación de vorticidad, el gradiente se puede determinar facilmente a
%partir de la funcion varGradient


gVf=varGradient(fVort,dx,dy,dz);

%Ahora, el termino de disipación tiene la forma nu*mean(d_jw'_i d_jw'_i)
%donde nu es la viscosidad, es decir, solo debemos contraer producto del
%tensor consigo mismo sobre los primeros dos indices,

Dens=nu*squeeze(sum(gVf.*gVf,[1 2]));

Dens=tAvg(Dens,t,T);

end


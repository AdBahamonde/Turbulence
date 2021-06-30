function Pmg = ensPmg(fVort,Smean,t,T)
%este termino tiene la formna mean(w_i'w_j')*mean(S_{ij})
%Debemos determinar la correlación de la fluctuación de vorticidad,
%para esto podemos utilizar la misma funcion usada para calcular Cuv, 

Cww=Corruv(fVort,fVort);
Cww=tAvg(Cww,t,T);

%Ahora simplemente contraemos sobre los dos indices con el gradiente medio

Pmg=squeeze(sum(Cww.*Smean,[1 2]));

end


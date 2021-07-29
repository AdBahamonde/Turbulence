function [I,Hx,Hy] = mutualInf(X,Y,pdf2D)


%pdf2D son las distribuciones conjuntas de probabilidad
%pdf2D no necesariamente est� normalizada
%X e Y son los dominios 



%Para normalizar la funci�n de distribuci�n simplemente la integramos en el
%dominio


x=X(1,:); %Rango de valores de x
y=Y(:,1); %rango de valores de y


%A Partir de  la PDF mutua podemos obtener las PDF's marginales como,


pdfx=trapz(y,pdf2D,1);
pdfy=trapz(x,pdf2D,2);


%Ahora para determinar la informaci�n mutua realizamos la siguiente
%integral


int=pdf2D.*log(pdf2D./(pdfx.*pdfy));
int(isnan(int)==1)=0;

%Tambi�n podemos calcular de paso las entrop�as de cada variable

hx=pdfx.*log(pdfx);
hy=pdfy.*log(pdfy);

hx(isnan(hx)==1)=0;
hy(isnan(hy)==1)=0;

%y la informaci�n mutua es,


I=trapz(y,trapz(x,int,2));
Hx=trapz(x,hx);
Hy=trapz(y,hy);

end
function SMean = tAvg(S,t,T)
%Esta función asume que la dimension temporal es siempre la última del
%arreglo

n=ndims(S);

SMean=mean(S,n);


end


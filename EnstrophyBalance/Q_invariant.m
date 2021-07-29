function Q = Q_invariant(S,vort,Ssym)
Q=0;

for i=1:3
    for j=1:3
        Q=Q-(1/2)*squeeze(S(i,j,:,:,:,:)).*squeeze(S(j,i,:,:,:,:));
    end
end

%ahora se normaliza el valor de Q

Q=Q/Ssym;

end


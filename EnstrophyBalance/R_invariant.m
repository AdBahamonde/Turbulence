function R = R_invariant(S,vort,Ssym)


R=0;

for i=1:3
    for j=1:3
        for k=1:3
        
            R=R-1/3*(squeeze(S(i,j,:,:,:,:).*S(j,k,:,:,:,:).*S(k,i,:,:,:,:)));
            
        end
    end
end

R=R/Ssym^(3/2);


end


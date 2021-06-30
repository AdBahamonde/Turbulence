function [Ssym] = symVelGrad(S)

%extrae la parte simetrrica del gradiente de velocidades


for i=1:3
    for j=1:3
        Ssym(i,j,:,:,:,:)=0.5*(S(i,j,:,:,:,:)+S(j,i,:,:,:,:));
    end
end


end


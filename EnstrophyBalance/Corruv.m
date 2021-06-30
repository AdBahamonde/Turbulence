function Cuv = Corruv(fU,fVort)
%Tensor de correlación de la velocidad con la vorticidad



for i=1:3
    for j=1:3

        Cuv(i,j,:,:,:,:)=squeeze(fU(i,:,:,:,:)).*squeeze(fVort(j,:,:,:,:));

    end
end




end


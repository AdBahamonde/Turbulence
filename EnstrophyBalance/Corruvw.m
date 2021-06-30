function Cuvw = Corruvw(fU1,fU2,fU3)
%Tensor de correlación de la velocidad con la vorticidad



for i=1:3
    for j=1:3
        for k=1:3
        
            Cuvw(i,j,k,:,:,:,:)=squeeze(fU1(i,:,:,:,:)).*squeeze(fU2(j,:,:,:,:)).*squeeze(fU3(k,:,:,:,:));
        
        end

    end
end




end


function S = coorChange(S,sY,sX,sZ,dx,dy,dz)


for j=1:sY
    for k=1:sZ
        
        %derivadas en x
          
        S(1,1,j,:,k)=squeeze(S(1,1,j,:,k))./dx; 
        S(2,1,j,:,k)=squeeze(S(2,1,j,:,k))./dx;
        S(3,1,j,:,k)=squeeze(S(3,1,j,:,k))./dx;
                         
    end
end

for i=1:sX
    for k=1:sZ
        %derivadas en y
    
        S(1,2,:,i,k)=squeeze(S(1,2,:,i,k))./dy; 
        S(2,2,:,i,k)=squeeze(S(2,2,:,i,k))./dy;
        S(3,2,:,i,k)=squeeze(S(3,2,:,i,k))./dy;
    end
end

for i=1:sX
    for j=1:sY
        
         %derivadas en z
            
         S(1,3,j,i,:)=squeeze(S(1,3,j,i,:))./dz; 
         S(2,3,j,i,:)=squeeze(S(2,3,j,i,:))./dz;
         S(3,3,j,i,:)=squeeze(S(3,3,j,i,:))./dz;
    
    end
end

end


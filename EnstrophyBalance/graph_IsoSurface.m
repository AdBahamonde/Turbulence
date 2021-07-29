
STR{1}='Pw';
STR{2}='Pt';
STR{3}='Pm';
STR{4}='Pmg';
STR{5}='Dens';
STR{6}='Tw';
STR{7}='Dw';


for I=1:7
[f,v]=isosurface(X,Y,Z,eval(STR{I}),200);
sV=size(v,1);
a=zeros(sV,1);
for i=1:sV
          [m,m1]=min(abs(y-v(i,2)));
          [m,m2]=min(abs(x-v(i,1)));
          [m,m3]=min(abs(z-v(i,3)));
          a(i)=squeeze(fVort(1,m1,m2,m3,1));
end

p=patch('Faces',f,'Vertices',v);
p.EdgeColor='none';
p.FaceVertexCData = a; 
p.FaceColor = 'interp';
camlight right
lighting gouraud
daspect([10 1 1])

data=a;

eval(sprintf('[b,pdf%d,xPdf%d]=kde(data,2^10,min(data)-0.1*abs(min(data)),max(data)+0.1*abs(max(data)));',I,I))


end
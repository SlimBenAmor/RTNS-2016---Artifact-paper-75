function [ ComparaisonDist ] = infEgaleProba( F,G )
%   proposed probabilistic comparison 

ComparaisonDist=[1 2;0 0];
i=1;
j=1;
Fcum=0;
Gcum=0;
% compare two distributions value by value 
while (i<=size(F,2))&&(j<=size(G,2))
    if (F(1,i)<=G(1,j))  % Less or equal
        ComparaisonDist(2,1)=ComparaisonDist(2,1)+F(2,i)*(1-Gcum);
        Fcum=Fcum+F(2,i);
        i=i+1;
    else
        ComparaisonDist(2,2)=ComparaisonDist(2,2)+G(2,j)*(1-Fcum);
        Gcum=Gcum+G(2,j);
        j=j+1;
    end
end
end
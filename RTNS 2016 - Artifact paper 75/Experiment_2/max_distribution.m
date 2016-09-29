function [ u ] = max_distribution( f,g )
%   proposed probabilistic max operation

u=[];
i=size(f,2);
j=size(g,2);
Fcum=0;
Gcum=0;

% compare two distributions value by value and affect the corresponding
% probability
while (i>=1)&&(j>=1)
        if (f(1,i)>=g(1,j))
            u=add_value(u,f(:,i),[0;1-Gcum]);
            Fcum=Fcum+f(2,i);
            i=i-1;
        else
            u=add_value(u,g(:,j),[0;1-Fcum]);
            Gcum=Gcum+g(2,j);
            j=j-1;
        end
end
end

function [ G ] = generate_Graph(n)
% this function generates a precedence matrix G for n tasks system
% it divide tasks into layers then relate some task of a given layer to 
% some task of the next layer
G=zeros(n);
t=[];
N=n-2;

% divide into layers
while(N>0)
    if (N>2)
        t=[t randi(floor(N))];
        N=N-t(size(t,2));
    else
        t=[t N];
        N=0;
    end
end

% generate some precedence between layer
s=1;
G(1,:)=[0 ones(1,t(1)) zeros(1,n-t(1)-1)];
for i=1:size(t,2)
    R=round(rand(t(i),n-s-t(i)));
    for j=1:size(R,1)
        if (sum(R(j,:))==0)
            f=1+floor((size(R,2)-1)*rand);
            R(j,randperm(size(R,2),f))=1;
        end
    end
    G(s+1:s+t(i),s+t(i)+1:n)=R;
    s=s+t(i);
end
end
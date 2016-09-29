function [ u ] = coalescion( f,g )
%coalescion : coalesce two probabilities distributions f and g


%remove value with zero probability
if isempty(f)
    u=f;
else
    u=f(:,f(2,:)~=0);
end

if isempty(g)
    gg=g;
else
    gg=g(:,g(2,:)~=0);
end

%coalesce the two distributions
for i=1:size(gg,2)
    u=add_value(u,gg(:,i),[0;1]);
end
end

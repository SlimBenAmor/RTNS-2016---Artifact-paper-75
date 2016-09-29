function [ u ] = convolution( f,g )
%CONVOLUTION : calculate the resulting probability distribution 'u' after
%convolving two given probabilities distributions f and g

u=[];
for i=1:size(f,2)
    for j=1:size(g,2)
        u=add_value(u,f(:,i),g(:,j));
    end
end
end


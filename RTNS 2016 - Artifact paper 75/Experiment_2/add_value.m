function [ u ] = add_value( u,f,g )
% help to make the convolution by calculating the values sum and the 
% probabilities product then insert the result in the right place on the 
% resulting distribution

n=size(u,2);
x=zeros(2,1);
x(1,1)=f(1)+g(1); %values sum
x(2,1)=f(2)*g(2); % probabilities product

% insert the result with dichotomy method
if (n==0)
    u=x;
else if (x(1,1)<u(1,1))
    u=[x u];
    else if (x(1,1)>u(1,n))
        u=[u x];
        else if(x(1,1)==u(1,1))
            u(2,1)=u(2,1)+x(2,1);
            else if (x(1,1)==u(1,n))
                u(2,n)=u(2,n)+x(2,1);
                else
                    bi=1;
                    bs=n;
                    while(bs-bi>1)
                        m=fix((bs+bi)/2);
                        if (x(1,1)<u(1,m))
                            bs=m;
                        else if (x(1,1)>u(1,m))
                                bi=m;
                            else
                                bi=m;
                                bs=m;
                            end
                        end
                    end
                    if (x(1,1)==u(1,bi))
                        u(2,bi)=u(2,bi)+x(2,1);
                    else if (x(1,1)==u(1,bs))
                        u(2,bs)=u(2,bs)+x(2,1);
                        else
                            u=[u(:,1:bi) x u(:,bi+1:n)];
                        end
                    end
                end
            end
        end
    end
end
end
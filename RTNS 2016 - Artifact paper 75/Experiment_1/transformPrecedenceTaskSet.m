function [ T ] = transformPrecedenceTaskSet ( Tau,G )
    % modify release time and deadline of each task according to the min
    % and max proposed operations on the paper (equations 6 and 7)
    %Tau: cell of tasks
    % every task has Ci,Ai,Di distribution
    Nt=size(G,2);
    index=1:Nt;
    asignedD=zeros(1,Nt);
    asignedR=zeros(1,Nt);
    T=Tau;
    
    %modify deadline
    while(asignedD~=ones(1,Nt))
        for i=Nt:-1:1
            succ=index(G(i,:)==1);
            Nsucc=size(succ,2);
            if (isempty(succ))
                asignedD(i)=1;
            else
                if asignedD(succ)==ones(1,Nsucc) 
                    Cj=T{succ(1)}{1};
                    Cj(1,:)=-Cj(1,:);
                    Dc=convolution(T{succ(1)}{3},Cj);
                    D=min_distribution(T{i}{3},Dc);
                    for k=2:Nsucc
                        Cj=T{succ(k)}{1};
                        Cj(1,:)=-Cj(1,:);
                        Dc=convolution(T{succ(k)}{3},Cj);
                        D=min_distribution(D,Dc);
                    end
                    T{i}{3}=D;
                    asignedD(i)=1;
                end
            end
        end   
    end
    
    %modify release time
    while(asignedR~=ones(1,Nt))
        for i=1:Nt
            pred=index(G(:,i)==1);
            Npred=size(pred,2);
            if (isempty(pred))
                asignedR(i)=1;
            else
                if asignedR(pred)==ones(1,Npred)
                    Rc=convolution(T{pred(1)}{2},T{pred(1)}{1});
                    R=max_distribution(T{i}{2},Rc);
                    for k=2:Npred
                        Rc=convolution(T{pred(k)}{2},T{pred(k)}{1});
                        R=max_distribution(R,Rc);
                    end
                    T{i}{2}=R;
                    asignedR(i)=1;
                end
            end
        end   
    end
    
end
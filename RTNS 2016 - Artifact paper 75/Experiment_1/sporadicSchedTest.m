function [ dmp ,DMPmax] = sporadicSchedTest( Tau,threshold )
    %schedulability test algorithm (proposed probabilistic extension)
    %Tau: cell of tasks
    % every task has Ci,Ri,Di distribution
    N=size(Tau,2);
    dmp=0;
    DMPmax=0;
    DMP=zeros(N);
    for j=1:N
        for i=1:N
            S=[0;1];
            for k=1:N   % calculate the sum of Ck
				r=infEgaleProba(Tau{i}{2},Tau{k}{2});
				d=infEgaleProba(Tau{k}{3},Tau{j}{3});
                x=r(2,1)*d(2,1); 
                Ck=Tau{k}{1};
                S1=convolution(S,Ck);%Ck
                S1(2,:)=S1(2,:)*x;
                S2=S;
                S2(2,:)=S2(2,:)*(1-x);
                S=coalescion(S1,S2);                  
            end
            Ri=Tau{i}{2};
            Ri(1,:)=-Ri(1,:);
            W=convolution(Tau{j}{3},Ri);
            w=[0;sum(W(2,W(1,:)<=0))];
            w=coalescion(w, W(:,W(1,:)>0));
            comp=infEgaleProba(S,w);   % compare the sum of Ck to available execution window between Dj and Ri
            DMP(i,j)=comp(2,2);
            DMPmax=max(DMPmax,comp(2,2));
            if (comp(2,2)>threshold)
                dmp=1;
            end
        end
    end
end
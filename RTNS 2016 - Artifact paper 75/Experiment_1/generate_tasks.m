function [ T ] = generate_tasks(Nt,Nv,U )
% generate random probabilistic task set with Nt tasks and Nv value per
% distribution and with U system utilization .

T=cell(1,Nt);
Ut=UUnifast(Nt,U);
Dmax=1000+randi(9000,1);
C=fix(Dmax.*Ut)+Nv;
for i=1:Nt
    % generate execution time distribution 
    r=randperm(C(i),Nv);
    r=sort(r);
    Ci(1,:)=C(i)-ceil(0.1*r(1))+r;
    Ci(2,1)=0.8+rand/10;
    for j=2:Nv-1
        Ci(2,j)=Ci(2,j-1)*0.1;
    end
    Ci(2,Nv)=1-sum(Ci(2,1:Nv-1));
    T{i}{1}=Ci; 
    
    % generate release time distribution 
    if (i>1)
        t=randi(i-1);
        r=T{t}{2}(1,1)+T{t}{1}(1,1);
    else
        r=0;
    end 
    Ri(1,:)=2*i+randperm(10*Nt,Nv);
    Ri(1,:)=sort(Ri(1,:));
    Ri(2,:)=rand(1,Nv);
    Ri(2,:)=Ri(2,:)/sum(Ri(2,:));
    T{i}{2}=Ri;
end

% generate deadline distribution 
for i=Nt:-1:1
    if (i<Nt)
        t=i+randi(Nt-i);
        d=Dmax-T{t}{1}(1,1);
    else
        d=Dmax;
    end
    Di(1,:)=d+randperm(10*Nt,Nv);
    Di(1,:)=sort(Di(1,:));
    Di(2,:)=rand(1,Nv);
    Di(2,:)=Di(2,:)/sum(Di(2,:));
    T{i}{3}=Di;
end
end
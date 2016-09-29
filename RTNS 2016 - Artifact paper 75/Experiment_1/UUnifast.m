function [ Ut ] = UUnifast(Nt,U)
% algorithm used to share the available system utilization  U between Nt tasks

Ut=5*ones(1,Nt);
nextU=U;
for i=1:Nt-1
    rate=rand^(1/(Nt-i));
    Ut(i)=nextU*(1-rate);
    nextU=nextU-Ut(i);
end
Ut(Nt)=nextU;
end
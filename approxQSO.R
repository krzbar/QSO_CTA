rG<-function(n){rnorm(n,mean=0,sd=sqrt(1/2))}

approxQSO1indiv<-function(delta,alpha,m,vF,vG,n,rG){
    N<-as.integer(log((4*max(c(vF,(1-2^(-n))*vG/2)))/(alpha*delta^2)))+1
    UjN<-sapply(0:(N-1),function(j){mean(rG(2^(j)))})
    m+sum(UjN)
}

approxQSO1forpop<-function(N,m,rG){
    UjN<-sapply(0:(N-1),function(j){mean(rG(2^(j)))})
    m+sum(UjN)
}


approxQSOpop<-function(delta,alpha,m,vF,vG,n,popsize,rG,BonferroniCorrect=TRUE){
    if (BonferroniCorrect){alpha<-alpha/popsize}
    N<-as.integer(log((4*max(c(vF,(1-2^(-n))*vG/2)))/(alpha*delta^2)))+1
    print(N)
    sapply(rep(N,popsize),approxQSO1forpop,m=m,rG=rG,simplify=TRUE)
}


#n=1,100,500, exp(1), n(0,1)
popsize<-10000
alpha<-
vG<-1
vF<-1
mnorm<-0
mexp<-1
delta<-0.01
alpha<-0.05

#Pop1expBF<-approxQSOpop(delta,alpha,mexp,vF,vG,n=1,popsize,rG,BonferroniCorrect=FALSE)
#save(Pop1expBF,file="file01.RData")
#Pop100expBF<-approxQSOpop(delta,alpha,mexp,vF,vG,n=100,popsize,rG,BonferroniCorrect=FALSE)
#save(Pop100expBF,file="file02.RData")
#Pop500expBF<-approxQSOpop(delta,alpha,mexp,vF,vG,n=500,popsize,rG,BonferroniCorrect=FALSE)
#save(Pop500expBF,file="file03.RData")
#Pop1normBF<-approxQSOpop(delta,alpha,mnorm,vF,vG,n=1,popsize,rG,BonferroniCorrect=FALSE)
#save(Pop1normBF,file="file04.RData")
#Pop100normBF<-approxQSOpop(delta,alpha,mnorm,vF,vG,n=100,popsize,rG,BonferroniCorrect=FALSE)
#save(Pop100normBF,file="file05.RData")
#Pop500normBF<-approxQSOpop(delta,alpha,mnorm,vF,vG,n=500,popsize,rG,BonferroniCorrect=FALSE)
#save(Pop500normBF,file="file06.RData")





#Pop1expBT<-approxQSOpop(delta,alpha,mexp,vF,vG,n=1,popsize,rG,BonferroniCorrect=TRUE)
#save(Pop1expBT,file="file07.RData")
#Pop100expBT<-approxQSOpop(delta,alpha,mexp,vF,vG,n=100,popsize,rG,BonferroniCorrect=TRUE)
#save(Pop100expBT,file="file08.RData")
#Pop500expBT<-approxQSOpop(delta,alpha,mexp,vF,vG,n=500,popsize,rG,BonferroniCorrect=TRUE)
#save(Pop500expBT,file="file09.RData")


Pop1normBT<-approxQSOpop(delta,alpha,mnorm,vF,vG,n=1,popsize,rG,BonferroniCorrect=TRUE)
save(Pop1normBT,file="file10.RData")
Pop100normBT<-approxQSOpop(delta,alpha,mnorm,vF,vG,n=100,popsize,rG,BonferroniCorrect=TRUE)
save(Pop100normBT,file="file11.RData")
Pop500normBT<-approxQSOpop(delta,alpha,mnorm,vF,vG,n=500,popsize,rG,BonferroniCorrect=TRUE)
save(Pop500normBT,file="file12.RData")



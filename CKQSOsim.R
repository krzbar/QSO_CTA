## This file accompanies the manuscript: 
## Bartoszek, Pulka "Approximately simulating quadratic stochastic operators"

## This software comes AS IS in the hope that it will be useful WITHOUT ANY WARRANTY, 
## NOT even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
## Please understand that there may still be bugs and errors. Use it at your own risk. 
## We take no responsibility for any errors or omissions in this code or for any misfortune 
## that may befall you or others as a result of its use. Please send comments and report 
## bugs to Krzysztof Bartoszek at krzbar@protonmail.ch .

.f_KQSO_pop_traj<-function(fQ,n,f0,pop_size,...){
    lpars<-list(...)[[1]]
    d<-1
    i<-1
    qso_pops<-matrix(NA,ncol=pop_size,nrow=n)
    if (!is.null(lpars$f0)){population<-f0(pop_size,lpars$f0)}
    else{population<-f0(pop_size)}
    qso_pops[i,]<-population
    i<-2
    while (i<=n){
        population<-replicate(pop.size,.f_KQSO_draw_el_pop(population,fQ,lpars))
        qso_pops[i,]<-population
        i<-i+1
    }
    if (!is.null(lpars$outfile)){
        write.table(qso_pops,file=lpars$outfile,quote=FALSE,row.names = FALSE, col.names = FALSE)
    }
    qso.pops
}


.f_KQSO_draw_el_pop<-function(population,fQ,...){
    lpars<-list(...)[[1]]
    xy<-sample(population,2,replace=FALSE)
    fQ(xy[1],xy[2],lpars)
}


f_KQSO_pop_traj_sample<-function(N,fQ,n,f0,pop_size,...){
    lpars<-list(...)
    qso_samp<-replicate(N,.f_KQSO_pop_traj(fQ,n,f0,pop_size,lpars),simplify=FALSE)
    qso_samp
}


f_CKQSO_approx_sample<-function(delta,alpha,m,vF,vG,n,rG){
## rG, returns a vector of sampled values
    N<-as.integer(log((4*max(c(vF,(1-2^(-n))*vG/2)))/(alpha*delta^2)))+1
    UjN<-sapply(0:(N-1),function(j){mean(rG(2^(j)))})
    m+sum(UjN)
}

.f_CKQSO_approx_pop_sample<-function(N,m,rG){
## rG, returns a vector of sampled values
    UjN<-sapply(0:(N-1),function(j){mean(rG(2^(j)))})
    m+sum(UjN)
}


f_CKQSO_approx_pop_sample_calcN<-function(delta,alpha,m,vF,vG,n,popsize,rG,BonferroniCorrect=TRUE){
## rG, returns a vector of sampled values
    if (BonferroniCorrect){alpha<-alpha/popsize}
    N<-as.integer(log((4*max(c(vF,(1-2^(-n))*vG/2)))/(alpha*delta^2)))+1
    print(N)
    sapply(rep(N,popsize),.f_CKQSO_approx_pop_sample,m=m,rG=rG,simplify=TRUE)
}

f_CKQSO_sample<-function(n,rG,rF){
## rG, rF return a vector of sampled values
    UjN<-sapply(0:(n-1),function(j){mean(rG(2^(j)))})
    Xn<-mean(rF(2^n))
    Xn+sum(UjN)
}

f_CKQSO_kernel_norm_05<-function(x,y,...){rnorm(1,mean=(x+y)/2,sd=sqrt(0.5))}

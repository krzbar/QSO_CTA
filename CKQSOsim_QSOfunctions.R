## This file accompanies the manuscript: 
## Bartoszek, Pulka "Approximately simulating quadratic stochastic operators"

## This software comes AS IS in the hope that it will be useful WITHOUT ANY WARRANTY, 
## NOT even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
## Please understand that there may still be bugs and errors. Use it at your own risk. 
## We take no responsibility for any errors or omissions in this code or for any misfortune 
## that may befall you or others as a result of its use. Please send comments and report 
## bugs to Krzysztof Bartoszek at krzbar@protonmail.ch .

.f_KQSO_pop_traj<-function(rG,n,rF,pop_size,...){
    lpars<-list(...)[[1]]
    d<-1
    i<-1
    qso_pops<-matrix(NA,ncol=pop_size,nrow=n)
    if (!is.null(lpars$rF)){population<-rF(pop_size,lpars$rF)}
    else{population<-rF(pop_size)}
    qso_pops[i,]<-population
    i<-2
    while (i<=n){
        population<-replicate(pop_size,.f_KQSO_draw_el_pop(population,rG,lpars))
        qso_pops[i,]<-population
        i<-i+1
    }
    if (!is.null(lpars$outfile)){
        write.table(qso_pops,file=lpars$outfile,quote=FALSE,row.names = FALSE, col.names = FALSE)
    }
    qso_pops
}


.f_KQSO_draw_el_pop<-function(population,rG,...){
    lpars<-list(...)[[1]]
    xy<-sample(population,2,replace=FALSE)
    rG(xy[1],xy[2],lpars)
}


f_KQSO_pop_traj_sample<-function(rG,n,rF,pop_size,...){
    lpars<-list(...)
    qso_samp<-.f_KQSO_pop_traj(rG,n,rF,pop_size,lpars)
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


f_CKQSO_approx_pop_sample_calcN<-function(delta,alpha,m,vF,vG,n,pop_size,rG,BonferroniCorrect=TRUE){
## rG, returns a vector of sampled values
    if (BonferroniCorrect){alpha<-alpha/pop_size}
    N<-min(n,as.integer(log((4*max(c(vF,(1-2^(-n))*vG/2)))/(alpha*delta^2)))+1)
    print(N)
    sapply(rep(N,pop_size),.f_CKQSO_approx_pop_sample,m=m,rG=rG,simplify=TRUE)
}

f_CKQSO_sample<-function(n,rG,rF){
## rG, rF return a vector of sampled values
    UjN<-sapply(0:(n-1),function(j){mean(rG(2^(j)))})
    Xn<-mean(rF(2^n))
    Xn+sum(UjN)
}

## Collection of kernel and seed functions
f_CKQSO_kerneldist_norm_05<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(0.5))}
f_CKQSO_kernel_norm_05<-function(x,y,...){rnorm(1,mean=(x+y)/2,sd=sqrt(0.5))}
f_CKQSO_seed_norm_0_1<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(1))}
f_CKQSO_seed_norm_0_10<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(10))}
f_CKQSO_seed_norm_1_1<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(1))}
f_CKQSO_seed_norm_1_10<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(10))}
f_CKQSO_seed_norm_0_01<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(0.1))}
f_CKQSO_seed_norm_1_01<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(0.1))}
f_CKQSO_seed_exp_1<-function(numsim,...){rexp(numsim,rate=1)}
f_CKQSO_seed_exp_10<-function(numsim,...){rexp(numsim,rate=10)}
f_CKQSO_seed_exp_01<-function(numsim,...){rexp(numsim,rate=0.1)}


# l_kernel_functions<-
# l_seed_functions<-
# v_n<-
# v_pop_size<-
# v_delta<-
# v_alpha<-
# 
# l_setups<-Cartesian_product_lists(l_kernel_functions,l_seed_functions,v_n,v_pop_size,v_delta,v_alpha)
# 
# f_CKQSO_kernel_norm_05<-function(x,y,...){rnorm(1,mean=(x+y)/2,sd=sqrt(0.5))}
# f_CKQSO_seed_norm_0_1<-function(x,y,...){rnorm(1,mean=0,sd=sqrt(1))}
# f_CKQSO_seed_norm_0_10<-function(x,y,...){rnorm(1,mean=0,sd=sqrt(10))}
# f_CKQSO_seed_norm_1_1<-function(x,y,...){rnorm(1,mean=0,sd=sqrt(1))}
# f_CKQSO_seed_norm_1_10<-function(x,y,...){rnorm(1,mean=0,sd=sqrt(10))}
# f_CKQSO_seed_norm_0_01<-function(x,y,...){rnorm(1,mean=0,sd=sqrt(0.1))}
# f_CKQSO_seed_norm_1_01<-function(x,y,...){rnorm(1,mean=0,sd=sqrt(0.1))}
# f_CKQSO_seed_exp_1<-function(x,y,...){rexp(1,rate=1)}
# f_CKQSO_seed_exp_10<-function(x,y,...){rexp(1,rate=10)}
# f_CKQSO_seed_exp_01<-function(x,y,...){rexp(1,rate=0.1)}

## =============================================================================


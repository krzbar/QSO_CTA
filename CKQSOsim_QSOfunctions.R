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

f_dosimulation_forparamset<-function(n,pop_size,delta,alpha,rG,rG_pop,vG,rF,vF,m,b_dosimul,b_doplot,b_dosave,c_fileprefix,otherparams,res_exact,res_approxBT,res_approxBF,res_popAlg,legendpos="topleft",b_replicate=FALSE,b_save_seeds=TRUE){
    rexp(1)
    RNG_kind<-RNGkind()
    RNG_version<-getRversion()
    Rseed_exact<-NA
    Rseed_approxBT<-NA
    Rseed_approxBF<-NA
    Rseed_popAlg<-NA
    if (b_replicate){
	load(paste0(c_fileprefix,".RData"))
	RNGkind(kind = RNG_kind[1], normal.kind = RNG_kind[2], sample.kind = RNG_kind[3])
	RNGversion(RNG_version)
    }
    if(b_dosimul){
        if (b_replicate){
	    .Random.seed<-Rseed_exact
	}
	Rseed_exact<-.Random.seed
	res_exact<-replicate(pop_size,f_CKQSO_sample(n=n,rG=rG,rF=rF),simplify=TRUE)
    }
    d_res_exact<-density(norm0_1norm05_exact)
    print("======================")
    if(b_dosimul){
        if (b_replicate){
	    .Random.seed<-Rseed_approxBT
	}
	Rseed_approxBT<-.Random.seed
	res_approxBT<-f_CKQSO_approx_pop_sample_calcN(delta,alpha,m,vF,vG,n,pop_size,rG,BonferroniCorrect=TRUE)
    }
    d_res_approxBT<-density(norm0_1norm05_approxBT)
    print("======================")
    if(b_dosimul){
	if (b_replicate){
	    .Random.seed<-Rseed_approxBF
	}
	Rseed_approxBF<-.Random.seed
	res_approxBF<-f_CKQSO_approx_pop_sample_calcN(delta,alpha,m,vF,vG,n,pop_size,rG,BonferroniCorrect=FALSE)
    }
    d_res_approxBF<-density(norm0_1norm05_approxBF)
    print("======================")
    if(b_dosimul){
	if (b_replicate){
	    .Random.seed<-Rseed_popAlg
	}
	Rseed_popAlg<-.Random.seed
	res_popAlg<-f_KQSO_pop_traj_sample(rG_pop,n,rF,pop_size)
    }
    d_res_popAlg<-density(res_popAlg)


    if (b_doplot){
        v_xlim<-c(min(c(d_res_popAlg$x,d_res_exact$x,d_res_approxBT$x,d_res_approxBF$x)),max(c(d_res_popAlg$x,d_res_exact$x,d_res_approxBT$x,d_res_approxBF$x)))
	v_ylim<-c(min(c(d_res_popAlg$y,d_res_exact$y,d_res_approxBT$y,d_res_approxBF$y)),max(c(d_res_popAlg$y,d_res_exact$y,d_res_approxBT$y,d_res_approxBF$y)))
        pdf(paste0(c_fileprefix,".pdf"))
        plot(NA,xlim=v_xlim,ylim=v_ylim,xlab="",ylab="") 
        points(d_res_exact$x,d_res_exact$y,col=gray(0.9),type="l",lty=1,lwd=7)
	points(d_res_approxBF$x,d_res_approxBF$y,col=gray(0.7),type="l",lty=1,lwd=5)
        points(d_res_approxBT$x,d_res_approxBT$y,col=gray(0.5),type="l",lty=1,lwd=3)
        points(d_res_popAlg$x,d_res_popAlg$y,col="black",type="l",lty=1,lwd=1)
	legend(legendpos,legend=c("Alg. 2 (exact)","Alg. 3","Alg. 3 (with Rem. 2 correction)","Alg. 1"),pch=19,col=c(gray(0.9),gray(0.7),gray(0.5),"black"),bty="n")
        dev.off()
    }
    if (b_save_seeds){save(RNG_kind,RNG_version,Rseed_exact,Rseed_approxBT,Rseed_approxBF,Rseed_popAlg,d_res_popAlg,d_res_exact,d_res_approxBT,d_res_approxBF,res_exact,res_approxBT,res_approxBF,res_popAlg,file=paste0(c_fileprefix,".RData"))}
    else{save(d_res_popAlg,d_res_exact,d_res_approxBT,d_res_approxBF,res_exact,res_approxBT,res_approxBF,res_popAlg,file=paste0(c_fileprefix,".RData"))}
    list(RNG_kind=RNG_kind,RNG_version=RNG_version,Rseed_exact=Rseed_exact,Rseed_approxBT=Rseed_approxBT,Rseed_approxBF=Rseed_approxBF,Rseed_popAlg=Rseed_popAlg,d_res_popAlg=d_res_popAlg,d_res_exact=d_res_exact,d_res_approxBT=d_res_approxBT,d_res_approxBF=d_res_approxBF,res_exact=res_exact,res_approxBT=res_approxBT,res_approxBF=res_approxBF,res_popAlg=res_popAlg)
}

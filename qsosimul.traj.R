.r.qso.L1.traj<-function(fQ,n,f0,pop.size,...){
    lpars<-list(...)[[1]]
    d<-1
    i<-1
    qso.pops<-matrix(NA,ncol=pop.size,nrow=n)
    if (!is.null(lpars$f0)){population<-f0(pop.size,lpars$f0)}
    else{population<-f0(pop.size)}
    qso.pops[i,]<-population
    i<-2
    while (i<=n){
	population<-replicate(pop.size,.qso.draw.el.pop(population,fQ,lpars))
        qso.pops[i,]<-population
	i<-i+1
    }
    if (!is.null(lpars$outfile)){
	write.table(qso.pops,file=lpars$outfile,quote=FALSE,row.names = FALSE, col.names = FALSE)
    }
    qso.pops
}


.qso.draw.el.pop<-function(population,fQ,...){
    lpars<-list(...)[[1]]
    xy<-sample(population,2,replace=FALSE)
    fQ(xy[1],xy[2],lpars)
}


r.qso.l1.traj.sample<-function(N,fQ,n,f0,pop.size,...){
    lpars<-list(...)
    qso.samp<-replicate(N,.r.qso.L1.traj(fQ,n,f0,pop.size,lpars),simplify=FALSE)
    qso.samp
}


r.q.kernel.norm1<-function(x,y,...){rnorm(1,mean=(x+y)/2,sd=sqrt(0.5))}

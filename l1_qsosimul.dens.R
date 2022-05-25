.r.qso.l1.dens<-function(lQ,n,vy){
    i<-1
    qso.tr<-rep(NA,length(vy))
    currprob<-vy
    d<-nrow(lQ[[1]])
    while (i<=n){
	qso.tr[i]<-sample(1:d,1,prob=currprob)
	prevprob<-currprob
	currprob<-sapply(lQ[-d],function(mQ,vprob){vprob%*%mQ%*%vprob},vprob=currprob,simplify=TRUE)
	if (sum(currprob[-d])<1){currprob[d]<-1-sum(currprob[-d])}
	else{
	    currprob[d]<-prevprob%*%lQ[[d]]%*%prevprob
	    currprob<-currprob/sum(currprob)
	}
	i<-i+1
    }
    qso.tr
}


r.qso.l1.dens.sample<-function(N,lQ,n,vy){
    qso.samp<-replicate(N,.r.qso.l1.dens(lQ,n,vy))
    qso.samp
}


lQ.ex4<-list(rbind(c(1,0.5),c(0.5,1)),rbind(c(0,0.5),c(0.5,0)))
lQ.df7<-list(rbind(c(1,0.5),c(0.5,0)),rbind(c(0,0.5),c(0.5,1)))

lQ.3.1<-list(rbind(c(0.2,0.2,0.25),c(0.2,0.3,0.5),c(0.25,0.5,0.25)),
	     rbind(c(0.2,0.6,0.25),c(0.6,0.4,0.2),c(0.25,0.2,0.55)),
	     rbind(c(0.6,0.2,0.5),c(0.2,0.3,0.3),c(0.5,0.3,0.2)))
c3<-0.6
#d3<-0.4
lQ.3.2<-list(rbind(c(0,0,0),c(0,0,1),c(0,1,c3)),rbind(c(0,0,1),c(0,0,0),c(1,0,1-c3)),rbind(c(1,1,0),c(1,1,0),c(0,0,0)))


lQ.Zach<-list(
	     rbind(c(1,1,0),c(1,0,0),c(0,0,0)),
	     rbind(c(0,0,0),c(0,1,1),c(0,1,0)),
	     rbind(c(0,0,1),c(0,0,0),c(1,0,1)))

lQ.Zachmod<-list(
	     rbind(c(1,0.75,0),c(0.75,0,0),c(0,0,0.5)),
	     rbind(c(0,0,0),c(0,1,0.75),c(0,0.75,0)),
	     rbind(c(0,0.25,1),c(0.25,0,0.25),c(1,0.25,0.5)))

lQ.Gani<-list(
	rbind(c(0.913,0.304,0.491,0.496),c(0.304,0.011,0.086,0.014),c(0.491,0.086,0.108,0.219),c(0.496,0.014,0.219,0.010)),
	rbind(c(0.005,0.361,0.152,0.013),c(0.361,0.925,0.650,0.521),c(0.152,0.650,0.081,0.211),c(0.013,0.521,0.211,0.010)),
	rbind(c(0.005,0.326,0.326,0.013),c(0.326,0.011,0.213,0.009),c(0.326,0.213,0.798,0.209),c(0.013,0.009,0.209,0.007)),
	rbind(c(0.077,0.031,0.031,0.478),c(0.031,0.053,0.051,0.456),c(0.031,0.051,0.013,0.361),c(0.478,0.456,0.361,0.973))
)


fQ.createP<-function(P){
    d<-nrow(P)
    sapply(1:d,function(k,d,P){x<-P[,k];(matrix(x,ncol=d,nrow=d,byrow=TRUE)+matrix(x,ncol=d,nrow=d,byrow=FALSE))/2},d=d,P=P,simplify=FALSE)
}

findstationaryprob<-function(lQ,v0=NULL){
    d<-nrow(lQ[[1]])
    if (is.null(v0)){v0<-runif(d);v0<-v0/sum(v0)}
    optres<-optim(log(v0[-d]),function(par,lQ){
	    par<-exp(par);
	    res<-Inf
	    if(sum(par)<=1){
		par<-c(par,1-sum(par))
		res<-sum(abs(par-sapply(lQ,function(mQ,vprob){vprob%*%mQ%*%vprob},vprob=par,simplify=TRUE)))
	    }
	    res
	},lQ=lQ)
    vprob<-exp(optres$par)	
##    vprob<-optres$par
    vprob<-c(vprob,1-sum(vprob))
    list(vprob,optres) 
}

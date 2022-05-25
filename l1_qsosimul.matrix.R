.r.qso.l1.matrix<-function(lQ,n,vy){
    i<-1
    d<-nrow(lQ[[1]])
    qso.probs<-matrix(NA,ncol=d,nrow=n)
    currprob<-vy

    while (i<=n){
	qso.probs[i,]<-currprob
	prevprob<-currprob
	currprob<-sapply(lQ[-d],function(mQ,vprob){vprob%*%mQ%*%vprob},vprob=currprob,simplify=TRUE)
	if (sum(currprob[-d])<1){currprob[d]<-1-sum(currprob[-d])}
	else{
	    currprob[d]<-prevprob%*%lQ[[d]]%*%prevprob
	    currprob<-currprob/sum(currprob)
	}
	i<-i+1
    }
    qso.probs
}


r.qso.l1.matrix.sample<-function(lQ,n,vy){
    .r.qso.l1.matrix(lQ,n,vy)
}


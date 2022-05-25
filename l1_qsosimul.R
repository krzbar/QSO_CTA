.r.qso.l1.tr<-function(Q,n,vx,vy,mixtype){
    i<-1
    x<-sample(length(vx),1,prob=vx)
    y<-sample(length(vy),1,prob=vy)
    qso.tr<-rep(NA,n)
    while (i<=n){
	pr<-Q(x,y)
	y<-sample(1:length(pr),1,prob=pr)
	qso.tr[i]<-y
	POMYSL O DEFINICJI JAK TO ZROBIC
	if (mixtype=="othermix"){x<-sample(1:length(vx),1,prob=vx)} 
	if (mixtype=="normmix"){x<-sample(1:length(pr),1,prob=pr)}
	i<-i+1
    }
    qso.tr
}


r.qso.l1.sample<-function(N,Q,n,vx,vy,mixtype){
    qso.samp<-replicate(N,.r.qso.l1.tr(Q,n,vx,vy,mixtype))
    qso.samp
}


Q.ex4<-function(x,y){if(x==1){P<-rbind(c(1,0),c(0.5,0.5))}else{P<-rbind(c(0.5,0.5),c(1,0))};P[y,]}
Q.ex6<-function(x,y){if(x==1){P<-rbind(c(0,1),c(1,0))}else{P<-rbind(c(1,0),c(1,0))};P[y,]}
##Q.ex7 ## bez sensu bo zawsze 1 wylosowane
Q.ex8<-function(x,y){if(x==1){P<-rbind(c(1,0),c(1,0))}else{P<-rbind(c(1,0),c(0,1))};P[y,]}
Q.Gani<-function(x,y){
    if(x==1){P<-rbind(c(0.913,0.005,0.005,0.077),c(0.304,0.361,0.326,0.031),c(0.491,0.152,0.326,0.031),c(0.496,0.013,0.013,0.478))};
    if(x==2){P<-rbind(c(0.304,0.361,0.326,0.031),c(0.011,0.925,0.011,0.053),c(0.086,0.650,0.213,0.051),c(0.014,0.521,0.009,0.456))};
    if(x==3){P<-rbind(c(0.491,0.152,0.326,0.031),c(0.086,0.650,0.213,0.051),c(0.108,0.081,0.798,0.013),c(0.219,0.211,0.209,0.361))};
    if(x==4){P<-rbind(c(0.496,0.013,0.013,0.478),c(0.014,0.521,0.009,0.456),c(0.219,0.211,0.209,0.361),c(0.010,0.010,0.007,0.973))};
    P[y,]
}

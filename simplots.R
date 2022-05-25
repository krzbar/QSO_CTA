dosimplot<-function(fileprefix,dens,mat,traj,vstat=NULL,vylim=NULL,vlegs=NULL){
    d<-ncol(dens)
    n<-nrow(dens)
    if (is.null(vylim)){vylim<-replicate(d,c(0,1),simplify=FALSE)}
    for (i in 1:d){
	pdf(paste(fileprefix,i,".pdf",sep=""))
	plot(1:n,dens[,i],ylim=vylim[[i]],main="",xlab="n",ylab="",pch=19,col=gray(0),cex=1.6)
	points(1:n,mat[,i],pch=17,col=gray(0.4),cex=1.2)
	points(1:n,traj[,i],pch=15,col=gray(0.7),cex=0.8)	
	if (!is.null(vstat)){abline(h=vstat[i])}
	if (!is.null(vlegs)){
	    if (!is.null(vstat)){
		legend(vlegs[i],col=c(gray(0),gray(0.4),gray(0.7),gray(0)),pch=c(19,17,15,NA),lty=c(NA,NA,NA,1),legend=c(expression(paste("sampling from ",Q[y]^(n))),expression(Q[y]^(n)),"population simulation","stationary probability"),bty="n")
	    }else{
		legend(vlegs[i],col=c(gray(0),gray(0.4),gray(0.7)),pch=c(19,17,15),legend=c(expression(paste("sampling from ",Q[y]^(n))),expression(Q[y]^(n)),"population simulation"),bty="n")
	    }
	}
	dev.off()
    }
    if (!is.null(vstat)){
	pdf(paste(fileprefix,"L2dist.pdf",sep=""))
	densdist<-apply(dens,1,function(x,vstat){sqrt(sum((x-vstat)^2))},vstat=vstat)
	matdist<-apply(mat,1,function(x,vstat){sqrt(sum((x-vstat)^2))},vstat=vstat)
	trajdist<-apply(traj,1,function(x,vstat){sqrt(sum((x-vstat)^2))},vstat=vstat)
	plot(1:n,densdist,ylim=vylim[[d+1]],main="",xlab="n",ylab="",pch=19,col=gray(0),cex=1.6)
	points(1:n,matdist,pch=17,col=gray(0.4),cex=1.2)
	points(1:n,trajdist,pch=15,col=gray(0.7),cex=0.8)
	legend("topright",col=c(gray(0),gray(0.4),gray(0.7)),pch=c(19,17,15),legend=c(expression(paste("sampling from ",Q[y]^(n))),expression(Q[y]^(n)),"population simulation"),bty="n")
	dev.off()
   }
}


load("Simdf73.RData")
load("Simdf74.RData")
load("NonSimdf7.RData")
#dosimplot(fileprefix="Qex4",dens=tabqsamp.dens.ex4[1:200,],mat=qsamp.matrix.ex4[1:200,],traj=qsamp.traj.ex4[[1]][1:200,],vstat=c(1,0),vylim=list(c(0.8,1),c(0,0.2),c(0,0.2)),vlegs=c("bottomright","topright"));
#dosimplot(fileprefix="Q31",dens=tabqsamp.dens.3.1[1:200,],mat=qsamp.matrix.3.1[1:200,],traj=qsamp.traj.3.1[[1]][1:200,],vstat=c(findstationaryprob(lQ.3.1)[[1]]),vylim=list(c(0.2,0.4),c(0.2,0.4),c(0.2,0.4),c(0,0.1)),vlegs=c("bottomright","bottomright","bottomright"));
#dosimplot(fileprefix="Q32",dens=tabqsamp.dens.3.2[1:200,],mat=qsamp.matrix.3.2[1:200,],traj=qsamp.traj.3.2[[1]][1:200,],vstat=c(findstationaryprob(lQ.3.2)[[1]]),vylim=list(c(0,1),c(0,1),c(0,1),c(0,1)),vlegs=c("topright","topright","right"));
#dosimplot(fileprefix="QGani",dens=tabqsamp.dens.Gani[1:500,],mat=qsamp.matrix.Gani[1:500,],traj=qsamp.traj.Gani[[1]][1:500,],vstat=c(findstationaryprob(lQ.Gani)[[1]]),vylim=list(c(0,0.4),c(0.2,0.6),c(0,0.4),c(0,0.4),c(0,0.4)),vlegs=c("topright","right","topright","bottomright"));
#dosimplot(fileprefix="Zach1",dens=tabqsamp.dens.Zach1[,],mat=qsamp.matrix.Zach1[,],traj=qsamp.traj.Zach1[[1]][,],vstat=c(1/3,1/3,1/3),vylim=list(c(0,1),c(0,1),c(0,1),c(0,1)),vlegs=c("center","right","center"));
#dosimplot(fileprefix="Zach2",dens=tabqsamp.dens.Zach2[,],mat=qsamp.matrix.Zach2[,],traj=qsamp.traj.Zach2[[1]][,],vstat=c(1/3,1/3,1/3),vylim=list(c(0,1),c(0,1),c(0,1),c(0,1)),vlegs=c("topright","right","right"));
#dosimplot(fileprefix="Zach12",dens=tabqsamp.dens.Zach1.2[,],mat=qsamp.matrix.Zach1.2[,],traj=qsamp.traj.Zach1.2[[1]][,],vstat=c(1/3,1/3,1/3),vylim=list(c(0,1),c(0,1),c(0,1),c(0,1)),vlegs=c("center","right","center"));
#dosimplot(fileprefix="Zach22",dens=tabqsamp.dens.Zach2.2[,],mat=qsamp.matrix.Zach2.2[,],traj=qsamp.traj.Zach2.2[[1]][,],vstat=c(1/3,1/3,1/3),vylim=list(c(0,1),c(0,1),c(0,1),c(0,1)),vlegs=c("topright","right","right"));

#mP<-rbind(c(0.15,0.3,0.55),c(0.1,0.9,0),c(0.05,0.15,0.8))
#dosimplot(fileprefix="Zachmod1",dens=tabqsamp.dens.Zachmod1[,],mat=qsamp.matrix.Zachmod1[,],traj=qsamp.traj.Zachmod1[[1]][,],vstat=c(findstationaryprob(lQ.Zachmod)[[1]]),vylim=list(c(0.25,0.38),c(0,0.4),c(0.2,0.7),c(0,0.6)),vlegs=c("bottomright","topright","bottomright"));
#dosimplot(fileprefix="Zachmod2",dens=tabqsamp.dens.Zachmod2[,],mat=qsamp.matrix.Zachmod2[,],traj=qsamp.traj.Zachmod2[[1]][,],vstat=c(findstationaryprob(lQ.Zachmod)[[1]]),vylim=list(c(0,0.4),c(0,0.3),c(0.4,0.71),c(0,0.4)),vlegs=c("bottomright","topright","bottomright"));
#dosimplot(fileprefix="QP",dens=tabqsamp.dens.P[1:200,],mat=qsamp.matrix.P[1:200,],traj=qsamp.traj.P[[1]][1:200,],vstat=c(findstationaryprob(fQ.createP(mP))[[1]]),vylim=list(c(0,0.4),c(0.3,0.7),c(0.2,0.5),c(0,0.5)),vlegs=c("topright","bottomright","topright"));

#dosimplot(fileprefix="Qdf71",dens=tabqsamp.dens.df71[1:10000,],mat=qsamp.matrix.df71[1:10000,],traj=qsamp.traj.df71[[1]][1:10000,],vstat=NULL,vylim=list(c(0,1),c(0,1)),vlegs=c("bottomright","bottomright"));
#dosimplot(fileprefix="Qdf72",dens=tabqsamp.dens.df72[1:10000,],mat=qsamp.matrix.df72[1:10000,],traj=qsamp.traj.df72[[1]][1:10000,],vstat=NULL,vylim=list(c(0,1),c(0,1)),vlegs=c("bottomright","bottomright"));

dosimplot(fileprefix="Qdf73",dens=tabqsamp.dens.df73[1:10000,],mat=qsamp.matrix.df73[1:10000,],traj=qsamp.traj.df73[[1]][1:10000,],vstat=NULL,vylim=list(c(0,1),c(0,1)),vlegs=c("bottomright","bottomright"));
dosimplot(fileprefix="Qdf74",dens=tabqsamp.dens.df74[1:10000,],mat=qsamp.matrix.df74[1:10000,],traj=qsamp.traj.df74[[1]][1:10000,],vstat=NULL,vylim=list(c(0,1),c(0,1)),vlegs=c("bottomright","bottomright"));

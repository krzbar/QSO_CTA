source("qsosimul.traj.R");
N<-1
n<-4
pop.size<-10
fQ<-r.q.kernel.norm1
f0<-rexp
otherparams<-list(outfile="expnorm1.txt")

expnorm1<-r.qso.l1.traj.sample(N=N,fQ=fQ,n=n,f0=f0,pop.size=pop.size,otherparams)
save(expnorm1,file="expnorm1.RData")



q("no")

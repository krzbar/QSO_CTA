## This file accompanies the manuscript: 
## Bartoszek, Pulka "Approximately simulating quadratic stochastic operators"

## This software comes AS IS in the hope that it will be useful WITHOUT ANY WARRANTY, 
## NOT even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
## Please understand that there may still be bugs and errors. Use it at your own risk. 
## We take no responsibility for any errors or omissions in this code or for any misfortune 
## that may befall you or others as a result of its use. Please send comments and report 
## bugs to Krzysztof Bartoszek at krzbar@protonmail.ch .

source("CKQSOsim_QSOfunctions.R")

## tmp sol jezeli bedzie dzialac
n<-4
pop_size<-1000
delta<-0.01
alpha<-0.01
rG<-f_CKQSO_kerneldist_norm_05
rG_pop<-f_CKQSO_kernel_norm_05
vG<-0.5
rF<-f_CKQSO_seed_norm_0_1
vF<-1
m<-0
otherparams<-list(outfile="norm0_1norm05.txt")

#expnorm1<-r.qso.l1.traj.sample(N=N,fQ=fQ,n=n,f0=f0,pop.size=pop.size,otherparams)
norm0_1norm05_exact<-replicate(pop_size,f_CKQSO_sample(n=n,rG=rG,rF=rF),simplify=TRUE)
print("======================")
norm0_1norm05_approxBT<-f_CKQSO_approx_pop_sample_calcN(delta,alpha,m,vF,vG,n,pop_size,rG,BonferroniCorrect=TRUE)
print("======================")
norm0_1norm05_approxBF<-f_CKQSO_approx_pop_sample_calcN(delta,alpha,m,vF,vG,n,pop_size,rG,BonferroniCorrect=FALSE)
print("======================")
norm0_1norm05_popAlg<-f_KQSO_pop_traj_sample(rG_pop,n,rF,pop_size)


save(norm0_1norm05_exact,norm0_1norm05_approxBT,norm0_1norm05_approxBF,norm0_1norm05_popAlg,file="norm0_1norm05.RData")

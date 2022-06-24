## This file accompanies the manuscript: 
## Bartoszek, Pulka "Approximately simulating quadratic stochastic operators"

## This software comes AS IS in the hope that it will be useful WITHOUT ANY WARRANTY, 
## NOT even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
## Please understand that there may still be bugs and errors. Use it at your own risk. 
## We take no responsibility for any errors or omissions in this code or for any misfortune 
## that may befall you or others as a result of its use. Please send comments and report 
## bugs to Krzysztof Bartoszek at krzbar@protonmail.ch .

source("CKQSOsim_QSOfunctions.R")
source("CKQSOsim_FGfunctions.R")
source("CKQSOsim_setups.R")


lsetup<-l_setup_norm0_1norm05_n4_simulated
lsetup<-l_setup_norm0_1norm05_n6_notsimulated
#expnorm1<-r.qso.l1.traj.sample(N=N,fQ=fQ,n=n,f0=f0,pop.size=pop.size,otherparams)
f_dosimulation_forparamset(n=lsetup$n,pop_size=lsetup$pop_size,delta=lsetup$delta,alpha=lsetup$alpha,rG=lsetup$rG,rG_pop=lsetup$rG_pop,vG=lsetup$vG,rF=lsetup$rF,vF=lsetup$vF,m=lsetup$m,b_dosimul=lsetup$b_dosimul,b_doplot=lsetup$b_doplot,b_dosave=lsetup$b_dosave,c_fileprefix=lsetup$c_fileprefix,otherparams=lsetup$otherparams,res_exact=lsetup$res_exact,res_approxBT=lsetup$res_approxBT,res_approxBF=lsetup$res_approxBF,res_popAlg=lsetup$res_popAlg,legendpos=lsetup$legendpos)


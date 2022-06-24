## This file accompanies the manuscript: 
## Bartoszek, Pulka "Approximately simulating quadratic stochastic operators"

## This software comes AS IS in the hope that it will be useful WITHOUT ANY WARRANTY, 
## NOT even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
## Please understand that there may still be bugs and errors. Use it at your own risk. 
## We take no responsibility for any errors or omissions in this code or for any misfortune 
## that may befall you or others as a result of its use. Please send comments and report 
## bugs to Krzysztof Bartoszek at krzbar@protonmail.ch .

l_setup_norm0_1norm05_n4_simulated<-list(n=4,pop_size=1000,delta=0.01,alpha=0.01,rG=f_CKQSO_kerneldist_norm_05,rG_pop=f_CKQSO_kernel_norm_05,vG=0.5,rF=f_CKQSO_seed_norm_0_1,vF=1,m=0,otherparams=list(outfile="norm0_1norm05.txt"),b_dosimul=FALSE,b_doplot=TRUE,b_dosave=FALSE,c_fileprefix="norm0_1norm05",res_exact=norm0_1norm05_exact,res_approxBT=norm0_1norm05_approxBT,res_approxBF=norm0_1norm05_approxBF,res_popAlg=norm0_1norm05_popAlg,legendpos="topleft")
l_setup_norm0_1norm05_n6_notsimulated<-list(n=6,pop_size=1000,delta=0.01,alpha=0.01,rG=f_CKQSO_kerneldist_norm_05,rG_pop=f_CKQSO_kernel_norm_05,vG=0.5,rF=f_CKQSO_seed_norm_0_1,vF=1,m=0,otherparams=list(outfile="norm0_1norm05_n6.txt"),b_dosimul=TRUE,b_doplot=TRUE,b_dosave=TRUE,c_fileprefix="norm0_1norm05_n6",res_exact=NULL,res_approxBT=NULL,res_approxBF=NULL,res_popAlg=NULL,legendpos="topright")


## This file accompanies the manuscript: 
## Bartoszek, Pulka "Convergence and simulation of centred kernel quadratic stochastic operators"

## This software comes AS IS in the hope that it will be useful WITHOUT ANY WARRANTY, 
## NOT even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
## Please understand that there may still be bugs and errors. Use it at your own risk. 
## We take no responsibility for any errors or omissions in this code or for any misfortune 
## that may befall you or others as a result of its use. Please send comments and report 
## bugs to Krzysztof Bartoszek at krzbar@protonmail.ch .

## Collection of kernel and seed functions
f_CKQSO_kerneldist_norm_05<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(0.5))}
f_CKQSO_kernel_norm_05<-function(x,y,...){rnorm(1,mean=(x+y)/2,sd=sqrt(0.5))}
f_CKQSO_seed_norm_0_1<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(1))}
f_CKQSO_seed_norm_0_10<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(10))}
f_CKQSO_seed_norm_1_1<-function(numsim,...){rnorm(numsim,mean=1,sd=sqrt(1))}
f_CKQSO_seed_norm_1_10<-function(numsim,...){rnorm(numsim,mean=1,sd=sqrt(10))}
f_CKQSO_seed_norm_0_01<-function(numsim,...){rnorm(numsim,mean=0,sd=sqrt(0.1))}
f_CKQSO_seed_norm_1_01<-function(numsim,...){rnorm(numsim,mean=1,sd=sqrt(0.1))}
f_CKQSO_seed_exp_1<-function(numsim,...){rexp(numsim,rate=1)}
f_CKQSO_seed_exp_10<-function(numsim,...){rexp(numsim,rate=10)}
f_CKQSO_seed_exp_01<-function(numsim,...){rexp(numsim,rate=0.1)}


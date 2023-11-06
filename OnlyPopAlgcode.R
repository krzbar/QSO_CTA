## This file accompanies the manuscript: 
## Bartoszek, Pulka "Convergence and simulation of centred kernel quadratic stochastic operators"

## This software comes AS IS in the hope that it will be useful WITHOUT ANY WARRANTY, 
## NOT even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
## Please understand that there may still be bugs and errors. Use it at your own risk. 
## We take no responsibility for any errors or omissions in this code or for any misfortune 
## that may befall you or others as a result of its use. Please send comments and report 
## bugs to Krzysztof Bartoszek at krzbar@protonmail.ch .

pdf("Mean_OnlyPop.pdf")
plot(apply(res_popAlg,1,mean),ylab="Sample average",xlab="generation",pch=19,cex=1,cex.lab=1.5)
dev.off()

pdf("p_valueOnlyPop.pdf")
plot(apply(res_popAlg,1,function(x){ks.test(x,pnorm)$p.value}),ylab="p-value",xlab="generation",pch=19,cex=1,cex.lab=1.5)
dev.off()

pdf("p_valueMeanAdj_OnlyPop.pdf")
plot(apply(res_popAlg,1,function(x){ks.test(x,pnorm,mean=mean(x))$p.value}),ylab="p-value",xlab="generation",pch=19,cex=1,cex.lab=1.5)
dev.off()


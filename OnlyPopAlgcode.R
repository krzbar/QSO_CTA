pdf("Mean_OnlyPop.pdf")
plot(apply(res_popAlg,1,mean),ylab="Sample average",xlab="generation",pch=19,cex=1,cex.lab=1.5)
dev.off()

pdf("p_valueOnlyPop.pdf")
plot(apply(res_popAlg,1,function(x){ks.test(x,pnorm)$p.value}),ylab="p-value",xlab="generation",pch=19,cex=1,cex.lab=1.5)
dev.off()

pdf("p_valueMeanAdj_OnlyPop.pdf")
plot(apply(res_popAlg,1,function(x){ks.test(x,pnorm,mean=mean(x))$p.value}),ylab="p-value",xlab="generation",pch=19,cex=1,cex.lab=1.5)
dev.off()


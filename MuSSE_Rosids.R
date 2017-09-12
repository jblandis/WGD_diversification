#perform a MuSSE analysis for WGD events in Rosids
library(diversitree)
#due to changes in ape and how an ultrametric tree is determined, need to have ape version 3.5 installed
library(ape)
library(geiger)
library(nlme)

#starting files of the tree and the data file
#the data file has two columns, one with the species name, the second with the character state starting at 1
mydata <- read.csv("Rosids_only.csv",header=TRUE, row.names=1)
mytree <- read.tree("Vascular_Plants_rooted.dated.tre")

#compare data file and tree file to see if any taxa are not represented in both
comparison <- name.check(phy=mytree,data=mydata)

# prune taxa that don't have data but are present in the tree
mytree <- drop.tip(mytree,comparison$tree_not_data)

#double check to make sure that taxa all match with tree and data
name.check(phy=mytree,data=mydata)
comparison <- name.check(phy=mytree,data=mydata)

#create vector for traits
# if the vector names are changed, then commands following this will need to be altered to maintain the procedure
states <- mydata[,1]
names(states) <- row.names(mydata)

#proportion of tips sampled.  Rosids estimates from the Plant list database
sampling.f <- 9603 / 86996
sampling.f

#make.musse needs two arguments, a tree and character states
lik <- make.musse(mytree,states,4,sampling.f=sampling.f)
lik

#argument names
argnames(lik)

#constrain transition rates so that events 1 <> 2 <> 3 <> 4
lik.base <- constrain(lik, q13 ~ 0, q14 ~ 0, q24~ 0, q31~ 0, q41~ 0, q42~ 0)
argnames(lik.base)

#heuristic guess as to sensible starting point
p <- starting.point.musse(mytree,4)

#full model allowing all variables to change at any time
fit <-find.mle(lik, p[argnames(lik)])
fit
save(fit, file="fit_10k.RData")
save.image()

#fit the base model constraining WGD to only change sequentially in either direction
fit.base <- find.mle(lik.base, p[argnames(lik.base)])
fit.base

#round to three decimal places
round(coef(fit.base),3)

#save(fit.base, file="fit.base.RData")
#save.image()
#load(file="fit.base.RData")

#test hypothesis of speciation rates are different for different states
lik.lambda <- constrain(lik, q13 ~ 0, q14 ~ 0, q24~ 0, q31~ 0, q41~ 0, q42~ 0, lambda2 ~ lambda1, lambda3 ~ lambda1, lambda4 ~ lambda1)

#then start search again
fit.lambda <- find.mle(lik.lambda, p[argnames(lik.lambda)])
fit.lambda

#round to three decimal places
round(coef(fit.lambda),3)

#save(fit.lambda, file="fit.lambda.RData")
#save.image()


#perform statistical test to get a p-value
anova(fit.base, free.lambda=fit.lambda)
anova

#then start search again
lik.mu <- constrain(lik, q13 ~ 0, q14 ~ 0, q24~ 0, q31~ 0, q41~ 0, q42~ 0, mu2 ~ mu1, mu3 ~ mu1, mu4 ~ mu1)

#then start search again
fit.mu <- find.mle(lik.mu, p[argnames(lik.mu)])
fit.mu
round(coef(fit.mu),3)

#save(fit.mu, file="fit.mu.RData")
#save.image()


#perform statistical test to get a p-value
anova(fit.base, free.lambda=fit.mu)
anova

#mcmc analysis
prior.exp <- make.prior.exponential(2)
#prior <- make.prior.exponential(1 / (2 * (p[1] - p[4])))
set.seed(1)
samples <- mcmc(lik, coef(fit), fail.value=NULL, nsteps=10000, prior=prior.exp, w=1, print.every=100)

#save distribution
save(samples, file="Samples_distribution_10000.RData")
#if need be, can reload file
#load("Samples_distribution.RData")


#to visualize speciation rate
pdf("Speciation_10000.pdf")
col <- c("snow2","blue", "yellow", "green")
profiles.plot(samples[c("lambda1", "lambda2", "lambda3", "lambda4")], col.line=col, las=1, 
	xlab="Speciation rate", legend="topright", font=2, cex.lab=0.5, font.lab=1, cex.legend=1, margin=1/4)

dev.off()

#to visualize extinction rate
pdf("Extinction_rate_10000.pdf")
col <- c("snow2","blue", "yellow", "green")
profiles.plot(samples[c("mu1", "mu2", "mu3", "mu4")], col.line=col, las=1, 
	xlab="Extinction rate", legend="topright", font=2, cex.lab=0.5, font.lab=1, cex.legend=1, margin=1/4)
dev.off()

#visualize net diversification
pdf("Net_diversification_10000.pdf")
samples$net1 <- samples$lambda1 - samples$mu1
samples$net2 <- samples$lambda2 - samples$mu2
samples$net3 <- samples$lambda3 - samples$mu3
samples$net4 <- samples$lambda4 - samples$mu4
col <- c("snow2","blue", "yellow", "green")
profiles.plot(samples[c("net1", "net2", "net3", "net4")], col.line=col, las=1, 
	xlab="Net diversification rate", legend="topright", font=2, cex.lab=0.5, font.lab=1, cex.legend=1, margin=1/4)

dev.off()

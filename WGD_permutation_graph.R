library(data.table)

 WGD <-fread("Shifts_permutation.txt", header=TRUE)

pdf("Shift_permutations.pdf")
hist(WGD$Perm, xlim=c(0,15), main="Randomized Diversification Shifts", xlab="Simultaneous WGD and Diversification Shifts", breaks=15, col=c("gray")) 
abline(v=13, lwd=3, col="springgreen")
dev.off()

length( which(WGD > 13))


###############

library(data.table)

 WGD <-fread("One_node_lag_permutation.txt", header=TRUE)

pdf("One_lag_randomization.pdf")
hist(WGD$Perm, xlim=c(0,40), main="Randomized Diversification Shifts", xlab="One Node Lag and Diversification Shifts", breaks=30, col=c("gray")) 
abline(v=1, lwd=3, col="springgreen")
dev.off()

length( which(WGD > 1))

###############

library(data.table)

WGD <-fread("Two_node_lag_permutation.txt", header=TRUE)
length( which(WGD > 9))


pdf("Two_lag_randomization.pdf")
hist(WGD$Perm, xlim=c(0,40), main="Randomized Diversification Shifts", xlab="Two Node Lag and Diversification Shifts", breaks=30, col=c("gray")) 
abline(v=9, lwd=3, col="springgreen")
dev.off()



###############

library(data.table)

WGD <-fread("Three_node_lag_permutation.txt", header=TRUE)
length( which(WGD > 8))


pdf("Three_lag_randomization.pdf")
hist(WGD$Perm, xlim=c(0,40), main="Randomized Diversification Shifts", xlab="Three Node Lag and Diversification Shifts", breaks=30, col=c("gray")) 
abline(v=8, lwd=3, col="springgreen")
dev.off()


###############

library(data.table)

WGD <-fread("Four_node_lag_permutation.txt", header=TRUE)
length( which(WGD > 10))


pdf("Four_lag_randomization.pdf")
hist(WGD$Perm, xlim=c(0,40), main="Randomized Diversification Shifts", xlab="Four Node Lag and Diversification Shifts", breaks=30, col=c("gray")) 
abline(v=10, lwd=3, col="springgreen")
dev.off()
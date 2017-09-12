library(data.table)

#read in log file from the randomizatin test. Data is in the first column, with a header of "Perm"
WGD <-fread("Shifts_permutation.txt", header=TRUE)

#create a PDF of the histogram of the data, with the observed data represented by a green line at 13 events
pdf("Shift_permutations.pdf")
hist(WGD$Perm, xlim=c(0,15), main="Randomized Diversification Shifts", xlab="Simultaneous WGD and Diversification Shifts", breaks=15, col=c("gray")) 
abline(v=13, lwd=3, col="springgreen")
dev.off()

#determine the number of randomization events that are greater than the observed data
length( which(WGD > 13))


###############

library(data.table)

#read in log file from the randomizatin test. Data is in the first column, with a header of "Perm"
WGD <-fread("One_node_lag_permutation.txt", header=TRUE)

#create a PDF of the histogram of the data, with the observed data represented by a green line at 13 events
pdf("One_lag_randomization.pdf")
hist(WGD$Perm, xlim=c(0,40), main="Randomized Diversification Shifts", xlab="One Node Lag and Diversification Shifts", breaks=30, col=c("gray")) 
abline(v=1, lwd=3, col="springgreen")
dev.off()

#determine the number of randomization events that are greater than the observed data
length( which(WGD > 1))

###############

library(data.table)

#read in log file from the randomizatin test. Data is in the first column, with a header of "Perm"
WGD <-fread("Two_node_lag_permutation.txt", header=TRUE)

#determine the number of randomization events that are greater than the observed data
length( which(WGD > 9))


#create a PDF of the histogram of the data, with the observed data represented by a green line at 13 events
pdf("Two_lag_randomization.pdf")
hist(WGD$Perm, xlim=c(0,40), main="Randomized Diversification Shifts", xlab="Two Node Lag and Diversification Shifts", breaks=30, col=c("gray")) 
abline(v=9, lwd=3, col="springgreen")
dev.off()



###############

library(data.table)

#read in log file from the randomizatin test. Data is in the first column, with a header of "Perm"
WGD <-fread("Three_node_lag_permutation.txt", header=TRUE)

#determine the number of randomization events that are greater than the observed data
length( which(WGD > 8))


#create a PDF of the histogram of the data, with the observed data represented by a green line at 13 events
pdf("Three_lag_randomization.pdf")
hist(WGD$Perm, xlim=c(0,40), main="Randomized Diversification Shifts", xlab="Three Node Lag and Diversification Shifts", breaks=30, col=c("gray")) 
abline(v=8, lwd=3, col="springgreen")
dev.off()


###############

library(data.table)

#read in log file from the randomizatin test. Data is in the first column, with a header of "Perm"
WGD <-fread("Four_node_lag_permutation.txt", header=TRUE)

#determine the number of randomization events that are greater than the observed data
length( which(WGD > 10))

#create a PDF of the histogram of the data, with the observed data represented by a green line at 13 events
pdf("Four_lag_randomization.pdf")
hist(WGD$Perm, xlim=c(0,40), main="Randomized Diversification Shifts", xlab="Four Node Lag and Diversification Shifts", breaks=30, col=c("gray")) 
abline(v=10, lwd=3, col="springgreen")
dev.off()

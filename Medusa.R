library(ape)
library(geiger)
library(devtools)
#install_github("josephwb/turboMEDUSA/MEDUSA", dependencies=TRUE)

require(MEDUSA)

#read the tree in nexus format
phy <- read.nexus("Angiosperm_MEDUSA_tree.nex")

#file specifying species richness for the genera used as tips
richness <- read.csv("Angiosperm_species_richness.csv")

#tricking MEDUSA to run two runs to make the summary easier for the big tree
fie <- c(phy,phy)
res1 <- MEDUSA(fie, richness, mc=TRUE, model="bd", criterion = "aicc")
summ <- multiMedusaSummary(res1, phy, plotModelSizes=TRUE, plotTree=FALSE)

#plot tree with annotated shifts
pdf("MultiMedusaPlot.pdf")
plotMultiMedusa(summ, annotateShift=TRUE, annotateRate="r.mean", tip.cex=0.2)
dev.off()

#similar to above, but plotted as a fan.  Smaller trees may not need both
pdf("Multi_fan.pdf")
plotMultiMedusa(summ, type="fan", time=FALSE, annotateShift=TRUE, annotateRate="r.mean", show.tip.label=FALSE)
dev.off()

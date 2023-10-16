library(seqinr)

myseqs <- read.alignment("/Users/angela/Documents/machado_lab/rotation_machado/chr2-all-Oct-6.fa", format = "fasta")
mat <- dist.alignment(myseqs, matrix = "identity")

library(tidyr)
library(ggplot2)

library(pophelper)

row_names <- readLines("structure.str")

sfiles <- list.files(path=system.file("/Users/angela/Documents/machado_lab/nDNA_STRUCTURE"), full.names=T)
slist <- readQ(c("/Users/angela/Documents/machado_lab/nDNA_STRUCTURE/structure.7.meanQ", "/Users/angela/Documents/machado_lab/nDNA_STRUCTURE/structure.5.meanQ","/Users/angela/Documents/machado_lab/nDNA_STRUCTURE/structure.4.meanQ", "/Users/angela/Documents/machado_lab/nDNA_STRUCTURE/structure.3.meanQ", "/Users/angela/Documents/machado_lab/nDNA_STRUCTURE/structure.2.meanQ"), 
               indlabfromfile=T)
rownames(slist[[1]]) <- row_names
rownames(slist[[2]]) <- row_names
rownames(slist[[3]]) <- row_names
slist1 <- alignK(slist, type ="auto")
slist1 <- alignK(slist1)

p1 <- plotQ(slist1,
            imgoutput="join",
            returnplot=T,
            exportplot=F,
            basesize=11,
            showindlab=T,
            useindlab=T,
            clustercol=c("coral","steelblue","lightblue","darkblue","orange","purple","seagreen"),
)

#admixture CV error plot
errors <- c(0.59614,0.43998,0.36264,0.24938,0.24119,0.21362,0.24911)
k <- c(1,2,3,4,5,6,7)

CV <- data.frame(unlist(errors),unlist(k))
colnames(CV) <- c("CV_Error", "K")

ggplot(CV, aes(x=k,y=errors)) +
  geom_point() +
  geom_line(linetype = "dashed") +
  theme_classic() +
  ylab("CV Error")
plot(x=k,y=errors)







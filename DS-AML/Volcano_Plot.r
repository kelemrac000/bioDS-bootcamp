
#Starter Script for Rackeb adn Jordan

#8/22/18


#Purpose: Create volcano plot for DEGs


############ Load Libraries ################

# 1)We will need to load libraries. The libraries we need are:  ggplot, and dplyr, and tidyr 

# library()
#install.packages("ggplot")
library("ggplot")
#install.packages("dplyr")
library("dplyr")
#install.packages("tidyr")
library("tidyr")


############ Read in the data files ############

#2) read in the results from the differential expression analysis. 
#this data frame contains results from all statistical tests, with foldchange and pvalues for all genes. 
#TARGET_AML_1031_DS.AML_vs_M7s_allGenesTested.csv

#uncomment this and complete the code
all.genes <- read.csv("GitHub/bioDS-bootcamp/DS-AML/TARGET_AML_1031_DS.AML_vs_M7s_allGenesTested.csv")



#add code to the first few lines and the dimensions of the data.frame. 
head(all.genes)
dim(all.genes)



######### Reformat the Differnetial Expression (DE) Data  ##########


#3) We need to add columns the DE results. We need to transform the pValues into negative log10 scale,
# and we need to classify each gene as having a foldchange (FC) greater than 2, less than -2, or not significantly FC. 
?log10
?case_when

#Run the code below.  
#Add comments that describe what each line of code is doing
all.genes.updated <- all.genes %>%
  
  mutate(Neg.Log10.P= -log10(pValue)) %>%
  
  mutate(DEGs.Groups=case_when(
            FoldChange > 2.0 & pValue < 0.05 ~ "FC Greater than 2",
            FoldChange < -2.0 & pValue < 0.05 ~ "FC Less than 2",
            TRUE ~ "Not Significant FC"))

Labels <- all.genes.updated


#add code to the first few lines and the dimensions of the data.frame. 
head(all.genes.updated)
dim(all.genes.updated)




#4) Lets look at how many genes were FC Greater than 2, FC Less than 2, and not significant
#using the all.genes.updated dataframe. 
?table
table

#uncomment this and complete the code
# table(dataframe[,COLUMN_NAME])




#5) Create a volcano plot that tells us how many genes are differentially expressed compared to all genes tested. 
# We will color the points by up-regulation and by down-regulation using our column "DEGs.Groups"
#Use the dataframe all.genes.updated
#Set x axis to "logFC"
#Set y axis to "Neg.Log10.P"
#Set the color to "DEGs.Groups"

?geom_vline
?geom_hline
?scale_color_manual

#uncomment this and complete the code
#Add comments that describe what each line of code is doing
# volcano1 <- ggplot(dataframe, aes(x="logFC", y="Neg.Log10.P", color="DEGs.Groups")) +
#                   geom_point() +
#                   geom_vline(xintercept=c(-1,1)) +
#                   geom_hline(yintercept = -log10(0.05)) +
#                   scale_color_manual(values=c("FC Greater than 2"="red", 
#                                               "FC Less than 2"="blue",
#                                               "Not Significant FC"="darkgrey"))  +
#                   theme_bw()


volcano1


#6) Save you volcano plot as a pdf file. 




#Starter Script for Rackeb and Jordan

#7/17/18 


#Purpose: Subset expression data and visualize sample-wise correlations. 

options(stringsAsFactors = FALSE)
############ Load Libraries ################

# 1)We will need to load libraries. The libraries we need are:  tidyverse, corrplot, and ggplot2,
#For tidyvese, see https://www.tidyverse.org/packages/ and follow the instructions. 
#For corrplot, see the tutorial http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram 
#Now, try ggplot2 on your own. 
install.packages(c("tidyverse","corrplot","ggplot2"))



############ Read in the data files ############

# 2) read in the expression data 

#The expression data is normalize to "transcripts per million" (TPMs). We will talk about normalization soon
# *Important*: We used normalized data to allow for sample to sample comparisons. 

#hint:
# what type of file is it? look at the suffix (.csv, .txt )
#which function would you choose based on the suffix? 

#This one is given to you. uncomment this and complete the code
TPMs <- read.csv("GitHub/bioDS-bootcamp/DS-AML/TARGET_AML_AAML0531_M7_and_DS-AML_dupGenesRemoved_TPM.csv", row.names=1)




#We need the gene names to be rownames. 
#look at read.csv() documentation to see why we used the row.names argument. 
?read.csv()
?rownames()

m0 <- matrix(NA, 4, 0)
rownames(m0)

m2 <- cbind(1, 1:4)
rownames(m2) <- rownames(m2, do.NULL = FALSE, prefix = "Obs.")

#add code to the first few lines and the dimensions of the data.frame. 
?head
?dim




#3) read in the clinical data elements (CDE) file, 

#uncomment this and complete the code
CDE <- read.csv("GitHub/bioDS-bootcamp/DS-AML/TARGET_AML_1031_M7s_DS-AML_CDE.csv", row.names = 1)



#add code to the first few lines and the dimensions of the data.frame. 
summary (CDE)

head(CDE)

dim(CDE)

#4) read in reference file, Homo_Sapiens_Entrez_Gene_IDs.txt.  


#uncomment this and complete the code
ref <- read.delim("GitHub/bioDS-bootcamp/DS-AML/Homo_Sapiens_Entrez_Gene_IDs (1).txt", sep ="\t")

  


#add code to view the first few lines and the dimensions of the data.frame. 
summary (ref)

head(ref)

dim(ref)




############### Data Exploration and Manipulation ###############


# 5)Look at the first patient's ISCN in the CDE. Use the dataframe[row#,column#] (slice notation) syntax.
# An ISCN is a systematic way of describing an individuals karyotype using symbols and abbreviations. 
CDE[1,4]




#What is a karyotype? review this video if you don't remember ( https://www.youtube.com/watch?v=hNMYV213xu0 ) 
#Just write the definition here and comment it out by adding a "#" in front. 
# karyotypes are basically your chromosomes, and checking any abnormalities in your karyotype are one of the first things doctors check for when diognosing a patient with a specific type of syndrome





# 6) Look at the first patients ISCN using the row index (numeric) and the column name (string). dataframe[row#, column_name]
# Often it can be best to specify the column name when indexing. This avoids mistakes like adding a column and thus shifting the columns over. 
#That way you column 3 is now column 4, and re-running your code will introduce an error. 

CDE[1,5]

# 7) Create a variable where you convert the column, "Age.at.Diagnosis.in.Days", to age in years.
Age.In.Years <- CDE[, "Age.at.Diagnosis.in.Days"]/365


#uncomment this and complete the code
Age.In.Years <- CDE[, "Age.at.Diagnosis.in.Days"]/365


# 8) Create a new column in CDE called "Age.in.years". Populate this column with
# the results from converting the column, "Age.at.Diagnosis.in.Days", to age in years. 
#Use base R.  So things like [] notation or $ notation.   
New_CDE <- cbind(CDE, Age.In.Years)
New_CDE


#example: data.frame[,"newColName"] <- c(1,2,3,4) / 2  



#add code to the first few lines and the dimensions of the updated data.frame. 
#This is to check that you added the information and its correct. 
head(New_CDE)
dim(New_CDE)
tail(New_CDE)
summary(New_CDE)



# 9) Copy and paste, and then run 2 examples of  gsub() and one example of grep() from the documentation. Examples on the bottom of the page. 
#Explain what each example is doing. Pick simple examples that use functions you have seen before. 
?grep

?gsub


#What type of data is returned by grep? use class()
class(grep)

#What type of data is returned by gsub? use class()
class(gsub)


# 10) Use head() to look at the first few lines of the "Chromosome" column in reference data.frame (ref). 
#The notation here is chromosome#, chromosome arm, and the location of G-bands where that gene is found. 
head(ref[, "Chromosome"])



# example: gene A1BG is found at 19q13.43,  so chromosome 19, q arm, g-band sections 13.43
#we won't go into detail about the g-band sections here,so description of the g-bands here is NOT technical. 



# 11) Look at row 102 using slice notation. Describe chromosomal location it is found at.
#Example: data.frame[row, columnName]
ref[102, "Chromosome"]




# 12) Create a variable with the row numbers (called row indices) for genes that come from chromosome 21. 

#uncomment this and complete the code
row.indices <- grep("^21[pq]", ref$Chromosome)
head(row.indices)

#here I gave you the regular expression to use since we didn't cover them yet. 
# Lets breakdown what "^21[pq]" is matching
# ^ means the strings begins with number 2, 
# 21 means that the strings 1 and 2 must follow each other exactly  
# [pq] means that 21 is followed by the letters p or q only. 
#Thus we get 


# 13) Create a new variable to subset the reference dataframe (ref) for genes on chromosome 21.  
#Use the variable row.indices to select the rows you want
#Example: data.frame[row.indices, ]
ref[row.indices,]

#uncomment this and complete the code
chr.21.ref <-ref[row.indices,] 

head(chr.21.ref)
# write code to check on the dimensions of the subset reference. 



# 14) Use intersect to find the genes that are in both the reference data and the expression dataset. 
?intersect

#what type of objects does intersect need? does it take data.frames? matrices? vectors? lists?



#uncomment this and complete the code
head(rownames(TPMs))
head(chr.21.ref[,"Approved.Symbol" ])
chr.21.genes <- intersect(rownames(TPMs), chr.21.ref[,"Approved.Symbol" ])





# 15) Select the rows from TPMs expression matrix for genes that are on chromosome 21. 
#Use the vector chr.21.genes you created. Save it as a new variable. 
#Example: TPMs[object,]


#uncomment this and complete the code
row.indices <-grep("^21[pq]", ref$Chromosome)
chr.21.expn <- TPMs[chr.21.genes,]






################# Correlation Plots 


# 16) follow the tutorial:	http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram
#Add a lines of code here. Do NOT copy and paste. 
# Stop after "Changing the color and the rotation of text labels" section. Do Not compute P-values yet.
#We want to always understand the code we use. So we haven't covered this yet.  

#NOTE: We want to look at gene-wise correlations. So you should see gene symbols on the x and y axis. 

install.packages("corrplot")
head(mtcars)
M <- cor(mtcars)
M
head(round(M,2))
library(corrplot)
corrplot(M, method="circle")
corrplot(M, method="pie")
corrplot(M, method="color")
corrplot(M, method="number")
corrplot(M, type="upper")
corrplot(M, type="lower")
corrplot(M, type="upper", order="hclust")col<- colorRampPalette(c("red", "white", "blue"))(20)
corrplot(M, type="upper", order="hclust", col=col)
corrplot(M, type="upper", order="hclust", col=c("black", "white"),
         bg="lightblue")
library(RColorBrewer)
corrplot(M, type="upper", order="hclust", 
         col=brewer.pal(n=8, name="RdBu"))
corrplot(M, type="upper", order="hclust",
         col=brewer.pal(n=8, name="RdYlBu"))
corrplot(M, type="upper", order="hclust",
         col=brewer.pal(n=8, name="PuOr"))
corrplot(M, type="upper", order="hclust", tl.col="black", tl.srt=45)


#17) How many genes on chr.21 from the reference (chr.21.ref) were in the expression dataframe chr.21.expn? 
#HINT: use dim() on the dataframes mentioned above. Remeber that each row contains information for 1 gene. 

chr.21.intersect<- intersect(rownames(chr.21.expn), chr.21.ref$Approved.Symbol)
chr.21.intersect


#18) Calculate the total counts (the sum) for each gene, across all samples, in the chr.21.expn dataframe.
?rowSums

#uncomment this and complete the code. 
# gene.count.totals <- rowSums(data.frame)
gene.count.totals <- rowSums(chr.21.expn)


#18)  Use "gene.count.totals" to find which genes have at least total 50 counts across all samples 

#uncomment this and complete the code. 
# genes.atleast.50 <- variable >= 50
genes.atleast.50 <- gene.count.totals >= 50



#19) use head() to look at the results of "genes.atleast.50".  Define a boolean value below.
# Then Use class() and str()  to figure out what type of object it is. 

head(genes.atleast.50)
class(genes.atleast.50)
str(genes.atleast.50)


#20) Booleans can be used to filter a data.frame. Any rows/columns with TRUE are kept, and 
#rows/columns with FALSE are filtered out. This makes sense, since FALSE means that entry in the dataframe DID NOT meet your criteria. 
#Use the boolean variable you created to select on the genes with at least a sum of 50 counts. 

# uncomment this and run the code.
chr.21.high.expn <- chr.21.expn[genes.atleast.50, ]



#use dim() on the chr.21.high.expn to see how many genes had at least 50 total counts or more. 
dim(chr.21.high.expn)

#WHY IS THIS IMPORTANT? Very lowly expressed genes are "noisy" and could be due to an error in the RNAseq process. 
#Filtering genes for those with high counts allows us to be more confident that these genes were measured accurately (accurate counts from RNAseq)



#21) to examine the relationship (similarity between) each patient, create a corrplot with chr.21.high.expn.
#Create a corrplot with the chr.21.high.expn,  the method="color" and with gene names in a readable size (fontsize change).
#change the text color to black. Change the order to "hclust". 
#Remember too look at the tutorial in question #16 and the documentation.
?corrplot


corrplot(chr.21.high.expn, method = "color", order = "hclust", tl.col = "black")

#Save this plot to a pdf file. #remember that the syntax below
#pdf("filename.pdf")
#corrplot(yourCorrelationMatrix, options)
#dev.off()

?pdf
?dev.off

# 22)To examine the relationship between each gene (correlation of each gene), we need to switch our columns into rows and rows into columns.
#We use the transpose function to do this. Use the chr.21.high.expn dataframe.

# uncomment this and run the code. the "tr" will remind us that it is transposed.

chr.21.high.tr <- t(chr.21.high.expn)
chr.21.high.tr

#use head() and dim() to check out what happened to the new data.frame you created.

head(chr.21.high.tr)
dim(chr.21.high.tr)

#This transformation caused there be 21 rows and 104 columns.
#the Y-axis shows the patients while the X-axis shows the genes that were being analyzed.
#It's a heat map showing correlation between a patient and gene expression rather than patient to patient

#23) Create a corrplot with the chr.21.high.tr  the method="color" and with gene names in a readable size (fontsize change).
#change the text color to black. Change the order to "hclust".
#Remember too look at the tutorial in question #16 and the documentation.
?corrplot

corrplot(chr.21.high.tr, method = "color", order = "hclust", tl.col = "black")

#Save this plot to a pdf file.

chr.21.tr <- cor(chr.21.high.tr)
pdf("Myplot3.pdf")
corrplot(chr.21.tr, method = "color", order = "hclust", tl.col = "black", tl.cex = 0.3)
dev.off()

head(chr.21.expn)

#need to transpose data frame, use function t(x)

chr.21.P <- cor(chr.21.expn)
chr.21.P

#transposing is useless to previous matrix because the X-axis and Y-axis are the same exact variable

pdf("Myplot.pdf")
corrplot(chr.21.P, method = "color")
dev.off()



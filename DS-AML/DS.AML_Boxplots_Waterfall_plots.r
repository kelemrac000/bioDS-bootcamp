
#Starter Script for Rackeb and Jordan

#8/13/18


#Purpose: Subset expression data and visualize sample-wise and gene-wise correlations.


############ Load Libraries ################

# 1)We will need to load libraries. The libraries we need are:  ggpubr, ggplot2, and dplyr, and tidyr

#install.packages("ggpubr")
library("ggpubr")

#You can add the next libraries.

#install.packages("ggplot2")
library("ggplot2")
#install.packages("dplyr")
library("dplyr")
#install.packages("tidyr")
library("tidyr")

############ Read in the data files ############

# 2) read in the expression data. We will use the normalized counts from your recent RNAseq experiment (TARGET_AML_1031_DS.AML_HTSeq_Hg38_Log2.Expn_norm_counts.csv)
# *IMPORTANT*: We used normalized data to allow for sample to sample comparisons.

#hint:
# what type of file is it? look at the suffix (.csv, .txt )
#which function would you choose based on the suffix?

#You would use a read.csv() function for a ".csv" file in RStudio if you are okay with the default settings, however, if your looking for a more primitive approach then us read.delim() so you can specify settings.

read.csv("GitHub/bioDS-bootcamp/DS-AML/TARGET_AML_1031_DS.AML_HTSeq_Hg38_TMMCPM_norm_counts.csv")

#This one is given to you. uncomment this and complete the code

Log2.Expn <- read.csv("GitHub/bioDS-bootcamp/DS-AML/TARGET_AML_1031_DS.AML_HTSeq_Hg38_TMMCPM_norm_counts.csv", row.names = 1)

#add code to the first few lines and the dimensions of the data.frame.

head(Log2.Expn)
dim(Log2.Expn)

#IMPORTANT: This data is on log2 Scale, meaning all numeric values are on log base 2 scale.
#This is to help better visualize the data.
#The spread of the data on log2 scale is far more compact. So we can more easily visualze
#the difference of say, 1 count versus 1000 counts if this were a barplot/boxplot.

#Since this is an imporant concept, please watch this video.
# https://www.youtube.com/watch?v=FofnXXt6-rU (13 min)

#3) read in the clinical data elements (CDE) file, TARGET_AML_1031_M7s_DS-AML_CDE.csv.

#uncomment this and complete the code

CDE <- read.csv("TARGET_AML_1031_M7s_DS-AML_CDE.csv")

#add code to the first few lines and the dimensions of the data.frame.

head(CDE)
dim(CDE)

#4) read in Differentially expressed genes (DEGs) list, TARGET_AML_1031_DS.AML_vs_M7s_DEGs.csv

#uncomment this and complete the code

DEGs <- read.csv("GitHub/bioDS-bootcamp/DS-AML/TARGET_AML_1031_DS.AML_vs_M7s_DEGs.csv")
head(DEGs)
#add code to the first few lines and the dimensions of the data.frame.

head(DEGs)
dim(DEGs)


# 5) read in the chr.21.ref, Chromosome_21_Reference.csv,  for a list of genes on chromosome 21.

#uncomment this and complete the code

ref <- read.delim("GitHub/bioDS-bootcamp/DS-AML/Homo_Sapiens_Entrez_Gene_IDs (1).txt")
row.indices <- grep("^21[p,q]", ref$Chromosome)
chr.21.ref <- ref[row.indices,]

############# Explore the Differentially Expressed Genes ###########

# 6) Using the genes in chr.21.ref, find how many DEGs were on chr.21.
#We will use a LOT of dplyr in this script.  Please review Dplyr if you need to.
#I will give you the first lines of code using dplyr, but then you will need write your own.

#We will use the operator "%in%" often in this script.  Please read https://stat.ethz.ch/R-manual/R-devel/library/base/html/match.html,
#and write your own definition of what "%in%" is doing.

# %in% Definition; A logical vector, indicating if a match was located for each element of x: thus the values are either TRUE or FALSE and never NA.

#Run the code below to find how many DEGs are on Chr.21.
#Add comments that describe what each line of code is doing. The first one is done for you.
?filter()

chr.21.DEGs <- DEGs %>% #define a new variable and pipe (%>%) the DEGs dataframe into the filter function.
  filter(., Gene %in% chr.21.ref$Approved.Symbol) #filter() is removing all rows that don't match
head(DEGs)
head(chr.21.DEGs)

dim(chr.21.DEGs)
#What is the dot ".", indicating to the function filter()?

#It is representing the dataframe that is piped into to the function.
#Basically saying `filter this DEGs dataframe`, but DEGs is represented as a ".".
#Then you never have to write out the whole variable name again, DEGs.

#Look at the head() and dim() of the Chr.21.DEGs.

head(chr.21.DEGs)
dim(chr.21.DEGs)

Log2.Expn(DEGs)
head(DEGs)

######### Reformat the Expression Data and Clinical Data ##########

#7) ggplot and dplyr packages *DO NOT* use rownames. This can be a little difficult to start off with.
#But we will create a new dataframe to solve this problem.


#Run the code below.
#Add comments that describe what each line of code is doing.
?mutate

Gene.Names <- rownames(Log2.Expn) #This line is setting all the row names (gene names) of variable "Log2.Expn" to a variable called Gene.Names

Log2.Expn.df <- Log2.Expn %>% #This line is defining a new variable (Log2.Expn.df) and piping the dataframe (Log2.Expn) into the mutate() function.
  mutate(., Gene = Gene.Names) #This line is using mutate() to add a new variable called "Gene" which is set equal to "Gene.Names".

head(Log2.Expn.df)

Log2.Expn

Log2.Expn.df
#8) We need to subset the clinical information to the few columns we will use for our analysis.
?select

#Run the code below.
#Add comments that describe what each line of code is doing.

CDE.subset <- CDE %>% #This line is defining a new variable called "CDE.subset" and piping the dataframe (CDE) into the select() function.
  select(Sample,group) #This line is selecting the variables that it wants to keep by putting them inside the function select().


#Look at the head() and dim() of the new CDE.subset. Write what happened to the CDE dataframe below.

head(CDE.subset)
dim(CDE.subset)

#After using these functions

######### Create a New Expression Dataframe with Added Clinical Information ##############

# 8) We need to filter the Expression Data for one of your "genes of interest".
#Then we will create a long-format dataframe, with a SINGLE column to hold ALL expression counts values, for all patient samples.
#Finally, add in the clinical information.
#lets just start with the first DEG in the DEGs dataframe called "ITGA2B".
?filter
?gather
?inner_join

#Run the code below.
#Add comments that describe what each line of code is doing.
ITGA2B.Expn <- Log2.Expn.df %>% #This line is defining a variable called "ITGA2B.Expn" and piping the dataframe "Log2.Expn.df" into the filter() function.
  filter(., Gene %in% c("ITGA2B")) %>% #This line is finding rows/columns where conditions are "TRUE". Only rows that are TRUE are kept while everything else is dropped. 
  gather(., key = Sample, value = Log2.Expression.Value,-Gene) %>% #This line is taking multiple columns and collapsing them into key-value pairs, duplicating all other columns as needed. 
  inner_join(., CDE.subset, by="Sample") #This line is 

#Look at the head() and dim() of the new CDE.subset.

head(CDE.subset)
dim(CDE.subset)

################### Create a box plot with Long-Format Expression Dataframe #############

# http://www.sthda.com/english/wiki/ggplot2-box-plot-quick-start-guide-r-software-and-data-visualization

#9 ) Create a boxplot with the ITGA2B expression dataframe, ITGA2B.Expn.
#We want the column "group" to be the x-axis.
#and Make "Log2.Expression.Value" column the y-axis.
# Make the color corrrespond to the column, "group" too.
#finally, Use Theme_classic()

#uncomment this and complete the code
box1 <- ggplot(ITGA2B.Expn, aes(x= group, y= Log2.Expression.Value, color= group)) +
  geom_boxplot() +
  theme_classic()

box1


#write your boxplot to a pdf file.
?pdf()



########### Create a Waterfall plot with the Long-Format Expression Dataframe #############


# 10) Run the code for this example below. We will use dplyr again.
data("mtcars")

#Look at the head() and dim() of mtcars dataframe


#Run the code below.
#Add comments that describe what each line of code is doing.
?mutate

cars <- rownames(mtcars)

mtcars.df <- mtcars %>%
  mutate(name = cars)


#Run the code below.
#Create ordered bar plots (waterfall plots). Change the fill color by the  variable "cyl".
?ggbarplot
ggbarplot(mtcars.df, x = "name", y = "mpg", #set x and y axis to the column names "name" and "mpg".
          fill = "cyl",               # change fill color by column "cyl".
          color = "white",            # Set bar border colors to white
          sort.val = "desc",          # Sort the values in dscending order
          sort.by.groups = TRUE,      # sort inside each group
          x.text.angle = 90)          # Rotate vertically x axis texts



#10 ) Create a waterfallplot with the ITGA2B.Expn. expression dataframe.
#We want the column "group" to be the x-axis.
#and Make "Log2.Expression.Value" column the y-axis.
# Make the fill color corrrespond to the column, "group" too.
# Make the border color corrrespond to the column, "group" as well.


bar1 <- ggbarplot(ITGA2B.Expn, x = "Sample", y = "Log2.Expression.Value", #set x and y axis to the column names "name" and "mpg".
                  fill = "group",               # change fill color by column "cyl".
                  color = "group",            # Set bar border colors to white
                  sort.val = "desc",          # Sort the values in dscending order
                  sort.by.groups = TRUE,      # sort inside each group
                  x.text.angle = 90)

bar1

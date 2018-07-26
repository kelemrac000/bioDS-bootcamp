#Starter Script for Rackeb adn Jordan

#7/17/18 


#Purpose: Subset expression data and visualize sample-wise correlations. 


############ Load Libraries ################

# 1)We will need to load libraries. The libraries we need are:  tidyverse, corrplot, and ggplot2,
#For tidyvese, see https://www.tidyverse.org/packages/ and follow the instructions. 
#For corrplot, see the tutorial http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram 
#Now, try ggplot2 on your own. 



############ Read in the data files ############

# 2) read in the expression data 

#The expression data is normalize to "transcripts per million" (TPMs). We will talk about normalization soon
# *Important*: We used normalized data to allow for sample to sample comparisons. 

#hint:
# what type of file is it? look at the suffix (.csv, .txt )
#which function would you choose based on the suffix? 

#This one is given to you. uncomment this and complete the code
#TPMs <- read.csv(, row.names=1)



#We need the gene names to be rownames. 
#look at read.csv() documentation to see why we used the row.names argument. 
?read.csv()
?rownames()

#add code to the first few lines and the dimensions of the data.frame. 
?head
?dim




#3) read in the clinical data elements (CDE) file, 

#uncomment this and complete the code
#CDE <- 



#add code to the first few lines and the dimensions of the data.frame. 




#4) read in reference file, Homo_Sapiens_Entrez_Gene_IDs.txt.  


#uncomment this and complete the code
#ref <- 
  


#add code to the first few lines and the dimensions of the data.frame. 





############### Data Exploration and Manipulation ###############


# 5)Look at the first patient's ISCN. Use the dataframe[row#,column#] (slice notation) syntax.
# An ISCN is a systematic way of describing an individuals karyotype using symbols and abbreviations. 





#What is a karyotype? review this video if you don't remember ( https://www.youtube.com/watch?v=hNMYV213xu0 ) 
#Just write the definition here and comment it out by adding a "#" in front. 






# 6) Look at the first patients ISCN using the row index (numeric) and the column name (string). dataframe[row#, column_name]
# Often it can be best to specify the column name when indexing. This avoids mistakes like adding a column and thus shifting the columns over. 
#That way you column 3 is now column 4, and re-running your code will introduce an error. 




# 7) Create a variable where you convert the column, "Age.at.Diagnosis.in.Days", to age in years.


#uncomment this and complete the code
# Age.In.Years <- 


# 8) Create a new column in CDE called "Age.in.years". Populate this column with
# the results from converting the column, "Age.at.Diagnosis.in.Days", to age in years. 
#Use base R.  So things like [] notation or $ notation.   


#example: data.frame[,"newColName"] <- c(1,2,3,4) / 2  



#add code to the first few lines and the dimensions of the updated data.frame. 
#This is to check that you added the information and its correct. 





# 9) Copy and paste, and then run 2 examples of  gsub() and one example of grep() from the documentation. Examples on the bottom of the page. 
#Explain what each example is doing. Pick simple examples that use functions you have seen before. 
?grep

?gsub


#What type of data is returned by grep? use class()


#What type of data is returned by gsub? use class()



# 10) Use head() to look at the first few lines of the "Chromosome" column in reference data.frame (ref). 
#The notation here is chromosome#, chromosome arm, and the location of G-bands where that gene is found. 




# example: gene A1BG is found at 19q13.43,  so chromosome 19, q arm, g-band sections 13.43
#we won't go into detail about the g-band sections here,so description of the g-bands here is NOT technical. 



# 11) Look at row 102 using slice notation. Describe chromosomal location it is found at.
#Example: data.frame[row, columnName]





# 12) Create a variable with the row numbers (called row indices) for genes that come from chromosome 21. 

#uncomment this and complete the code
#row.indices <- grep("^21[pq]", data.frame$columnName)


#here I gave you the regular expression to use since we didn't cover them yet. 
# Lets breakdown what "^21[pq]" is matching
# ^ means the strings begins with number 2, 
# 21 means that the strings 1 and 2 must follow each other exactly  
# [pq] means that 21 is followed by the letters p or q only. 
#Thus we get 


# 13) Create a new variable to subset the reference dataframe (ref) for genes on chromosome 21.  
#Use the variable row.indices to select the rows you want
#Example: data.frame[row.indices, ]


#uncomment this and complete the code
# chr.21.ref <- 


# write code to check on the dimensions of the subset reference. 




# 14) Use intersect to find the genes that are in both the reference data and the expression dataset. 
?intersect

#what type of objects does intersect need? does it take data.frames? matrices? vectors? lists?



#uncomment this and complete the code
# head(rownames(TPMs))
# head(chr.21.ref[,GeneSymbolColumn]) # you provide which column to use
# chr.21.genes <- intersect(rownames(TPMs), chr.21.ref[,GeneSymbolColumn])





# 15) Select the rows from TPMs expression matrix for genes that are on chromosome 21. 
#Use the vector chr.21.genes you created. Save it as a new variable. 
#Example: TPMs[object,]


#uncomment this and complete the code
# chr.21.expn <- 






################# Correlation Plots 


# 16) follow the tutorial:	http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram
#Add a lines of code here. Do NOT copy and paste. 
# Stop after "Changing the color and the rotation of text labels" section. Do Not compute P-values yet.
#We want to always understand the code we use. So we haven't covered this yet.  

#NOTE: We want to look at gene-wise correlations. So you should see gene symbols on the x and y axis. 





#17) Create a corrplot with the method="color" and with gene names in a readable size (fontsize change).  












############################################################
# Coursera: Exploratory Data Analysis: Course Project 2    #
#                                                          #
# Exploring PM2.5 pollution in the United States           #
#                                                          #
# Author: Sebastian Kraus @ Chung-Ang University, Seoul    #
############################################################


url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "data/FNEI.zip", method = "auto")
unzip("data/FNEI.zip", exdir = "data")

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

library(tidyverse)

# Q1:
# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

#finding the total emissions
em.total <- with(NEI, aggregate(Emissions, by = list(year), sum))

#plotting
plot(em.total$Group.1, em.total$x, 
     ylab = "PM2.5 Emissions (total) in tons", xlab = "Year", main = "PM2.5 Emissions in the United States" )

#adding a regression line
abline(lm(formula = x ~ Group.1,data = em.total))
dev.copy(png,"plot1.png",width=600, height=400); dev.off()

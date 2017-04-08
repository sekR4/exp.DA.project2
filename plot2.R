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

# Q2:
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

em.Baltimore <- filter(NEI, fips == 24510)
em.total.Baltimore <- with(em.Baltimore, aggregate(Emissions, by = list(year), sum))
plot(em.total.Baltimore$Group.1, em.total.Baltimore$x, 
     ylab = "PM2.5 Emissions (total) in tons", xlab = "Year", main = "PM2.5 Emissions in Baltimore")
abline(lm(formula = x ~ Group.1,data = em.total.Baltimore))
dev.copy(png,"plot2.png",width=600, height=400); dev.off()

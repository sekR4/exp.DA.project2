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

# Q3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases in emissions 
# from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

em.Baltimore <- filter(NEI, fips == 24510)

ggplot(data = em.Baltimore) + 
  geom_col(mapping = aes(x = factor(year), y = Emissions, fill = type))+
  facet_wrap(~type)  + labs(title = "Air pollution in Baltimore City from 1998 - 2008", 
                            subtitle = "By types of sources") + 
  ylab("PM2.5 Emissions (total) in tons") +  xlab("Year")
dev.copy(png,"plot3.png",width=600, height=400); dev.off()

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

# Q5: 
# How have emissions from motor vehicle sources changed 
# from 1999-2008 in Baltimore City?

#subsetting
em.baltimore <- NEI[NEI$fips=="24510",]
em.baltimore.motor.vehicle <- em.baltimore[em.baltimore$type=="ON-ROAD",]

#plotting
ggplot(data = em.baltimore.motor.vehicle) + 
  geom_col(mapping = aes(x = factor(year), y = Emissions))+
  labs(title = "Emissions from motor vehicle sources in Baltimore", 
       subtitle = "from 1999-2008") + 
  ylab("PM2.5 Emissions (total) in tons") +
  xlab("Year")
dev.copy(png,"plot5.png",width=600, height=400); dev.off()
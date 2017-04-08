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

# Q6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

#subsetting
em.bal.vs.cal <- NEI[NEI$fips=="24510" | NEI$fips =="06037",]
em.bal.vs.cal.m.v <- em.bal.vs.cal[em.bal.vs.cal$type=="ON-ROAD",]

#creating "City"-variable
em.bal.vs.cal.m.v <- mutate(em.bal.vs.cal.m.v, 
                            City = ifelse(em.bal.vs.cal.m.v$fips=="24510", 
                                          "Baltimore", "Los Angeles"))
#plotting
ggplot(data = em.bal.vs.cal.m.v) + 
  geom_col(mapping = aes(x = factor(year), y = Emissions, fill = City))+
  facet_grid(~City)+
  labs(title = "Emissions in Baltimore and Los Angeles from 1999-2008", 
       subtitle = "For motor vehicle sources") + 
  ylab("PM2.5 Emissions (total) in tons") +
  xlab("Year") + guides(fill=FALSE)
dev.copy(png,"plot6.png",width=600, height=400); dev.off()
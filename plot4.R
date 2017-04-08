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

# Q4:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

#creating a logical vector
coal.combustion.related <- with(SCC, grepl("comb", SCC.Level.One, ignore.case = T) |
                                  grepl("coal", SCC.Level.Three, ignore.case = T))
#filtering required SCC
c.c.r.SCC <- SCC[coal.combustion.related,]$SCC

#subsetting coal combustion-related observations
c.c.r.NEI <- NEI[NEI$SCC %in% c.c.r.SCC,]

#plotting
ggplot(data = c.c.r.NEI) + 
  geom_col(mapping = aes(x = factor(year), y = Emissions))+
  labs(title = "Coal combustion-related emissions across the US", 
       subtitle = "from 1999-2008") + ylab("PM2.5 Emissions (total) in tons") + 
  xlab("Year")
dev.copy(png,"plot4.png",width=600, height=400); dev.off()

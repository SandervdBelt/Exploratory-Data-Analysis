NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#since the call sum(is.na(NEI)) returned 0, I don't have to deal with NAs

NEI_Baltimore <- subset(NEI, fips=="24510")
NEI_Bal_year_type <- aggregate(Emissions ~ year+type, NEI_Baltimore, sum)

library(ggplot2)

p <- ggplot(NEI_Bal_year_type, aes(year, Emissions))
png <- p +
  geom_line(aes(color=factor(type)), size = 4) + 
  geom_smooth(aes(group=factor(type)), lty=2, method="lm", se=FALSE) + 
  theme_minimal(base_size = 12) +
  ggtitle("Total PM2.5 emissions in Baltimore 1999-2008 per type") +
  ylab("Emission in tons")
ggsave("Plot3.PNG", plot = png)

#Sadly I couldn't get the linear models to be colored as well, but this should do the trick.
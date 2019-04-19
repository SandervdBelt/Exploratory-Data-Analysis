NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#since the call sum(is.na(NEI)) returned 0, I don't have to deal with NAs

NEI_per_year <- tapply(NEI$Emissions, NEI$year, sum)
years <- unique(NEI$year)

png(filename="Plot1.png", width = 480, height = 480, units="px")
plot(years, NEI_per_year, xlab = "year", ylab = "Total emissions of PM2.5 (in tons)", main = "Sum of PM2.5 emissions registered by all stations", pch=19, col="green")
lines(years, NEI_per_year, col="green")
dev.off()
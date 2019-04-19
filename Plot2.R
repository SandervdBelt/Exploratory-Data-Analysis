NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#since the call sum(is.na(NEI)) returned 0, I don't have to deal with NAs

NEI_Baltimore <- subset(NEI, fips=="24510")
NEI_Baltimore_per_year <- tapply(NEI_Baltimore$Emissions, NEI_Baltimore$year, sum)
years <- unique(NEI_Baltimore$year)

png(filename="Plot2.png", width = 480, height = 480, units="px")
plot(years, NEI_Baltimore_per_year, xlab = "year", ylab = "Total emissions of PM2.5 (in tons)", main = "PM2.5 emissions registered by all Baltimore stations", pch=19, col="green")
lines(years, NEI_Baltimore_per_year, col="green")
dev.off()
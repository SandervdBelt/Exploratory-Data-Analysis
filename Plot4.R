NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#since the call sum(is.na(NEI)) returned 0, I don't have to deal with NAs

SCC_coal <- SCC[grepl("Coal", SCC$EI.Sector, ignore.case = TRUE),]
#As I couldn't find a README in the download, I just filtered the EI.Sector column for the occurence of "Coal", as combustion would seem the only way to extract energy from coal (?)
NEI_Coal <- NEI[NEI$SCC %in% SCC_coal$SCC,]
#Keeps only the rows for the SCC's with coal in their description
NEI_coal_per_year <- aggregate(Emissions ~ year, NEI_Coal, sum)
#this leaves a 4*2 table: 4 years with their total emission from coal-related sources

png(filename="Plot4.png", width = 480, height = 480, units="px")
with(NEI_coal_per_year, 
     plot(year, Emissions, 
     type="h", lwd=20, lend=1, ylim=c(0,600000), 
     yaxs="i", ylab="Emission in tons", main="Total PM2.5 Emission in the USA, 1999-2008"))
dev.off()
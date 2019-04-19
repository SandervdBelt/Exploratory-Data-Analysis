NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#since the call sum(is.na(NEI)) returned 0, I don't have to deal with NAs
NEI_Baltimore <- subset(NEI, fips=="24510")
SCC_motor <- SCC[grepl("Vehicles", SCC$EI.Sector, ignore.case = TRUE),]
#As I couldn't find a README in the download, I just filtered the EI.Sector column for the occurence of "Vehicles", as combustion would seem the only way to extract energy from coal (?)
NEI_Bal_vehicles <- NEI_Baltimore[NEI_Baltimore$SCC %in% SCC_motor$SCC,]
#Keeps only the rows for the SCC's with "vehicle" in their description
NEI_Bal_veh_per_year <- aggregate(Emissions ~ year, NEI_Bal_vehicles, sum)
#this leaves a 4*2 table: 4 years with their total emission from coal-related sources

png(filename="Plot5.png", width = 480, height = 480, units="px")
with(NEI_Bal_veh_per_year,
     plot(year, Emissions, 
          type="h", lwd=20, lend=1, ylim=c(0,400), yaxs="i",
          ylab="Emission in tons", main="PM2.5 Emissions from vehicles in Baltimore, 1999-2008"))
with(NEI_Bal_veh_per_year, abline(lm(Emissions ~ year)))
dev.off()
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#since the call sum(is.na(NEI)) returned 0, I don't have to deal with NAs
NEI_Baltimore <- subset(NEI, fips=="24510")
NEI_LA <- subset(NEI, fips=="06037")
SCC_motor <- SCC[grepl("Vehicles", SCC$EI.Sector, ignore.case = TRUE),]
#As I couldn't find a README in the download, I just filtered the EI.Sector column for the occurence of "Vehicles", as combustion would seem the only way to extract energy from coal (?)
NEI_Bal_vehicles <- NEI_Baltimore[NEI_Baltimore$SCC %in% SCC_motor$SCC,]
NEI_LA_vehicles <- NEI_LA[NEI_LA$SCC %in% SCC_motor$SCC,]
#Keeps only the rows for the SCC's with "vehicle" in their description
NEI_Bal_veh_per_year <- aggregate(Emissions ~ year, NEI_Bal_vehicles, sum)
NEI_LA_veh_per_year <- aggregate(Emissions ~ year, NEI_LA_vehicles, sum)
#this leaves two 4*2 table2: 4 years with their total emission from coal-related sources for both LA & Baltimore
NEI_both_veh_year <- cbind(NEI_LA_veh_per_year, NEI_Bal_veh_per_year$Emissions)
names(NEI_both_veh_year) <- c("year", "LA_Emissions", "Bal_Emissions")

# Getting LA & Baltimore in 1 plot is tricky, as LA is quite a bit more polluted. So I'm using 2 separate y-axes. Resource from
# https://www.r-bloggers.com/r-single-plot-with-two-different-y-axes/

png(filename="Plot6.png", width = 480, height = 480, units="px")
par(mar = c(4,5,3,5))
with(NEI_both_veh_year,
     plot(year, LA_Emissions, type="l", col="red", lwd=3, ylab="LA: Emission in tons", xlab="years", main="PM2.5 Emission from motor vehicles in Baltimore & LA, 1999-2008"))
par(new=T)
with(NEI_both_veh_year,
     plot(year, Bal_Emissions, axes=F, type="l", col="green", lwd=3, ylab=NA, xlab=NA))
axis(side=4)
mtext(side=4, line=3, "Baltimore: Emissions in tons")
legend("topright", legend=c("LA", "Baltimore"), lty=c(1,1), col=c("red", "green"))
dev.off()
# My first code in Git Hub
# Let's install the raster package
install.packages("raster")
library(raster)

# Import data, setting the working directory for Windows
setwd("C:/Lab/")

# Compact data together
l2011 <- brick("p224r63_2011_masked.grd")

# Plotting the data in a savage manner
plot(l2011)

# Gamma di colori per legenda
cl <- colorRampPalette(c("red","orange","yellow")) (100) #100 sono le sfumature
plot(l2011, col=cl)

# Plotting one element
plot(l2011[[4]],col=cl) #modo 1
plot(l2011$B4_sre,col=cl) #modo 2
nir <- l2011[[4]] #associare intera banda a un oggetto
plot(nir,col=cl) #modo 3

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# plot RGB layers
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Exercise: build a multiframe with visible RGB
# (linear stretch) on top of false colours
# (histogram stretch)
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")

#Exercise: plot the NIR band
plot(l2011[[4]])

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") #colori naturali
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") #componente rossa
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin") #componente verde
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin") #infrarosso montato su componente blu

#Import the 1988 image
l1988 <- brick("p224r63_1988_masked.grd")
plot(l1988)
#Plot in RGB space (natural colours)
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Lin")

#multiframe
par(mfrow=c(2,1))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")

#hist
plotRGB(l2011, 4, 3, 2, stretch="Hist")

#multiframe with 4 images
par(mfrow=c(2,2))
plotRGB(l1988, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l1988, r=3, g=4, b=2, stretch="Hist")
plotRGB(l2011, r=3, g=4, b=2, stretch="Hist")








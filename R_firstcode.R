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

# Exercise: upload the image from 1988
l1988 <- brick("p224r63_1988.grd")

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")





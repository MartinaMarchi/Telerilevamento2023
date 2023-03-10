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




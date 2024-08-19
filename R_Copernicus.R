library(raster)

install.packages("ncdf4")
library(ncdf4)
library(ggplot2)
library(viridis)

# register and download data from:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

ssoil <- raster("~/Downloads/c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")

ssoil

plot(ssoil)

ggplot() +
+ geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))

# with viridis
ggplot() +
geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
scale_fill_viridis(option="magma")

# R code for downloading and visualizing Copernicus data

# 1- Packages
# install.packages("ncdf4")
library(ncdf4)
library(raster)

# 2- Working directory
setwd("C:/lab/")

# 3- Importing imagery
sc <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")

# 4- Plotting the image
plot(sc)

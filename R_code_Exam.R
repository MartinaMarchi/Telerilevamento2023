# Caricamento delle librerie necessarie
library(raster) # Per la gestione dei raster e delle immagini satellitari
library(ggplot2) # Per la visualizzazione grafica
library(viridis) # Per una palette di colori avanzata
library(patchwork)

# Impostazione della directory di lavoro
setwd("C:/Telerilevamento/")

# Caricamento delle immagini satellitari Sentinel-2 pre e post Tempesta Vaia
s2_pre <- raster("October_2018.jp2") # Immagine pre-tempesta (Ottobre 2018)
s2_post <- raster("December_2018.jp2")  # Immagine post-tempesta (Dicembre 2018)

# Caricamento delle singole bande (NIR, Red, Green, Blue) pre e post-tempesta
# Immagini prima della tempesta (ottobre 2018)
s2_pre_nir <- raster("October_2018_nir.jp2")
s2_pre_red <- raster("October_2018_red.jp2")
s2_pre_green <- raster("October_2018_green.jp2")
s2_pre_blue <- raster("October_2018_blue.jp2")

# Immagini dopo della tempesta (dicembre 2018)
s2_post_nir <- raster("December_2018_nir.jp2")
s2_post_red <- raster("December_2018_red.jp2")
s2_post_green <- raster("December_2018_green.jp2")
s2_post_blue <- raster("December_2018_blue.jp2")

# Visualizzazione delle immagini pre e post-tempesta
plot(s2_pre)
plot(s2_post)

# Creazione di una lista di file pre-tempesta (Ottobre 2018)
rlist_pre <- list.files(pattern="October_2018_")

# Caricamento e creazione di uno stack di immagini pre-tempesta
raster_pre <- lapply(rlist_pre, raster) 
stack_pre <- stack(raster_pre)  # Creazione stack pre-tempesta

# Creazione di una lista di file post-tempesta (Dicembre 2018)
rlist_post <- list.files(pattern="December_2018_")

# Caricamento e creazione di uno stack di immagini post-tempesta
raster_post <- lapply(rlist_post, raster)
stack_post <- stack(raster_post)  # Creazione stack post-tempesta

# Confronto immagini RGB pre e post Tempesta Vaia
par(mfrow=c(1,2)) 
plotRGB(stack_pre, 4,2,1, stretch="Lin")  # Pre-tempesta (RGB)
plotRGB(stack_post, 4,2,1, stretch="Lin")  # Post-tempesta (RGB)

# Confronto immagini a infrarossi pre e post Tempesta Vaia
par(mfrow=c(1,2)) 
plotRGB(stack_pre, 3,2,1, stretch="Lin")  # Pre-tempesta (infrarossi)
plotRGB(stack_post, 3,2,1, stretch="Lin")  # Post-tempesta (infrarossi)

# Definizione dell'estensione da ritagliare
ext <- c(650000, 670000, 5100000, 5140000)

# Ritaglio delle immagini alle dimensioni dell'estensione definita
s2_pre_nir_crop <- crop(s2_pre_nir, ext)
s2_pre_red_crop <- crop(s2_pre_red, ext)
s2_pre_green_crop <- crop(s2_pre_green, ext)

s2_post_nir_crop <- crop(s2_post_nir, ext)
s2_post_red_crop <- crop(s2_post_red, ext)
s2_post_green_crop <- crop(s2_post_green, ext)

# Creazione di stack pre-tempesta e post-tempesta
s2_pre_stack <- stack(s2_pre_red_crop, s2_pre_green_crop, s2_pre_nir_crop)
s2_post_stack <- stack(s2_post_red_crop, s2_post_green_crop, s2_post_nir_crop)

# Visualizzazione delle immagini infrarosse pre e post-tempesta
plotRGB(s2_pre_stack, r = 3, g = 1, b = 2, stretch = "lin", main = "Immagine Infrarossa Pre-Tempesta")
plotRGB(s2_post_stack, r = 3, g = 1, b = 2, stretch = "lin", main = "Immagine Infrarossa Post-Tempesta")

# Calcolo degli indici NDVI (Normalized Difference Vegetation Index) e NDWI (Normalized Difference Water Index)
ndvi_pre <- (s2_pre_nir_crop - s2_pre_red_crop) / (s2_pre_nir_crop + s2_pre_red_crop)
ndvi_post <- (s2_post_nir_crop - s2_post_red_crop) / (s2_post_nir_crop + s2_post_red_crop)

ndwi_pre <- (s2_pre_green_crop - s2_pre_nir_crop) / (s2_pre_green_crop + s2_pre_nir_crop)
ndwi_post <- (s2_post_green_crop - s2_post_nir_crop) / (s2_post_green_crop + s2_post_nir_crop)

# Definizione di una palette di colori
cl <- colorRampPalette(c('darkred', 'bisque2', 'blue', 'green'))(100)

# Confronto degli indici NDVI pre e post Tempesta Vaia
par(mfrow=c(2,2))
plot(ndvi_pre, col=cl, main="NDVI Ottobre 2018") # NDVI Pre-tempesta
plot(ndvi_post, col=cl, main="NDVI Dicembre 2018") # NDVI Post-tempesta

# Confronto degli indici NDWI pre e post Tempesta Vaia
plot(ndwi_pre, col=cl, main="NDWI Ottobre 2018") # NDWI Pre-tempesta
plot(ndwi_post, col=cl, main="NDWI Dicembre 2018")  # NDWI Post-tempesta

# Creazione di dataframe dai raster per la visualizzazione con ggplot (post-tempesta)
ndvi_post_df <- as.data.frame(ndvi_post, xy=TRUE)
ndwi_post_df <- as.data.frame(ndwi_post, xy=TRUE)

# Visualizzazione grafica con ggplot (NDVI e NDWI post-tempesta)
p1 <- ggplot() +
  geom_raster(data=ndvi_post_df, mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option="magma") +
  ggtitle("NDVI Dicembre 2018")

p2 <- ggplot() +
  geom_raster(data=ndwi_post_df, mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option="plasma") +
  ggtitle("NDWI Dicembre 2018")

# Combinazione dei grafici post-tempesta con patchwork
p1 + p2

# Creazione di dataframe dai raster per la visualizzazione con ggplot (pre-tempesta)
ndvi_pre_df <- as.data.frame(ndvi_pre, xy=TRUE)
ndwi_pre_df <- as.data.frame(ndwi_pre, xy=TRUE)

# Visualizzazione grafica con ggplot (NDVI e NDWI pre-tempesta)
p3 <- ggplot() +
  geom_raster(data=ndvi_pre_df, mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option="magma") +
  ggtitle("NDVI Ottobre 2018")

p4 <- ggplot() +
  geom_raster(data=ndwi_pre_df, mapping=aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option="plasma") +
  ggtitle("NDWI Ottobre 2018")

# Combinazione dei grafici pre-tempesta con patchwork
p3 + p4

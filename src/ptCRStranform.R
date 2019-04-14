library(tidyverse)
library(data.table)
library(sp)

freadClip <- function(...) {
  X <- tempfile()
  writeLines(clipboard(), X)
  fread(X, ...)
}

wgs84TOtwd97 <- function() {
  freadClip() %>%
    as_tibble() %>%
    `colnames<-`(c("x", "y")) %>%
    `coordinates<-`(c("x", "y")) %>%
    `proj4string<-`(CRS("+init=epsg:4326")) %>%
    spTransform(CRS("+init=epsg:3826")) %>%
    as_tibble() %>%
    mutate(x = round(x, 0), y = round(y, 0)) %>%
    transmute(xy = paste0(x, "\t", y)) %>%
    pull(xy) %>%
    writeClipboard()
  
}

twd97TOwgs84 <- function() {
  freadClip() %>%
    as_tibble() %>%
    `colnames<-`(c("x", "y")) %>%
    `coordinates<-`(c("x", "y")) %>%
    `proj4string<-`(CRS("+init=epsg:3826")) %>%
    spTransform(CRS("+init=epsg:4326")) %>%
    as_tibble() %>%
    transmute(xy = paste0(x, "\t", y)) %>%
    pull(xy) %>%
    writeClipboard()
}

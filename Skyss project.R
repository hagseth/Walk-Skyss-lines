install.packages("XML")
install.packages("leaflet")

library(XML)
library(leaflet)

## Data set #1 
gpx_parsed <- htmlTreeParse(file = "Walking 2024-08-12T202527Z.gpx", useInternalNodes = TRUE)
gpx_parsed

coords <- xpathSApply(doc = gpx_parsed, path = "//trkpt", fun = xmlAttrs)
elevation <- xpathSApply(doc = gpx_parsed, path = "//trkpt/ele", fun = xmlValue)

df <- data.frame(
  lat = as.numeric(coords["lat", ]),
  lon = as.numeric(coords["lon", ]),
  elevation = as.numeric(elevation)
)

head(df, 10)
tail(df, 10)


## Data set #2
gpx_parsed_2 <- htmlTreeParse(file = "Walking 2024-10-05T122612Z.gpx", useInternalNodes = TRUE)
gpx_parsed_2

coords_2 <- xpathSApply(doc = gpx_parsed_2, path = "//trkpt", fun = xmlAttrs)
elevation_2 <- xpathSApply(doc = gpx_parsed_2, path = "//trkpt/ele", fun = xmlValue)

df_2 <- data.frame(
  lat = as.numeric(coords_2["lat", ]),
  lon = as.numeric(coords_2["lon", ]),
  elevation = as.numeric(elevation_2)
)

head(df, 10)
tail(df, 10)



leaflet() %>%
  addTiles() %>%
  addPolylines(data = df, lat = ~lat, lng = ~lon, color = "#000000", opacity = 0.8, weight = 3) %>%
  addPolylines(data = df_2, lat = ~lat, lng = ~lon, color = "#eb3434", opacity = 0.8, weight = 3) 

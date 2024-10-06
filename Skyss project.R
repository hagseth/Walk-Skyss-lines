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



#Plotting the routes using leaflet

leaflet() %>%
  addTiles() %>%
  addProviderTiles(providers$   Stadia.OSMBright)%>%
  addPolylines(
    data = df, 
    lat = ~lat, 
    lng = ~lon, 
    color = "#000000",
    opacity = 0.9, 
    weight = 4,
  ) %>%
  addPolylines(data = df_2, lat = ~lat, lng = ~lon, color = "#eb3434", opacity = 0.9, weight = 4) %>%
  addLabelOnlyMarkers(
    lat = 60.391128, 
    lng = 5.279552, 
    label = "1", 
    labelOptions = labelOptions(
      noHide = TRUE,
      direction = "center",
      textsize = "15px",
      style = list("color" = "#000", "font-weight" = "bold", "background" = "rgba(255,255,255,1)")
    )
    
  )


# Different maps
# Stadia.StamenTonerLite -- Black & White
# Stadia.AlidadeSmooth -- Black and white but smoother
# Stadia.OSMBright -- Ligner google maps - clean og har ikke for mange labels 
# Se full liste her - https://leaflet-extras.github.io/leaflet-providers/preview/index.html



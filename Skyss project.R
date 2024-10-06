install.packages("XML")
install.packages("leaflet")

library(XML)
library(leaflet)

## Dummy data 1 
gpx_parsed <- htmlTreeParse(file = "linje11.gpx", useInternalNodes = TRUE)


coords <- xpathSApply(doc = gpx_parsed, path = "//trkpt", fun = xmlAttrs)

df <- data.frame(
  lat = as.numeric(coords["lat", ]),
  lon = as.numeric(coords["lon", ])
)

head(df, 10)
tail(df, 10)


## Dummy data 2
gpx_parsed_2 <- htmlTreeParse(file = "Walking 2024-08-12T202527Z.gpx", useInternalNodes = TRUE)
gpx_parsed_2
coords_2 <- xpathSApply(doc = gpx_parsed_2, path = "//trkpt", fun = xmlAttrs)
df_2 <- data.frame(
  lat = as.numeric(coords_2["lat", ]),
  lon = as.numeric(coords_2["lon", ])
)




#Plotting the routes using leaflet

leaflet() %>%
  addTiles() %>%
  addProviderTiles(providers$Stadia.AlidadeSmooth)%>%
  addPolylines(
    data = df, 
    lat = ~lat, 
    lng = ~lon, 
    color = "#000000",
    opacity = 0.9, 
    weight = 2,
  ) %>%
  addPolylines(
    data = df_2, 
    lat = ~lat, 
    lng = ~lon, 
    color = "#eb3434", 
    opacity = 0.9, 
    weight = 2) %>%
  addLabelOnlyMarkers(
    lat = 60.389354, , 
    lng = 5.339223, 
    label = "11", 
    labelOptions = labelOptions(
      noHide = TRUE,
      direction = "center",
      style = list("color" = "#000", "font-weight" = "bold","font-size" = "10px", "background" = "rgba(255,255,255,1)")
    )
    
  )


# Different maps
# Stadia.StamenTonerLite -- Black & White
# Stadia.AlidadeSmooth -- Black and white but smoother
# Stadia.OSMBright -- Ligner google maps - clean og har ikke for mange labels 
# Se full liste her - https://leaflet-extras.github.io/leaflet-providers/preview/index.html



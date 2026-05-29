# Load necessary libraries
library(sf)
library(rnaturalearth)
library(rnaturalearthhires)
library(ggplot2)

# 1. Data Loading
# Load your sample data (Ensure columns: name, longitude, latitude, type)
samples <- read.csv("data/samples.csv") 

# Convert to spatial object
samples_sf <- st_as_sf(samples, coords = c("longitude", "latitude"), crs = 4326)

# 2. Get Thailand Administrative Boundaries
thai_sf <- ne_states(country = "Thailand", returnclass = "sf")

# 3. Create Map Plot
map_plot <- ggplot() +
  # Background map
  geom_sf(data = thai_sf, fill = "white", color = "gray70") +
  # Sample points
  geom_sf(data = samples_sf, aes(color = type), size = 3) +
  theme_minimal() +
  theme(panel.grid.major = element_line(color = "gray90"))
print(map_plot)

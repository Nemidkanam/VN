# --- NMDS Plotting Script ---
# Install the packages
install.packages(c("vegan", "ggplot2"))

# Load necessary libraries
library(vegan)
library(ggplot2)

# Set working directory to the project root
# Use relative paths:
arg_data <- read.csv("data/NMDS.csv", row.names = 1)
meta <- read.csv("data/NMDS_metadata.csv")

# 1. Calculate Jaccard distance matrix
dist_matrix <- vegdist(arg_data, method = "jaccard")

# 2. Run NMDS
set.seed(123)
nmds_results <- metaMDS(dist_matrix, k = 2, trymax = 100)
print(paste("Stress value:", round(nmds_results$stress, 3)))

# 3. Prepare data for ggplot
nmds_coords <- as.data.frame(nmds_results$points)
colnames(nmds_coords) <- c("NMDS1", "NMDS2")
nmds_coords$Sample_ID <- rownames(nmds_coords)

# Merge with metadata
nmds_coords <- merge(nmds_coords, meta[, c("Sample_ID", "source")], by = "Sample_ID", all.x = TRUE)
nmds_coords$source <- as.factor(nmds_coords$source)

# 4. Plot using ggrepel (cleaner than geom_text)
ggplot(nmds_coords, aes(x = NMDS1, y = NMDS2, color = source)) +
  geom_point(size = 3, alpha = 0.7) +
  stat_ellipse(type = "t", level = 0.95) + # Add 95% confidence ellipses
  geom_text(aes(label = Sample_ID), # Map the SampleID column to the label aesthetic
            vjust = -1, hjust = 0.5, # Adjust vertical and horizontal justification to position labels slightly above points
            size = 3) + # Adjust label size as needed
  labs(title = "NMDS of ARGs in Pork Meat vs. Cecum",
       x = "NMDS1", y = "NMDS2") +
  theme_minimal()

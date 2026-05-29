# Load necessary libraries
library(tidyverse)
library(scales)

# 1. Load Data
SNP_data <- read.csv("data//SNPs_number.csv")

# 2. Build Distance Matrix
# Get unique strains from both columns
all_strains <- unique(c(SNP_data$strain1, SNP_data$strain2))
snp_matrix <- matrix(0, nrow = length(all_strains), ncol = length(all_strains),
                     dimnames = list(all_strains, all_strains))

# Populate the matrix
for (i in 1:nrow(SNP_data)) {
  s1 <- SNP_data$strain1[i]
  s2 <- SNP_data$strain2[i]
  div <- SNP_data$SNPs_in_clonal[i]
  snp_matrix[s1, s2] <- div
  snp_matrix[s2, s1] <- div
}

# 3. Hierarchical Clustering
# Clustering helps identify clonal groups (blocks of low SNP counts)
dist_obj <- as.dist(snp_matrix)
hc <- hclust(dist_obj, method = "average")
reordered_strains <- hc$labels[hc$order]

# 4. Prepare Long Format Data for ggplot
df_reordered_long <- as.data.frame(snp_matrix) %>%
  rownames_to_column("strain1") %>%
  pivot_longer(cols = -strain1, names_to = "strain2", values_to = "SNPs_in_clonal") %>%
  mutate(strain1 = factor(strain1, levels = reordered_strains),
         strain2 = factor(strain2, levels = rev(reordered_strains)))

# 5. Plotting with Cutoff visualization
SNPsinclonal_cutoff <- 10

p_clustered <- ggplot(df_reordered_long, aes(x = strain1, y = strain2, fill = SNPs_in_clonal)) +
  geom_tile(color = "black") + 
  geom_text(aes(label = round(SNPs_in_clonal, 0)), color = "black", size = 2.5) + 
  scale_fill_gradientn(
    name = "Clonal SNPs",
    colors = c("white", "pink", "purple"),
    values = rescale(c(min(df_reordered_long$SNPs_in_clonal),
                       SNPsinclonal_cutoff - 0.5,
                       SNPsinclonal_cutoff,
                       max(df_reordered_long$SNPs_in_clonal))),
    limits = c(0, max(df_reordered_long$SNPs_in_clonal))
  ) +
  labs(
    title = "Clonal SNP Number Matrix",
    subtitle = paste0("Color shift highlights divergence at >", SNPsinclonal_cutoff, " SNPs"),
    x = "Strain",
    y = "Strain"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    axis.text.y = element_text(size = 8),
    panel.grid.major = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

print(p_clustered)

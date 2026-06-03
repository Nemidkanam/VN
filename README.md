# Bioinformatics Analysis Pipeline for Bacterial Genomics

This repository contains the analytical workflow and code used to process, analyze, and visualize genomic data for ESBL-producing *Escherichia coli* isolated from pig farms in Thailand.

## Project Components

### 1. Geographic Mapping
Visualizes the geographic distribution of study sites.
* **Key Functionality**: Integrates administrative boundaries, maps study sites, and manages site labels.
* **Core Libraries**: `sf`, `rnaturalearth`, `rnaturalearthhires`, `ggrepel`.

### 2. NMDS Analysis (Antimicrobial Resistance Genes)
Analyzes and visualizes differences in antimicrobial resistance gene (ARG) or virulent factor (VF) profiles between sample sources.
* **Key Functionality**: Calculates Jaccard distance matrices, performs non-metric multidimensional scaling (NMDS) ordination, and visualizes groupings with 95% confidence ellipses.
* **Core Libraries**: `vegan`, `ggplot2`.

### 3. ST48 SNP Divergence Heatmap
Identifies clonal relationships and transmission clusters among ST48 strains.
* **Key Functionality**: Computes pairwise SNP distance matrices, performs hierarchical clustering, and generates a heatmap with a defined divergence cutoff.
* **Core Libraries**: `tidyverse`.

## System Requirements
* **R Version**: 4.0 or higher.
* **Dependencies**: To install all required libraries, run:
  ```R
  install.packages(c("tidyverse", "sf", "rnaturalearth", "rnaturalearthhires", "ggplot2", "ggrepel", "vegan"))
  
## How to Run
1. **Prepare Data**: Ensure your data is located in a `/data` subfolder.
   - `SNPs_number_ST48.csv`: Must contain columns `strain1`, `strain2`, and `SNPs_in_clonal`.
   - `samples.csv`: Must contain columns `name`, `longitude`, `latitude`, and `type`.
   - `NMDS.csv`: A matrix of ARG or VF presence/absence (samples as rows, genes as columns).
   - `NMDS_metadata.csv`: A table containing `Sample_ID` and `source` columns.
2. **Execute Scripts**: Run the scripts in the `/scripts` directory in order:
   - `plot_thai_map.R` (Generates the spatial distribution map).
   - `NMDS_analysis.R` (Generates the NMDS Jaccard distance matrices).
   - `cluster_snp_heatmap.R` (Generates the SNP divergence matrix).

## License
This code is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Reproducibility & Archival
This repository is linked to Zenodo to provide a persistent DOI. Please cite this repository and the associated publication when using these scripts.
<a href="https://doi.org/10.5281/zenodo.20519663"><img src="https://zenodo.org/badge/1252984816.svg" alt="DOI"></a>

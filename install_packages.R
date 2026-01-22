# Install Missing Packages for TCGA Viral Etiology Analysis

cat("========================================\n")
cat("TCGA Analysis Package Installation\n")
cat("========================================\n\n")

# Check if BiocManager is installed
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    cat("Installing BiocManager...\n")
    install.packages("BiocManager")
}

cat("\nInstalling Bioconductor packages...\n")
cat("(This may take some time!)\n\n")

bioc_packages <- c(
    "DESeq2", # Differential expression analysis
    "clusterProfiler", # GSEA and pathway enrichment
    "enrichplot", # Enrichment visualization
    "org.Hs.eg.db", # Human genome annotation
    "DOSE", # Disease ontology
    "EnhancedVolcano" # Volcano plots
)

# Install Bioconductor packages
BiocManager::install(bioc_packages, update = FALSE, ask = FALSE)

cat("\n\nInstalling CRAN packages...\n")

cran_packages <- c(
    "survminer" # Survival plot enhancements
)

install.packages(cran_packages, dependencies = TRUE)

cat("\n\n========================================\n")
cat("Installation Complete!\n")
cat("========================================\n\n")

cat("Verifying installation...\n")

all_packages <- c(bioc_packages, cran_packages)
success <- 0
failed <- c()

for (pkg in all_packages) {
    if (requireNamespace(pkg, quietly = TRUE)) {
        cat(sprintf("✓ %s\n", pkg))
        success <- success + 1
    } else {
        cat(sprintf("✗ %s FAILED\n", pkg))
        failed <- c(failed, pkg)
    }
}

cat(sprintf(
    "\n\nSummary: %d/%d packages installed successfully\n",
    success, length(all_packages)
))

if (length(failed) > 0) {
    cat("\nFailed packages:\n")
    for (pkg in failed) {
        cat(sprintf("  - %s\n", pkg))
    }
    cat("\nPlease try installing failed packages manually:\n")
    cat(sprintf(
        "BiocManager::install(c(%s))\n",
        paste(sprintf('"%s"', failed), collapse = ", ")
    ))
} else {
    cat("\nAll packages installed successfully!\n")
    cat("You can now run the TCGA_Viral_Etiology_Analysis.Rmd notebook.\n")
}

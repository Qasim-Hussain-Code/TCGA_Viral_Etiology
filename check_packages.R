# Quick package check
pkgs <- c(
    "tidyverse", "readr", "DESeq2", "clusterProfiler", "enrichplot",
    "org.Hs.eg.db", "DOSE", "survival", "survminer", "EnhancedVolcano",
    "ggrepel", "pheatmap", "cowplot", "RColorBrewer", "rmarkdown"
)

cat("Checking required packages...\n\n")
missing <- c()
installed <- c()

for (pkg in pkgs) {
    if (requireNamespace(pkg, quietly = TRUE)) {
        installed <- c(installed, pkg)
        cat(sprintf("✓ %s\n", pkg))
    } else {
        missing <- c(missing, pkg)
        cat(sprintf("✗ %s (MISSING)\n", pkg))
    }
}

cat(sprintf("\n\nSummary:\n"))
cat(sprintf("Installed: %d/%d packages\n", length(installed), length(pkgs)))
cat(sprintf("Missing: %d packages\n", length(missing)))

if (length(missing) > 0) {
    cat("\nTo install missing packages, run:\n\n")

    # Separate CRAN and Bioconductor packages
    bioc_pkgs <- c(
        "DESeq2", "clusterProfiler", "enrichplot", "org.Hs.eg.db",
        "DOSE", "EnhancedVolcano"
    )
    cran_missing <- setdiff(missing, bioc_pkgs)
    bioc_missing <- intersect(missing, bioc_pkgs)

    if (length(cran_missing) > 0) {
        cat(sprintf(
            "install.packages(c(%s))\n",
            paste(sprintf('"%s"', cran_missing), collapse = ", ")
        ))
    }

    if (length(bioc_missing) > 0) {
        cat("\nif (!require('BiocManager')) install.packages('BiocManager')\n")
        cat(sprintf(
            "BiocManager::install(c(%s))\n",
            paste(sprintf('"%s"', bioc_missing), collapse = ", ")
        ))
    }
} else {
    cat("\nAll required packages are installed!\n")
}

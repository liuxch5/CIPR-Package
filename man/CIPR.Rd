% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CIPR.R
\name{CIPR}
\alias{CIPR}
\title{Cluster Identity Predictor}
\usage{
CIPR(
  input_dat,
  comp_method = "logfc_dot_product",
  reference = NULL,
  select_ref_subsets = "all",
  custom_reference = NULL,
  custom_ref_annot = NULL,
  keep_top_var = 100,
  plot_ind = F,
  plot_top = T,
  top_num = 5,
  save_png = F,
  global_plot_obj = T,
  global_results_obj = T,
  update_ref = T,
  ...
)
}
\arguments{
\item{input_dat}{Data frame containing normalized log2-transformed gene
expression values per cluster OR a table of differentially expressed genes
per cluster}

\item{comp_method}{Method to use for identity score calculations. It accepts
one of the following: "logfc_dot_product" (default), "logfc_spearman",
"logfc_pearson", "all_genes_spearman", "all_genes_pearson"}

\item{reference}{Reference data frame containing gene expression data from
known cell types. It accepts one of the following: "immgen" (default),
"mmrnaseq", "blueprint", "hpca", "dice", "hema", "hsrnaseq", "custom"}

\item{select_ref_subsets}{The names of cell subsets to be included in the
analysis. For using the entire reference dataset use "all", or
provide a character vector of cell types of interest. Defaults to "all"}

\item{custom_reference}{A data frame containing custom reference. There must
be a column named 'gene' and other columns contain normalized gene expression
data from known samples. Defaults to NULL}

\item{custom_ref_annot}{A data frame containing custom reference metadata.
This is optional to get more informative results from CIPR. The data
frame must contain columns named 'short_name' (must match column names in
custom reference), 'long_name' (human readable names for reference samples),
'description' (details such as positive and negative sorting markers),
'reference_cell_type' (e.g. T cell, B cell, NK)}

\item{keep_top_var}{Top n percent of highly variant reference genes to
include in the analysis. It accepts a numeric value smaller than or equal
to 100 (default). The value of 100 results in keeping all the genes in the
reference dataset)}

\item{plot_ind}{Logical value. Set it to TRUE to plot identity scores for
each cluster. Defaults to FALSE}

\item{plot_top}{Logical value. set it to TRUE to plot top scoring reference
cell types for each cluster. Defaults ot TRUE.}

\item{top_num}{A numeric value determining how many top scoring reference
cell types will be plotted for each cluster. Defaults to 5.}

\item{save_png}{Logical value. Set it to TRUE if you would like to export png
images of the results. Defaults to FALSE}

\item{global_plot_obj}{Logical value. Set it to TRUE if you would like to
keep the plots as an object in the global environment. This can be useful
for accessing and manipulating the graphs. Defaults to TRUE.}

\item{global_results_obj}{Logical value. Set it to TRUE if you would like to
keep the analysis results as a global object. Defaults to TRUE.}

\item{...}{arguments to pass to theme() (for graph manipulation)}
}
\value{
Graphical outputs and/or data frames of identity scores calculated
for each cluster in the input data.
}
\description{
CIPR (Cluster Identity PRedictor) is a pipeline that helps annotating
unknown single cell clusters in single cell RNA sequencing (scRNAseq experiments).
This function scores unknown cluster gene expression signatures against known reference
datasets using user-selected analytical approaches to facilitate scRNAseq analysis.
}
\examples{

# Example of using CIPR in conjunction with Seurat
library(Seurat)
allmarkers <- FindAllMarkers(seurat_object)
avgexp <- AverageExpression(seurat_object)

# Using built-in immgen as reference and logfc dot product method
CIPR(input_dat = allmarkers,
comp_method = "logfc_dot_product",
reference="immgen",
keep_top_var = 100,
global_results_obj = T,
plot_top = T)

#' # Using built-in immgen as reference and all genes spearman method

CIPR(input_dat = avgexp,
comp_method = "all_genes_spearman",
reference="immgen",
keep_top_var = 100,
global_results_obj = T,
plot_top = T)


# Using built-in dice reference and logFC spearman method
# Variance threshold of top 50\%

CIPR(input_dat = allmarkers,
comp_method = "logfc_spearman",
reference="dice",
keep_top_var = 50,
global_results_obj = T,
plot_top = T)


# Using a custom reference

CIPR(input_dat = allmarkers,
comp_method = "logfc_dot_product",
reference="custom",
custom_ref_dat_path = custom_ref_df,
custom_ref_annot_path = custom_annot_df,
keep_top_var = 100,
global_results_obj = T,
plot_top = T)


# Using a blueprint-encode reference and limiting the analysis
# to "Pericytes", "Skeletal muscle", "Smooth muscle"

CIPR(input_dat = allmarkers,
comp_method = "logfc_dot_product",
reference="blueprint-encode",
select_ref_subsets = c("Pericytes", "Skeletal muscle", "Smooth muscle")
keep_top_var = 100,
global_results_obj = T,
plot_top = T)

# Using built in example data (logFC signatures per cluster)
CIPR(input_dat = example_logfc_data,
comp_method = "logfc_dot_product",
reference="blueprint-encode",
select_ref_subsets = c("Pericytes", "Skeletal muscle", "Smooth muscle")
keep_top_var = 100,
global_results_obj = T,
plot_top = T)


# Using built in example data (average expression)
CIPR(input_dat = example_avgexp_data,
comp_method = "all_spearman",
reference="immgen",
select_ref_subsets = "all",
keep_top_var = 100,
global_results_obj = T,
plot_top = T)

}

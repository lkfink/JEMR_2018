# Analysis stack for attmap_v1p2 data
# Set analyses to be performed by populating perform.an with vector of prefered 
# analyses (e.g., to perform analyses 2 and 3, set perform.an <- c(2, 3))
#
# 08 OCT 2015 - BH
# Most updated version - 20170719
# LF - making edits for her attmap experiments
# LF - 20180328 - making final edits for plots for attmap pupil paper
# LF - 20180816 - adding effect size calculation
# LF- 20180907 - use 'updated_models_r1_LF.R' for stats; use this for fig. 3 plot
##############

library(dplyr)

# load functions for this analysis

# These aren't necessary (from previous versions)
#source('~/svn/private/R/attmap/attmap_v1p2/attmap_subj_analysis.R')
#source('~/svn/private/R/attmap/attmap_v1p2/attmap_v1p2_import_data.R')

# Function to clean data, converts subIDs to integers, detects duplicates and removes
source('~/Documents/JanataLab/CodeRepos/private/R/attmap/attmap_v1p2/attmap_v1p2_clean_data.R')

# Various plots - uses ggplot - good for comparison to Brain's 
source('~/Documents/JanataLab/CodeRepos/private/R/attmap/attmap_v1p2/attmap_v1p2_plots.R')

# Replicate these from Brian's
source('~/Documents/JanataLab/CodeRepos/private/R/attmap/attmap_v1p2/attmap_v1p2_stats_v2.R')

##########################################################################
# import data
##########################################################################

# store the current directory
# hang onto this because switch a lot for data etc. 
start.dir <- getwd()

# specify file paths
data.path <- "~/Documents/JanataLab/attmap_R/tables/"
fig.path <- "~/Documents/JanataLab/attmap_R/figs/"
stats_out.path <- "~/Documents/JanataLab/attmap_R/stats/"

# load data
setwd(data.path) # set data path as working directory
# used to be "attmap_v1p2_eyetrack_thresh_data2.csv"
thresh.data <- read.csv("attmap_v1p2_eyetrack_thresh_data_updated.csv", header = T, sep = ",", 
                        na.strings = "") # %>% tbl_df()


##########################################################################
# Perform analyses
##########################################################################

# SPECIFY ANALYSES TO PERFORM:
perform.an <- c(1,2,3) # vector in which elements = analysis numbers

na <- 0 # initialize analysis counter

#######################################
# ANALYSIS 1: clean data
na <- na + 1

# check if this analysis wanted
if(!is.na(match(na,perform.an))) {
  cat(sprintf("\nPEROFRMING ANALYSIS %d . . .\n", na))
  params.clean <- list()
  clean.data <- attmap_v1p2_clean_data(thresh.data)
}

#######################################
# ANALYSIS 2: statistical tests
na <- na + 1
if(!is.na(match(na,perform.an))) {
  cat(sprintf("\nPEROFRMING ANALYSIS %d . . .\n", na))
  params.stats <- list()
  params.stats$out_fpath <- stats_out.path
  params.stats$out_fname <- "attmap_v1p2_R_stat_v2_results_20180907.txt"
  params.stats$write_outfile <- 1 # flag if want
  stats.v1p2 <- attmap_v1p2_stats_v2(clean.data, params.stats)
}

######################################
# ANLAYSIS 3: generate plots
#TODO: CHECK - regression line seems different than original plots. think something switched with most recent R version
na <- na + 1
if(!is.na(match(na,perform.an))) {
  cat(sprintf("\nPEROFRMING ANALYSIS %d . . .\n", na))
  params.plots <- list()
  params.plots$fpath <- fig.path
  params.plots$plot_scatter <- 0
  params.plots$plot_subjdata <- 1
  params.plots$plot_blockAnalysis <- 0
  #effect_size.reson <- lmm_effect_size(full_model=thresh_mod1, reduced_model=reduced_model.res)
  p <- attmap_v1p2_plots(clean.data, stats.v1p2, params.plots)
  
}

setwd(start.dir)

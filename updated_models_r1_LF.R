# Behavioral threshold analyses for attmap_pupil paper
# Note that other testing had previously been done to determine that adding a random slope 
# to these models did not improve fit (i.e. anova(mod1_noslope, mod2_slope)). 
# LF - last edited 20180907

# Load mixed effects package
require(nlme)
# Load custom function for effect size calculation
source('~/Documents/JanataLab/CodeRepos/private/R/utils/lmm_effect_size.R')

# load data
data.path <- "~/Documents/JanataLab/attmap_R/tables/"
setwd(data.path) # set data path as working directory
thresh.data <- read.csv("attmap_v1p2_eyetrack_thresh_data_updated.csv", header = T, sep = ",", 
                        na.strings = "") %>% tbl_df()

# Function to clean data, converts subIDs to integers, detects duplicates and removes
source('~/Documents/JanataLab/CodeRepos/private/R/attmap/attmap_v1p2/attmap_v1p2_clean_data.R')

# clean data
thresh.data <- attmap_v1p2_clean_data(thresh.data)

# optimize convergence iteration limit
ctrl <- lmeControl(opt='optim')

# Original model used:
# simple model w/ fixed effect of interest: resonator 
cat("\n################\nModel w/out random slope included\n")
cat("\n################\nResonator output\n")
thresh_mod1 <- lme(mean_pdf ~ reson_out, control=ctrl,
                   data = thresh.data, random = ~ 1|subject_id,
                   na.action=na.exclude, method="REML")

print(summary(thresh_mod1))

cat("\n######################\nEFFECT SIZES\n")
reduced_model.res <- update(thresh_mod1, . ~ . - reson_out)
effect_size.reson <- lmm_effect_size(full_model=thresh_mod1, reduced_model=reduced_model.res)
cat("\n")
print(sprintf('f^2 effect size of reson_out: %f', effect_size.reson))
cat("\n")

cat("\n################\nEnvelope output\n")
thresh_mod1 <- lme(mean_pdf ~ envVal, control=ctrl,
                   data = thresh.data, random = ~ 1|subject_id,
                   na.action=na.exclude, method="REML")

print(summary(thresh_mod1))

cat("\n######################\nEFFECT SIZES\n")
reduced_model.res <- update(thresh_mod1, . ~ . - envVal)
effect_size.reson <- lmm_effect_size(full_model=thresh_mod1, reduced_model=reduced_model.res)
cat("\n")
print(sprintf('f^2 effect size of envVal: %f', effect_size.reson))
cat("\n")

cat("\n################\nFull reson output\n")
thresh_mod1 <- lme(mean_pdf ~ fullResonVal, control=ctrl,
                   data = thresh.data, random = ~ 1|subject_id,
                   na.action=na.exclude, method="REML")

print(summary(thresh_mod1))

cat("\n######################\nEFFECT SIZES\n")
reduced_model.res <- update(thresh_mod1, . ~ . - fullResonVal)
effect_size.reson <- lmm_effect_size(full_model=thresh_mod1, reduced_model=reduced_model.res)
cat("\n")
print(sprintf('f^2 effect size of full reson output: %f', effect_size.reson))
cat("\n")

  
  
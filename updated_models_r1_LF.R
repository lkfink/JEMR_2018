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





## Plot ##################################################################################
# load graphics packages
library(ggplot2)
library(lattice)
library(grid)

stats.v1p2 <- attmap_v1p2_stats_v2(thresh.data, params.stats)
params.plots <- list()
params.plots$fpath <- fig.path
params.plots$plot_scatter <- 0
params.plots$plot_subjdata <- 1
params.plots$plot_blockAnalysis <- 0

# get LMM intercepts and slope for plotting and add to data frame
rand_ints <- stats.v1p2$simple_mod$coefficients$random$subject_id[,'(Intercept)']
rand_slopes <- stats.v1p2$simple_mod$coefficients$random$subject_id[,'reson_out']
fixed_int <- stats.v1p2$simple_mod$coefficients$fixed['(Intercept)']
fixed_slope <- stats.v1p2$simple_mod$coefficients$fixed['reson_out']
lmm_sub_names <- rownames(stats.v1p2$simple_mod$coefficients$random$subject_id)

thresh.data$lmm_intercept <- rep(NA, length=length(thresh.data$subject_id))
thresh.data$lmm_slope <- rep(NA, length=length(thresh.data$subject_id))
subj_names = levels(thresh.data$subject_id)
for(sub in 1:length(subj_names)){
  lmm_sub_idx <- which(lmm_sub_names==subj_names[sub])
  
  # if current subject not found in lmm data, skip this iteration
  # (we don't have Ensemble data for one subject, so if Ensemble-dependent
  # variables included in LMM model, that subject is omitted)
  if(length(lmm_sub_idx)==0){
    next
  }
  
  data_sub_idx <- grep(subj_names[sub], thresh.data$subject_id)
  # get this subject's intercept and the fixed LMM reson_out slope
  thresh.data$lmm_intercept[data_sub_idx] <- fixed_int + rand_ints[lmm_sub_idx]
  thresh.data$lmm_slope[data_sub_idx] <- rand_slopes[lmm_sub_idx]
}



# plot of individual subjects' performance

  
# open PDF device for writing to file
fig.path <- "~/Documents/JanataLab/attmap_R/figs/"
plot_fname = file.path(fig.path,"attmap_v1p2_subject_data_20180907.pdf")
pdf(file = plot_fname)
  
if(length(subj_names) != length(lmm_sub_names)){
  nonmatching_sub <- setdiff(subj_names, lmm_sub_names)
  thresh.data <- subset(thresh.data, !(subject_id %in% nonmatching_sub))
}
  
  
  # plot subject scatter
sp <- ggplot(thresh.data, aes(x=reson_out, y=mean_pdf)) +
    #pdf(file = plot_fname) +
    # add LMM fit line
  geom_abline(aes(intercept=lmm_intercept, slope=lmm_slope)) +
  facet_wrap( ~ subject_id, ncol=6) +
  ylab("Intensity Increment Detection Threshold (dB SPL)")
  
sp <- sp + geom_point() + xlab("Resonator Amplitude") + ylim(c(0, 20)) +
  theme_classic() + theme(axis.title.y=element_text(size=14)) +
  theme(axis.text.y=element_text(size=8)) +
  theme(axis.title.x=element_text(size=14)) +
  theme(axis.text.x=element_text(size=8))
print(sp)
  
  # close graphics device
dev.off()
remove(plot_fname)
  
  
# Attmap_pupil 
# Comparing models for pupil glm
# LF - last edited 20180907

# Load custom function for effect size calculation
source('~/Documents/JanataLab/CodeRepos/private/R/utils/lmm_effect_size.R')

# store the current directory
start.dir <- getwd()

# specify file paths
data.path <- "~/Documents/JanataLab/attmap_R/tables/"
fig.path <- "~/Documents/JanataLab/attmap_R/figs/"
stats_out.path <- "~/Documents/JanataLab/attmap_R/stats/"

# load data
setwd(data.path) # set data path as working directory
pupil.data <- read.csv("pupMEM_hm.csv", 
                       header = T, sep = ",", na.strings = "")


# Load mixed effects package
require(lme4)
#require(lmerTest)
require(car)
#require(sjPlot)
require(multcomp)
library(caret)

# Load overdispersion function 
overdisp_fun <- function(model) {
  ## number of variance parameters in an n-by-n variance-covariance matrix
  vpars <- function(m) {
    nrow(m) * (nrow(m) + 1)/2
  }
  # The next two lines calculate the residual degrees of freedom
  model.df <- sum(sapply(VarCorr(model), vpars)) + length(fixef(model))
  rdf <- nrow(model.frame(model)) - model.df
  # extracts the Pearson residuals
  rp <- residuals(model, type = "pearson")
  Pearson.chisq <- sum(rp^2)
  prat <- Pearson.chisq/rdf
  # Generates a p-value. If less than 0.05, the data are overdispersed.
  pval <- pchisq(Pearson.chisq, df = rdf, lower.tail = FALSE)
  c(chisq = Pearson.chisq, ratio = prat, rdf = rdf, p = pval)
}

# fit generalized LMM logistic model on peak reson out with glmer
peakReson_mod <- glmer(hit ~ trialPupMean + 
                       resonOut + (1|subject_id), 
                     family=binomial(link="logit"), data=pupil.data, 
                     na.action=na.exclude,
                     control=glmerControl(optimizer="bobyqa", 
                                          optCtrl=list(maxfun=2e5)))



#sink(file.path(params$out_fpath, 'peakResonMod.txt'))
print(summary(peakReson_mod, corr=FALSE))
#sink()


#predictions <- predict(peakReson_mod, type = "response")
#mean(predictions, na.rm = TRUE) # .58916

p <- as.numeric(predict(peakReson_mod, type="response")>0.5)
mean(p==pupil.data$hit) # .61
table(p,pupil.data$hit) 

se <- sqrt(diag(vcov(peakReson_mod)))
# table of estimates with 95% CI
(tab <- cbind(Est = fixef(peakReson_mod), LL = fixef(peakReson_mod) - 1.96 * se, UL = fixef(peakReson_mod) + 1.96 *
                se))
exp(tab)




######################################################################
# fit generalized LMM logistic model on amp env with glmer
env_mod <- glmer(hit ~ trialPupMean + 
                         ampEnvVal + (1|subject_id), 
                       family=binomial(link="logit"), data=pupil.data, 
                       na.action=na.exclude,
                       control=glmerControl(optimizer="bobyqa", 
                                            optCtrl=list(maxfun=2e5)))
#sink(file.path(params$out_fpath, 'peakResonMod.txt'))
print(summary(env_mod, corr=FALSE))


p2 <- as.numeric(predict(env_mod, type="response")>0.5)
mean(p2==pupil.data$hit) # .60
table(p2,pupil.data$hit)

cc <- confint(env_mod,parm="beta_")  ## slow (~ 11 seconds)
ctab <- cbind(est=fixef(env_mod),cc)

check <- confint(env_mod,parm="beta_",method="Wald")

se <- sqrt(diag(vcov(env_mod)))
# table of estimates with 95% CI
(tab <- cbind(Est = fixef(env_mod), LL = fixef(env_mod) - 1.96 * se, UL = fixef(env_mod) + 1.96 *
                se))
exp(tab)


library(pROC)
roc.test(pupil.data$hit ~ fitted(peakReson_mod) + fitted(env_mod))
a = predict(peakReson_mod, type=c("response"))
b = predict(env_mod, type=c("response"))
roc.test(pupil.data$hit ~ a + b)


attmap_v1p2_stats_v2 <- function(thresh.data, params) {

        # Preliminary statistical analysis for attmap intensity deviance threshold data (attmap_v1p2)
        # 23 May 2015 BH - started script
        # 16 Dec 2015 BH - reorganized code into a function to adapt to attmap_v1p2_analyses.R 
        #                       analysis job stack; added txt output of results
        # LF edited for attmap_pupil - 20180907
        
        # Load mixed effects package
        require(nlme)
        # Load custom function for effect size calculation
        source('~/Documents/JanataLab/CodeRepos/private/R/utils/lmm_effect_size.R')
        
        # set output file
        sink(file.path(params$out_fpath,params$out_fname))
        
        # optimize convergence iteration limit
        ctrl <- lmeControl(opt='optim')
        
        cat("\nEvaluating fixed effects of . . .\n\n")
        
        # LMM w/ random effects of subjects' slopes and intercepts
        cat("\n################\nModel w/ random slope included\n")
        cat("\n################\nResonator output\n")
        thresh_mod.simp <- lme(mean_pdf ~ 1, data = thresh.data, random = ~ reson_out|subject_id,
                               na.action=na.exclude, method="REML")
        print(summary(thresh_mod.simp))
        
        
        # simple model w/ fixed effect of interest: resonator 
        cat("\n################\nModel w/out random slope included\n")
        cat("\n################\nResonator output\n")
        thresh_mod1 <- lme(mean_pdf ~ reson_out, #control=ctrl,
                                        data = thresh.data, random = ~ 1|subject_id,
                                        na.action=na.exclude, method="REML")
        
        print(summary(thresh_mod1))
        
        
        
        cat("\n######################\nEFFECT SIZES\n")
        cat("\n######################\nOn models w/out rand slope included\n")
        # reson_out effect size
        reduced_model.res <- update(thresh_mod1, . ~ . - reson_out)
        # if use model with random slope and intercept, cannot calculate effect size
       
        effect_size.reson <- lmm_effect_size(full_model=thresh_mod1, reduced_model=reduced_model.res)
        
        cat("\n")
        print(sprintf('f^2 effect size of reson_out: %f', effect_size.reson))
        cat("\n")
        
        
        sink()
        
        lmm.mod <- list()
        lmm.mod$simple_mod <- thresh_mod.simp
        lmm.mod$final_mod <- thresh_mod.simp #final_model
        
        return(lmm.mod)
        
}
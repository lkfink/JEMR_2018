# plot data from attmap_v1p2 experiment
# 
# Aug 2015 - BH
##########################################

attmap_v1p2_plots <- function(thresh.data, stats.v1p2, params) {

        # load graphics packages
        library(ggplot2)
        library(lattice)
        library(grid)
        
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
        
        
        ########################################
        # scatter plots of reson amplitude X threshold
        if(params$plot_scatter){
                # open PDF device for writing to file
                plot_fname = file.path(params$fpath,"attmap_v1p2_resonXthresh_scatter_20180907.pdf")
                pdf(file = plot_fname)
                
                # build plot layers
                sp <- ggplot(thresh.data, aes(x = reson_out, y = mean_pdf)) +
                        geom_point() + 
                        geom_smooth(se=FALSE, method="lm", color="black") +
                        xlab("Resonator Amplitude") + ylab("Increment Detection Threshold (dB SPL)") +
                        theme_classic(base_size = 16) + theme(legend.position="top")
                print(sp)       
                
                # close graphics device
                dev.off()
                remove(plot_fname)
        }
        
        ###########################################
        # # plot of individual subjects' performeance
        # if(params$plot_subjdata){
                
                # # open PDF device for writing to file
                # plot_fname = file.path(params$fpath,"attmap_v1p2_subject_data.pdf")
                # pdf(file = plot_fname)
                
                # if(length(subj_names) != length(lmm_sub_names)){
                        # nonmatching_sub <- setdiff(subj_names, lmm_sub_names)
                        # thresh.data <- subset(thresh.data, !(subject_id %in% nonmatching_sub))
                # }
                
                
                # # plot subject scatter
                # sp <- ggplot(thresh.data, aes(x=reson_out, y=mean_pdf)) +
                        # #pdf(file = plot_fname) +
                        # # add LMM fit line
                        # geom_abline(aes(intercept=lmm_intercept, slope=lmm_slope)) +
                        # facet_wrap( ~ subject_id, ncol=7) +
                        # ylab("Intensity Increment Detection Threshold (dB SPL)")
                
                # sp <- sp + geom_point() + xlab("Resonator Amplitude") + ylim(c(0, 20)) +
                        # theme_classic() + theme(axis.title.y=element_text(size=14)) +
                        # theme(axis.text.y=element_text(size=8)) +
                        # theme(axis.title.x=element_text(size=14)) +
                        # theme(axis.text.x=element_text(size=8))
                # print(sp)
                
                # # close graphics device
                # dev.off()
                # remove(plot_fname)
                

        # }
        
        # LAUREN version! 
        # plot of individual subjects' performance
        if(params$plot_subjdata){
                
                # open PDF device for writing to file
                plot_fname = file.path(params$fpath,"attmap_v1p2_subject_data_20180907.pdf")
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
                

        }
        
        ###########################################
        # plot difference in performance over experiment blocks
        
        if(params$plot_blockAnalysis){
                
                # reson X thresh scatter by runs
                # open PDF device for writing to file
                plot_fname = file.path(params$fpath,"attmap_v1p2_block_analysis_scatter_20180907.pdf")
                pdf(file = plot_fname)
                
                block_analysis = xyplot(mean_pdf ~ reson_out | as.factor(run_num), thresh.data,
                                   grid = TRUE,
                                   type = c("p","r"), col.line = "red")
                print(block_analysis)
                
                # close graphics device
                dev.off()
                remove(plot_fname)
                
                #####################################
                # boxplot of thresholds by run
                # open PDF device for writing to file
                plot_fname = file.path(params$fpath,"attmap_v1p2_threshbyblock_boxplot.pdf")
                pdf(file = plot_fname)
                
                # build plot layers
                p <- ggplot(thresh.data, aes(x = as.factor(run_num), y = mean_pdf)) + 
                        geom_boxplot(aes(group = as.factor(run_num))) +
                        stat_summary(fun.y="mean", geom="point", size=2.5, shape = 23) +
                        xlab("Block #") +
                        ylab("Intensity Deviant Threshold (dB SPL)") +
                        theme_bw(base_size = 14)
                print(p)
                
                # close graphics device
                dev.off() 
                remove(plot_fname)
                
                #####################################
                # histogram of thresholds by run
                # open PDF device for writing to file
                plot_fname = file.path(params$fpath,"attmap_v1p2_threshbyblock_hist.pdf")
                pdf(file = plot_fname)
                
                # build plot layers
                p <- ggplot(thresh.data, aes(x = mean_pdf)) + 
                        geom_histogram() +
                        facet_wrap(~ run_num) +
                        theme_bw(base_size = 14) +
                        xlab("Intensity Deviant Threshold (dB SPL)")
                print(p)
                
                # close graphics device
                dev.off() 
                remove(plot_fname)
        }
}

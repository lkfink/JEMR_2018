# JEMR_2018
All materials in this repository are related to:

Fink, L. K., Hurley, B. K., Geng, J. J. & Janata, P. (2018). A linear oscillator model predicts dynamic temporal attention and pupillary entrainment to rhythmic patterns. *Journal of Eye Movement Research, 11*(2):12. DOI: 10.16910/jemr.11.2.12

This article was part of a [Special Issue on Music & Eye-Tracking in the Journal of Eye Movement Research (JEMR)](https://bop.unibe.ch/JEMR/issue/view/793). Please cite, if using anything in this repository. 

## Stimulus Presentation Code
If readers are interested in the stimulus presentation software developed for this experiment, please note that it was originally created by [Brian Hurley](https://github.com/bkhurley) and published in [this repository](https://github.com/janatalab/attmap) on the Janata Lab Github page. That version is purely behavioral. The version presented to participants in the JEMR study, required a few extensions from the original software for communication with the eye-tracking computer. 

### Dependencies
[Max/MSP](https://cycling74.com/products/max/) 5 or later

## Analysis Code
The MATLAB and R code in this repository was used to preprocess, statistically model, and plot behavioral and eye-tracking data. The data are not included in the repository. 

### Dependancies
The analysis code is presented for example purposes only and is not reproducable as is. This is because (1) some data are queried from the Janata Lab's MySQL server which requires authentication, and (2) some code relies on lab-general functions from our private Janata Lab repository. Interested readers can check out the [Janata Lab website](http://atonal.ucdavis.edu/resources/software/), which contains links to download a large percentage of our lab specific software, including the linear oscillator model discussed in the paper. 

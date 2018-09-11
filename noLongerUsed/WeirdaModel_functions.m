% Converstion of Weirda et al.'s pupil deconvolution model from R to matlab for use in Fink et al. Attention Mapping Experiments.
% Source file: pdd_functions.R
% Original source code and updates can be found at https://sourceforge.net/p/wierdapdd/

% Pupil dilation deconvolution method described in:
% Wierda, Van Rijn, Taatgen & Martens (submitted) Pupil dilation deconvolution reveals the 
% dynamics of attention at high temporal resolution.



%------------------------------------------------------------------------------------------%
function y = se(x) %Standard Error
	y = std(x)/sqrt(length(x));
end

%------------------------------------------------------------------------------------------%
function h = h_pupil(t,n,t_max,f) % Hoeks & Levelt pupillary response function

% n+1 = number of layers
% t_max = response maximum
% f = scaling factor

% (t,n=10.1,t_max=930,f=1/(10^27) )
h = f*(t^n)*exp(-n*t/t_max);
h(1) = 0;
return h
end

% confused about how this should be called and whether just f should be input and the others preset
%------------------------------------------------------------------------------------------%
function o = create_matrix_ones(n)
  o = eye(n); %are row and column names necessary? if yes, use table?
  return o
end
%------------------------------------------------------------------------------------------%

function o =  pupil_model_strength_slope(pars,locations,input_length,output_text,h)
% Again confused whether pars should be only input or what
% (pars,locations=NULL,input.length=145,output.text = FALSE,h=NULL)
if(~isempty(data.x))
    length_data = length(data.x);
    % The number of spikes to be fitted
    n = (length(pars))- 1;
    
    % Each subject has fixed locations for all conditions
    locations = locations;
    strengths = pars[1:n];
    slope = pars[n+1];
    
    if(output_text)
        fprintf('Values:\n')
        fprintf('\tLocations: %.03f \n',locations)
        fprintf('\tStrength: %.03f \n',strengths)
        fprintf('\tSlope: %.03f \n',slope)
        
        
        locations = floor(locations);
        i = zeros(1,input_length);
        loc_check = ((length(unique(locations)) == length(locations)) && (max(locations) < length(i) )) && !any(diff(locations)<0);
        % ^ what's going on here?
        
            fprintf('\tLocation check: %d\n',loc_check)
            
            
            if(loc_check)
                i[locations] = strengths;
                o = convolve(i,reverse(h),'valid'); % Double check bebacuse r and matlab conv functions seem a little different
                o = o + (1:length(o))*slope;
                
            else
                o = rep(1000,length_data);
            end
                
            else
                
                error('This function requires a global h and data.x variable containing the h-functions and pupil-data to be fitted\n')
                o = NaN;
    end
    return o[1:length_data];
end
                
                


%------------------------------------------------------------------------------------------%


end







% Original Functions (in R)

#####################################################################
########
########        Hoeks & Levelt pupillary response function
########
#####################################################################


h_pupil <- function(t,n=10.1,t_max=930,f=1/(10^27) )
  # n+1 = number of layers
  # t_max = response maximum
  # f = scaling factor
{
  h<-f*(t^n)*exp(-n*t/t_max)
  h[0] <- 0
  h
}

#####################################################################
########
########  			Functions for fitting the strength & slope 
########
#####################################################################

create.matrix.ones <- function(n)
{
  o <- c() %function to combine inputs
  for(i in 1:n)
  {
    tmp <- rep(0,n) % replicate
    tmp[i] <- 1
    o <- rbind(o,tmp)  % combine rows or columns
  }
  o
}

pupil.model.strength.slope <- function(pars,locations=NULL,input.length=145,output.text = FALSE,h=NULL)
{
  if(!is.null(data.x))
  {
    length_data <- length(data.x)
    # The number of spikes to be fitted
    n <- (length(pars))  - 1
    # Each subject has fixed locations for all conditions	
    
    locations <- locations
    strengths <- pars[1:n]		
    slope <- pars[n+1]
    
    if(output.text)
    {
      cat("Values:\n")
      cat("\tLocations:",locations,"\n")
      cat("\tStrength:",strengths,"\n")
      cat("\tSlope:",slope,"\n")
    }
    
    locations <- floor(locations)
    i <- rep(0,input.length)
    loc_check <- (( length(unique(locations)) == length(locations)) && (max(locations) < length(i) )) && !any(diff(locations)<0)
    
    if(output.text)
    {
      cat("\tLocation check:",loc_check,"\n")
    }
    
    
    if(loc_check)
    {
      i[locations] <- strengths
      o <- convolve(i,rev(h),type="open")
      o <- o + (1:length(o))*slope
    }
    else
    {
      o <- rep(1000,length_data)
    }
  }
  else
  {
    cat("ERROR: This function requires a global h and data.x variable containing the h-functions and pupil-data to be fitted\n")
    o <- NULL
  }
  o[1:length_data]
}


pupil.fit.strength.slope <- function(pars,locations=locations,input.length=145,output.text = FALSE,h=NULL)
{
  tmp_data <- data.x
  tmp_pred <- pupil.model.strength.slope(pars,locations,input.length,output.text,h)
  o <- sum((tmp_pred[1:length(tmp_data)] - tmp_data)^2)  
}

pupil.optim.strength.slope <- function(x,n=4,locations=NULL,input.length=145,output.text=FALSE,h=NULL)
{
  data.x <<- x
  ui <- create.matrix.ones(n+1)
  strength_ci <- rep(0,n)
  
  slope_ci <- -5
  
  # Constrains
  ci <- c(strength_ci,slope_ci)
  # Starting values
  strength_theta <- runif(n,0.01,0.25)
  slope_theta <- -2
  theta <- c(strength_theta,slope_theta)
  
  if(output.text)
  {
    tmp <- ui %*% theta - ci
    if(prod(tmp) > 0)
    {
      o <- TRUE
    }
    else
    {
      o <- FALSE
    }
    o	
    cat("Initial value check:",o,"\n")
    cat("\tCall to Optim function\n")
  }
  
  fit_pars <- constrOptim(f=pupil.fit.strength.slope,grad=NULL,theta= theta,ui=ui,ci=ci,outer.iterations = 10000,locations=locations,input.length=input.length,output.text=output.text,h=h)
  fit_pars
  
}

pddeconvolution <-function(size,time,pulse_locations)
{
  # <size> - a vector of pupil sizes
  # <time> - a vector of times corresponding to the samples in <size>
  # <pulse_locations> - the locations of the "pulses", not sure if in time or in samples (indicies)

  # this generates a PIRF (pupillary impluse response function) for the time vector <time>
  h <- h_pupil(time)
  h
  pulses <- 1:length(pulse_locations)
  model_pred <- pupil.optim.strength.slope(size,n=length(pulses),locations=pulse_locations,input.length=max(pulse_locations)+1,h=h)
  model_pred
  output <- c() # this is a stupid way to create a vector of length 0...
  output$pulses <- model_pred$par[pulses]
  output$slope <- model_pred$par[length(model_pred$par)]
  output
}

pdconvolution <-function(pulses,slope,time,pulse_locations)
{
  h <- h_pupil(time)
  output <- c()
  output <- data.frame(time=time,x=pupil.model.strength.slope(c(pulses,slope),locations=pulse_locations,input.length=max(pulse_locations)+1,h=h,output.text=F))
  output
}

line_green <-function(x,y,y_err)
{
  lines(x,y,lwd=2,col="darkgreen")
  
  err1 <- y - y_err
  err2 <- y + y_err
  
  lines(x,err1,type="l",col=c("darkgreen"),lwd=1,lty=2)
  lines(x,err2,type="l",col=c("darkgreen"),lwd=1,lty=2)
  polygon(c(x,rev(x)),c(err1,rev(err2)),col=rgb(0,100,0,30,maxColorValue=255),border=NA)
}

line_orange <-function(x,y,y_err)
{
  lines(x,y,lwd=2,col="darkorange")
  
  err1 <- y - y_err
  err2 <- y + y_err
  
  lines(x,err1,type="l",col=c("darkorange"),lwd=1,lty=2)
  lines(x,err2,type="l",col=c("darkorange"),lwd=1,lty=2)
  polygon(c(x,rev(x)),c(err1,rev(err2)),col=rgb(255,140,0,30,maxColorValue=255),border=NA)
}
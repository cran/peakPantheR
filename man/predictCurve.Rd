% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/curveFit_utils.R
\name{predictCurve}
\alias{predictCurve}
\title{Predict curve values}
\usage{
predictCurve(fittedCurve, x)
}
\arguments{
\item{fittedCurve}{(peakPantheR_curveFit) A 'peakPantheR_curveFit': a list of curve fitting parameters, curve shape model \code{curveModel} and nls.lm fit status \code{fitStatus}.}

\item{x}{(numeric) values at which to evaluate the fitted curve}
}
\value{
fitted curve values at x
}
\description{
Evaluate fitted curve values at \code{x} data points
}
\examples{
\dontrun{
## Input a fitted curve
fittedCurve <- list(amplitude=275371.1, center=3382.577, sigma=0.07904697, gamma=0.001147647,
                    fitStatus=2, curveModel="skewedGaussian")
class(fittedCurve)  <- 'peakPantheR_curveFit'
input_x     <- c(3290, 3300, 3310, 3320, 3330, 3340, 3350, 3360, 3370, 3380, 3390, 3400, 3410)

## Predict y at each input_x
pred_y      <- predictCurve(fittedCurve, input_x)
pred_y
# [1] 2.347729e-08 1.282668e-05 3.475590e-03 4.676579e-01 3.129420e+01 1.043341e+03 1.736915e+04
# [8] 1.447754e+05 6.061808e+05 1.280037e+06 1.369651e+06 7.467333e+05 2.087477e+05
}
}

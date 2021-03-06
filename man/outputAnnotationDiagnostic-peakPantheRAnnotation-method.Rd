% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/methods_peakPantheRAnnotation.R
\docType{methods}
\name{outputAnnotationDiagnostic,peakPantheRAnnotation-method}
\alias{outputAnnotationDiagnostic,peakPantheRAnnotation-method}
\alias{outputAnnotationDiagnostic}
\title{Save to disk the annotation parameters as CSV and a diagnostic plot per fitted compound
Save to disk the annotation parameters as CSV (as generated by \code{outputAnnotationParamsCSV()}) and a diagnostic plot per fitted compound (as generated by \code{annotationDiagnosticMultiplot()}) if \code{savePlots} is TRUE}
\usage{
\S4method{outputAnnotationDiagnostic}{peakPantheRAnnotation}(object, saveFolder,
  savePlots = TRUE, sampleColour = NULL, verbose = TRUE, ...)
}
\arguments{
\item{object}{(peakPantheRAnnotation) Annotated peakPantheRAnnotation object}

\item{saveFolder}{(str) Path of folder where annotationParameters_summary.csv and plots will be saved}

\item{savePlots}{(bool) If TRUE save a diagnostic plot for each compound}

\item{sampleColour}{(str) NULL or vector colour for each sample}

\item{verbose}{(bool) If TRUE message progress}

\item{...}{Additional parameters for plotting i.e. \code{sampling} for the number of points to employ when plotting fittedCurve}
}
\value{
None
}
\description{
Save to disk the annotation parameters as CSV and a diagnostic plot per fitted compound
Save to disk the annotation parameters as CSV (as generated by \code{outputAnnotationParamsCSV()}) and a diagnostic plot per fitted compound (as generated by \code{annotationDiagnosticMultiplot()}) if \code{savePlots} is TRUE
}

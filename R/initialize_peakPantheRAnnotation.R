#####################################################################
## Constructor for \link{peakPantheRAnnotation-class}, initialising a new peakPantheRAnnotation with default values, \code{spectraPaths} and \code{targetFeatTable} will set the samples and compounds to process
#' @description \code{peakPantheRAnnotation()}: create an instance of the \code{peakPantherAnnotation} class.
#'
#' @param spectraPaths NULL or a character vector of spectra file paths, to set samples to process
#' @param targetFeatTable NULL or a \code{\link{data.frame}} of compounds to target as rows and parameters as columns: \code{cpdID} (str), \code{cpdName} (str), \code{rtMin} (float in seconds), \code{rt} (float in seconds, or \emph{NA}), \code{rtMax} (float in seconds), \code{mzMin} (float), \code{mz} (float or \emph{NA}), \code{mzMax} (float). Set compounds to target.
#' @param cpdID A character vector of compound IDs, of length number of compounds
#' @param cpdName A character vector of compound names, of length number of compounds
#' @param ROI A data.frame of Regions Of Interest (ROI) with compounds as row and ROI parameters as columns: \code{rtMin} (float in seconds), \code{rt} (float in seconds, or \emph{NA}), \code{rtMax} (float in seconds), \code{mzMin} (float), \code{mz} (float or \emph{NA}), \code{mzMax} (float).
#' @param FIR A data.frame of Fallback Integration Regions (FIR) with compounds as row and FIR parameters as columns: \code{rtMin} (float in seconds), \code{rtMax} (float in seconds), \code{mzMin} (float), \code{mzMax} (float).
#' @param uROI A data.frame of updated Regions Of Interest (uROI) with compounds as row and uROI parameters as columns: \code{rtMin} (float in seconds), \code{rt} (float in seconds, or \emph{NA}), \code{rtMax} (float in seconds), \code{mzMin} (float), \code{mz} (float or \emph{NA}), \code{mzMax} (float).
#' @param filepath A character vector of file paths, of length number of spectra files
#' @param cpdMetadata A data.frame of compound metadata, with compounds as row and metadata as columns
#' @param spectraMetadata A data.frame of sample metadata, with samples as row and metadata as columns
#' @param acquisitionTime A character vector of acquisition date-time (converted from POSIXct) or NA
#' @param uROIExist A logical stating if uROI have been set
#' @param useUROI A logical stating if uROI are to be used
#' @param useFIR A logical stating if FIR are to be used
#' @param TIC A numeric vector of TIC or NA, of length number of spectra files
#' @param peakTables A list of peakTable data.frame, of length number of spectra files. Each peakTable data.frame has compounds as rows and peak annotation results as columns.
#' @param dataPoints A list of length number of spectra files. Each list element is a \emph{ROIsDataPoint} list of \code{data.frame} of raw data points for each ROI/uROI (retention time "rt", mass "mz" and intensity "int" (as column) of each raw data points (as row))
#' @param peakFit A list of length number of spectra files. Each list element is a \emph{curveFit} list of \code{peakPantheR_curveFit} or NA for each ROI
#' @param isAnnotated A logical stating in the annotation took place
peakPantheRAnnotation <- function(spectraPaths = NULL,
                                  targetFeatTable = NULL,
                                  cpdID = character(),
                                  cpdName = character(),
                                  ROI = data.frame(rtMin=numeric(), rt=numeric(), rtMax=numeric(), mzMin=numeric(), mz=numeric(), mzMax=numeric(), stringsAsFactors=F),
                                  FIR = data.frame(rtMin=numeric(), rtMax=numeric(), mzMin=numeric(), mzMax=numeric(), stringsAsFactors=F),
                                  uROI = data.frame(rtMin=numeric(), rt=numeric(), rtMax=numeric(), mzMin=numeric(), mz=numeric(), mzMax=numeric(), stringsAsFactors=F),
                                  filepath = character(),
                                  cpdMetadata = data.frame(),
                                  spectraMetadata = data.frame(),
                                  acquisitionTime = character(),
                                  uROIExist = FALSE,
                                  useUROI = FALSE,
                                  useFIR = FALSE,
                                  TIC = numeric(),
                                  peakTables = list(),
                                  dataPoints = list(),
                                  peakFit = list(),
                                  isAnnotated = FALSE) {

  ## set spectra if spectraPaths is provided
  if (!is.null(spectraPaths)){
    # check input
    # is a vector of character
    if (!is.vector(spectraPaths) | is.list(spectraPaths) | !is.character(spectraPaths)){
      stop("specified spectraPaths is not a vector of character")
    }
    # load values and allocate size
    nbSpectra         <- length(spectraPaths)
    filepath          <- spectraPaths
    # set acquisitionTime default if no acquisitionTime passed in
    if (length(acquisitionTime) == 0) {
      acquisitionTime <- as.character(rep(NA,nbSpectra))
    }
    # set TIC default if no TIC passed in
    if (length(TIC) == 0) {
      TIC             <- as.numeric(rep(NA,nbSpectra))
    }
    # set peakTables default if no peakTables passed in
    if (length(peakTables) == 0) {
      peakTables      <- vector("list", nbSpectra)
    }
    # set dataPoints default if no dataPoints passed in
    if (length(dataPoints) == 0) {
      dataPoints      <- vector("list", nbSpectra)
    }
    # set peakFit default if no peakFit passed in
    if (length(peakFit) == 0) {
      peakFit         <- vector("list", nbSpectra)
    }
    # set spectraMetadata to the correct size if no spectraMetadata passed in (at the correct size)
    if (dim(spectraMetadata)[1] != nbSpectra) {
      spectraMetadata <- data.frame(matrix(, nrow=nbSpectra, ncol=0))
    }
  }

  ## set compounds if targetFeatTable is provided
  if (!is.null(targetFeatTable)){
    # check input
    # is data.frame
    if (class(targetFeatTable) != "data.frame"){
      stop("specified targetFeatTable is not a data.frame")
    }
    # required columns are present
    if (!all(c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin", "mz", "mzMax") %in% colnames(targetFeatTable))){
      stop("expected columns in targetFeatTable are \"cpdID\", \"cpdName\", \"rtMin\", \"rt\", \"rtMax\", \"mzMin\", \"mz\" and \"mzMax\"")
    }
    # column type
    if (dim(targetFeatTable)[1] != 0){
      if (!is.character(targetFeatTable$cpdID[1])){
        stop("targetFeatTable$cpdID must be character")
      }
      if (!is.character(targetFeatTable$cpdName[1])){
        stop("targetFeatTable$cpdName must be character")
      }
      if (!is.numeric(targetFeatTable$rtMin[1])){
        stop("targetFeatTable$rtMin must be numeric")
      }
      if (!(is.numeric(targetFeatTable$rt[1]) | is.na(targetFeatTable$rt[1]))){
        stop("targetFeatTable$rt must be numeric or NA")
      }
      if (!is.numeric(targetFeatTable$rtMax[1])){
        stop("targetFeatTable$rtMax must be numeric")
      }
      if (!is.numeric(targetFeatTable$mzMin[1])){
        stop("targetFeatTable$mzMin must be numeric")
      }
      if (!(is.numeric(targetFeatTable$mz[1]) | is.na(targetFeatTable$mz[1]))){
        stop("targetFeatTable$mz must be numeric or NA")
      }
      if (!is.numeric(targetFeatTable$mzMax[1])){
        stop("targetFeatTable$mzMax must be numeric")
      }
    }
    # load values and allocate size
    nbCompound  <- dim(targetFeatTable)[1]
    cpdID       <- targetFeatTable$cpdID
    cpdName     <- targetFeatTable$cpdName
    ROI         <- targetFeatTable[,c("rtMin", "rt", "rtMax", "mzMin", "mz", "mzMax")]
    # set cpdMetadata to the correct size if no cpdMetadata passed in (at the correct size)
    if (dim(cpdMetadata)[1] != nbCompound) {
      cpdMetadata <- data.frame(matrix(, nrow=nbCompound, ncol=0))
    }
    # only set FIR and uROI to the correct size if not provided in input (at the correct size)
    if (dim(FIR)[1] != nbCompound) {
      FIR       <- data.frame(rtMin=as.numeric(rep(NA,nbCompound)), rtMax=as.numeric(rep(NA,nbCompound)), mzMin=as.numeric(rep(NA,nbCompound)), mzMax=as.numeric(rep(NA,nbCompound)), stringsAsFactors=F)
    }
    if (dim(uROI)[1] != nbCompound) {
      uROI      <- data.frame(rtMin=as.numeric(rep(NA,nbCompound)), rt=as.numeric(rep(NA,nbCompound)), rtMax=as.numeric(rep(NA,nbCompound)), mzMin=as.numeric(rep(NA,nbCompound)), mz=as.numeric(rep(NA,nbCompound)), mzMax=as.numeric(rep(NA,nbCompound)), stringsAsFactors=F)
      # if we reset, it doesn't exist
      uROIExist <- FALSE
      # if we reset, it can't be used
      useUROI   <- FALSE
    }
  }

  ## set the final values
  new("peakPantheRAnnotation", cpdID=cpdID, cpdName=cpdName, ROI=ROI, FIR=FIR, uROI=uROI, filepath=filepath, cpdMetadata=cpdMetadata, spectraMetadata=spectraMetadata, acquisitionTime=acquisitionTime, uROIExist=uROIExist, useUROI=useUROI, useFIR=useFIR, TIC=TIC, peakTables=peakTables, dataPoints=dataPoints, peakFit=peakFit, isAnnotated=isAnnotated)
}

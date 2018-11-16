#' Point cloud of two circles of different size and density with noise
#'
#' A dataset containing 350 randomly generated points.
#'
#' @name two_circle_noise_added_dat
#' @docType data
#' @keywords datasets
#' @usage data(two_circle_noise_added_dat)
#' @format A matrix of 350 rows and 2 columns
#' @examples
#' # load data
#' data(two_circle_noise_added_dat)
#'
#' # input variables
#' Xlim <- c(-3,4)
#' Ylim <- c(-3,3)
#' lim <- cbind(Xlim, Ylim)
#' by <- 0.05
#' spseq <- seq(0.01,0.7,length.out=100)
#'
#' # compute persistence terrace with parallel option
#' \dontrun{
#' two_circle_noise_pt <- computept(two_circle_noise_added_dat,sp=spseq,lim=lim,by=by,par=TRUE)
#'
#' # draw persistence terrace, satellite view
#' plotpt(two_circle_noise_pt,dimension=1)
#' }
NULL

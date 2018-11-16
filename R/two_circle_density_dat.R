#' Point cloud of two circles of same size but different point density
#'
#' A dataset containing 500 randomly generated points: 100 points from low point density circle and 400 from high point density circle.
#'
#' @name two_circle_density_dat
#' @docType data
#' @keywords datasets
#' @usage data(two_circle_density_dat)
#' @format A matrix of 500 rows and 2 columns
#' @examples
#' # load data
#' data(two_circle_density_dat)
#'
#' # input variables
#' Xlim <- c(-3,6)
#' Ylim <- c(-3,3)
#' lim <- cbind(Xlim, Ylim)
#' by <- 0.1
#' spseq <- seq(0.01,1,length.out=20)
#' 
#' # compute persistence terrace
#' two_circle_density_pt <- computept(two_circle_density_dat,sp=spseq,lim=lim,by=by)
#' 
#' \dontrun{
#' # compute persistence terrace with parallel option
#' two_circle_density_pt <- computept(two_circle_density_dat,sp=spseq,lim=lim,by=by,par=TRUE)
#' }
#' 
#' # draw persistence terrace, satellite view
#' plotpt(two_circle_density_pt,dimension=1)
NULL

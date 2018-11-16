#' Point cloud of two circles of same point density but different size
#'
#' A dataset containing 1000 randomly generated points: 200 points from a radius one circle and 800 points from a radius four circle.
#'
#' @name two_circle_size_dat
#' @docType data
#' @keywords datasets
#' @usage data(two_circle_size_dat)
#' @format A matrix of 1000 rows and 2 columns
#' @examples
#' # load data
#' data(two_circle_size_dat)
#'
#' # input variables
#' Xlim <- c(-4,13)
#' Ylim <- c(-7,7)
#' lim <- cbind(Xlim, Ylim)
#' by <- 0.1
#' spseq <- seq(0.01,3,length.out = 25)
#'
#' # compute persistence terrace with parallel option
#' \dontrun{
#' two_circle_size_pt <- computept(two_circle_size_dat,sp=spseq,lim=lim,by=by,par=TRUE)
#'
#' # draw persistence terrace, satellite view
#' plotpt(two_circle_size_pt,dimension=1)
#' }
NULL

#' Point cloud of three circles of different size and point density
#'
#' A dataset containing 600 randomly generated points: 200 points from each circle.
#'
#' @name three_circle_dat
#' @docType data
#' @keywords datasets
#' @usage data(three_circle_dat)
#' @format A matrix of 600 rows and 2 columns
#' @examples
#'
#' # load three circle data
#' data(three_circle_dat)
#'
#' # input variables
#' Xlim <- c(-4,12)
#' Ylim <- c(-4,9)
#' lim <- cbind(Xlim, Ylim)
#' by <- 0.2
#' spseq <- seq(0.01,1.5,length.out = 10)
#'
#' # compute persistence terrace
#' three_circle_pt <- computept(three_circle_dat,sp=spseq,lim=lim,by=by)
#' 
#' \dontrun{
#' # compute persistence terrace with parallel option
#' spseq <- seq(0.01,1.5,length.out = 30)
#' three_circle_pt <- computept(three_circle_dat,sp=spseq,lim=lim,by=by,par=TRUE)
#' }
#' 
#' # draw terrace area plot
#' terracearea(three_circle_pt,dimension=1)
#' # draw persistence terrace, satellite view
#' plotpt(three_circle_pt,dimension=1)
#' # draw persistence terrace, overall view
#' plotpt(three_circle_pt,dimension=1,satellite=FALSE)
NULL

#' Point cloud of four features; square, circle, equilateral and isosceles triangles
#'
#' A dataset containing 2,400 points of four features on the two-dimensional space: 400 points from a a square, 800 points from a circle and 1,200 points from two triangles.
#'
#' @name four_feature_dat
#' @docType data
#' @keywords datasets
#' @usage data(four_feature_dat)
#' @format A matrix of 2,400 rows and 2 columns
#' @examples
#' # load four feature dat
#' data(four_feature_dat)
#'
#' # input variables
#' Xlim <- c(-7,5)
#' Ylim <- c(-5,6)
#' lim <- cbind(Xlim, Ylim)
#' by <- 0.2
#' spseq <- seq(0.01,0.6,length.out = 10)
#' 
#' # compute barcodes
#' four_feature_pt <- computept(four_feature_dat,sp=spseq,lim=lim,by=by)
#' 
#' \dontrun{
#' # compute persistence terrace with parallel option
#' spseq <- seq(0.01,0.6,length.out = 30)
#' two_circle_density_pt <- computept(four_feature_dat,sp=spseq,lim=lim,by=by,par=TRUE)
#' }
#'
#' ## draw area plot
#' terracearea(four_feature_pt,dimension=1,maxheight=20)
#' ## draw persistence terrace
#' plotpt(four_feature_pt,cmax=6,dimension=1)

NULL

#' Point cloud sampled from the muscle tissue cross-sectional image
#'
#' A dataset containing 6,500 points: 5,000 points sampled from the muscle fiber image and 1,500 points sampled from the boundary lines of the image.
#'
#' @name muscle_fiber_dat
#' @docType data
#' @keywords datasets
#' @usage data(muscle_fiber_dat)
#' @format A matrix of 6,500 rows and 2 columns
#' @examples
#' # load muscle fiber data
#' data(muscle_fiber_dat)
#'
#' # input variables
#' Xlim <- c(-50,350)
#' Ylim <- c(-50,250)
#' lim <- cbind(Xlim, Ylim)
#' by <- 6
#' spseq <- seq(2,40,length.out = 9)
#'
#' # compute persistence terrace
#' muscle_fiber_pt=computept(muscle_fiber_dat,sp=spseq,lim=lim,by=by)
#'
#' \dontrun{
#' # compute persistence terrace with parallel option
#' spseq <- seq(2,40,length.out = 30)
#' two_circle_density_pt <- computept(muscle_fiber_dat,sp=spseq,lim=lim,by=by,par=TRUE)
#' }
#' 
#' # draw terrace area plot
#' terracearea(muscle_fiber_pt,dimension=1,maxheight=20)
#' # draw persistence terrace
#' plotpt(muscle_fiber_pt,cmax=12,dimension=1)

NULL

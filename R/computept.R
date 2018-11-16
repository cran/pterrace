#' Computes a persistence terrace of point cloud data.
#'
#' Computes a persistence terrace of point cloud data for given smoothing parameters. For the detailed explanation of the parameters \code{data}, \code{sp}, \code{fun}, \code{lim}, \code{by}, \code{lib}, \code{sublevel}, see the R package \code{TDA}. A parallel option is available to reduce computation time.
#'
#' @param data a matrix of n by d, a point cloud of n points in d dimensions.
#' @param sp a vector of smoothing parameter values to be used in the persistence terrace.
#' @param fun a smoothing function. The default is the Gaussian kernel density estimator.
#' @param lim a 2 by d matrix specifying the range of space to compute. The default value is \code{NULL}.
#' @param by a numeric value or vector that specifies the grid. The default value is \code{NULL}.
#' @param lib a library to compute persistent homology. The default is "Dionysus".
#' @param maxdimension a integer of specifying the maximum dimension of persistence terrace to compute.
#' @param sublevel a logical value selecting whether persistent homology is computed to super-level sets (\code{FALSE}) or sub-level sets (\code{TRUE}). The default value is \code{FALSE}.
#' @param par if \code{TRUE}, the user can compute the persistence terrace in parallel using multiple cores. The default value is FALSE.
#' @param ncore an integer selecting the number of cores to use when parallel computing option is selected. The default value is \code{NULL}.
#' @import TDA
#' @import foreach
#' @import doParallel
#' @import parallel
#' @return The function \code{computept} returns a list of the computed persistence terraces up to given dimension. For each dimension, the computed persistence terrace includes the following components:
#' @return \item{x}{The vector of the smoothing parameters used in computation. The x-axis of the persistence terrace.}
#' @return \item{y}{The vector of filtration where the Betti number changes. The y-axis of the persistence terrace.}
#' @return \item{z}{The matrix of Betti numbers.}
#' @export
#'
#' @examples
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
#' threecirclept <- computept(three_circle_dat,sp=spseq,lim=lim,by=by)
#' 
#' \dontrun{
#' # compute persistence terrace with parallel option
#' spseq <- seq(0.01,1.5,length.out = 30)
#' threecirclept <- computept(three_circle_dat,sp=spseq,lim=lim,by=by,par=TRUE)
#' }


computept <-
function(data,sp,fun=kde,lim=NULL,by=NULL,maxdimension=max(NCOL(data)),lib="Dionysus",sublevel=FALSE,par=FALSE,ncore=NULL) {
	if (is.numeric(sp)==FALSE) warning("'sp' needs to be a numeric vector")

  nsp=length(sp)
  totalbars=list()

	if (par==FALSE) {
		for (ii in 1:nsp) {
			diag=TDA::gridDiag(data,FUN=fun,h=sp[ii],lim=lim,by=by,sublevel=sublevel,maxdimension=maxdimension,library=lib)
			totalbars[[ii]]=diag$diagram
		}
	}
	else if (par==TRUE) {
		cores=parallel::detectCores()
		if (is.null(ncore)==TRUE) {
		  if (cores>1) { # multi-core processor, compute parallel with #(cores)-1
		    cl = parallel::makeCluster(cores[1]-1)
		    doParallel::registerDoParallel(cl)
		    foreach::foreach (ii=1:nsp) %do% {
		      diag=TDA::gridDiag(data,FUN=fun,h=sp[ii],lim=lim,by=by,sublevel=sublevel,maxdimension=maxdimension,library=lib)
		      totalbars[[ii]]=diag$diagram
		    }
		    parallel::stopCluster(cl)
		  }
		  else {# single-core processor
		    for (ii in 1:nsp) {
		      diag=gridDiag(data,FUN=fun,h=sp[ii],lim=lim,by=by,sublevel=sublevel,maxdimension=maxdimension,library=lib)
		      totalbars[[ii]]=diag$diagram
		    }
		  }
		}
		else if (is.null(ncore)==FALSE) {
			if (ncore<1 || ncore%%1!=0)  warning("'ncore' needs to be a positive integer")
			if (cores<ncore) warning("The selected number of cores needs to be smaller")
			else {
				doParallel::registerDoParallel(ncore)
				foreach::foreach (ii=1:nsp) %do% { # multi-core processor, compute parallel with given ncores
					diag=TDA::gridDiag(data,FUN=fun,h=sp[ii],lim=lim,by=by,sublevel=sublevel,maxdimension=maxdimension,library=lib)
				  totalbars[[ii]]=diag$diagram
				}
				parallel::stopCluster(ncore)
			}
		}
	}
	else warning("The parallel option 'par' should be either TRUE or FALSE")

  track=list()
  for (ii in 0:maxdimension) {
    track[[ii+1]]=list()
    for (jj in 1:nsp) {
      bars=totalbars[[jj]]
      ## select barcodes of dimension k, k is ii
      kbars=bars[which(bars[,1]==ii),,drop=FALSE]
      if ( is.nan(mean(kbars))==1 ) {
        numofk=1
        track[[ii+1]][[jj]]=cbind(0,0)
      }
      else {
        ## label the changes of the circle numbers: 1 for birth and -1 for death
        ### (Birth & Death), (number of k-dimensional holes changes, +1 and -1)
        numofk=cbind(c(kbars[,3],kbars[,2]),c(rep(1,dim(kbars)[1]),rep(-1,dim(kbars)[1])))
        ## sort the birth and death according to the filtration value
        numofk=numofk[order(-numofk[,1]),]
        # track the number of circles by summing the changes
        numtrack=cumsum(numofk[,2])
        ## save the result to the (jj)th list in track[[ii+1]]
        track[[ii+1]][[jj]]=cbind(numofk[,1],numtrack)
      }
    }
  }

  xyz=list()
  for (ii in 0:maxdimension) {
    totalres=NULL
    y=NULL
    z=NULL
    for (jj in 1:nsp) {
      totalres=rbind(totalres,track[[ii+1]][[jj]])
    }
    y=sort(totalres[,1],decreasing = TRUE)
    zmat=matrix(0,length(y),length(sp))
    for (jj in 1:nsp) {
      sptrack=track[[ii+1]][[jj]]
      z=rep(0,length(y))
      for (kk in 1:dim(sptrack)[1]) {
        ### fill out number of k dimensional holes for all y values
        z=z+(y<=sptrack[kk])*(y>sptrack[kk+1])*sptrack[kk,2]
      }
      ### save jjth column of zvalue matrix
      zmat[,jj]=z
    }
    xyz[[ii+1]]=list(x=sp,y=y,z=zmat)
  }
  return(xyz)
}

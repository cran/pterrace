#' Draws a terrace area plot for a persistence terrace.
#'
#' @param xyz a list of computed persistence terraces returned by the function \link{computept}.
#' @param dimension an integer selecting the dimension of the persistence terrace to plot the terrace area plot.
#' @param maxheight an integer specifying the maximum heights to show. The default value is \code{NULL}.
#' @return The function \code{terracearea} returns the terrace area plot.
#' @importFrom graphics lines plot text
#' @export
#' @keywords graphics
#' @examples
#' \dontrun{
#' # load three circle data
#' data(three_circle_dat)
#'
#' # input variables
#' Xlim <- c(-4,12)
#' Ylim <- c(-4,9)
#' lim <- cbind(Xlim, Ylim)
#' by <- 0.1
#' spseq <- seq(0.01,1.5,length.out = 25)
#'
#' # compute persistence terrace
#' threecirclept <- computept(three_circle_dat,sp=spseq,lim=lim,by=by)
#'
#' # draw terrace area plot
#' terracearea(threecirclept,dimension=1)
#' }



terracearea <-
function(xyz,dimension,maxheight=NULL) {
	if (is.null(maxheight)==TRUE) {
		xyz=xyz[[dimension+1]]
		if (sum(sum(xyz$z))==0) warning("There is no terrace layer")
		xdist=diff(c(0,xyz$x)/max(xyz$x) )
  ydist=diff(sort(c(0,xyz$y),decreasing = F)/max(xyz$y))
  # zvalue matrix is the same is the plot (from large y to small y by from small x to large x)
  ydist=rev(ydist)
  areamat=outer(ydist,xdist,"*")

  uniquezvalue=sort(unique(as.vector(xyz$z)),decreasing = FALSE)
  uniquezvalue=uniquezvalue[-1]
  areavec=vector("numeric",length=length(uniquezvalue))

  for (ii in 1:length(uniquezvalue)) {
    areavec[ii]=sum(sum(areamat*((xyz$z==uniquezvalue[ii])*1)))
  }
  plot(uniquezvalue,areavec,type="n",xlab="Height of terrace",ylab="Corresponding area")
  text(uniquezvalue,areavec,paste(uniquezvalue))
  lines(uniquezvalue,areavec,type="c")
	}


  else {
  	xyz=xyz[[dimension+1]]
  	if (sum(sum(xyz$z))==0) warning("There is no terrace layer")
  	xdist=diff(c(0,xyz$x)/max(xyz$x) )
  	ydist=diff(sort(c(0,xyz$y),decreasing = F)/max(xyz$y))
  	# zvalue matrix is the same is the plot (from large y to small y by from small x to large x)
  	ydist=rev(ydist)
  	areamat=outer(ydist,xdist,"*")

  	uniquezvalue=sort(unique(as.vector(xyz$z)),decreasing = FALSE)
  	uniquezvalue=uniquezvalue[-1]
  	areavec=vector("numeric",length=length(uniquezvalue))

  	for (ii in 1:length(uniquezvalue)) {
  		areavec[ii]=sum(sum(areamat*((xyz$z==uniquezvalue[ii])*1)))
  	}

  	loc=which.min(uniquezvalue<maxheight)
  	uniquezvalue=uniquezvalue[1:loc]
  	areavec=areavec[1:loc]

  	plot(uniquezvalue,areavec,type="n",xlab="Height of terrace",ylab="Corresponding area")
  	text(uniquezvalue,areavec,paste(uniquezvalue))
  	lines(uniquezvalue,areavec,type="c")
  }


}

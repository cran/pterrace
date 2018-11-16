#' Draws a persistence terrace.
#'
#' @param xyz a list of computed persistence terraces returned by the function \link{computept}.
#' @param dimension an integer selecting the dimension of the persistence terrace to plot.
#' @param cmax an integer specifying the maximum number of colors to be used. The default value is 10.
#' @param satellite a logical variable to select a viewpoint. If \code{FALSE}, plots the overall view of the persistence terrace. The default value is \code{TRUE}.
#' @import plotly
#' @import viridis
#' @keywords graphics
#' @return The function \code{plotpt} returns the persistence terrace graphic.
#' @export

#' @examples
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
#' \dontrun{
#' threecirclept <- computept(three_circle_dat,sp=spseq,lim=lim,by=by)
#'
#' # draw persistence terrace, satellite view
#' plotpt(threecirclept,dimension=1)
#' # draw persistence terrace, overall view
#' plotpt(threecirclept,dimension=1,satellite=FALSE)
#' }



plotpt <-
function(xyz,dimension,cmax=10,satellite=T) {
	xyz=xyz[[dimension+1]]
	# reverse the y order in zvalue matrix
	zcmax=xyz$z[nrow(xyz$z):1,]
	# replae the values greater than cmax with cmax
	zcmax[zcmax>cmax]=cmax
	#acmax=min(max(max(zcmax)),cmax)
	colorsch=c("white",rev(viridis_pal()( max(max(max(zcmax)),15) )))
	if (satellite==T) {
		plot_ly(x=xyz$x,y=sort(xyz$y,decreasing = F),z=xyz$z[nrow(xyz$z):1,], cmin=0, cmax=min(cmax,max(max(xyz$z))),
					surfacecolor=zcmax, colors=colorsch[1:(max(max(zcmax))+1)],
					colorbar=list(ticklen=30,ticks="inside",tickmode="auto",nticks=max(max(zcmax))+1,xanchor="center",yanchor="top",x=0.9,y=0) ) %>% add_surface() %>%
		layout(scene = list(camera = list(eye = list(x = 0, y = -0.5, z = 2)),
												xaxis=list(title = "smoothing parameter",titlefont=list(size=14),showgrid=F,showline=T,zeroline=F,mirror="FALSE"),
												yaxis=list(title = "filtration",titlefont=list(size=14),tickmode="auto",nticks=8,showgrid=F,showline=T,zeroline=F,mirror="FALSE"),
												zaxis=list(visible=F)),
					 margin=list(l = 0,	r = 0,	b = 70,	t = 0),legend=list(x=0,y=0) )
	}
	else {
		plot_ly(x=xyz$x,y=sort(xyz$y,decreasing = F),z=xyz$z[nrow(xyz$z):1,], cmin=0, cmax=min(cmax,max(max(xyz$z))),
						surfacecolor=zcmax, colors=colorsch[1:(max(max(zcmax))+1)],
						colorbar=list(ticklen=30,ticks="inside",tickmode="auto",nticks=max(max(zcmax))+1,xanchor="center",yanchor="top",x=0.9,y=0) ) %>% add_surface() %>%
		layout(scene = list(xaxis=list(title = "smoothing parameter",titlefont=list(size=14),showgrid=F,showline=T,zeroline=F,side="bottom",mirror="FALSE"),
												yaxis=list(title = "filtration",titlefont=list(size=14),tickmode="auto",nticks=8,showgrid=F,showline=T,zeroline=F,side="bottom",mirror="FALSE"),
												zaxis=list(title = "Number of holes",titlefont=list(size=14),showgrid=F,showline=T,zeroline=F,side="bottom",mirror="FALSE")),
												margin=list(l = 0,	r = 0,	b = 70,	t = 0),legend=list(x=0,y=0) )
	}
}

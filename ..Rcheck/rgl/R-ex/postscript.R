### Name: rgl.postscript
### Title: export screenshot
### Aliases: rgl.postscript
### Keywords: dynamic

### ** Examples


## Not run: 
##D 
##D #
##D # create a series of frames for an animation
##D #
##D 
##D rgl.open()
##D shade3d(oh3d(), color="red")
##D rgl.viewpoint(0,20)
##D 
##D for (i in 1:45) {
##D   rgl.viewpoint(i,20)
##D   filename <- paste("pic",formatC(i,digits=1,flag="0"),".eps",sep="") 
##D   rgl.postscript(filename, fmt="eps")
##D }
##D 
## End(Not run)





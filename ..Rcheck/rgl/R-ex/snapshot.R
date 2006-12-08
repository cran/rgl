### Name: rgl.snapshot
### Title: export screenshot
### Aliases: rgl.snapshot snapshot3d
### Keywords: dynamic

### ** Examples


## Not run: 
##D 
##D #
##D # create animation
##D #
##D 
##D shade3d(oh3d(), color="red")
##D rgl.viewpoint(0,20)
##D 
##D setwd(tempdir())
##D for (i in 1:45) {
##D   rgl.viewpoint(i,20)
##D   filename <- paste("pic",formatC(i,digits=1,flag="0"),".png",sep="")
##D   rgl.snapshot(filename)
##D }
##D ## Now run ImageMagick command:
##D ##    convert -delay 10 *.png -loop 0 pic.gif
## End(Not run)





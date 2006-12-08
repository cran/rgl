### Name: viewpoint
### Title: Set up viewpoint
### Aliases: rgl.viewpoint view3d
### Keywords: dynamic

### ** Examples


# animated round trip tour for 10 seconds

rgl.open()
shade3d(oh3d(), color="red")

start <- proc.time()[3]
while ((i <- 36*(proc.time()[3]-start)) < 360) {
  rgl.viewpoint(i,i/4); 
}





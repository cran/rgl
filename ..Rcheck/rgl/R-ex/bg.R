### Name: bg
### Title: Set up Background
### Aliases: rgl.bg bg3d
### Keywords: dynamic

### ** Examples

  rgl.open()
  
  # a simple white background
  
  bg3d("white")

  # the holo-globe (inspired by star trek):

  rgl.bg(sphere=TRUE, color=c("black","green"), lit=FALSE, back="lines" )

  # an environmental sphere with a nice texture.

  rgl.bg(sphere=TRUE, texture=system.file("textures/sunsleep.png", package="rgl"), 
         back="filled" )




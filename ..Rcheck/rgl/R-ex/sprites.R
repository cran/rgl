### Name: sprites
### Title: add sprite set shape
### Aliases: sprites3d particles3d rgl.sprites
### Keywords: dynamic

### ** Examples

open3d()
particles3d( rnorm(100), rnorm(100), rnorm(100), color=rainbow(100) )
# is the same as
sprites3d( rnorm(100), rnorm(100), rnorm(100), color=rainbow(100),
  lit=FALSE, alpha=.2,
  textype="alpha", texture=system.file("textures/particle.png", package="rgl") )




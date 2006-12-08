### Name: scene
### Title: scene management
### Aliases: rgl.clear rgl.pop clear3d pop3d rgl.ids
### Keywords: dynamic

### ** Examples

  x <- rnorm(100)
  y <- rnorm(100)
  z <- rnorm(100)
  p <- plot3d(x, y, z, type='s')
  rgl.ids()
  lines3d(x, y, z)
  rgl.ids()
  if (interactive()) {
    readline("Hit enter to change spheres")
    rgl.pop(id = p[c("data", "box.lines")])
    spheres3d(x, y, z, col="red", radius=1/5)
    box3d()
  }




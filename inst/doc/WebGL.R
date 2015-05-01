## ----setup, echo=FALSE, results="asis"-----------------------------------
source("setup.R")
set.seed(123)

## ----plot3d, rgl=TRUE----------------------------------------------------
with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length, 
                  type="s", col=as.numeric(Species)))
subid <- currentSubscene3d()

## ----toggle, rgl = TRUE, rgl.keepopen = TRUE-----------------------------
sphereid <- with(subset(iris, Species == "setosa"), 
     spheres3d(Sepal.Length, Sepal.Width, Petal.Length, 
                  col=as.numeric(Species),
                  radius = 0.211))
with(subset(iris, Species == "versicolor"), 
     spheres3d(Sepal.Length, Sepal.Width, Petal.Length, 
               col=as.numeric(Species),
     	       radius = 0.211))
with(subset(iris, Species == "virginica"), 
     spheres3d(Sepal.Length, Sepal.Width, Petal.Length, 
               col=as.numeric(Species),
     	       radius = 0.211))
aspect3d(1,1,1)
decorate3d()
subid <- currentSubscene3d()

## ----results="asis"------------------------------------------------------
toggleButton(sphereid, label = "setosa", prefix = "toggle", subscene = subid)
toggleButton(sphereid+1, label = "versicolor", prefix = "toggle", subscene = subid)
toggleButton(sphereid+2, label = "virginica", prefix = "toggle", subscene = subid)

## ----results="asis", echo=FALSE------------------------------------------
toggleButton(sphereid, label = "setosa", prefix = "toggle", subscene = subid)
toggleButton(sphereid+1, label = "versicolor", prefix = "toggle", subscene = subid)
toggleButton(sphereid+2, label = "virginica", prefix = "toggle", subscene = subid)

## ----slider, rgl=TRUE, rgl.keepopen=TRUE---------------------------------

## ----results="asis"------------------------------------------------------
subsetSlider(subsets = list(setosa = sphereid, 
                  versicolor = sphereid + 1, 
                  virginica = sphereid + 2, 
                  all = sphereid + 0:2),
             prefixes = "slider", subscenes = subid, 
             init = 3)

## ----userMatrix, rgl=TRUE------------------------------------------------

## ----results="asis"------------------------------------------------------
M <- r3dDefaults$userMatrix
fn <- par3dinterp(time = (0:2)*0.75, userMatrix = list(M,
                                     rotate3d(M, pi/2, 1, 0, 0),
                                     rotate3d(M, pi/2, 0, 1, 0) ) )
propertySlider(setter = par3dinterpSetter(fn, 0, 1.5, steps=15, 
					   prefix = "userMatrix", 
					   subscene = subid),
	       step = 0.01)

## ----curve, rgl=TRUE-----------------------------------------------------
time <- 0:500
xyz <- cbind(cos(time/20), sin(time/10), time)
lineid <- plot3d(xyz, type="l", col = c("black", "black"))["data"]
sphereid <- spheres3d(xyz[1, , drop=FALSE], radius = 8, col = "red")

## ----results="asis"------------------------------------------------------
propertySlider( list(ageSetter(births = time, ages = c(0, 0, 50),
			  colors = c("gray", "red", "gray"),
			  objids = lineid, prefixes = "curve"),
		     ageSetter(births = 0, ages = time,
		     	  vertices = xyz, objids = sphereid,
		     	  prefixes = "curve")),
		     maxS = max(time) + 50)

## ----eval=FALSE----------------------------------------------------------
#  writeWebGL(..., prefix = "<prefix>")

## ----echo=FALSE, results="asis"------------------------------------------
writeIndex(cols = 5)


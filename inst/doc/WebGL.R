## ----setup, echo=FALSE, results="asis"----------------------------------------
source("setup.R")
setupKnitr(autoprint = FALSE)
set.seed(123)

## ----elementId----------------------------------------------------------------
library(rgl)
plotids <- with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length, 
                  type="s", col=as.numeric(Species)))
rglwidget(elementId = "plot3drgl")

## -----------------------------------------------------------------------------
toggleWidget(sceneId = "plot3drgl", ids = plotids["data"], label = "Data")

## -----------------------------------------------------------------------------
names(plotids)
unclass(plotids)

## ----Pipes--------------------------------------------------------------------
rglwidget() %>%
toggleWidget(ids = plotids["data"], label = "Data")

## ----eval=FALSE---------------------------------------------------------------
#  rglwidget() |>
#  toggleWidget(ids = plotids["data"], label = "Data")

## ----"Control before widget"--------------------------------------------------
toggleWidget(NA, ids = plotids["data"], label = "Data") %>%
rglwidget(controllers = .) 

## ----eval=FALSE---------------------------------------------------------------
#  toggleWidget(NA, ids = plotids["data"], label = "Data") |>
#    w => rglwidget(controllers = w)

## ----"Toggle subsets"---------------------------------------------------------
clear3d() # Remove the earlier display

with(subset(iris, Species == "setosa"), 
     spheres3d(Sepal.Length, Sepal.Width, Petal.Length, 
                  col=as.numeric(Species),
                  radius = 0.211,
                  tag = "setosa"))
with(subset(iris, Species == "versicolor"), 
     spheres3d(Sepal.Length, Sepal.Width, Petal.Length, 
               col=as.numeric(Species),
     	       radius = 0.211, 
     	       tag = "versicolor"))
with(subset(iris, Species == "virginica"), 
     spheres3d(Sepal.Length, Sepal.Width, Petal.Length, 
               col=as.numeric(Species),
     	       radius = 0.211,
     	       tag = "virginica"))
aspect3d(1,1,1)
decorate3d(tag = "axes")
rglwidget() %>%
toggleWidget(tags = "setosa") %>%
toggleWidget(tags = "versicolor") %>%
toggleWidget(tags = "virginica") %>%
toggleWidget(tags = "axes") %>% 
asRow(last = 4)

## ----Slider-------------------------------------------------------------------
rglwidget() %>%
playwidget(start = 0, stop = 3, interval = 1,
	   subsetControl(1, subsets = list(
	   			 Setosa = tagged3d("setosa"),
	   			 Versicolor = tagged3d("versicolor"),
	   			 Virginica = tagged3d("virginica"),
	   			 All = tagged3d(c("setosa", "versicolor", "virginica"))
	   			 )))

## ----"par3dinterpControl()"---------------------------------------------------
M <- r3dDefaults$userMatrix
fn <- par3dinterp(time = (0:2)*0.75, userMatrix = list(M,
                                      rotate3d(M, pi/2, 1, 0, 0),
                                      rotate3d(M, pi/2, 0, 1, 0)) )
rglwidget() %>%
playwidget(par3dinterpControl(fn, 0, 3, steps=15),
 	   step = 0.01, loop = TRUE, rate = 0.5)

## ----"vertexControl()"--------------------------------------------------------
setosavals <- subset(iris, Species == "setosa")
which <- which.min(setosavals$Sepal.Width)
init <- setosavals$Sepal.Length[which]
rglwidget() %>%
playwidget(
  vertexControl(values = matrix(c(init,   0,   0,   0, 
                                     8,   1,   1,   1), 
                                nrow = 2, byrow = TRUE),
                attributes = c("x", "red", "green", "blue"),
                vertices = which, tag = "setosa"),
	step = 0.01)

## ----"ageControl()"-----------------------------------------------------------
time <- 0:500
xyz <- cbind(cos(time/20), sin(time/10), time)
lineid <- plot3d(xyz, type="l", col = "black")["data"]
sphereid <- spheres3d(xyz[1, , drop=FALSE], radius = 8, col = "red")
rglwidget() %>%
playwidget(list(
  ageControl(births = time, ages = c(0, 0, 50),
		colors = c("gray", "red", "gray"), objids = lineid),
  ageControl(births = 0, ages = time,
		vertices = xyz, objids = sphereid)),
  start = 0, stop = max(time) + 20, rate = 50,
  components = c("Reverse", "Play", "Slower", "Faster",
                 "Reset", "Slider", "Label"),
  loop = TRUE)

## ----crosstalk,eval = requireNamespace("crosstalk", quietly=TRUE)-------------
# This example requires the crosstalk package
# We skip it if crosstalk is not available. 

ids <- with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length, 
                  type="s", col=as.numeric(Species)))
par3d(mouseMode = "selecting")
rglwidget(shared = rglShared(ids["data"])) %>% 
rglMouse()

## ----"rglShared()",eval=requireNamespace("crosstalk", quietly = TRUE)---------
# This example requires the crosstalk package.  
# We skip it if crosstalk is not available. 

library(crosstalk)
sd <- SharedData$new(mtcars)
ids <- plot3d(sd$origData(), col = mtcars$cyl, type = "s")
# Copy the key and group from existing shared data
rglsd <- rglShared(ids["data"], key = sd$key(), group = sd$groupName())
rglwidget(shared = rglsd) %>%
asRow("Mouse mode: ", rglMouse(getWidgetId(.)), 
      "Subset: ", filter_checkbox("cylinderselector", 
		                "Cylinders", sd, ~ cyl, inline = TRUE),
      last = 4, colsize = c(1,2,1,2), height = 60)

## ----plot3d2------------------------------------------------------------------
plotids <- with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length, 
                  type="s", col=as.numeric(Species)))
subid <- currentSubscene3d()
rglwidget(elementId="plot3drgl2")

## ----echo=FALSE, results="asis"-----------------------------------------------
writeIndex(cols = 5)


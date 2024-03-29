currentSubscene3d <- function(dev = cur3d()) {
  .C(rgl_getsubsceneid, id = 1L, dev = as.integer(dev))$id
}

subsceneInfo <- function(id = NA, embeddings, recursive = FALSE) {
  if (is.na(id)) 
    id <- currentSubscene3d()
  else if (is.character(id) && id == "root") 
    id <- .C(rgl_getsubsceneid, id = 0L, dev = as.integer(cur3d()))$id
  if (!id) stop("No subscene info available.")
  id <- as.integer(id)
  result <- list(id = id)
  
  parent <- .C(rgl_getsubsceneparent, id = id)$id
  
  if (is.na(parent)) stop(gettextf("Subscene %s not found", id), domain = NA)
  if (!parent) parent <- NULL
  result[["parent"]] <- parent
  
  n <- .C(rgl_getsubscenechildcount, id = id, n = integer(1))$n
  if (n) {
    children <- .C(rgl_getsubscenechildren, id = id, children=integer(n))$children
    if (recursive) {
      childlist <- list()
      for (i in seq_len(n))
        childlist[[i]] <- subsceneInfo(id = children[i], recursive = TRUE)
      result[["children"]] <- childlist
    } else
      result[["children"]] <- children
  }
  
  embeddingNames <- c("inherit", "modify", "replace")
  if (!missing(embeddings)) {
    embeddings <- pmatch(embeddings, embeddingNames, duplicates.ok = TRUE)
    if (any(is.na(embeddings)) || length(embeddings) != 4)
      stop(gettextf("Four embeddings must be specified; names chosen from %s", 
      	            paste(dQuote(embeddingNames), collapse=", ")), domain = NA)
    if (embeddings[4] == "modify")
      stop("The mouseMode embedding cannot be 'modify'")
    .C(rgl_setEmbeddings, id = id, embeddings = as.integer(embeddings))
  }
  embeddings <- .C(rgl_getEmbeddings, id = id, embeddings = integer(4))$embeddings
  embeddings <- embeddingNames[embeddings]
  names(embeddings) <- c("viewport", "projection", "model", "mouse")
  result[["embeddings"]] <- embeddings
  result
}

newSubscene3d <- function(viewport = "replace", 
                       projection = "replace",
		                   model = "replace",
		                   mouseMode = "inherit",
                       parent = currentSubscene3d(), 
		                   copyLights = TRUE,
                       copyShapes = FALSE,
                       copyBBoxDeco = copyShapes,
                       copyBackground = FALSE,
                       newviewport,
                       ignoreExtent) {
  embedding <- c("inherit", "modify", "replace")
  viewport <- pmatch(viewport, embedding)
  projection <- pmatch(projection, embedding)
  model <- pmatch(model, embedding)
  mouseMode <- pmatch(mouseMode, embedding)
  
  if (missing(ignoreExtent))
    ignoreExtent <- model == 3
  stopifnot(length(viewport) == 1L, length(projection) == 1L, 
            length(model) == 1L, length(mouseMode) ==1L,
            mouseMode != 2L,
            !is.na(viewport), !is.na(projection), !is.na(model))
  embedding <- c(viewport, projection, model, mouseMode)
  
  id <- .C(rgl_newsubscene, id = integer(1), parent = as.integer(parent),
               embedding = as.integer(embedding),
               as.integer(ignoreExtent))$id
               
  if (id) {
    if (copyLights || copyShapes || copyBBoxDeco || copyBackground) {
      useSubscene3d(parent)
      ids <- ids3d(type = 
        c("lights", "shapes", "bboxdeco", "background")[c(copyLights, copyShapes, copyBBoxDeco, copyBackground)])$id
      if (length(ids)) 
        addToSubscene3d(ids, subscene = id)
    }
    useSubscene3d(id)
    if (!missing(newviewport)) {
      embedding <- subsceneInfo(id)$embeddings
      if (embedding[1] > 1)
        par3d(viewport = as.integer(newviewport))
    }
  } else
    stop("Subscene creation failed")
  lowlevel(id)
}

useSubscene3d <- function(subscene) {
  result <- .C(rgl_setsubscene, id=as.integer(subscene))$id
  if (!result) stop(gettextf("Subscene %d not found.", subscene), domain = NA)
  invisible(result)
}

addToSubscene3d <- function(ids = tagged3d(tags), tags, subscene = currentSubscene3d()) {
  ids <- as.integer(ids)
  dups <- intersect(ids, ids3d("all", subscene)$id)
  if (length(dups))
    stop(gettextf("Cannot add %s, already present", paste(dups, collapse = ", ")), domain = NA)
  result <- .C(rgl_addtosubscene, success = as.integer(subscene), 
     n = as.integer(length(ids)), ids = ids)$success
  if (!result)
    stop(gettextf("Failed to add objects to subscene %s", subscene), domain = NA)
  lowlevel(subscene)
}

delFromSubscene3d <- function(ids = tagged3d(tags), tags, subscene = currentSubscene3d()) {
  result <- .C(rgl_delfromsubscene, success = as.integer(subscene), 
     n = as.integer(length(ids)), ids = as.integer(ids))$success
  if (!result)
    stop(gettextf("Failed to delete objects from subscene %s", subscene), domain = NA)
  lowlevel(subscene)
}

# This destroys any objects that are in the scene but
# not in either the protect vector or visible in a subscene

gc3d <- function(protect=NULL) {
  protect <- as.integer(protect)
  invisible( .C(rgl_gc, n = length(protect), protect)$n )
}

subsceneList <- function(value, window = cur3d()) {
  alllists <- .rglEnv$subsceneLists  
  # This cleans up lists for closed windows:
  alllists <- alllists[names(alllists) %in% rgl.dev.list()]
  if (!missing(value)) {
    if (is.null(alllists)) alllists <- list()
    alllists[[as.character(window)]] <- value
    assign("subsceneLists", alllists, envir = .rglEnv)
  }
  if (is.null(alllists)) return(NULL)
  else return(alllists[[as.character(window)]])
}

next3d <- function(current = NA, clear = TRUE, reuse = TRUE) {
  .check3d()
  if (is.na(current))
    current <- currentSubscene3d()
  subscenes <- subsceneList()
  while (!is.null(subscenes) && !(current %in% subscenes))
    subscenes <- attr(subscenes, "prev")
  if (is.null(subscenes)) 
    subscenes <- current
  
  this <- which(current == subscenes)
  if (reuse && !nrow(ids3d(subscene = current))) {
    # do nothing
  } else if (this == length(subscenes)) 
    this <- 1
  else 
    this <- this + 1
  
  repeat{
    current <- subscenes[this]
    result <- try(useSubscene3d(current))
    if (inherits(result, "try-error")) {
      subsceneList(subscenes <- subscenes[-this])
      if (length(subscenes) == 0)
      	stop("'subsceneList()' contained no valid subscenes")
      if (this > length(subscenes)) this <- 1
    } else break
  }
      
  if (clear)
    clear3d(subscene = current)
}
  
clearSubsceneList <- function(delete = currentSubscene3d() %in% subsceneList(),
                              window = cur3d()) {
  if (!missing(window))
    set3d(window)  
  thelist <- subsceneList()
  if (delete && length(thelist)) {
    parent <- subsceneInfo(thelist[1])$parent
    if (is.null(parent))
      parent <- rootSubscene()
    pop3d(type="subscene", id=thelist)
    useSubscene3d(parent)
    gc3d()
  }
  subsceneList(attr(thelist, "prev"))
  invisible(currentSubscene3d())
}

mfrow3d <- function(nr, nc, byrow = TRUE, parent = NA, sharedMouse = FALSE,
                           ...) {
  stopifnot(nr >= 1, nc >= 1)
  .check3d()
  if (missing(parent))
    clearSubsceneList()
  if (is.na(parent))
    parent <- currentSubscene3d()
  useSubscene3d(parent)
  result <- integer(nr*nc)
  parentvp <- par3d("viewport")
  if (byrow)
    for (i in seq_len(nr))
      for (j in seq_len(nc)) {
        newvp <- c(parentvp[1] + (j - 1)*parentvp[3]/nc,
                   parentvp[2] + (nr - i)*parentvp[4]/nr,
                   parentvp[3]/nc, parentvp[4]/nr)
        result[(i-1)*nc + j] <- newSubscene3d(newviewport = newvp, parent = parent, ...)
      }
  else
    for (j in seq_len(nc))
      for (i in seq_len(nr)) {
        newvp <- c(parentvp[1] + (j - 1)*parentvp[3]/nc,
                   parentvp[2] + (nr - i)*parentvp[4]/nr,
                   parentvp[3]/nc, parentvp[4]/nr)
        result[(j-1)*nr + i] <- newSubscene3d(newviewport = newvp, parent = parent, ...)
      }
  if (sharedMouse)
    for (sub in result)
      par3d(listeners = result, subscene = sub)
  useSubscene3d(result[1])
  attr(result, "prev") <- subsceneList()
  subsceneList(result)
  invisible(result)
}

layout3d <- function(mat, widths = rep.int(1, ncol(mat)), 
                          heights = rep.int(1, nrow(mat)),
                          parent = NA, sharedMouse = FALSE,
                          ...) {
  storage.mode(mat) <- "integer"
  mat <- as.matrix(mat)
  num.figures <- max(mat)
  if (!all(seq_len(num.figures) %in% as.integer(mat)))
    stop(gettextf("Layout matrix must contain at least one reference\nto each of the values {1 ... %d}\n", 
            num.figures), domain = NA)

  .check3d()
  if (missing(parent))
    clearSubsceneList()
  if (is.na(parent))
    parent <- currentSubscene3d()
  useSubscene3d(parent)
  parentvp <- par3d("viewport")
  
  widths <- parentvp["width"]*widths/sum(widths)
  heights <- parentvp["height"]*heights/sum(heights)
  xs <- c(0, cumsum(widths))
  ys <- rev(c(0, cumsum(rev(heights))))[-1]
  
  result <- integer(num.figures)
  for (i in seq_len(num.figures)) {
    rows <- range(row(mat)[mat == i])
    cols <- range(col(mat)[mat == i])
    newvp <- c(xs[cols[1]], ys[rows[2]], sum(widths[cols[1]:cols[2]]), sum(heights[rows[1]:rows[2]]))
    result[i] <- newSubscene3d(newviewport = newvp, parent = parent,  ...)
  }
  if (sharedMouse)
    for (sub in result)
      par3d(listeners = result, subscene = sub)
  useSubscene3d(result[1])
  attr(result, "prev") <- subsceneList()
  subsceneList(result)
  invisible(result)
}

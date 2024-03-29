# enumerations

rgl.enum <- function( name, ..., multi = FALSE) {
  choices <- list( ... )
  names   <- attr(choices,"names")

  if (multi) pos <- pmatch( name, c(names, "all") )
  else pos <- pmatch( name, names )
 
  max <- length(names)

  if ( any( is.na(pos) ) )
    stop(gettextf("Symbolic value must be chosen from: %s", list(names)), domain = NA)
  else if ( (max+1) %in% pos )
    pos <- seq_along(names)
    
  id  <- unlist(choices[pos])
  
  if ( length(id) > 1 && !multi )
    stop("Multiple choices not allowed")
 
  return( id )
}

rgl.enum.nodetype <- function(type) 
rgl.enum( type, shapes=1, lights=2, bboxdeco=3, userviewpoint=4, material=5, background=6, subscene=7, modelviewpoint=8, 
          multi = TRUE )

rgl.enum.attribtype <- function(attrib)
rgl.enum( attrib, vertices=1, normals=2, colors=3, texcoords=4, dim=5, 
          texts=6, cex=7, adj=8, radii=9, centers=10, ids=11, 
          usermatrix=12, types=13, flags=14, offsets=15,
	        family=16, font=17, pos=18, fogscale=19, axes=20,
          indices=21, shapenum=22)

rgl.enum.pixfmt <- function(fmt)
rgl.enum( fmt, png=0 )

rgl.enum.polymode <- function(mode)
rgl.enum( mode, filled=1, lines=2, points=3, culled=4)

rgl.enum.textype <- function(textype)
rgl.enum( textype, alpha=1, luminance=2, luminance.alpha=3, rgb=4, rgba=5 )

rgl.enum.fogtype <- function(fogtype)
rgl.enum(fogtype, none=1, linear=2, exp=3, exp2=4)

rgl.enum.primtype <- function(primtype)
rgl.enum( primtype, points=1, lines=2, triangles=3, quadrangles=4, linestrips=5 )
  
rgl.enum.texminfilter <- function(minfiltertype)
rgl.enum(minfiltertype, nearest=0, linear=1, nearest.mipmap.nearest=2, nearest.mipmap.linear=3, linear.mipmap.nearest=4, linear.mipmap.linear=5)
  
rgl.enum.texmagfilter <- function(magfiltertype)
rgl.enum(magfiltertype, nearest=0, linear=1)

rgl.enum.gl2ps <- function(postscripttype)
rgl.enum(postscripttype, ps=0, eps=1, tex=2, pdf=3, svg=4, pgf=5)

rgl.enum.pixelcomponent <- function(component)
rgl.enum(component, red=0, green=1, blue=2, alpha=3, depth=4, luminance=5)

rgl.enum.depthtest <- function(depthtest)
rgl.enum(depthtest, never=0, less=1, equal=2, lequal=3, greater=4, 
                    notequal=5, gequal=6, always= 7)

rgl.enum.blend <- function(blend)
rgl.enum(blend, zero=0, one=1, 
         src_color=2, one_minus_src_color=3, 
         dst_color=4, one_minus_dst_color=5,
         src_alpha=6, one_minus_src_alpha=7,
         dst_alpha=8, one_minus_dst_alpha=9,
         constant_color=10, one_minus_constant_color=11,
         constant_alpha=12, one_minus_constant_alpha=13,
         src_alpha_saturate=14)

rgl.enum.texmode <- function(texmode)
  rgl.enum(texmode, replace = 0, modulate = 1, 
           decal = 2, blend = 3, add = 4)

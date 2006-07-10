##
## R source file
## This file is part of rgl
##
## $Id: zzz.R 457 2006-06-26 01:20:52Z murdoch $
##

##
## ===[ SECTION: package entry/exit point ]===================================
##

##
## entry-point
##
##

.onLoad <- function(lib, pkg)
{
  # OS-specific 
  
  if ( .Platform$OS.type == "unix" ) {
    unixos <- system("uname",intern=TRUE)
    if ( unixos == "Darwin" ) {
      # For MacOS X we have to remove /usr/X11R6/lib from the DYLD_LIBRARY_PATH
      # because it would override Apple's OpenGL framework
      Sys.putenv("DYLD_LIBRARY_PATH"=gsub("/usr/X11R6/lib","",Sys.getenv("DYLD_LIBRARY_PATH")))      
    }
  }
	
  ret <- .C( "rgl_init", 
    success=FALSE , 
    PACKAGE="rgl"
  )
  
  if (!ret$success) {
    warning("error in rgl_init")
  }
  
}


##
## exit-point
##
##

.onUnload <- function(libpath)
{ 
  # shutdown
  
  ret <- .C( "rgl_quit", success=FALSE, PACKAGE="rgl" )
  
}


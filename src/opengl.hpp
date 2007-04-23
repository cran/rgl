#ifndef RGL_OPENGL_H
#define RGL_OPENGL_H
// ---------------------------------------------------------------------------
// Using OpenGL and GLU
//
// $Id: opengl.hpp 475 2006-07-24 15:43:35Z dmurdoch $
// ---------------------------------------------------------------------------
#include "config.hpp"
// ---------------------------------------------------------------------------
#ifdef RGL_OSX
#include <AGL/gl.h>
#include <AGL/glu.h>
#endif
// ---------------------------------------------------------------------------
#ifdef RGL_W32
#include <windows.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GLsdk/GL/glext.h>
#endif
// ---------------------------------------------------------------------------
#ifdef RGL_X11
#include <GL/gl.h>
#include <GL/glu.h>
#endif
// ---------------------------------------------------------------------------
#endif // RGL_OPENGL_HPP
 

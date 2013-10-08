#ifndef RGL_FPS_H
#define RGL_FPS_H

// C++ header file
// This file is part of RGL
//
// $Id: fps.h 976 2013-10-04 15:06:19Z murdoch $

#include "scene.h"

namespace rgl {

//
// FPS COUNTER
//

class FPS
{
private:
  double lastTime;
  int   framecnt;
  char  buffer[12];
public:
  inline FPS() { };
  void init(double t);
  void render(double t, RenderContext* ctx);
};

} // namespace rgl

#endif // RGL_FPS_H


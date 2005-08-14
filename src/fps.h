#ifndef RGL_FPS_H
#define RGL_FPS_H

// C++ header file
// This file is part of RGL
//
// $Id: fps.h 376 2005-08-03 23:58:47Z dadler $

#include "scene.h"

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

#endif // RGL_FPS_H


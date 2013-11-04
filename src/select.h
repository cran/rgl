#ifndef PLX_SELECT_H
#define PLX_SELECT_H

// C++ header file
// This file is part of RGL
//
// $Id: select.h 976 2013-10-04 15:06:19Z murdoch $

#include "scene.h"

namespace rgl {

//
// Mouse selection rectangle
//

class SELECT
{
public:
  inline SELECT() { };
  void render(double* position);
};

} // namespace rgl

#endif // PLX_SELECT_H


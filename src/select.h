#ifndef PLX_SELECT_H
#define PLX_SELECT_H

// C++ header file
// This file is part of RGL
//
// $Id: select.h 384 2005-08-04 22:32:13Z dadler $

#include "scene.h"

//
// Mouse selection rectangle
//

class SELECT
{
public:
  inline SELECT() { };
  void render(double* position);
};

#endif // PLX_SELECT_H


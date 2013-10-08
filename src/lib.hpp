#ifndef RGL_LIB_HPP
#define RGL_LIB_HPP
// ---------------------------------------------------------------------------
// $Id: lib.hpp 976 2013-10-04 15:06:19Z murdoch $
// ---------------------------------------------------------------------------

namespace rgl {

// ---------------------------------------------------------------------------
bool init(bool onlyNULLDevice);
const char * GUIFactoryName(bool useNULLDevice);    
void quit();
void printMessage(const char* string);
double getTime();
// ---------------------------------------------------------------------------

} // namespace rgl

#endif // RGL_LIB_HPP


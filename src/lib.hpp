#ifndef RGL_LIB_HPP
#define RGL_LIB_HPP
// ---------------------------------------------------------------------------
// $Id: lib.hpp 947 2013-07-18 00:36:47Z murdoch $
// ---------------------------------------------------------------------------
namespace lib {
// ---------------------------------------------------------------------------
bool init(bool onlyNULLDevice);
const char * GUIFactoryName(bool useNULLDevice);    
void quit();
void printMessage(const char* string);
double getTime();
// ---------------------------------------------------------------------------
} // namespace lib
// ---------------------------------------------------------------------------
#endif // RGL_LIB_HPP


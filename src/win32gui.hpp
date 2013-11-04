#ifndef RGL_W32_GUI_HPP
#define RGL_W32_GUI_HPP
// ---------------------------------------------------------------------------
// $Id: win32gui.hpp 976 2013-10-04 15:06:19Z murdoch $
// ---------------------------------------------------------------------------
#include "gui.hpp"
// ---------------------------------------------------------------------------
#include <windows.h>

namespace rgl {

// ---------------------------------------------------------------------------
class Win32GUIFactory : public GUIFactory
{
public:
  Win32GUIFactory();
  virtual ~Win32GUIFactory();
  WindowImpl* createWindowImpl(Window* window);
#ifndef WGL_WGLEXT_PROTOTYPES
  PFNWGLCHOOSEPIXELFORMATARBPROC wglChoosePixelFormatARB;
#endif
};
// ---------------------------------------------------------------------------

} // namespace rgl

#endif // RGL_W32_GUI_HPP


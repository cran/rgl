#ifndef RGL_W32_GUI_H
#define RGL_W32_GUI_H
// ---------------------------------------------------------------------------
// $Id: win32gui.h 1115 2014-07-18 13:51:22Z murdoch $
// ---------------------------------------------------------------------------
#include "gui.h"
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

#endif // RGL_W32_GUI_H


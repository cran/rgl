#ifndef RGL_W32_GUI_HPP
#define RGL_W32_GUI_HPP
// ---------------------------------------------------------------------------
// $Id: win32gui.hpp 840 2012-01-06 16:07:37Z murdoch $
// ---------------------------------------------------------------------------
#include "gui.hpp"
// ---------------------------------------------------------------------------
#include <windows.h>
// ---------------------------------------------------------------------------
namespace gui {
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
} // namespace gui
// ---------------------------------------------------------------------------
#endif // RGL_W32_GUI_HPP


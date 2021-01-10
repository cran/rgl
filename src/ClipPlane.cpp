#include "ClipPlane.h"
#include "Viewpoint.h"
#include "R.h"
#include <algorithm>

using namespace rgl;

//////////////////////////////////////////////////////////////////////////////
//
// CLASS
//   ClipPlaneSet
//

int ClipPlaneSet::num_planes = 0;

ClipPlaneSet::ClipPlaneSet(Material& in_material, int in_nnormal, double* in_normal, int in_noffset, double* in_offset)
 : 
   Shape(in_material,true),
   nPlanes(max(in_nnormal, in_noffset)),
   normal(in_nnormal, in_normal), 
   offset(in_noffset, in_offset)
{
}

int ClipPlaneSet::getAttributeCount(AABox& bbox, AttribID attrib)
{
  switch (attrib) {
    case NORMALS: 
    case OFFSETS: return nPlanes;
  }
  return 0;
}

void ClipPlaneSet::getAttribute(AABox& bbox, AttribID attrib, int first, int count, double* result)
{
  int n = getAttributeCount(bbox, attrib);
  if (first + count < n) n = first + count;
  if (first < n) {
    if (attrib == NORMALS) {
      while (first < n) {
	*result++ = normal.getRecycled(first).x;
	*result++ = normal.getRecycled(first).y;
	*result++ = normal.getRecycled(first).z;
        first++;
      }
    } else if (attrib == OFFSETS) {
	while (first < n) 
	  *result++ = offset.getRecycled(first++);
    }
  }
}

void ClipPlaneSet::renderBegin(RenderContext* renderContext)
{
  firstPlane = GL_CLIP_PLANE0 + num_planes;
  num_planes += nPlanes;
}

void ClipPlaneSet::drawPrimitive(RenderContext* renderContext, int index)
{
#ifndef RGL_NO_OPENGL   
  GLdouble eqn[4];
  eqn[0] = normal.getRecycled(index).x;
  eqn[1] = normal.getRecycled(index).y;
  eqn[2] = normal.getRecycled(index).z;
  eqn[3] = offset.getRecycled(index);
  glClipPlane(firstPlane + index, eqn);
  glEnable(firstPlane + index);
#endif
}

void ClipPlaneSet::enable(bool show)
{
#ifndef RGL_NO_OPENGL  
  for (int i=0; i<nPlanes; i++) {
    if (show) glEnable(firstPlane + i);
    else      glDisable(firstPlane + i);
  }
#endif
}

void ClipPlaneSet::intersectBBox(AABox& bbox)
{
  GLfloat a, b, c, d, a1, b1, c1, d1;
  for (int j=0; j<3; j++) /* repeat to propagate changes between coordinates */
  for (int i=0; i<nPlanes; i++) {
    a = normal.getRecycled(i).x;
    b = normal.getRecycled(i).y;
    c = normal.getRecycled(i).z;
    d = offset.getRecycled(i);
    b1 = -b/a;
    c1 = -c/a;
    d1 = -d/a;
    if (a > 0) 
      bbox.vmin.x = getMax(bbox.vmin.x,  b1*(b1 > 0 ? bbox.vmin.y : bbox.vmax.y)
                                        +c1*(c1 > 0 ? bbox.vmin.z : bbox.vmax.z)
                                        +d1);
    else if (a < 0)
      bbox.vmax.x = getMin(bbox.vmax.x,  b1*(b1 > 0 ? bbox.vmax.y : bbox.vmin.y)
                                        +c1*(c1 > 0 ? bbox.vmax.z : bbox.vmin.z)
                                        +d1);
    a1 = -a/b;
    c1 = -c/b;
    d1 = -d/b;
    if (b > 0) 
      bbox.vmin.y = getMax(bbox.vmin.y,  a1*(a1 > 0 ? bbox.vmin.x : bbox.vmax.x)
                                        +c1*(c1 > 0 ? bbox.vmin.z : bbox.vmax.z)
                                        +d1);
    else if (b < 0)
      bbox.vmax.y = getMin(bbox.vmax.y,  a1*(a1 > 0 ? bbox.vmax.x : bbox.vmin.x)
                                        +c1*(c1 > 0 ? bbox.vmax.z : bbox.vmin.z)
                                        +d1);
                                       
    a1 = -a/c;
    b1 = -b/c;
    d1 = -d/c;
    if (c > 0) 
      bbox.vmin.z = getMax(bbox.vmin.z,  a1*(a1 > 0 ? bbox.vmin.x : bbox.vmax.x)
                                        +b1*(b1 > 0 ? bbox.vmin.y : bbox.vmax.y)
                                        +d1);
    else if (c < 0)
      bbox.vmax.z = getMin(bbox.vmax.z,  a1*(a1 > 0 ? bbox.vmax.x : bbox.vmin.x)
                                        +b1*(b1 > 0 ? bbox.vmax.y : bbox.vmin.y)
                                        +d1);
  }
}

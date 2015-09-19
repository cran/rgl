---
title: "rgl Overview"
author: "Duncan Murdoch"
date: "September 18, 2015"
output:
  rmarkdown::html_vignette:
    toc: yes
    fig_width: 5
    fig_height: 5
vignette: >
  %\VignetteIndexEntry{rgl Overview} 
  %\VignetteEngine{knitr::rmarkdown}
---


```
## Loading required namespace: rmarkdown
```

<style>
.nostripes tr.even {background-color: white;}
table {border-style: none;}
table th {border-style: none;}
table td {border-style: none;}
a[href^=".."] {text-decoration: underline;}
</style>



## Introduction

The `rgl` package is used to produce interactive 3-D plots.  It contains
high-level graphics commands modelled loosely after classic R graphics,
but working in three dimensions.  It also contains low level structure
inspired by the `grid` package.

This document gives an overview.  See the help pages for details.

### About this document

This document was written in R Markdown, using the `knitr` package
for production.  It corresponds to rgl version 
0.95.1332.

Most of the highlighted function names are HTML links.
The internal links should work in any browser; the links to
help topics should work if you view the vignette from
within the R help system.

The document includes WebGL figures.  To view these, you must have
Javascript and WebGL enabled in your browser.  Some older browsers
may not support this -- see http://get.webgl.org for tests
and links to a discussion.


## Basics and High Level Functions

The <a name="plot3d"><a href="../../rgl/help/plot3d">`plot3d`</a></a> function
plots points within an rgl window.  It is similar to the classic 
<a href="../../graphics/help/plot">`plot`</a> function,
but works in 3 dimensions.

For example

```r
with(iris, plot3d(Sepal.Length, Sepal.Width, Petal.Length, 
                  type="s", col=as.numeric(Species)))
```

<script src="CanvasMatrix.js" type="text/javascript"></script>
<canvas id="plot3dtextureCanvas" style="display: none;" width="256" height="256">
Your browser does not support the HTML5 canvas element.</canvas>
<script type="text/javascript">
var min = Math.min,
max = Math.max,
sqrt = Math.sqrt,
sin = Math.sin,
acos = Math.acos,
tan = Math.tan,
SQRT2 = Math.SQRT2,
PI = Math.PI,
log = Math.log,
exp = Math.exp,
vshader, fshader,
rglClass = function() {
this.zoom = [];
this.FOV  = [];
this.userMatrix = [];
this.viewport = [];
this.listeners = [];
this.clipplanes = [];
this.opaque = [];
this.transparent = [];
this.subscenes = [];
this.vshaders = [];
this.fshaders = [];
this.flags = [];
this.prog = [];
this.ofsLoc = [];
this.origLoc = [];
this.sizeLoc = [];
this.usermatLoc = [];
this.vClipplane = [];
this.texture = [];
this.texLoc = [];
this.sampler = [];
this.origsize = [];
this.values = [];
this.offsets = [];
this.normLoc = [];
this.clipLoc = [];
this.centers = [];
this.f = [];
this.buf = [];
this.ibuf = [];
this.mvMatLoc = [];
this.prMatLoc = [];
this.textScaleLoc = [];
this.normMatLoc = [];
this.IMVClip = [];
this.drawFns = [];
this.clipFns = [];
this.prMatrix = new CanvasMatrix4();
this.mvMatrix = new CanvasMatrix4();
this.vp = null;
this.prmvMatrix = null;
this.origs = null;
this.gl = null;
};
(function() {
this.getShader = function( gl, shaderType, code ){
var shader;
shader = gl.createShader ( shaderType );
gl.shaderSource(shader, code);
gl.compileShader(shader);
if (gl.getShaderParameter(shader, gl.COMPILE_STATUS) === 0)
alert(gl.getShaderInfoLog(shader));
return shader;
};
this.multMV = function(M, v) {
return [M.m11*v[0] + M.m12*v[1] + M.m13*v[2] + M.m14*v[3],
M.m21*v[0] + M.m22*v[1] + M.m23*v[2] + M.m24*v[3],
M.m31*v[0] + M.m32*v[1] + M.m33*v[2] + M.m34*v[3],
M.m41*v[0] + M.m42*v[1] + M.m43*v[2] + M.m44*v[3]];
};
this.f_is_lit = 1;
this.f_is_smooth = 2;
this.f_has_texture = 4;
this.f_is_indexed = 8;
this.f_depth_sort = 16;
this.f_fixed_quads = 32;
this.f_is_transparent = 64;
this.f_is_lines = 128;
this.f_sprites_3d = 256;
this.f_sprite_3d = 512;
this.f_is_subscene = 1024;
this.f_is_clipplanes = 2048;
this.f_reuse = 4096;
this.whichList = function(id) {
if (this.flags[id] & this.f_is_subscene)
return "subscenes";
else if (this.flags[id] & this.f_is_clipplanes)
return "clipplanes";
else if (this.flags[id] & this.f_is_transparent)
return "transparent";
else
return "opaque";
};
this.inSubscene = function(id, subscene) {
var thelist = this.whichList(id);
return this[thelist][subscene].indexOf(id) > -1;
};
this.addToSubscene = function(id, subscene) {
var thelist = this.whichList(id);
if (this[thelist][subscene].indexOf(id) == -1)
this[thelist][subscene].push(id);
};
this.delFromSubscene = function(id, subscene) {
var thelist = this.whichList(id),
i = this[thelist][subscene].indexOf(id);
if (i > -1)
this[thelist][subscene].splice(i, 1);
};
this.setSubsceneEntries = function(ids, subscene) {
this.subscenes[subscene] = [];
this.clipplanes[subscene] = [];
this.transparent[subscene] = [];
this.opaque[subscene] = [];
for (var i = 0; i < ids.length; i++)
this.addToSubscene(ids[i], subscene);
};
this.getSubsceneEntries = function(subscene) {
return(this.subscenes[subscene].concat(this.clipplanes[subscene]).
concat(this.transparent[subscene]).concat(this.opaque[subscene]));
};
}).call(rglClass.prototype);
var plot3drgl = new rglClass();
plot3drgl.start = function() {
var i, j, v, ind, texts, f, texinfo;
var debug = function(msg) {
document.getElementById("plot3ddebug").innerHTML = msg;
};
debug("");
var canvas = document.getElementById("plot3dcanvas");
if (!window.WebGLRenderingContext){
debug(" Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
try {
// Try to grab the standard context. If it fails, fallback to experimental.
this.gl = canvas.getContext("webgl") ||
canvas.getContext("experimental-webgl");
}
catch(e) {}
if ( !this.gl ) {
debug(" Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var gl = this.gl,
width = 505, height = 505;
canvas.width = width;   canvas.height = height;
var normMatrix = new CanvasMatrix4(),
saveMat = {},
distance,
posLoc = 0,
colLoc = 1;
var activeSubscene = 1;
this.flags[1] = 1195;
this.zoom[1] = 1;
this.FOV[1] = 30;
this.viewport[1] = [0, 0, 504, 504];
this.userMatrix[1] = new CanvasMatrix4();
this.userMatrix[1].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[1] = [];
this.opaque[1] = [7,9,10,11,12,13,14,15,16,17,18];
this.transparent[1] = [];
this.subscenes[1] = [];
function getPowerOfTwo(value) {
var pow = 1;
while(pow<value) {
pow *= 2;
}
return pow;
}
function handleLoadedTexture(texture, textureCanvas) {
gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
gl.bindTexture(gl.TEXTURE_2D, texture);
gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
gl.generateMipmap(gl.TEXTURE_2D);
gl.bindTexture(gl.TEXTURE_2D, null);
}
function loadImageToTexture(filename, texture) {
var canvas = document.getElementById("plot3dtextureCanvas"),
ctx = canvas.getContext("2d"),
image = new Image();
image.onload = function() {
var w = image.width,
h = image.height,
canvasX = getPowerOfTwo(w),
canvasY = getPowerOfTwo(h);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.imageSmoothingEnabled = true;
ctx.drawImage(image, 0, 0, canvasX, canvasY);
handleLoadedTexture(texture, canvas);
plot3drgl.drawScene();
};
image.src = filename;
}
function drawTextToCanvas(text, cex) {
var canvasX, canvasY,
textX, textY,
textHeight = 20 * cex,
textColour = "white",
fontFamily = "Arial",
backgroundColour = "rgba(0,0,0,0)",
canvas = document.getElementById("plot3dtextureCanvas"),
ctx = canvas.getContext("2d"),
i;
ctx.font = textHeight+"px "+fontFamily;
canvasX = 1;
var widths = [];
for (i = 0; i < text.length; i++)  {
widths[i] = ctx.measureText(text[i]).width;
canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
}
canvasX = getPowerOfTwo(canvasX);
var offset = 2*textHeight, // offset to first baseline
skip = 2*textHeight;   // skip between baselines
canvasY = getPowerOfTwo(offset + text.length*skip);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.fillStyle = backgroundColour;
ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
ctx.fillStyle = textColour;
ctx.textAlign = "left";
ctx.textBaseline = "alphabetic";
ctx.font = textHeight+"px "+fontFamily;
for(i = 0; i < text.length; i++) {
textY = i*skip + offset;
ctx.fillText(text[i], 0,  textY);
}
return {canvasX:canvasX, canvasY:canvasY,
widths:widths, textHeight:textHeight,
offset:offset, skip:skip};
}
// ****** sphere object ******
this.sphereverts = new Float32Array([
-1, 0, 0,
1, 0, 0,
0, -1, 0,
0, 1, 0,
0, 0, -1,
0, 0, 1,
-0.7071068, 0, -0.7071068,
-0.7071068, -0.7071068, 0,
0, -0.7071068, -0.7071068,
-0.7071068, 0, 0.7071068,
0, -0.7071068, 0.7071068,
-0.7071068, 0.7071068, 0,
0, 0.7071068, -0.7071068,
0, 0.7071068, 0.7071068,
0.7071068, -0.7071068, 0,
0.7071068, 0, -0.7071068,
0.7071068, 0, 0.7071068,
0.7071068, 0.7071068, 0,
-0.9349975, 0, -0.3546542,
-0.9349975, -0.3546542, 0,
-0.77044, -0.4507894, -0.4507894,
0, -0.3546542, -0.9349975,
-0.3546542, 0, -0.9349975,
-0.4507894, -0.4507894, -0.77044,
-0.3546542, -0.9349975, 0,
0, -0.9349975, -0.3546542,
-0.4507894, -0.77044, -0.4507894,
-0.9349975, 0, 0.3546542,
-0.77044, -0.4507894, 0.4507894,
0, -0.9349975, 0.3546542,
-0.4507894, -0.77044, 0.4507894,
-0.3546542, 0, 0.9349975,
0, -0.3546542, 0.9349975,
-0.4507894, -0.4507894, 0.77044,
-0.9349975, 0.3546542, 0,
-0.77044, 0.4507894, -0.4507894,
0, 0.9349975, -0.3546542,
-0.3546542, 0.9349975, 0,
-0.4507894, 0.77044, -0.4507894,
0, 0.3546542, -0.9349975,
-0.4507894, 0.4507894, -0.77044,
-0.77044, 0.4507894, 0.4507894,
0, 0.3546542, 0.9349975,
-0.4507894, 0.4507894, 0.77044,
0, 0.9349975, 0.3546542,
-0.4507894, 0.77044, 0.4507894,
0.9349975, -0.3546542, 0,
0.9349975, 0, -0.3546542,
0.77044, -0.4507894, -0.4507894,
0.3546542, -0.9349975, 0,
0.4507894, -0.77044, -0.4507894,
0.3546542, 0, -0.9349975,
0.4507894, -0.4507894, -0.77044,
0.9349975, 0, 0.3546542,
0.77044, -0.4507894, 0.4507894,
0.3546542, 0, 0.9349975,
0.4507894, -0.4507894, 0.77044,
0.4507894, -0.77044, 0.4507894,
0.9349975, 0.3546542, 0,
0.77044, 0.4507894, -0.4507894,
0.4507894, 0.4507894, -0.77044,
0.3546542, 0.9349975, 0,
0.4507894, 0.77044, -0.4507894,
0.77044, 0.4507894, 0.4507894,
0.4507894, 0.77044, 0.4507894,
0.4507894, 0.4507894, 0.77044
]);
this.spherefaces=new Uint16Array([
0, 18, 19,
6, 20, 18,
7, 19, 20,
19, 18, 20,
4, 21, 22,
8, 23, 21,
6, 22, 23,
22, 21, 23,
2, 24, 25,
7, 26, 24,
8, 25, 26,
25, 24, 26,
7, 20, 26,
6, 23, 20,
8, 26, 23,
26, 20, 23,
0, 19, 27,
7, 28, 19,
9, 27, 28,
27, 19, 28,
2, 29, 24,
10, 30, 29,
7, 24, 30,
24, 29, 30,
5, 31, 32,
9, 33, 31,
10, 32, 33,
32, 31, 33,
9, 28, 33,
7, 30, 28,
10, 33, 30,
33, 28, 30,
0, 34, 18,
11, 35, 34,
6, 18, 35,
18, 34, 35,
3, 36, 37,
12, 38, 36,
11, 37, 38,
37, 36, 38,
4, 22, 39,
6, 40, 22,
12, 39, 40,
39, 22, 40,
6, 35, 40,
11, 38, 35,
12, 40, 38,
40, 35, 38,
0, 27, 34,
9, 41, 27,
11, 34, 41,
34, 27, 41,
5, 42, 31,
13, 43, 42,
9, 31, 43,
31, 42, 43,
3, 37, 44,
11, 45, 37,
13, 44, 45,
44, 37, 45,
11, 41, 45,
9, 43, 41,
13, 45, 43,
45, 41, 43,
1, 46, 47,
14, 48, 46,
15, 47, 48,
47, 46, 48,
2, 25, 49,
8, 50, 25,
14, 49, 50,
49, 25, 50,
4, 51, 21,
15, 52, 51,
8, 21, 52,
21, 51, 52,
15, 48, 52,
14, 50, 48,
8, 52, 50,
52, 48, 50,
1, 53, 46,
16, 54, 53,
14, 46, 54,
46, 53, 54,
5, 32, 55,
10, 56, 32,
16, 55, 56,
55, 32, 56,
2, 49, 29,
14, 57, 49,
10, 29, 57,
29, 49, 57,
14, 54, 57,
16, 56, 54,
10, 57, 56,
57, 54, 56,
1, 47, 58,
15, 59, 47,
17, 58, 59,
58, 47, 59,
4, 39, 51,
12, 60, 39,
15, 51, 60,
51, 39, 60,
3, 61, 36,
17, 62, 61,
12, 36, 62,
36, 61, 62,
17, 59, 62,
15, 60, 59,
12, 62, 60,
62, 59, 60,
1, 58, 53,
17, 63, 58,
16, 53, 63,
53, 58, 63,
3, 44, 61,
13, 64, 44,
17, 61, 64,
61, 44, 64,
5, 55, 42,
16, 65, 55,
13, 42, 65,
42, 55, 65,
16, 63, 65,
17, 64, 63,
13, 65, 64,
65, 63, 64
]);
var sphereBuf = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, sphereBuf);
gl.bufferData(gl.ARRAY_BUFFER, plot3drgl.sphereverts, gl.STATIC_DRAW);
var sphereIbuf = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, sphereIbuf);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, plot3drgl.spherefaces, gl.STATIC_DRAW);
// ****** spheres object 7 ******
this.flags[7] = 3;
this.vshaders[7] = "	/* ****** spheres object 7 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[7] = "	/* ****** spheres object 7 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[7]  = gl.createProgram();
gl.attachShader(this.prog[7], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[7] ));
gl.attachShader(this.prog[7], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[7] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[7], 0, "aPos");
gl.bindAttribLocation(this.prog[7], 1, "aCol");
gl.linkProgram(this.prog[7]);
this.offsets[7]={vofs:0, cofs:3, nofs:-1, radofs:7, oofs:-1, tofs:-1, stride:8};
v=new Float32Array([
5.1, 3.5, 1.4, 0, 0, 0, 1, 0.2112069,
4.9, 3, 1.4, 0, 0, 0, 1, 0.2112069,
4.7, 3.2, 1.3, 0, 0, 0, 1, 0.2112069,
4.6, 3.1, 1.5, 0, 0, 0, 1, 0.2112069,
5, 3.6, 1.4, 0, 0, 0, 1, 0.2112069,
5.4, 3.9, 1.7, 0, 0, 0, 1, 0.2112069,
4.6, 3.4, 1.4, 0, 0, 0, 1, 0.2112069,
5, 3.4, 1.5, 0, 0, 0, 1, 0.2112069,
4.4, 2.9, 1.4, 0, 0, 0, 1, 0.2112069,
4.9, 3.1, 1.5, 0, 0, 0, 1, 0.2112069,
5.4, 3.7, 1.5, 0, 0, 0, 1, 0.2112069,
4.8, 3.4, 1.6, 0, 0, 0, 1, 0.2112069,
4.8, 3, 1.4, 0, 0, 0, 1, 0.2112069,
4.3, 3, 1.1, 0, 0, 0, 1, 0.2112069,
5.8, 4, 1.2, 0, 0, 0, 1, 0.2112069,
5.7, 4.4, 1.5, 0, 0, 0, 1, 0.2112069,
5.4, 3.9, 1.3, 0, 0, 0, 1, 0.2112069,
5.1, 3.5, 1.4, 0, 0, 0, 1, 0.2112069,
5.7, 3.8, 1.7, 0, 0, 0, 1, 0.2112069,
5.1, 3.8, 1.5, 0, 0, 0, 1, 0.2112069,
5.4, 3.4, 1.7, 0, 0, 0, 1, 0.2112069,
5.1, 3.7, 1.5, 0, 0, 0, 1, 0.2112069,
4.6, 3.6, 1, 0, 0, 0, 1, 0.2112069,
5.1, 3.3, 1.7, 0, 0, 0, 1, 0.2112069,
4.8, 3.4, 1.9, 0, 0, 0, 1, 0.2112069,
5, 3, 1.6, 0, 0, 0, 1, 0.2112069,
5, 3.4, 1.6, 0, 0, 0, 1, 0.2112069,
5.2, 3.5, 1.5, 0, 0, 0, 1, 0.2112069,
5.2, 3.4, 1.4, 0, 0, 0, 1, 0.2112069,
4.7, 3.2, 1.6, 0, 0, 0, 1, 0.2112069,
4.8, 3.1, 1.6, 0, 0, 0, 1, 0.2112069,
5.4, 3.4, 1.5, 0, 0, 0, 1, 0.2112069,
5.2, 4.1, 1.5, 0, 0, 0, 1, 0.2112069,
5.5, 4.2, 1.4, 0, 0, 0, 1, 0.2112069,
4.9, 3.1, 1.5, 0, 0, 0, 1, 0.2112069,
5, 3.2, 1.2, 0, 0, 0, 1, 0.2112069,
5.5, 3.5, 1.3, 0, 0, 0, 1, 0.2112069,
4.9, 3.6, 1.4, 0, 0, 0, 1, 0.2112069,
4.4, 3, 1.3, 0, 0, 0, 1, 0.2112069,
5.1, 3.4, 1.5, 0, 0, 0, 1, 0.2112069,
5, 3.5, 1.3, 0, 0, 0, 1, 0.2112069,
4.5, 2.3, 1.3, 0, 0, 0, 1, 0.2112069,
4.4, 3.2, 1.3, 0, 0, 0, 1, 0.2112069,
5, 3.5, 1.6, 0, 0, 0, 1, 0.2112069,
5.1, 3.8, 1.9, 0, 0, 0, 1, 0.2112069,
4.8, 3, 1.4, 0, 0, 0, 1, 0.2112069,
5.1, 3.8, 1.6, 0, 0, 0, 1, 0.2112069,
4.6, 3.2, 1.4, 0, 0, 0, 1, 0.2112069,
5.3, 3.7, 1.5, 0, 0, 0, 1, 0.2112069,
5, 3.3, 1.4, 0, 0, 0, 1, 0.2112069,
7, 3.2, 4.7, 1, 0, 0, 1, 0.2112069,
6.4, 3.2, 4.5, 1, 0, 0, 1, 0.2112069,
6.9, 3.1, 4.9, 1, 0, 0, 1, 0.2112069,
5.5, 2.3, 4, 1, 0, 0, 1, 0.2112069,
6.5, 2.8, 4.6, 1, 0, 0, 1, 0.2112069,
5.7, 2.8, 4.5, 1, 0, 0, 1, 0.2112069,
6.3, 3.3, 4.7, 1, 0, 0, 1, 0.2112069,
4.9, 2.4, 3.3, 1, 0, 0, 1, 0.2112069,
6.6, 2.9, 4.6, 1, 0, 0, 1, 0.2112069,
5.2, 2.7, 3.9, 1, 0, 0, 1, 0.2112069,
5, 2, 3.5, 1, 0, 0, 1, 0.2112069,
5.9, 3, 4.2, 1, 0, 0, 1, 0.2112069,
6, 2.2, 4, 1, 0, 0, 1, 0.2112069,
6.1, 2.9, 4.7, 1, 0, 0, 1, 0.2112069,
5.6, 2.9, 3.6, 1, 0, 0, 1, 0.2112069,
6.7, 3.1, 4.4, 1, 0, 0, 1, 0.2112069,
5.6, 3, 4.5, 1, 0, 0, 1, 0.2112069,
5.8, 2.7, 4.1, 1, 0, 0, 1, 0.2112069,
6.2, 2.2, 4.5, 1, 0, 0, 1, 0.2112069,
5.6, 2.5, 3.9, 1, 0, 0, 1, 0.2112069,
5.9, 3.2, 4.8, 1, 0, 0, 1, 0.2112069,
6.1, 2.8, 4, 1, 0, 0, 1, 0.2112069,
6.3, 2.5, 4.9, 1, 0, 0, 1, 0.2112069,
6.1, 2.8, 4.7, 1, 0, 0, 1, 0.2112069,
6.4, 2.9, 4.3, 1, 0, 0, 1, 0.2112069,
6.6, 3, 4.4, 1, 0, 0, 1, 0.2112069,
6.8, 2.8, 4.8, 1, 0, 0, 1, 0.2112069,
6.7, 3, 5, 1, 0, 0, 1, 0.2112069,
6, 2.9, 4.5, 1, 0, 0, 1, 0.2112069,
5.7, 2.6, 3.5, 1, 0, 0, 1, 0.2112069,
5.5, 2.4, 3.8, 1, 0, 0, 1, 0.2112069,
5.5, 2.4, 3.7, 1, 0, 0, 1, 0.2112069,
5.8, 2.7, 3.9, 1, 0, 0, 1, 0.2112069,
6, 2.7, 5.1, 1, 0, 0, 1, 0.2112069,
5.4, 3, 4.5, 1, 0, 0, 1, 0.2112069,
6, 3.4, 4.5, 1, 0, 0, 1, 0.2112069,
6.7, 3.1, 4.7, 1, 0, 0, 1, 0.2112069,
6.3, 2.3, 4.4, 1, 0, 0, 1, 0.2112069,
5.6, 3, 4.1, 1, 0, 0, 1, 0.2112069,
5.5, 2.5, 4, 1, 0, 0, 1, 0.2112069,
5.5, 2.6, 4.4, 1, 0, 0, 1, 0.2112069,
6.1, 3, 4.6, 1, 0, 0, 1, 0.2112069,
5.8, 2.6, 4, 1, 0, 0, 1, 0.2112069,
5, 2.3, 3.3, 1, 0, 0, 1, 0.2112069,
5.6, 2.7, 4.2, 1, 0, 0, 1, 0.2112069,
5.7, 3, 4.2, 1, 0, 0, 1, 0.2112069,
5.7, 2.9, 4.2, 1, 0, 0, 1, 0.2112069,
6.2, 2.9, 4.3, 1, 0, 0, 1, 0.2112069,
5.1, 2.5, 3, 1, 0, 0, 1, 0.2112069,
5.7, 2.8, 4.1, 1, 0, 0, 1, 0.2112069,
6.3, 3.3, 6, 0, 0.8039216, 0, 1, 0.2112069,
5.8, 2.7, 5.1, 0, 0.8039216, 0, 1, 0.2112069,
7.1, 3, 5.9, 0, 0.8039216, 0, 1, 0.2112069,
6.3, 2.9, 5.6, 0, 0.8039216, 0, 1, 0.2112069,
6.5, 3, 5.8, 0, 0.8039216, 0, 1, 0.2112069,
7.6, 3, 6.6, 0, 0.8039216, 0, 1, 0.2112069,
4.9, 2.5, 4.5, 0, 0.8039216, 0, 1, 0.2112069,
7.3, 2.9, 6.3, 0, 0.8039216, 0, 1, 0.2112069,
6.7, 2.5, 5.8, 0, 0.8039216, 0, 1, 0.2112069,
7.2, 3.6, 6.1, 0, 0.8039216, 0, 1, 0.2112069,
6.5, 3.2, 5.1, 0, 0.8039216, 0, 1, 0.2112069,
6.4, 2.7, 5.3, 0, 0.8039216, 0, 1, 0.2112069,
6.8, 3, 5.5, 0, 0.8039216, 0, 1, 0.2112069,
5.7, 2.5, 5, 0, 0.8039216, 0, 1, 0.2112069,
5.8, 2.8, 5.1, 0, 0.8039216, 0, 1, 0.2112069,
6.4, 3.2, 5.3, 0, 0.8039216, 0, 1, 0.2112069,
6.5, 3, 5.5, 0, 0.8039216, 0, 1, 0.2112069,
7.7, 3.8, 6.7, 0, 0.8039216, 0, 1, 0.2112069,
7.7, 2.6, 6.9, 0, 0.8039216, 0, 1, 0.2112069,
6, 2.2, 5, 0, 0.8039216, 0, 1, 0.2112069,
6.9, 3.2, 5.7, 0, 0.8039216, 0, 1, 0.2112069,
5.6, 2.8, 4.9, 0, 0.8039216, 0, 1, 0.2112069,
7.7, 2.8, 6.7, 0, 0.8039216, 0, 1, 0.2112069,
6.3, 2.7, 4.9, 0, 0.8039216, 0, 1, 0.2112069,
6.7, 3.3, 5.7, 0, 0.8039216, 0, 1, 0.2112069,
7.2, 3.2, 6, 0, 0.8039216, 0, 1, 0.2112069,
6.2, 2.8, 4.8, 0, 0.8039216, 0, 1, 0.2112069,
6.1, 3, 4.9, 0, 0.8039216, 0, 1, 0.2112069,
6.4, 2.8, 5.6, 0, 0.8039216, 0, 1, 0.2112069,
7.2, 3, 5.8, 0, 0.8039216, 0, 1, 0.2112069,
7.4, 2.8, 6.1, 0, 0.8039216, 0, 1, 0.2112069,
7.9, 3.8, 6.4, 0, 0.8039216, 0, 1, 0.2112069,
6.4, 2.8, 5.6, 0, 0.8039216, 0, 1, 0.2112069,
6.3, 2.8, 5.1, 0, 0.8039216, 0, 1, 0.2112069,
6.1, 2.6, 5.6, 0, 0.8039216, 0, 1, 0.2112069,
7.7, 3, 6.1, 0, 0.8039216, 0, 1, 0.2112069,
6.3, 3.4, 5.6, 0, 0.8039216, 0, 1, 0.2112069,
6.4, 3.1, 5.5, 0, 0.8039216, 0, 1, 0.2112069,
6, 3, 4.8, 0, 0.8039216, 0, 1, 0.2112069,
6.9, 3.1, 5.4, 0, 0.8039216, 0, 1, 0.2112069,
6.7, 3.1, 5.6, 0, 0.8039216, 0, 1, 0.2112069,
6.9, 3.1, 5.1, 0, 0.8039216, 0, 1, 0.2112069,
5.8, 2.7, 5.1, 0, 0.8039216, 0, 1, 0.2112069,
6.8, 3.2, 5.9, 0, 0.8039216, 0, 1, 0.2112069,
6.7, 3.3, 5.7, 0, 0.8039216, 0, 1, 0.2112069,
6.7, 3, 5.2, 0, 0.8039216, 0, 1, 0.2112069,
6.3, 2.5, 5, 0, 0.8039216, 0, 1, 0.2112069,
6.5, 3, 5.2, 0, 0.8039216, 0, 1, 0.2112069,
6.2, 3.4, 5.4, 0, 0.8039216, 0, 1, 0.2112069,
5.9, 3, 5.1, 0, 0.8039216, 0, 1, 0.2112069
]);
this.values[7] = v;
this.normLoc[7] = gl.getAttribLocation(this.prog[7], "aNorm");
this.mvMatLoc[7] = gl.getUniformLocation(this.prog[7],"mvMatrix");
this.prMatLoc[7] = gl.getUniformLocation(this.prog[7],"prMatrix");
this.normMatLoc[7] = gl.getUniformLocation(this.prog[7],"normMatrix");
// ****** text object 9 ******
this.flags[9] = 40;
this.vshaders[9] = "	/* ****** text object 9 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[9] = "	/* ****** text object 9 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[9]  = gl.createProgram();
gl.attachShader(this.prog[9], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[9] ));
gl.attachShader(this.prog[9], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[9] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[9], 0, "aPos");
gl.bindAttribLocation(this.prog[9], 1, "aCol");
gl.linkProgram(this.prog[9]);
texts = [
"Sepal.Length"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[9] = gl.getAttribLocation(this.prog[9], "aOfs");
this.texture[9] = gl.createTexture();
this.texLoc[9] = gl.getAttribLocation(this.prog[9], "aTexcoord");
this.sampler[9] = gl.getUniformLocation(this.prog[9],"uSampler");
handleLoadedTexture(this.texture[9], document.getElementById("plot3dtextureCanvas"));
this.offsets[9]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
6.1, 1.432519, -0.3950545, 0, -0.5, 0.5, 0.5,
6.1, 1.432519, -0.3950545, 1, -0.5, 0.5, 0.5,
6.1, 1.432519, -0.3950545, 1, 1.5, 0.5, 0.5,
6.1, 1.432519, -0.3950545, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[9].stride*(4*i + j) + this.offsets[9].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[9] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[9] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[9]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[9], gl.STATIC_DRAW);
this.ibuf[9] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[9]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[9] = gl.getUniformLocation(this.prog[9],"mvMatrix");
this.prMatLoc[9] = gl.getUniformLocation(this.prog[9],"prMatrix");
this.textScaleLoc[9] = gl.getUniformLocation(this.prog[9],"textScale");
// ****** text object 10 ******
this.flags[10] = 40;
this.vshaders[10] = "	/* ****** text object 10 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[10] = "	/* ****** text object 10 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[10]  = gl.createProgram();
gl.attachShader(this.prog[10], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[10] ));
gl.attachShader(this.prog[10], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[10] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[10], 0, "aPos");
gl.bindAttribLocation(this.prog[10], 1, "aCol");
gl.linkProgram(this.prog[10]);
texts = [
"Sepal.Width"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[10] = gl.getAttribLocation(this.prog[10], "aOfs");
this.texture[10] = gl.createTexture();
this.texLoc[10] = gl.getAttribLocation(this.prog[10], "aTexcoord");
this.sampler[10] = gl.getUniformLocation(this.prog[10],"uSampler");
handleLoadedTexture(this.texture[10], document.getElementById("plot3dtextureCanvas"));
this.offsets[10]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
3.44878, 3.2, -0.3950545, 0, -0.5, 0.5, 0.5,
3.44878, 3.2, -0.3950545, 1, -0.5, 0.5, 0.5,
3.44878, 3.2, -0.3950545, 1, 1.5, 0.5, 0.5,
3.44878, 3.2, -0.3950545, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[10].stride*(4*i + j) + this.offsets[10].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[10] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[10] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[10]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[10], gl.STATIC_DRAW);
this.ibuf[10] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[10]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[10] = gl.getUniformLocation(this.prog[10],"mvMatrix");
this.prMatLoc[10] = gl.getUniformLocation(this.prog[10],"prMatrix");
this.textScaleLoc[10] = gl.getUniformLocation(this.prog[10],"textScale");
// ****** text object 11 ******
this.flags[11] = 40;
this.vshaders[11] = "	/* ****** text object 11 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[11] = "	/* ****** text object 11 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[11]  = gl.createProgram();
gl.attachShader(this.prog[11], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[11] ));
gl.attachShader(this.prog[11], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[11] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[11], 0, "aPos");
gl.bindAttribLocation(this.prog[11], 1, "aCol");
gl.linkProgram(this.prog[11]);
texts = [
"Petal.Length"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[11] = gl.getAttribLocation(this.prog[11], "aOfs");
this.texture[11] = gl.createTexture();
this.texLoc[11] = gl.getAttribLocation(this.prog[11], "aTexcoord");
this.sampler[11] = gl.getUniformLocation(this.prog[11],"uSampler");
handleLoadedTexture(this.texture[11], document.getElementById("plot3dtextureCanvas"));
this.offsets[11]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
3.44878, 1.432519, 3.95, 0, -0.5, 0.5, 0.5,
3.44878, 1.432519, 3.95, 1, -0.5, 0.5, 0.5,
3.44878, 1.432519, 3.95, 1, 1.5, 0.5, 0.5,
3.44878, 1.432519, 3.95, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[11].stride*(4*i + j) + this.offsets[11].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[11] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[11] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[11]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[11], gl.STATIC_DRAW);
this.ibuf[11] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[11]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[11] = gl.getUniformLocation(this.prog[11],"mvMatrix");
this.prMatLoc[11] = gl.getUniformLocation(this.prog[11],"prMatrix");
this.textScaleLoc[11] = gl.getUniformLocation(this.prog[11],"textScale");
// ****** lines object 12 ******
this.flags[12] = 128;
this.vshaders[12] = "	/* ****** lines object 12 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[12] = "	/* ****** lines object 12 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[12]  = gl.createProgram();
gl.attachShader(this.prog[12], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[12] ));
gl.attachShader(this.prog[12], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[12] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[12], 0, "aPos");
gl.bindAttribLocation(this.prog[12], 1, "aCol");
gl.linkProgram(this.prog[12]);
this.offsets[12]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
5, 1.840399, 0.6076504,
8, 1.840399, 0.6076504,
5, 1.840399, 0.6076504,
5, 1.772419, 0.4405329,
6, 1.840399, 0.6076504,
6, 1.772419, 0.4405329,
7, 1.840399, 0.6076504,
7, 1.772419, 0.4405329,
8, 1.840399, 0.6076504,
8, 1.772419, 0.4405329
]);
this.values[12] = v;
this.buf[12] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[12]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[12], gl.STATIC_DRAW);
this.mvMatLoc[12] = gl.getUniformLocation(this.prog[12],"mvMatrix");
this.prMatLoc[12] = gl.getUniformLocation(this.prog[12],"prMatrix");
// ****** text object 13 ******
this.flags[13] = 40;
this.vshaders[13] = "	/* ****** text object 13 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[13] = "	/* ****** text object 13 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[13]  = gl.createProgram();
gl.attachShader(this.prog[13], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[13] ));
gl.attachShader(this.prog[13], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[13] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[13], 0, "aPos");
gl.bindAttribLocation(this.prog[13], 1, "aCol");
gl.linkProgram(this.prog[13]);
texts = [
"5",
"6",
"7",
"8"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[13] = gl.getAttribLocation(this.prog[13], "aOfs");
this.texture[13] = gl.createTexture();
this.texLoc[13] = gl.getAttribLocation(this.prog[13], "aTexcoord");
this.sampler[13] = gl.getUniformLocation(this.prog[13],"uSampler");
handleLoadedTexture(this.texture[13], document.getElementById("plot3dtextureCanvas"));
this.offsets[13]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
5, 1.636459, 0.106298, 0, -0.5, 0.5, 0.5,
5, 1.636459, 0.106298, 1, -0.5, 0.5, 0.5,
5, 1.636459, 0.106298, 1, 1.5, 0.5, 0.5,
5, 1.636459, 0.106298, 0, 1.5, 0.5, 0.5,
6, 1.636459, 0.106298, 0, -0.5, 0.5, 0.5,
6, 1.636459, 0.106298, 1, -0.5, 0.5, 0.5,
6, 1.636459, 0.106298, 1, 1.5, 0.5, 0.5,
6, 1.636459, 0.106298, 0, 1.5, 0.5, 0.5,
7, 1.636459, 0.106298, 0, -0.5, 0.5, 0.5,
7, 1.636459, 0.106298, 1, -0.5, 0.5, 0.5,
7, 1.636459, 0.106298, 1, 1.5, 0.5, 0.5,
7, 1.636459, 0.106298, 0, 1.5, 0.5, 0.5,
8, 1.636459, 0.106298, 0, -0.5, 0.5, 0.5,
8, 1.636459, 0.106298, 1, -0.5, 0.5, 0.5,
8, 1.636459, 0.106298, 1, 1.5, 0.5, 0.5,
8, 1.636459, 0.106298, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<4; i++)
for (j=0; j<4; j++) {
ind = this.offsets[13].stride*(4*i + j) + this.offsets[13].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[13] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15
]);
this.buf[13] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[13]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[13], gl.STATIC_DRAW);
this.ibuf[13] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[13]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[13] = gl.getUniformLocation(this.prog[13],"mvMatrix");
this.prMatLoc[13] = gl.getUniformLocation(this.prog[13],"prMatrix");
this.textScaleLoc[13] = gl.getUniformLocation(this.prog[13],"textScale");
// ****** lines object 14 ******
this.flags[14] = 128;
this.vshaders[14] = "	/* ****** lines object 14 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[14] = "	/* ****** lines object 14 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[14]  = gl.createProgram();
gl.attachShader(this.prog[14], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[14] ));
gl.attachShader(this.prog[14], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[14] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[14], 0, "aPos");
gl.bindAttribLocation(this.prog[14], 1, "aCol");
gl.linkProgram(this.prog[14]);
this.offsets[14]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
4.0606, 2, 0.6076504,
4.0606, 4.5, 0.6076504,
4.0606, 2, 0.6076504,
3.95863, 2, 0.4405329,
4.0606, 2.5, 0.6076504,
3.95863, 2.5, 0.4405329,
4.0606, 3, 0.6076504,
3.95863, 3, 0.4405329,
4.0606, 3.5, 0.6076504,
3.95863, 3.5, 0.4405329,
4.0606, 4, 0.6076504,
3.95863, 4, 0.4405329,
4.0606, 4.5, 0.6076504,
3.95863, 4.5, 0.4405329
]);
this.values[14] = v;
this.buf[14] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[14]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[14], gl.STATIC_DRAW);
this.mvMatLoc[14] = gl.getUniformLocation(this.prog[14],"mvMatrix");
this.prMatLoc[14] = gl.getUniformLocation(this.prog[14],"prMatrix");
// ****** text object 15 ******
this.flags[15] = 40;
this.vshaders[15] = "	/* ****** text object 15 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[15] = "	/* ****** text object 15 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[15]  = gl.createProgram();
gl.attachShader(this.prog[15], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[15] ));
gl.attachShader(this.prog[15], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[15] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[15], 0, "aPos");
gl.bindAttribLocation(this.prog[15], 1, "aCol");
gl.linkProgram(this.prog[15]);
texts = [
"2",
"2.5",
"3",
"3.5",
"4",
"4.5"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[15] = gl.getAttribLocation(this.prog[15], "aOfs");
this.texture[15] = gl.createTexture();
this.texLoc[15] = gl.getAttribLocation(this.prog[15], "aTexcoord");
this.sampler[15] = gl.getUniformLocation(this.prog[15],"uSampler");
handleLoadedTexture(this.texture[15], document.getElementById("plot3dtextureCanvas"));
this.offsets[15]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
3.75469, 2, 0.106298, 0, -0.5, 0.5, 0.5,
3.75469, 2, 0.106298, 1, -0.5, 0.5, 0.5,
3.75469, 2, 0.106298, 1, 1.5, 0.5, 0.5,
3.75469, 2, 0.106298, 0, 1.5, 0.5, 0.5,
3.75469, 2.5, 0.106298, 0, -0.5, 0.5, 0.5,
3.75469, 2.5, 0.106298, 1, -0.5, 0.5, 0.5,
3.75469, 2.5, 0.106298, 1, 1.5, 0.5, 0.5,
3.75469, 2.5, 0.106298, 0, 1.5, 0.5, 0.5,
3.75469, 3, 0.106298, 0, -0.5, 0.5, 0.5,
3.75469, 3, 0.106298, 1, -0.5, 0.5, 0.5,
3.75469, 3, 0.106298, 1, 1.5, 0.5, 0.5,
3.75469, 3, 0.106298, 0, 1.5, 0.5, 0.5,
3.75469, 3.5, 0.106298, 0, -0.5, 0.5, 0.5,
3.75469, 3.5, 0.106298, 1, -0.5, 0.5, 0.5,
3.75469, 3.5, 0.106298, 1, 1.5, 0.5, 0.5,
3.75469, 3.5, 0.106298, 0, 1.5, 0.5, 0.5,
3.75469, 4, 0.106298, 0, -0.5, 0.5, 0.5,
3.75469, 4, 0.106298, 1, -0.5, 0.5, 0.5,
3.75469, 4, 0.106298, 1, 1.5, 0.5, 0.5,
3.75469, 4, 0.106298, 0, 1.5, 0.5, 0.5,
3.75469, 4.5, 0.106298, 0, -0.5, 0.5, 0.5,
3.75469, 4.5, 0.106298, 1, -0.5, 0.5, 0.5,
3.75469, 4.5, 0.106298, 1, 1.5, 0.5, 0.5,
3.75469, 4.5, 0.106298, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<6; i++)
for (j=0; j<4; j++) {
ind = this.offsets[15].stride*(4*i + j) + this.offsets[15].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[15] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23
]);
this.buf[15] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[15]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[15], gl.STATIC_DRAW);
this.ibuf[15] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[15]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[15] = gl.getUniformLocation(this.prog[15],"mvMatrix");
this.prMatLoc[15] = gl.getUniformLocation(this.prog[15],"prMatrix");
this.textScaleLoc[15] = gl.getUniformLocation(this.prog[15],"textScale");
// ****** lines object 16 ******
this.flags[16] = 128;
this.vshaders[16] = "	/* ****** lines object 16 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[16] = "	/* ****** lines object 16 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[16]  = gl.createProgram();
gl.attachShader(this.prog[16], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[16] ));
gl.attachShader(this.prog[16], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[16] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[16], 0, "aPos");
gl.bindAttribLocation(this.prog[16], 1, "aCol");
gl.linkProgram(this.prog[16]);
this.offsets[16]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
4.0606, 1.840399, 1,
4.0606, 1.840399, 7,
4.0606, 1.840399, 1,
3.95863, 1.772419, 1,
4.0606, 1.840399, 2,
3.95863, 1.772419, 2,
4.0606, 1.840399, 3,
3.95863, 1.772419, 3,
4.0606, 1.840399, 4,
3.95863, 1.772419, 4,
4.0606, 1.840399, 5,
3.95863, 1.772419, 5,
4.0606, 1.840399, 6,
3.95863, 1.772419, 6,
4.0606, 1.840399, 7,
3.95863, 1.772419, 7
]);
this.values[16] = v;
this.buf[16] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[16]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[16], gl.STATIC_DRAW);
this.mvMatLoc[16] = gl.getUniformLocation(this.prog[16],"mvMatrix");
this.prMatLoc[16] = gl.getUniformLocation(this.prog[16],"prMatrix");
// ****** text object 17 ******
this.flags[17] = 40;
this.vshaders[17] = "	/* ****** text object 17 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[17] = "	/* ****** text object 17 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[17]  = gl.createProgram();
gl.attachShader(this.prog[17], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[17] ));
gl.attachShader(this.prog[17], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[17] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[17], 0, "aPos");
gl.bindAttribLocation(this.prog[17], 1, "aCol");
gl.linkProgram(this.prog[17]);
texts = [
"1",
"2",
"3",
"4",
"5",
"6",
"7"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[17] = gl.getAttribLocation(this.prog[17], "aOfs");
this.texture[17] = gl.createTexture();
this.texLoc[17] = gl.getAttribLocation(this.prog[17], "aTexcoord");
this.sampler[17] = gl.getUniformLocation(this.prog[17],"uSampler");
handleLoadedTexture(this.texture[17], document.getElementById("plot3dtextureCanvas"));
this.offsets[17]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
3.75469, 1.636459, 1, 0, -0.5, 0.5, 0.5,
3.75469, 1.636459, 1, 1, -0.5, 0.5, 0.5,
3.75469, 1.636459, 1, 1, 1.5, 0.5, 0.5,
3.75469, 1.636459, 1, 0, 1.5, 0.5, 0.5,
3.75469, 1.636459, 2, 0, -0.5, 0.5, 0.5,
3.75469, 1.636459, 2, 1, -0.5, 0.5, 0.5,
3.75469, 1.636459, 2, 1, 1.5, 0.5, 0.5,
3.75469, 1.636459, 2, 0, 1.5, 0.5, 0.5,
3.75469, 1.636459, 3, 0, -0.5, 0.5, 0.5,
3.75469, 1.636459, 3, 1, -0.5, 0.5, 0.5,
3.75469, 1.636459, 3, 1, 1.5, 0.5, 0.5,
3.75469, 1.636459, 3, 0, 1.5, 0.5, 0.5,
3.75469, 1.636459, 4, 0, -0.5, 0.5, 0.5,
3.75469, 1.636459, 4, 1, -0.5, 0.5, 0.5,
3.75469, 1.636459, 4, 1, 1.5, 0.5, 0.5,
3.75469, 1.636459, 4, 0, 1.5, 0.5, 0.5,
3.75469, 1.636459, 5, 0, -0.5, 0.5, 0.5,
3.75469, 1.636459, 5, 1, -0.5, 0.5, 0.5,
3.75469, 1.636459, 5, 1, 1.5, 0.5, 0.5,
3.75469, 1.636459, 5, 0, 1.5, 0.5, 0.5,
3.75469, 1.636459, 6, 0, -0.5, 0.5, 0.5,
3.75469, 1.636459, 6, 1, -0.5, 0.5, 0.5,
3.75469, 1.636459, 6, 1, 1.5, 0.5, 0.5,
3.75469, 1.636459, 6, 0, 1.5, 0.5, 0.5,
3.75469, 1.636459, 7, 0, -0.5, 0.5, 0.5,
3.75469, 1.636459, 7, 1, -0.5, 0.5, 0.5,
3.75469, 1.636459, 7, 1, 1.5, 0.5, 0.5,
3.75469, 1.636459, 7, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<7; i++)
for (j=0; j<4; j++) {
ind = this.offsets[17].stride*(4*i + j) + this.offsets[17].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[17] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23,
24, 25, 26, 24, 26, 27
]);
this.buf[17] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[17]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[17], gl.STATIC_DRAW);
this.ibuf[17] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[17]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[17] = gl.getUniformLocation(this.prog[17],"mvMatrix");
this.prMatLoc[17] = gl.getUniformLocation(this.prog[17],"prMatrix");
this.textScaleLoc[17] = gl.getUniformLocation(this.prog[17],"textScale");
// ****** lines object 18 ******
this.flags[18] = 128;
this.vshaders[18] = "	/* ****** lines object 18 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[18] = "	/* ****** lines object 18 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[18]  = gl.createProgram();
gl.attachShader(this.prog[18], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[18] ));
gl.attachShader(this.prog[18], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[18] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[18], 0, "aPos");
gl.bindAttribLocation(this.prog[18], 1, "aCol");
gl.linkProgram(this.prog[18]);
this.offsets[18]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
4.0606, 1.840399, 0.6076504,
4.0606, 4.559601, 0.6076504,
4.0606, 1.840399, 7.29235,
4.0606, 4.559601, 7.29235,
4.0606, 1.840399, 0.6076504,
4.0606, 1.840399, 7.29235,
4.0606, 4.559601, 0.6076504,
4.0606, 4.559601, 7.29235,
4.0606, 1.840399, 0.6076504,
8.1394, 1.840399, 0.6076504,
4.0606, 1.840399, 7.29235,
8.1394, 1.840399, 7.29235,
4.0606, 4.559601, 0.6076504,
8.1394, 4.559601, 0.6076504,
4.0606, 4.559601, 7.29235,
8.1394, 4.559601, 7.29235,
8.1394, 1.840399, 0.6076504,
8.1394, 4.559601, 0.6076504,
8.1394, 1.840399, 7.29235,
8.1394, 4.559601, 7.29235,
8.1394, 1.840399, 0.6076504,
8.1394, 1.840399, 7.29235,
8.1394, 4.559601, 0.6076504,
8.1394, 4.559601, 7.29235
]);
this.values[18] = v;
this.buf[18] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[18]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[18], gl.STATIC_DRAW);
this.mvMatLoc[18] = gl.getUniformLocation(this.prog[18],"mvMatrix");
this.prMatLoc[18] = gl.getUniformLocation(this.prog[18],"prMatrix");
gl.enable(gl.DEPTH_TEST);
gl.depthFunc(gl.LEQUAL);
gl.clearDepth(1.0);
gl.clearColor(1,1,1,1);
var drag  = 0;
this.drawScene = function() {
gl.depthMask(true);
gl.disable(gl.BLEND);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
this.drawFns[1].call(this, 1);
gl.flush();
};
// ****** spheres object 7 *******
this.drawFns[7] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, sphereBuf);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, sphereIbuf);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.enableVertexAttribArray(this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id],  3, gl.FLOAT, false, 12,  0);
gl.disableVertexAttribArray( colLoc );
var sphereNorm = new CanvasMatrix4();
sphereNorm.scale(1.17337, 1.760048, 0.7159564);
sphereNorm.multRight(normMatrix);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(sphereNorm.getAsArray()) );
for (i = 0; i < 150; i++) {
var sphereMV = new CanvasMatrix4();
var baseofs = i*plot3drgl.offsets[id].stride;
var ofs = baseofs + this.offsets[id].radofs;
var scale = this.values[id][ofs];
sphereMV.scale(0.8522463*scale, 0.5681663*scale, 1.396733*scale);
sphereMV.translate(this.values[id][baseofs],
this.values[id][baseofs+1],
this.values[id][baseofs+2]);
sphereMV.multRight(this.mvMatrix);
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(sphereMV.getAsArray()) );
ofs = baseofs + this.offsets[id].cofs;
gl.vertexAttrib4f( colLoc, this.values[id][ofs],
this.values[id][ofs+1],
this.values[id][ofs+2],
this.values[id][ofs+3] );
gl.drawElements(gl.TRIANGLES, 384, gl.UNSIGNED_SHORT, 0);
}
};
// ****** text object 9 *******
this.drawFns[9] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 10 *******
this.drawFns[10] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 11 *******
this.drawFns[11] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 12 *******
this.drawFns[12] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 10);
};
// ****** text object 13 *******
this.drawFns[13] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 14 *******
this.drawFns[14] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 14);
};
// ****** text object 15 *******
this.drawFns[15] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 16 *******
this.drawFns[16] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 16);
};
// ****** text object 17 *******
this.drawFns[17] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 42, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 18 *******
this.drawFns[18] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 24);
};
// ***** subscene 1 ****
this.drawFns[1] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.clearColor(1, 1, 1, 1);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
this.prMatrix.makeIdentity();
var radius = 4.426427,
distance = 19.69367,
t = tan(this.FOV[1]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[1];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -6.1, -3.2, -3.95 );
this.mvMatrix.scale( 1.17337, 1.760048, 0.7159564 );
this.mvMatrix.multRight( plot3drgl.userMatrix[1] );
this.mvMatrix.translate(-0, -0, -19.69367);
normMatrix.makeIdentity();
normMatrix.scale( 0.8522463, 0.5681663, 1.396733 );
normMatrix.multRight( plot3drgl.userMatrix[1] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
this.drawScene();
var vpx0 = {
1: 0
};
var vpy0 = {
1: 0
};
var vpWidths = {
1: 504
};
var vpHeights = {
1: 504
};
var activeModel = {
1: 1
};
var activeProjection = {
1: 1
};
plot3drgl.listeners = {
1: [ 1 ]
};
var whichSubscene = function(coords){
if (0 <= coords.x && coords.x <= 504 && 0 <= coords.y && coords.y <= 504) return(1);
return(1);
};
var translateCoords = function(subsceneid, coords){
return {x:coords.x - vpx0[subsceneid], y:coords.y - vpy0[subsceneid]};
};
var vlen = function(v) {
return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
};
var xprod = function(a, b) {
return [a[1]*b[2] - a[2]*b[1],
a[2]*b[0] - a[0]*b[2],
a[0]*b[1] - a[1]*b[0]];
};
var screenToVector = function(x, y) {
var width = vpWidths[activeSubscene],
height = vpHeights[activeSubscene],
radius = max(width, height)/2.0,
cx = width/2.0,
cy = height/2.0,
px = (x-cx)/radius,
py = (y-cy)/radius,
plen = sqrt(px*px+py*py);
if (plen > 1.e-6) {
px = px/plen;
py = py/plen;
}
var angle = (SQRT2 - plen)/SQRT2*PI/2,
z = sin(angle),
zlen = sqrt(1.0 - z*z);
px = px * zlen;
py = py * zlen;
return [px, py, z];
};
var rotBase;
var trackballdown = function(x,y) {
rotBase = screenToVector(x, y);
var l = plot3drgl.listeners[activeModel[activeSubscene]];
saveMat = {};
for (var i = 0; i < l.length; i++)
saveMat[l[i]] = new CanvasMatrix4(plot3drgl.userMatrix[l[i]]);
};
var trackballmove = function(x,y) {
var rotCurrent = screenToVector(x,y),
dot = rotBase[0]*rotCurrent[0] +
rotBase[1]*rotCurrent[1] +
rotBase[2]*rotCurrent[2],
angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180.0/PI,
axis = xprod(rotBase, rotCurrent),
l = plot3drgl.listeners[activeModel[activeSubscene]],
i;
for (i = 0; i < l.length; i++) {
plot3drgl.userMatrix[l[i]].load(saveMat[l[i]]);
plot3drgl.userMatrix[l[i]].rotate(angle, axis[0], axis[1], axis[2]);
}
plot3drgl.drawScene();
};
var trackballend = 0;
var y0zoom = 0;
var zoom0 = 0;
var zoomdown = function(x, y) {
y0zoom = y;
zoom0 = {};
l = plot3drgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
zoom0[l[i]] = log(plot3drgl.zoom[l[i]]);
};
var zoommove = function(x, y) {
l = plot3drgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
plot3drgl.zoom[l[i]] = exp(zoom0[l[i]] + (y-y0zoom)/height);
plot3drgl.drawScene();
};
var zoomend = 0;
var y0fov = 0;
var fov0 = 0;
var fovdown = function(x, y) {
y0fov = y;
fov0 = {};
l = plot3drgl.listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
fov0[l[i]] = plot3drgl.FOV[l[i]];
};
var fovmove = function(x, y) {
l = plot3drgl.listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
plot3drgl.FOV[l[i]] = max(1, min(179, fov0[l[i]] + 180*(y-y0fov)/height));
plot3drgl.drawScene();
};
var fovend = 0;
var mousedown = [trackballdown, zoomdown, fovdown];
var mousemove = [trackballmove, zoommove, fovmove];
var mouseend = [trackballend, zoomend, fovend];
function relMouseCoords(event){
var totalOffsetX = 0,
totalOffsetY = 0,
currentElement = canvas;
do{
totalOffsetX += currentElement.offsetLeft;
totalOffsetY += currentElement.offsetTop;
currentElement = currentElement.offsetParent;
}
while(currentElement);
var canvasX = event.pageX - totalOffsetX,
canvasY = event.pageY - totalOffsetY;
return {x:canvasX, y:canvasY};
}
canvas.onmousedown = function ( ev ){
if (!ev.which) // Use w3c defns in preference to MS
switch (ev.button) {
case 0: ev.which = 1; break;
case 1:
case 4: ev.which = 2; break;
case 2: ev.which = 3;
}
drag = ev.which;
var f = mousedown[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height-coords.y;
activeSubscene = whichSubscene(coords);
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
ev.preventDefault();
}
};
canvas.onmouseup = function ( ev ){
if ( drag === 0 ) return;
var f = mouseend[drag-1];
if (f)
f();
drag = 0;
};
canvas.onmouseout = canvas.onmouseup;
canvas.onmousemove = function ( ev ){
if ( drag === 0 ) return;
var f = mousemove[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height - coords.y;
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
}
};
var wheelHandler = function(ev) {
var del = 1.1;
if (ev.shiftKey) del = 1.01;
var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
l = plot3drgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
plot3drgl.zoom[l[i]] *= ds;
plot3drgl.drawScene();
ev.preventDefault();
};
canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
canvas.addEventListener("mousewheel", wheelHandler, false);
};
</script>
<canvas id="plot3dcanvas" class="rglWebGL" width="1" height="1"></canvas>
<p id="plot3ddebug">
You must enable Javascript to view this page properly.</p>
<script>plot3drgl.start();</script>
can be used to plot three columns of the `iris` data.  
Allowed plot types include `"p", "l", "h", "s"`,
meaning points, lines, segments from z=0, and spheres.  There's
a lot of flexibility in specifying the coordinates; the 
<a href="../../grDevices/help/xyz.coords">`xyz.coords`</a> function
from the `grDevices` package is used for this.

You can use your mouse to manipulate the plot.  The default is that
if you click and hold with the left mouse button, you can rotate 
the plot by dragging it.  The right mouse button is used to resize
it, and the middle button changes the perspective in the point of view.

If you call <a href="#plot3d">`plot3d`</a> again, it will overwrite the current plot.
To open a new graphics window, use <a href="#open3d">`open3d`</a>.
 
The other high level function is <a name="persp3d"><a href="../../rgl/help/persp3d">`persp3d`</a></a> to draw surfaces.
It is
similar to the classic <a href="../../graphics/help/persp">`persp`</a>
function, but with greater flexibility.
First, any of `x`, `y` or `z`
can be specified using matrices, not just `z`.  This allows parametric
surfaces to be plotted. 
An even simpler specification is possible:  `x` may be a function,
in which case `persp3d` will work out the grid itself.  See 
<a href="../../rgl/help/persp3d.function">?persp3d.function</a>
for details.  For example, the `MASS` package estimates
Gamma parameters using maximum likelihood in a 
<a href="../../MASS/help/fitdistr">?MASS::fitdistr</a> example.
Here we show the log likelihood surface. 

```r
library(MASS)
# from the fitdistr example
set.seed(123)
x <- rgamma(100, shape = 5, rate = 0.1)
fit <- fitdistr(x, dgamma, list(shape = 1, rate = 0.1), lower = 0.001)
loglik <- function(shape, rate) sum(dgamma(x, shape=shape, rate=rate, 
                                           log=TRUE))
loglik <- Vectorize(loglik)
xlim <- fit$estimate[1]+4*fit$sd[1]*c(-1,1)
ylim <- fit$estimate[2]+4*fit$sd[2]*c(-1,1)

mfrow3d(1, 2, sharedMouse = TRUE)
persp3d(loglik, 
        xlim = xlim, ylim = ylim,
        n = 30)
zlim <- fit$loglik + c(-qchisq(0.99, 2)/2, 0)
next3d()
persp3d(loglik, 
        xlim = xlim, ylim = ylim, zlim = zlim,
        n = 30)
```

<canvas id="persp3dtextureCanvas" style="display: none;" width="256" height="256">
Your browser does not support the HTML5 canvas element.</canvas>
<script type="text/javascript">
var persp3drgl = new rglClass();
persp3drgl.start = function() {
var i, j, v, ind, texts, f, texinfo;
var debug = function(msg) {
document.getElementById("persp3ddebug").innerHTML = msg;
};
debug("");
var canvas = document.getElementById("persp3dcanvas");
if (!window.WebGLRenderingContext){
debug(" Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
try {
// Try to grab the standard context. If it fails, fallback to experimental.
this.gl = canvas.getContext("webgl") ||
canvas.getContext("experimental-webgl");
}
catch(e) {}
if ( !this.gl ) {
debug(" Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var gl = this.gl,
width = 433, height = 217;
canvas.width = width;   canvas.height = height;
var normMatrix = new CanvasMatrix4(),
saveMat = {},
distance,
posLoc = 0,
colLoc = 1;
var activeSubscene = 19;
this.flags[19] = 1024;
this.zoom[19] = 1;
this.FOV[19] = 30;
this.viewport[19] = [0, 0, 432, 216];
this.userMatrix[19] = new CanvasMatrix4();
this.userMatrix[19].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[19] = [];
this.opaque[19] = [];
this.transparent[19] = [];
this.subscenes[19] = [25,26];
this.flags[25] = 1195;
this.zoom[25] = 1;
this.FOV[25] = 30;
this.viewport[25] = [0, 0, 216, 216];
this.userMatrix[25] = new CanvasMatrix4();
this.userMatrix[25].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[25] = [];
this.opaque[25] = [27,29,30,31,40,41,42,43,44,45,46];
this.transparent[25] = [];
this.subscenes[25] = [];
this.flags[26] = 1192;
this.zoom[26] = 1;
this.FOV[26] = 30;
this.viewport[26] = [216, 0, 216, 216];
this.userMatrix[26] = new CanvasMatrix4();
this.userMatrix[26].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[26] = [];
this.opaque[26] = [35,37,38,39,47,48,49,50,51,52,53];
this.transparent[26] = [];
this.subscenes[26] = [32];
this.flags[32] = 3083;
this.viewport[32] = [216, 0, 216, 216];
this.clipplanes[32] = [33];
this.opaque[32] = [34];
this.transparent[32] = [];
this.subscenes[32] = [];
function getPowerOfTwo(value) {
var pow = 1;
while(pow<value) {
pow *= 2;
}
return pow;
}
function handleLoadedTexture(texture, textureCanvas) {
gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
gl.bindTexture(gl.TEXTURE_2D, texture);
gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
gl.generateMipmap(gl.TEXTURE_2D);
gl.bindTexture(gl.TEXTURE_2D, null);
}
function loadImageToTexture(filename, texture) {
var canvas = document.getElementById("persp3dtextureCanvas"),
ctx = canvas.getContext("2d"),
image = new Image();
image.onload = function() {
var w = image.width,
h = image.height,
canvasX = getPowerOfTwo(w),
canvasY = getPowerOfTwo(h);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.imageSmoothingEnabled = true;
ctx.drawImage(image, 0, 0, canvasX, canvasY);
handleLoadedTexture(texture, canvas);
persp3drgl.drawScene();
};
image.src = filename;
}
function drawTextToCanvas(text, cex) {
var canvasX, canvasY,
textX, textY,
textHeight = 20 * cex,
textColour = "white",
fontFamily = "Arial",
backgroundColour = "rgba(0,0,0,0)",
canvas = document.getElementById("persp3dtextureCanvas"),
ctx = canvas.getContext("2d"),
i;
ctx.font = textHeight+"px "+fontFamily;
canvasX = 1;
var widths = [];
for (i = 0; i < text.length; i++)  {
widths[i] = ctx.measureText(text[i]).width;
canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
}
canvasX = getPowerOfTwo(canvasX);
var offset = 2*textHeight, // offset to first baseline
skip = 2*textHeight;   // skip between baselines
canvasY = getPowerOfTwo(offset + text.length*skip);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.fillStyle = backgroundColour;
ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
ctx.fillStyle = textColour;
ctx.textAlign = "left";
ctx.textBaseline = "alphabetic";
ctx.font = textHeight+"px "+fontFamily;
for(i = 0; i < text.length; i++) {
textY = i*skip + offset;
ctx.fillText(text[i], 0,  textY);
}
return {canvasX:canvasX, canvasY:canvasY,
widths:widths, textHeight:textHeight,
offset:offset, skip:skip};
}
// ****** surface object 27 ******
this.flags[27] = 11;
this.vshaders[27] = "	/* ****** surface object 27 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[27] = "	/* ****** surface object 27 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[27]  = gl.createProgram();
gl.attachShader(this.prog[27], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[27] ));
gl.attachShader(this.prog[27], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[27] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[27], 0, "aPos");
gl.bindAttribLocation(this.prog[27], 1, "aCol");
gl.linkProgram(this.prog[27]);
this.offsets[27]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
2.909307, 0.0582374, -442.918, -0.1733823, -0.9846532, 0.01991898,
3.156036, 0.0582374, -442.828, -0.006314733, -0.9999165, 0.0112765,
3.402764, 0.0582374, -445.0072, 0.01110619, -0.9999374, 0.001380169,
3.649492, 0.0582374, -449.266, 0.01391447, -0.9999029, 0.0008538322,
3.89622, 0.0582374, -455.4438, 0.0149837, -0.9998875, 0.0006270157,
4.142948, 0.0582374, -463.403, 0.01538958, -0.9998815, 0.0004973433,
4.389677, 0.0582374, -473.0242, 0.01548466, -0.9998801, 0.0004127407,
4.636405, 0.0582374, -484.203, 0.01541809, -0.9998811, 0.0003529912,
4.883132, 0.0582374, -496.8474, 0.01526284, -0.9998835, 0.0003084721,
5.129861, 0.0582374, -510.8753, 0.01505807, -0.9998866, 0.0002739869,
5.376589, 0.0582374, -526.2137, 0.01482602, -0.9998901, 0.0002464719,
5.623317, 0.0582374, -542.7966, 0.01458001, -0.9998938, 0.0002239998,
5.870045, 0.0582374, -560.5645, 0.01432824, -0.9998974, 0.0002052962,
6.116773, 0.0582374, -579.463, 0.01407576, -0.9999009, 0.0001894841,
6.363502, 0.0582374, -599.4429, 0.01382584, -0.9999044, 0.0001759393,
6.610229, 0.0582374, -620.4588, 0.01358046, -0.9999079, 0.0001642057,
6.856958, 0.0582374, -642.4691, 0.01334087, -0.999911, 0.0001539422,
7.103686, 0.0582374, -665.4352, 0.01310784, -0.9999142, 0.0001448885,
7.350414, 0.0582374, -689.3216, 0.0128817, -0.9999171, 0.0001368422,
7.597142, 0.0582374, -714.0953, 0.01266264, -0.9999198, 0.0001296436,
7.84387, 0.0582374, -739.7254, 0.01245071, -0.9999225, 0.0001231655,
8.090598, 0.0582374, -766.1834, 0.01224574, -0.9999251, 0.0001173047,
8.337327, 0.0582374, -793.4423, 0.01204764, -0.9999275, 0.000111977,
8.584055, 0.0582374, -821.4771, 0.01185622, -0.9999298, 0.0001071126,
8.830783, 0.0582374, -850.264, 0.01167119, -0.999932, 0.0001026536,
9.077511, 0.0582374, -879.7809, 0.01149233, -0.999934, 9.855122e-05,
9.324239, 0.0582374, -910.0068, 0.01131938, -0.999936, 9.476439e-05,
9.570968, 0.0582374, -940.9219, 0.01115215, -0.9999378, 9.125804e-05,
9.817696, 0.0582374, -972.5074, 0.01099038, -0.9999396, 8.80021e-05,
10.06442, 0.0582374, -1004.746, 0.01091729, -0.9999405, 8.643325e-05,
2.909307, 0.06363552, -442.7806, -0.4404045, -0.8953233, 0.06663439,
3.156036, 0.06363552, -440.5035, -0.3564373, -0.9337018, 0.03396469,
3.402764, 0.06363552, -440.4956, 0.003059807, -0.9998619, 0.01634069,
3.649492, 0.06363552, -442.5673, 0.01267542, -0.9999191, 0.001198615,
3.89622, 0.06363552, -446.558, 0.01463138, -0.9998927, 0.0007852869,
4.142948, 0.06363552, -452.3301, 0.01537442, -0.9998817, 0.0005936368,
4.389677, 0.06363552, -459.7642, 0.01562779, -0.9998778, 0.0004793614,
4.636405, 0.06363552, -468.756, 0.01564475, -0.9998776, 0.0004027161,
4.883132, 0.06363552, -479.2132, 0.01553667, -0.9998793, 0.0003475111,
5.129861, 0.06363552, -491.0541, 0.01535957, -0.999882, 0.0003057659,
5.376589, 0.06363552, -504.2054, 0.01514392, -0.9998854, 0.0002730539,
5.623317, 0.06363552, -518.6012, 0.01490744, -0.9998889, 0.0002467106,
5.870045, 0.06363552, -534.1819, 0.01466086, -0.9998925, 0.0002250308,
6.116773, 0.06363552, -550.8934, 0.01441074, -0.9998962, 0.0002068713,
6.363502, 0.06363552, -568.6862, 0.01416126, -0.9998997, 0.0001914355,
6.610229, 0.06363552, -587.515, 0.01391504, -0.9999031, 0.0001781513,
6.856958, 0.06363552, -607.3381, 0.01367375, -0.9999065, 0.0001665966,
7.103686, 0.06363552, -628.1171, 0.01343839, -0.9999097, 0.0001564537,
7.350414, 0.06363552, -649.8165, 0.0132095, -0.9999128, 0.0001474779,
7.597142, 0.06363552, -672.403, 0.01298742, -0.9999157, 0.0001394783,
7.84387, 0.06363552, -695.8461, 0.01277228, -0.9999185, 0.0001323037,
8.090598, 0.06363552, -720.1169, 0.01256399, -0.9999211, 0.0001258323,
8.337327, 0.06363552, -745.1888, 0.0123625, -0.9999236, 0.0001199655,
8.584055, 0.06363552, -771.0364, 0.01216766, -0.999926, 0.0001146223,
8.830783, 0.06363552, -797.6363, 0.01197921, -0.9999283, 0.0001097353,
9.077511, 0.06363552, -824.9661, 0.01179694, -0.9999305, 0.0001052486,
9.324239, 0.06363552, -853.0048, 0.01162064, -0.9999325, 0.0001011147,
9.570968, 0.06363552, -881.7328, 0.01145008, -0.9999344, 9.729365e-05,
9.817696, 0.06363552, -911.1313, 0.01128504, -0.9999364, 9.375121e-05,
10.06442, 0.06363552, -941.1826, 0.0112041, -0.9999373, 9.204566e-05,
2.909307, 0.06903364, -444.7443, -0.3665033, 0.930172, 0.02133924,
3.156036, 0.06903364, -440.4583, -0.6675006, 0.7352419, 0.1177378,
3.402764, 0.06903364, -438.4415, -0.6590972, -0.7485873, 0.07216562,
3.649492, 0.06903364, -438.5043, 0.01219323, -0.9995008, 0.02914364,
3.89622, 0.06903364, -440.4861, 0.01333859, -0.9999102, 0.001329768,
4.142948, 0.06903364, -444.2493, 0.01513546, -0.9998852, 0.000862965,
4.389677, 0.06903364, -449.6745, 0.01582005, -0.9998747, 0.0006500814,
4.636405, 0.06903364, -456.6573, 0.01604742, -0.9998711, 0.000523932,
4.883132, 0.06903364, -465.1056, 0.01605271, -0.9998711, 0.0004396146,
5.129861, 0.06903364, -474.9376, 0.01594008, -0.999873, 0.0003790198,
5.376589, 0.06903364, -486.08, 0.01576199, -0.9998757, 0.000333272,
5.623317, 0.06903364, -498.4668, 0.01554718, -0.9998792, 0.0002974669,
5.870045, 0.06903364, -512.0386, 0.01531247, -0.9998828, 0.0002686595,
6.116773, 0.06903364, -526.7412, 0.01506793, -0.9998865, 0.0002449697,
6.363502, 0.06903364, -542.5251, 0.0148199, -0.9998902, 0.0002251388,
6.610229, 0.06903364, -559.345, 0.01457235, -0.9998938, 0.0002082911,
6.856958, 0.06903364, -577.1592, 0.01432787, -0.9998974, 0.000193798,
7.103686, 0.06903364, -595.9293, 0.01408804, -0.9999008, 0.0001811968,
7.350414, 0.06903364, -615.6198, 0.0138538, -0.999904, 0.0001701388,
7.597142, 0.06903364, -636.1974, 0.01362581, -0.9999072, 0.0001603563,
7.84387, 0.06903364, -657.6315, 0.01340436, -0.9999102, 0.0001516399,
8.090598, 0.06903364, -679.8935, 0.01318952, -0.999913, 0.0001438241,
8.337327, 0.06903364, -702.9564, 0.01298135, -0.9999158, 0.0001367759,
8.584055, 0.06903364, -726.7952, 0.01277977, -0.9999184, 0.0001303873,
8.830783, 0.06903364, -751.3861, 0.01258458, -0.9999209, 0.0001245699,
9.077511, 0.06903364, -776.707, 0.01239561, -0.9999232, 0.00011925,
9.324239, 0.06903364, -802.7368, 0.01221267, -0.9999255, 0.0001143665,
9.570968, 0.06903364, -829.4559, 0.01203557, -0.9999276, 0.0001098677,
9.817696, 0.06903364, -856.8455, 0.01186408, -0.9999297, 0.0001057099,
10.06442, 0.06903364, -884.8879, 0.01177998, -0.9999307, 0.0001037111,
2.909307, 0.07443175, -448.4924, -0.04158115, 0.9991336, 0.001706959,
3.156036, 0.07443175, -442.3488, -0.160208, 0.9870341, 0.009851196,
3.402764, 0.07443175, -438.4744, -0.2329365, 0.9708249, 0.05691927,
3.649492, 0.07443175, -436.6796, -0.9315635, -0.344452, 0.1163714,
3.89622, 0.07443175, -436.8038, 0.01058928, -0.9998778, 0.01149942,
4.142948, 0.07443175, -438.7094, 0.01403513, -0.9999005, 0.001467471,
4.389677, 0.07443175, -442.277, 0.01564566, -0.9998772, 0.0009427461,
4.636405, 0.07443175, -447.4023, 0.01626107, -0.9998676, 0.0007076225,
4.883132, 0.07443175, -453.993, 0.01645586, -0.9998645, 0.000569186,
5.129861, 0.07443175, -461.9673, 0.01644497, -0.9998647, 0.0004769824,
5.376589, 0.07443175, -471.2521, 0.01632439, -0.9998667, 0.0004108718,
5.623317, 0.07443175, -481.7815, 0.01614276, -0.9998696, 0.0003610406,
5.870045, 0.07443175, -493.4957, 0.01592689, -0.9998732, 0.0003220866,
6.116773, 0.07443175, -506.3406, 0.01569241, -0.9998769, 0.0002907756,
6.363502, 0.07443175, -520.267, 0.01544883, -0.9998807, 0.0002650466,
6.610229, 0.07443175, -535.2292, 0.01520202, -0.9998845, 0.0002435223,
6.856958, 0.07443175, -551.1859, 0.01495584, -0.9998882, 0.0002252453,
7.103686, 0.07443175, -568.0984, 0.01471266, -0.9998918, 0.00020953,
7.350414, 0.07443175, -585.9312, 0.01447394, -0.9998952, 0.0001958714,
7.597142, 0.07443175, -604.6513, 0.01424071, -0.9998987, 0.0001838894,
7.84387, 0.07443175, -624.2279, 0.01401353, -0.9999018, 0.0001732924,
8.090598, 0.07443175, -644.6323, 0.01379262, -0.9999049, 0.000163853,
8.337327, 0.07443175, -665.8376, 0.01357819, -0.9999079, 0.0001553907,
8.584055, 0.07443175, -687.8187, 0.01337025, -0.9999107, 0.0001477611,
8.830783, 0.07443175, -710.5521, 0.01316866, -0.9999133, 0.0001408469,
9.077511, 0.07443175, -734.0154, 0.01297332, -0.9999158, 0.0001345519,
9.324239, 0.07443175, -758.1876, 0.01278403, -0.9999183, 0.0001287963,
9.570968, 0.07443175, -783.0491, 0.01260067, -0.9999207, 0.0001235135,
9.817696, 0.07443175, -808.5811, 0.012423, -0.9999229, 0.0001186474,
10.06442, 0.07443175, -834.7659, 0.01233587, -0.999924, 0.0001163122,
2.909307, 0.07982987, -453.7747, -0.03489903, 0.9993902, 0.001108189,
3.156036, 0.07982987, -445.9037, -0.03704328, 0.9993126, 0.001446361,
3.402764, 0.07982987, -440.3018, -0.1097788, 0.9939289, 0.007334975,
3.649492, 0.07982987, -436.7795, -0.1250741, 0.9918209, 0.02544901,
3.89622, 0.07982987, -435.1763, -0.9750286, -0.1738242, 0.1382182,
4.142948, 0.07982987, -435.3544, 0.01092478, -0.9999043, 0.008479643,
4.389677, 0.07982987, -437.1945, 0.01476817, -0.9998897, 0.001612344,
4.636405, 0.07982987, -440.5923, 0.01616381, -0.9998689, 0.001024728,
4.883132, 0.07982987, -445.4556, 0.01669987, -0.9998603, 0.0007662957,
5.129861, 0.07982987, -451.7025, 0.01685612, -0.9998578, 0.0006151407,
5.376589, 0.07982987, -459.2598, 0.01682482, -0.9998584, 0.0005148292,
5.623317, 0.07982987, -468.0616, 0.01669315, -0.9998606, 0.0004430726,
5.870045, 0.07982987, -478.0484, 0.01650569, -0.9998637, 0.0003890747,
6.116773, 0.07982987, -489.1659, 0.01628695, -0.9998673, 0.0003469158,
6.363502, 0.07982987, -501.3647, 0.01605136, -0.9998712, 0.0003130611,
6.610229, 0.07982987, -514.5995, 0.01580762, -0.9998751, 0.0002852635,
6.856958, 0.07982987, -528.8287, 0.01556128, -0.9998789, 0.0002620232,
7.103686, 0.07982987, -544.0137, 0.01531584, -0.9998828, 0.0002422997,
7.350414, 0.07982987, -560.1191, 0.01507343, -0.9998864, 0.0002253482,
7.597142, 0.07982987, -577.1117, 0.01483554, -0.9998899, 0.0002106209,
7.84387, 0.07982987, -594.9608, 0.01460309, -0.9998934, 0.0001977058,
8.090598, 0.07982987, -613.6378, 0.01437649, -0.9998966, 0.0001862869,
8.337327, 0.07982987, -633.1156, 0.01415612, -0.9998998, 0.000176118,
8.584055, 0.07982987, -653.3693, 0.0139421, -0.9999028, 0.000167004,
8.830783, 0.07982987, -674.3751, 0.01373437, -0.9999058, 0.0001587885,
9.077511, 0.07982987, -696.111, 0.01353287, -0.9999084, 0.0001513447,
9.324239, 0.07982987, -718.5558, 0.01333746, -0.9999111, 0.0001445687,
9.570968, 0.07982987, -741.6898, 0.01314802, -0.9999136, 0.0001383743,
9.817696, 0.07982987, -765.4943, 0.01296438, -0.999916, 0.0001326895,
10.06442, 0.07982987, -789.9516, 0.01287431, -0.9999171, 0.0001299664,
2.909307, 0.08522799, -460.3904, -0.03286642, 0.9994595, 0.0008619254,
3.156036, 0.08522799, -450.9049, -0.03318557, 0.9994488, 0.001014286,
3.402764, 0.08522799, -443.6887, -0.03554334, 0.999367, 0.001512567,
3.649492, 0.08522799, -438.552, -0.08119119, 0.9966813, 0.005854142,
3.89622, 0.08522799, -435.3344, -0.08704181, 0.9960423, 0.01798728,
4.142948, 0.08522799, -433.8981, -0.9796101, -0.1190136, 0.1618639,
4.389677, 0.08522799, -434.1238, 0.01156124, -0.9999058, 0.007392605,
4.636405, 0.08522799, -435.9072, 0.01554139, -0.9998777, 0.001765108,
4.883132, 0.08522799, -439.1561, 0.01669141, -0.9998602, 0.001109007,
5.129861, 0.08522799, -443.7886, 0.01713837, -0.9998528, 0.0008261368,
5.376589, 0.08522799, -449.7315, 0.01725041, -0.9998511, 0.0006618132,
5.623317, 0.08522799, -456.9189, 0.01719479, -0.9998521, 0.000553165,
5.870045, 0.08522799, -465.2913, 0.01704931, -0.9998546, 0.0004756291,
6.116773, 0.08522799, -474.7944, 0.01685386, -0.999858, 0.0004173799,
6.363502, 0.08522799, -485.3788, 0.01663059, -0.9998617, 0.0003719582,
6.610229, 0.08522799, -496.9993, 0.01639254, -0.9998657, 0.0003355188,
6.856958, 0.08522799, -509.614, 0.01614769, -0.9998696, 0.0003056224,
7.103686, 0.08522799, -523.1847, 0.01590102, -0.9998736, 0.0002806433,
7.350414, 0.08522799, -537.6757, 0.01565561, -0.9998775, 0.0002594554,
7.597142, 0.08522799, -553.0539, 0.01541355, -0.9998812, 0.0002412537,
7.84387, 0.08522799, -569.2886, 0.01517616, -0.9998848, 0.0002254463,
8.090598, 0.08522799, -586.3511, 0.01494413, -0.9998884, 0.0002115888,
8.337327, 0.08522799, -604.2146, 0.01471802, -0.9998918, 0.0001993405,
8.584055, 0.08522799, -622.8539, 0.01449808, -0.999895, 0.0001884357,
8.830783, 0.08522799, -642.2453, 0.01428434, -0.999898, 0.0001786645,
9.077511, 0.08522799, -662.3668, 0.01407682, -0.999901, 0.0001698584,
9.324239, 0.08522799, -683.1971, 0.0138754, -0.9999037, 0.0001618811,
9.570968, 0.08522799, -704.7168, 0.01368004, -0.9999064, 0.0001546207,
9.817696, 0.08522799, -726.9069, 0.01349052, -0.999909, 0.0001479845,
10.06442, 0.08522799, -749.7498, 0.01339759, -0.9999103, 0.0001448119,
2.909307, 0.09062611, -468.1755, -0.03209225, 0.9994847, 0.000723801,
3.156036, 0.09062611, -457.1748, -0.03192701, 0.99949, 0.0008156221,
3.402764, 0.09062611, -448.4434, -0.03211552, 0.9994836, 0.001065454,
3.649492, 0.09062611, -441.7915, -0.03415856, 0.9994152, 0.0015763,
3.89622, 0.09062611, -437.0586, -0.06542395, 0.9978446, 0.005077059,
4.142948, 0.09062611, -434.1071, -0.06796914, 0.9975797, 0.01466025,
4.389677, 0.09062611, -432.8177, -0.9773642, -0.0909239, 0.1910292,
4.636405, 0.09062611, -433.0858, 0.01233514, -0.9998997, 0.006952934,
4.883132, 0.09062611, -434.8195, 0.01635944, -0.9998643, 0.001926618,
5.129861, 0.09062611, -437.9367, 0.01722991, -0.9998509, 0.001195695,
5.376589, 0.09062611, -442.3644, 0.01757808, -0.9998452, 0.0008871827,
5.623317, 0.09062611, -448.0367, 0.0176405, -0.9998443, 0.0007092215,
5.870045, 0.09062611, -454.8938, 0.01755709, -0.9998457, 0.0005919999,
6.116773, 0.09062611, -462.8817, 0.01739512, -0.9998487, 0.0005085473,
6.363502, 0.09062611, -471.9509, 0.01718963, -0.9998522, 0.0004459589,
6.610229, 0.09062611, -482.0561, 0.01696029, -0.9998561, 0.0003972156,
6.856958, 0.09062611, -493.1557, 0.01671864, -0.9998603, 0.0003581501,
7.103686, 0.09062611, -505.2112, 0.01647168, -0.9998643, 0.0003261241,
7.350414, 0.09062611, -518.1869, 0.01622383, -0.9998683, 0.000299383,
7.597142, 0.09062611, -532.0499, 0.01597791, -0.9998723, 0.000276713,
7.84387, 0.09062611, -546.7693, 0.01573576, -0.9998763, 0.0002572469,
8.090598, 0.09062611, -562.3167, 0.01549841, -0.9998799, 0.0002403481,
8.337327, 0.09062611, -578.6649, 0.0152666, -0.9998835, 0.0002255389,
8.584055, 0.09062611, -595.789, 0.01504077, -0.9998869, 0.0002124532,
8.830783, 0.09062611, -613.6652, 0.01482106, -0.9998901, 0.0002008062,
9.077511, 0.09062611, -632.2714, 0.01460754, -0.9998933, 0.0001903723,
9.324239, 0.09062611, -651.5866, 0.01440015, -0.9998963, 0.0001809711,
9.570968, 0.09062611, -671.5911, 0.01419887, -0.9998993, 0.0001724563,
9.817696, 0.09062611, -692.266, 0.01400352, -0.999902, 0.0001647079,
10.06442, 0.09062611, -713.5936, 0.01390775, -0.9999033, 0.0001610119,
2.909307, 0.09602423, -476.9947, -0.03184158, 0.9994928, 0.0006346626,
3.156036, 0.09602423, -464.5665, -0.0314744, 0.9995044, 0.0006978182,
3.402764, 0.09602423, -454.4075, -0.03099347, 0.9995192, 0.0008565079,
3.649492, 0.09602423, -446.3281, -0.03112755, 0.9995149, 0.00111539,
3.89622, 0.09602423, -440.1677, -0.03287223, 0.9994582, 0.001637746,
4.142948, 0.09602423, -435.7887, -0.05556506, 0.9984444, 0.004631756,
4.389677, 0.09602423, -433.0717, -0.05627217, 0.9983333, 0.01281051,
4.636405, 0.09602423, -431.9123, -0.9709981, -0.07372162, 0.2274372,
4.883132, 0.09602423, -432.2184, 0.01320791, -0.9998895, 0.006818702,
5.129861, 0.09602423, -433.9082, 0.01722731, -0.9998494, 0.002097878,
5.376589, 0.09602423, -436.9084, 0.01778057, -0.9998411, 0.001284907,
5.623317, 0.09602423, -441.1531, 0.01802015, -0.9998372, 0.0009494702,
5.870045, 0.09602423, -446.5827, 0.01802794, -0.9998373, 0.0007573829,
6.116773, 0.09602423, -453.1431, 0.01791327, -0.9998394, 0.0006313428,
6.363502, 0.09602423, -460.7848, 0.01773236, -0.9998427, 0.0005418319,
6.610229, 0.09602423, -469.4624, 0.01751508, -0.9998466, 0.0004748162,
6.856958, 0.09602423, -479.1345, 0.01727824, -0.9998507, 0.0004226915,
7.103686, 0.09602423, -489.7624, 0.01703179, -0.9998549, 0.0003809571,
7.350414, 0.09602423, -501.3106, 0.01678178, -0.9998592, 0.0003467706,
7.597142, 0.09602423, -513.7461, 0.01653206, -0.9998633, 0.0003182441,
7.84387, 0.09602423, -527.038, 0.01628508, -0.9998674, 0.0002940737,
8.090598, 0.09602423, -541.1578, 0.01604227, -0.9998714, 0.0002733288,
8.337327, 0.09602423, -556.0786, 0.01580463, -0.9998751, 0.000255327,
8.584055, 0.09602423, -571.7751, 0.01557278, -0.9998787, 0.0002395565,
8.830783, 0.09602423, -588.2238, 0.01534697, -0.9998823, 0.0002256259,
9.077511, 0.09602423, -605.4025, 0.01512732, -0.9998856, 0.00021323,
9.324239, 0.09602423, -623.2902, 0.01491386, -0.9998888, 0.0002021279,
9.570968, 0.09602423, -641.8671, 0.01470658, -0.9998918, 0.0001921267,
9.817696, 0.09602423, -661.1144, 0.01450536, -0.9998948, 0.0001830703,
10.06442, 0.09602423, -681.0146, 0.01440676, -0.9998963, 0.0001787608,
2.909307, 0.1014223, -486.7347, -0.0318547, 0.9994924, 0.0005721606,
3.156036, 0.1014223, -472.9571, -0.03138298, 0.9995073, 0.0006191117,
3.402764, 0.1014223, -461.4487, -0.03059925, 0.9995315, 0.0007318093,
3.649492, 0.1014223, -452.0198, -0.03013733, 0.9995454, 0.0008966583,
3.89622, 0.1014223, -444.51, -0.0302082, 0.999543, 0.001164141,
4.142948, 0.1014223, -438.7816, -0.03167045, 0.9994971, 0.001697026,
4.389677, 0.1014223, -434.7151, -0.04873248, 0.9988024, 0.004355338,
4.636405, 0.1014223, -432.2063, -0.04821124, 0.9987691, 0.01165826,
4.883132, 0.1014223, -431.1631, -0.959832, -0.06211196, 0.2736143,
5.129861, 0.1014223, -431.5034, 0.01416968, -0.999876, 0.006864647,
5.376589, 0.1014223, -433.1541, 0.01815088, -0.9998327, 0.002280026,
5.623317, 0.1014223, -436.0494, 0.01834447, -0.9998308, 0.001376766,
5.870045, 0.1014223, -440.1296, 0.0184658, -0.9998291, 0.001013043,
6.116773, 0.1014223, -445.3405, 0.01841387, -0.9998301, 0.0008063175,
6.363502, 0.1014223, -451.6328, 0.01826483, -0.999833, 0.0006712065,
6.610229, 0.1014223, -458.9611, 0.01806275, -0.9998367, 0.0005754927,
6.856958, 0.1014223, -467.2837, 0.01783188, -0.999841, 0.0005039573,
7.103686, 0.1014223, -476.5622, 0.01758617, -0.9998453, 0.0004483893,
7.350414, 0.1014223, -486.761, 0.01733381, -0.9998497, 0.0004039432,
7.597142, 0.1014223, -497.847, 0.0170799, -0.9998541, 0.0003675642,
7.84387, 0.1014223, -509.7895, 0.01682765, -0.9998584, 0.0003372282,
8.090598, 0.1014223, -522.5599, 0.01657893, -0.9998626, 0.0003115387,
8.337327, 0.1014223, -536.1312, 0.01633506, -0.9998666, 0.0002895004,
8.584055, 0.1014223, -550.4783, 0.01609684, -0.9998704, 0.0002703841,
8.830783, 0.1014223, -565.5776, 0.01586458, -0.9998741, 0.000253643,
9.077511, 0.1014223, -581.4069, 0.01563851, -0.9998777, 0.0002388592,
9.324239, 0.1014223, -597.9451, 0.01541873, -0.9998811, 0.0002257078,
9.570968, 0.1014223, -615.1725, 0.01520527, -0.9998844, 0.000213932,
9.817696, 0.1014223, -633.0705, 0.014998, -0.9998875, 0.0002033262,
10.06442, 0.1014223, -651.6213, 0.01489648, -0.999889, 0.0001982929,
2.909307, 0.1068205, -497.3001, -0.03201561, 0.9994872, 0.0005258295,
3.156036, 0.1068205, -482.243, -0.03148216, 0.9995043, 0.0005625835,
3.402764, 0.1068205, -469.4552, -0.03053358, 0.9995335, 0.000648194,
3.649492, 0.1068205, -458.7469, -0.02980184, 0.9995556, 0.0007653105,
3.89622, 0.1068205, -449.9576, -0.02934523, 0.999569, 0.0009360959,
4.142948, 0.1068205, -442.9497, -0.02934699, 0.9995686, 0.001211752,
4.389677, 0.1068205, -437.6039, -0.03054275, 0.999532, 0.001754283,
4.636405, 0.1068205, -433.8156, -0.0436473, 0.9990383, 0.00417496,
4.883132, 0.1068205, -431.4929, -0.04222779, 0.9990487, 0.01089563,
5.129861, 0.1068205, -430.5538, -0.9412521, -0.05366032, 0.3334144,
5.376589, 0.1068205, -430.9251, 0.01522084, -0.9998594, 0.007034805,
5.623317, 0.1068205, -432.541, 0.01913793, -0.9998138, 0.002474523,
5.870045, 0.1068205, -435.3417, 0.01892287, -0.9998199, 0.001471407,
6.116773, 0.1068205, -439.2733, 0.01891579, -0.9998206, 0.001077942,
6.363502, 0.1068205, -444.2861, 0.01879941, -0.9998229, 0.0008560438,
6.610229, 0.1068205, -450.3349, 0.01861291, -0.9998266, 0.0007115997,
6.856958, 0.1068205, -457.3781, 0.01838743, -0.9998308, 0.0006095336,
7.103686, 0.1068205, -465.3771, 0.01814139, -0.9998353, 0.0005333852,
7.350414, 0.1068205, -474.2965, 0.01788548, -0.99984, 0.0004743118,
7.597142, 0.1068205, -484.1031, 0.01762622, -0.9998447, 0.0004271094,
7.84387, 0.1068205, -494.7662, 0.01736763, -0.9998491, 0.0003885059,
8.090598, 0.1068205, -506.2571, 0.01711209, -0.9998536, 0.0003563364,
8.337327, 0.1068205, -518.549, 0.01686118, -0.9998578, 0.0003291094,
8.584055, 0.1068205, -531.6166, 0.01661585, -0.999862, 0.0003057629,
8.830783, 0.1068205, -545.4365, 0.01637653, -0.9998659, 0.0002855197,
9.077511, 0.1068205, -559.9863, 0.01614355, -0.9998697, 0.000267798,
9.324239, 0.1068205, -575.2451, 0.01591704, -0.9998733, 0.0002521533,
9.570968, 0.1068205, -591.1932, 0.015697, -0.9998769, 0.0002382398,
9.817696, 0.1068205, -607.8117, 0.01548335, -0.9998802, 0.0002257845,
10.06442, 0.1068205, -625.083, 0.01537879, -0.9998817, 0.0002198912,
2.909307, 0.1122186, -508.6093, -0.03226484, 0.9994793, 0.0004900796,
3.156036, 0.1122186, -492.336, -0.03169144, 0.9994977, 0.0005199328,
3.402764, 0.1122186, -478.3318, -0.03064208, 0.9995303, 0.0005879991,
3.649492, 0.1122186, -466.4071, -0.02976374, 0.9995568, 0.000676927,
3.89622, 0.1122186, -456.4015, -0.0290684, 0.9995771, 0.0007983343,
4.142948, 0.1122186, -448.1773, -0.02860674, 0.9995903, 0.0009748395,
4.389677, 0.1122186, -441.6151, -0.02853582, 0.999592, 0.001258262,
4.636405, 0.1122186, -436.6105, -0.0294802, 0.9995638, 0.001809623,
4.883132, 0.1122186, -433.0714, -0.0396577, 0.9992051, 0.004053008,
5.129861, 0.1122186, -430.916, -0.03755139, 0.9992408, 0.0103748,
5.376589, 0.1122186, -430.071, -0.9097114, -0.04695949, 0.4125772,
5.623317, 0.1122186, -430.4704, 0.01636896, -0.9998394, 0.007303543,
5.870045, 0.1122186, -432.0548, 0.02019704, -0.9997925, 0.002683054,
6.116773, 0.1122186, -434.77, 0.0195169, -0.9998083, 0.001568982,
6.363502, 0.1122186, -438.5665, 0.01937115, -0.9998117, 0.001144216,
6.610229, 0.1122186, -443.399, 0.01918544, -0.9998156, 0.0009065851,
6.856958, 0.1122186, -449.2258, 0.01895849, -0.99982, 0.0007525359,
7.103686, 0.1122186, -456.0085, 0.0187076, -0.9998248, 0.0006439632,
7.350414, 0.1122186, -463.7115, 0.01844475, -0.9998298, 0.0005631058,
7.597142, 0.1122186, -472.3018, 0.01817747, -0.9998347, 0.0005004626,
7.84387, 0.1122186, -481.7485, 0.01791037, -0.9998396, 0.0004504592,
8.090598, 0.1122186, -492.0231, 0.01764622, -0.9998443, 0.0004095981,
8.337327, 0.1122186, -503.0986, 0.01738681, -0.9998488, 0.0003755699,
8.584055, 0.1122186, -514.95, 0.01713317, -0.9998532, 0.0003467859,
8.830783, 0.1122186, -527.5535, 0.0168858, -0.9998574, 0.000322116,
9.077511, 0.1122186, -540.8869, 0.01664511, -0.9998614, 0.0003007344,
9.324239, 0.1122186, -554.9294, 0.01641116, -0.9998653, 0.0002820227,
9.570968, 0.1122186, -569.6611, 0.01618397, -0.9998691, 0.0002655088,
9.817696, 0.1122186, -585.0632, 0.01596346, -0.9998726, 0.0002508263,
10.06442, 0.1122186, -601.1182, 0.01585566, -0.9998743, 0.0002439027,
2.909307, 0.1176167, -520.5926, -0.03256882, 0.9994695, 0.0004616408,
3.156036, 0.1176167, -503.16, -0.0319677, 0.9994889, 0.0004865693,
3.402764, 0.1176167, -487.9966, -0.03085141, 0.9995239, 0.0005425034,
3.649492, 0.1176167, -474.9128, -0.02988372, 0.9995533, 0.0006131505,
3.89622, 0.1176167, -463.748, -0.02905907, 0.9995775, 0.0007053154,
4.142948, 0.1176167, -454.3646, -0.02838822, 0.9995967, 0.0008308898,
4.389677, 0.1176167, -446.6432, -0.02791398, 0.9996098, 0.001012909,
4.636405, 0.1176167, -440.4794, -0.02776834, 0.9996136, 0.001303719,
4.883132, 0.1176167, -435.7812, -0.02847561, 0.9995928, 0.001863166,
5.129861, 0.1176167, -432.4665, -0.03640631, 0.9993293, 0.003969145,
5.376589, 0.1176167, -430.4623, -0.03375597, 0.9993799, 0.01001781,
5.623317, 0.1176167, -429.7026, -0.8537433, -0.04087403, 0.5190873,
5.870045, 0.1176167, -430.1278, 0.01762461, -0.9998154, 0.00765938,
6.116773, 0.1176167, -431.6838, 0.02133911, -0.9997681, 0.002907709,
6.363502, 0.1176167, -434.3211, 0.02012778, -0.9997961, 0.001669634,
6.610229, 0.1176167, -437.9944, 0.01983256, -0.9998026, 0.001211911,
6.856958, 0.1176167, -442.662, 0.01957266, -0.9998081, 0.0009579602,
7.103686, 0.1176167, -448.2855, 0.01930244, -0.9998134, 0.0007940245,
7.350414, 0.1176167, -454.8293, 0.01902408, -0.9998188, 0.000678788,
7.597142, 0.1176167, -462.2604, 0.01874297, -0.9998242, 0.000593123,
7.84387, 0.1176167, -470.548, 0.01846317, -0.9998294, 0.0005268441,
8.090598, 0.1176167, -479.6634, 0.01818724, -0.9998346, 0.0004739938,
8.337327, 0.1176167, -489.5797, 0.01791686, -0.9998394, 0.0004308418,
8.584055, 0.1176167, -500.2719, 0.01765296, -0.9998441, 0.0003949301,
8.830783, 0.1176167, -511.7162, 0.01739601, -0.9998487, 0.0003645702,
9.077511, 0.1176167, -523.8904, 0.01714632, -0.999853, 0.0003385622,
9.324239, 0.1176167, -536.7737, 0.01690385, -0.9998571, 0.0003160296,
9.570968, 0.1176167, -550.3462, 0.01666863, -0.9998611, 0.0002963176,
9.817696, 0.1176167, -564.5892, 0.01644055, -0.9998649, 0.0002789265,
10.06442, 0.1176167, -579.485, 0.01632917, -0.9998667, 0.0002707567,
2.909307, 0.1230148, -533.1893, -0.03290743, 0.9994583, 0.0004384704,
3.156036, 0.1230148, -514.6496, -0.03228593, 0.9994786, 0.0004597388,
3.402764, 0.1230148, -498.379, -0.03112227, 0.9995155, 0.0005068688,
3.649492, 0.1230148, -484.188, -0.03009545, 0.9995469, 0.0005648672,
3.89622, 0.1230148, -471.9161, -0.02919234, 0.9995737, 0.0006380415,
4.142948, 0.1230148, -461.4255, -0.02840864, 0.9995961, 0.0007333657,
4.389677, 0.1230148, -452.597, -0.02775315, 0.9996145, 0.0008629868,
4.636405, 0.1230148, -445.326, -0.0272605, 0.9996278, 0.00105032,
4.883132, 0.1230148, -439.5206, -0.02703914, 0.9996336, 0.001348154,
5.129861, 0.1230148, -435.0988, -0.02752276, 0.9996194, 0.001914994,
5.376589, 0.1230148, -431.9874, -0.03367636, 0.9994252, 0.003910942,
5.623317, 0.1230148, -430.1205, -0.0305871, 0.9994842, 0.009779655,
5.870045, 0.1230148, -429.4386, -0.7498045, -0.03405491, 0.6607825,
6.116773, 0.1230148, -429.8874, 0.01900242, -0.9997867, 0.008100312,
6.363502, 0.1230148, -431.4175, 0.02257804, -0.9997401, 0.003151136,
6.610229, 0.1230148, -433.9837, 0.0207565, -0.999783, 0.001773517,
6.856958, 0.1230148, -437.5441, 0.02030051, -0.9997932, 0.001281064,
7.103686, 0.1230148, -442.0605, 0.01996182, -0.9998003, 0.00101019,
7.350414, 0.1230148, -447.4972, 0.01964537, -0.9998067, 0.0008360768,
7.597142, 0.1230148, -453.821, 0.01933759, -0.9998127, 0.0007140119,
7.84387, 0.1230148, -461.0015, 0.01903686, -0.9998186, 0.0006234398,
8.090598, 0.1230148, -469.0097, 0.01874339, -0.9998242, 0.0005534593,
8.337327, 0.1230148, -477.8188, 0.01845783, -0.9998296, 0.0004977151,
8.584055, 0.1230148, -487.4038, 0.01818051, -0.9998347, 0.0004522386,
8.830783, 0.1230148, -497.741, 0.0179115, -0.9998396, 0.0004144183,
9.077511, 0.1230148, -508.8081, 0.01765079, -0.9998443, 0.0003824625,
9.324239, 0.1230148, -520.5842, 0.01739824, -0.9998486, 0.0003551002,
9.570968, 0.1230148, -533.0496, 0.01715373, -0.9998529, 0.0003314046,
9.817696, 0.1230148, -546.1854, 0.016917, -0.9998569, 0.0003106825,
10.06442, 0.1230148, -559.974, 0.01680165, -0.9998588, 0.0003009902,
2.909307, 0.1284129, -546.3468, -0.03326781, 0.9994464, 0.0004192234,
3.156036, 0.1284129, -526.7474, -0.03263068, 0.9994674, 0.0004376838,
3.402764, 0.1284129, -509.4173, -0.0314318, 0.9995058, 0.0004781836,
3.649492, 0.1284129, -494.1667, -0.03036336, 0.9995388, 0.0005270031,
3.89622, 0.1284129, -480.8351, -0.02940853, 0.9995673, 0.0005870289,
4.142948, 0.1284129, -469.285, -0.02855671, 0.9995919, 0.0006626777,
4.389677, 0.1284129, -459.3968, -0.02780409, 0.9996132, 0.0007610857,
4.636405, 0.1284129, -451.0663, -0.02715672, 0.9996309, 0.000894638,
4.883132, 0.1284129, -444.2012, -0.0266413, 0.9996445, 0.001087095,
5.129861, 0.1284129, -438.7198, -0.02634401, 0.999652, 0.001391609,
5.376589, 0.1284129, -434.5488, -0.02661692, 0.9996439, 0.001965215,
5.623317, 0.1284129, -431.6224, -0.03133264, 0.9995015, 0.003870917,
5.870045, 0.1284129, -429.8808, -0.02788297, 0.9995648, 0.009634354,
6.116773, 0.1284129, -429.27, -0.5555333, -0.02451123, 0.8311328,
6.363502, 0.1284129, -429.7405, 0.02052295, -0.9997521, 0.008630321,
6.610229, 0.1284129, -431.247, 0.02393088, -0.9997078, 0.003416613,
6.856958, 0.1284129, -433.7479, 0.02140461, -0.9997692, 0.001880842,
7.103686, 0.1284129, -437.2047, 0.02077595, -0.9997832, 0.001351741,
7.350414, 0.1284129, -441.5817, 0.02035329, -0.9997923, 0.001063294,
7.597142, 0.1284129, -446.846, 0.01998797, -0.9997999, 0.0008787059,
7.84387, 0.1284129, -452.9668, 0.01964902, -0.9998067, 0.0007496474,
8.090598, 0.1284129, -459.9154, 0.01932712, -0.999813, 0.000654063,
8.337327, 0.1284129, -467.665, 0.019019, -0.9998189, 0.0005803119,
8.584055, 0.1284129, -476.1904, 0.018723, -0.9998246, 0.0005216266,
8.830783, 0.1284129, -485.4679, 0.01843797, -0.9998299, 0.0004737908,
9.077511, 0.1284129, -495.4754, 0.01816327, -0.999835, 0.0004340358,
9.324239, 0.1284129, -506.1919, 0.01789831, -0.9998397, 0.0004004642,
9.570968, 0.1284129, -517.5977, 0.01764262, -0.9998444, 0.0003717325,
9.817696, 0.1284129, -529.6739, 0.01739575, -0.9998487, 0.0003468612,
10.06442, 0.1284129, -542.4029, 0.0172758, -0.9998507, 0.0003352865,
2.909307, 0.1338111, -560.0189, -0.03364164, 0.9994339, 0.0004029789,
3.156036, 0.1338111, -539.4036, -0.03299213, 0.9994556, 0.0004192284,
3.402764, 0.1338111, -521.0574, -0.03176595, 0.9994953, 0.0004545863,
3.649492, 0.1338111, -504.7909, -0.03066658, 0.9995296, 0.0004964939,
3.89622, 0.1338111, -490.4433, -0.02967541, 0.9995595, 0.0005469747,
4.142948, 0.1338111, -477.8772, -0.02877896, 0.9995857, 0.0006089906,
4.389677, 0.1338111, -466.9731, -0.02796812, 0.9996086, 0.0006870633,
4.636405, 0.1338111, -457.6265, -0.02723862, 0.9996287, 0.0007884811,
4.883132, 0.1338111, -449.7455, -0.02659358, 0.9996459, 0.0009258504,
5.129861, 0.1338111, -443.2482, -0.02605208, 0.99966, 0.001123247,
5.376589, 0.1338111, -438.0612, -0.02567942, 0.9996692, 0.001434115,
5.623317, 0.1338111, -434.1188, -0.02575388, 0.9996663, 0.002013912,
5.870045, 0.1338111, -431.3612, -0.02928331, 0.9995638, 0.003843967,
6.116773, 0.1338111, -429.7345, -0.02553373, 0.9996281, 0.009566114,
6.363502, 0.1338111, -429.189, -0.2334967, -0.01043484, 0.9723016,
6.610229, 0.1338111, -429.6796, 0.02221267, -0.9997104, 0.00925927,
6.856958, 0.1338111, -431.1645, 0.02542051, -0.99967, 0.003708425,
7.103686, 0.1338111, -433.6053, 0.02207305, -0.9997544, 0.001991774,
7.350414, 0.1338111, -436.9663, 0.02125935, -0.9997731, 0.001423994,
7.597142, 0.1338111, -441.2147, 0.02074794, -0.9997841, 0.001117307,
7.84387, 0.1338111, -446.3195, 0.02033081, -0.9997929, 0.0009219242,
8.090598, 0.1338111, -452.2521, 0.01995868, -0.9998005, 0.0007856977,
8.337327, 0.1338111, -458.9857, 0.01961452, -0.9998074, 0.0006849972,
8.584055, 0.1338111, -466.4951, 0.01929075, -0.9998138, 0.0006074058,
8.830783, 0.1338111, -474.7567, 0.01898335, -0.9998196, 0.0005457305,
9.077511, 0.1338111, -483.7483, 0.01869, -0.9998252, 0.0004955006,
9.324239, 0.1338111, -493.4488, 0.01840909, -0.9998305, 0.0004537845,
9.570968, 0.1338111, -503.8386, 0.01813949, -0.9998354, 0.0004185773,
9.817696, 0.1338111, -514.8988, 0.01788029, -0.9998401, 0.0003884603,
10.06442, 0.1338111, -526.6119, 0.01775484, -0.9998423, 0.0003745258,
2.909307, 0.1392092, -574.1648, -0.03402332, 0.999421, 0.0003890833,
3.156036, 0.1392092, -552.5737, -0.0333636, 0.9994432, 0.0004035543,
3.402764, 0.1392092, -533.2518, -0.03211542, 0.9994841, 0.0004348261,
3.649492, 0.1392092, -516.0094, -0.03099206, 0.9995195, 0.000471374,
3.89622, 0.1392092, -500.6861, -0.0299741, 0.9995506, 0.0005146682,
4.142948, 0.1392092, -487.1442, -0.02904646, 0.9995779, 0.0005667841,
4.389677, 0.1392092, -475.2643, -0.02819769, 0.9996022, 0.0006307535,
4.636405, 0.1392092, -464.942, -0.02741943, 0.9996238, 0.0007111994,
4.883132, 0.1392092, -456.0852, -0.0267066, 0.999643, 0.0008155535,
5.129861, 0.1392092, -448.612, -0.02605954, 0.99966, 0.0009566316,
5.376589, 0.1392092, -442.4493, -0.02548951, 0.9996745, 0.001158792,
5.623317, 0.1392092, -437.5311, -0.02504232, 0.9996853, 0.001475701,
5.870045, 0.1392092, -433.7978, -0.02492923, 0.9996872, 0.002061136,
6.116773, 0.1392092, -431.1952, -0.02746486, 0.9996155, 0.003826541,
6.363502, 0.1392092, -429.674, -0.02346465, 0.9996789, 0.009566952,
6.610229, 0.1392092, -429.1888, 0.1529871, 0.006033534, 0.9882098,
6.856958, 0.1392092, -429.6979, 0.02410645, -0.9996594, 0.01000389,
7.103686, 0.1392092, -431.1629, 0.02707644, -0.9996252, 0.004032254,
7.350414, 0.1392092, -433.5482, 0.02276359, -0.9997387, 0.002106536,
7.597142, 0.1392092, -436.8207, 0.02175111, -0.9997624, 0.001497865,
7.84387, 0.1392092, -440.9498, 0.02114585, -0.9997758, 0.001172235,
8.090598, 0.1392092, -445.9066, 0.0206743, -0.9997858, 0.0009657423,
8.337327, 0.1392092, -451.6644, 0.02026733, -0.9997943, 0.0008221725,
8.584055, 0.1392092, -458.1981, 0.01989951, -0.9998018, 0.0007162456,
8.830783, 0.1392092, -465.4839, 0.019559, -0.9998085, 0.0006347423,
9.077511, 0.1392092, -473.4996, 0.0192395, -0.9998147, 0.0005700279,
9.324239, 0.1392092, -482.2244, 0.01893719, -0.9998206, 0.0005173679,
9.570968, 0.1392092, -491.6384, 0.01864959, -0.999826, 0.0004736641,
9.817696, 0.1392092, -501.7228, 0.01837491, -0.9998311, 0.0004368006,
10.06442, 0.1392092, -512.4601, 0.01824265, -0.9998335, 0.0004198614,
2.909307, 0.1446073, -588.7485, -0.03440886, 0.9994078, 0.0003770603,
3.156036, 0.1446073, -566.2187, -0.03374053, 0.9994306, 0.0003900742,
3.402764, 0.1446073, -545.9581, -0.03247415, 0.9994725, 0.0004180343,
3.649492, 0.1446073, -527.7772, -0.03133165, 0.999509, 0.0004503267,
3.89622, 0.1446073, -511.5152, -0.030293, 0.9995409, 0.0004880502,
4.142948, 0.1446073, -497.0346, -0.02934239, 0.9995694, 0.0005327112,
4.389677, 0.1446073, -484.216, -0.02846731, 0.9995946, 0.0005864348,
4.636405, 0.1446073, -472.9551, -0.0276576, 0.9996173, 0.0006523225,
4.883132, 0.1446073, -463.1596, -0.02690512, 0.9996378, 0.0007350933,
5.129861, 0.1446073, -454.7478, -0.02620396, 0.9996563, 0.0008423146,
5.376589, 0.1446073, -447.6465, -0.02555117, 0.9996731, 0.0009869935,
5.623317, 0.1446073, -441.7896, -0.02495066, 0.999688, 0.001193744,
5.870045, 0.1446073, -437.1176, -0.02443018, 0.9997004, 0.001516399,
6.116773, 0.1446073, -433.5764, -0.02414046, 0.9997064, 0.002106993,
6.363502, 0.1446073, -431.1165, -0.02583348, 0.999659, 0.003816444,
6.610229, 0.1446073, -429.6926, -0.02162038, 0.9997199, 0.009635058,
6.856958, 0.1446073, -429.2631, 0.4616211, 0.01963062, 0.88686,
7.103686, 0.1446073, -429.7894, 0.02625278, -0.9995961, 0.01088869,
7.350414, 0.1446073, -431.2361, 0.02893877, -0.9995715, 0.004395674,
7.597142, 0.1446073, -433.57, 0.02347731, -0.9997219, 0.002225363,
7.84387, 0.1446073, -436.7604, 0.02225212, -0.9997512, 0.001573432,
8.090598, 0.1446073, -440.7786, 0.02154782, -0.9997671, 0.001228119,
8.337327, 0.1446073, -445.5977, 0.02101899, -0.9997786, 0.001010177,
8.584055, 0.1446073, -451.1927, 0.02057537, -0.999788, 0.0008590793,
8.830783, 0.1446073, -457.5399, 0.02018259, -0.9997961, 0.0007478156,
9.077511, 0.1446073, -464.617, 0.01982439, -0.9998032, 0.0006623271,
9.324239, 0.1446073, -472.4031, 0.01949201, -0.9998099, 0.0005945225,
9.570968, 0.1446073, -480.8784, 0.01918018, -0.9998159, 0.0005393958,
9.817696, 0.1446073, -490.0242, 0.01888539, -0.9998215, 0.0004936772,
10.06442, 0.1446073, -499.8228, 0.01874448, -0.9998242, 0.0004728414,
2.909307, 0.1500054, -603.7379, -0.03479549, 0.9993944, 0.0003665541,
3.156036, 0.1500054, -580.3038, -0.03411977, 0.9994177, 0.0003783563,
3.402764, 0.1500054, -559.139, -0.03283802, 0.9994607, 0.0004035867,
3.649492, 0.1500054, -540.0538, -0.03167971, 0.9994981, 0.0004324317,
3.89622, 0.1500054, -522.8876, -0.03062447, 0.9995309, 0.0004657324,
4.142948, 0.1500054, -507.5027, -0.02965618, 0.9995601, 0.0005046148,
4.389677, 0.1500054, -493.7799, -0.02876186, 0.9995862, 0.0005506228,
4.636405, 0.1500054, -481.6147, -0.02793053, 0.9996098, 0.0006059291,
4.883132, 0.1500054, -470.915, -0.02715282, 0.9996311, 0.0006737006,
5.129861, 0.1500054, -461.599, -0.02642072, 0.9996507, 0.0007587484,
5.376589, 0.1500054, -453.5933, -0.02572696, 0.9996687, 0.0008687677,
5.623317, 0.1500054, -446.8322, -0.02506549, 0.9996853, 0.001016946,
5.870045, 0.1500054, -441.256, -0.0244334, 0.9997007, 0.001228126,
6.116773, 0.1500054, -436.8105, -0.02384106, 0.9997146, 0.00155625,
6.363502, 0.1500054, -433.4464, -0.02338434, 0.9997243, 0.002151532,
6.610229, 0.1500054, -431.1183, -0.02435505, 0.9996961, 0.003811901,
6.856958, 0.1500054, -429.7845, -0.01996024, 0.9997531, 0.009773142,
7.103686, 0.1500054, -429.4066, 0.6519807, 0.02907502, 0.757678,
7.350414, 0.1500054, -429.949, 0.02871723, -0.9995162, 0.0119492,
7.597142, 0.1500054, -431.3786, 0.03106259, -0.9995059, 0.004809166,
7.84387, 0.1500054, -433.6648, 0.02421637, -0.999704, 0.002348518,
8.090598, 0.1500054, -436.7787, 0.02276289, -0.9997395, 0.001650754,
8.337327, 0.1500054, -440.6936, 0.02195409, -0.9997582, 0.00128498,
8.584055, 0.1500054, -445.3844, 0.02136518, -0.9997712, 0.001055237,
8.830783, 0.1500054, -450.8273, 0.02088309, -0.9997816, 0.0008964232,
9.077511, 0.1500054, -457.0001, 0.02046409, -0.9997904, 0.000779709,
9.324239, 0.1500054, -463.882, 0.02008733, -0.9997981, 0.0006901623,
9.570968, 0.1500054, -471.453, 0.01974145, -0.999805, 0.0006192168,
9.817696, 0.1500054, -479.6946, 0.0194195, -0.9998114, 0.0005615866,
10.06442, 0.1500054, -488.589, 0.01926717, -0.9998143, 0.0005355844,
2.909307, 0.1554035, -619.1042, -0.03518141, 0.9993809, 0.000357295,
3.156036, 0.1554035, -594.798, -0.03449922, 0.9994047, 0.0003680761,
3.402764, 0.1554035, -572.7609, -0.0332041, 0.9994486, 0.0003910231,
3.649492, 0.1554035, -552.8033, -0.03203232, 0.9994868, 0.000417027,
3.89622, 0.1554035, -534.7648, -0.03096338, 0.9995204, 0.0004467461,
4.142948, 0.1554035, -518.5078, -0.02998104, 0.9995504, 0.0004810429,
4.389677, 0.1554035, -503.9126, -0.02907198, 0.9995772, 0.0005210699,
4.636405, 0.1554035, -490.8752, -0.02822489, 0.9996015, 0.0005684049,
4.883132, 0.1554035, -479.3032, -0.02743004, 0.9996236, 0.0006252676,
5.129861, 0.1554035, -469.1149, -0.02667868, 0.9996439, 0.0006948888,
5.376589, 0.1554035, -460.2369, -0.02596234, 0.9996627, 0.0007821658,
5.623317, 0.1554035, -452.6035, -0.02527259, 0.9996802, 0.0008949174,
5.870045, 0.1554035, -446.1551, -0.02460025, 0.9996969, 0.001046497,
6.116773, 0.1554035, -440.8373, -0.02393543, 0.9997127, 0.001261945,
6.363502, 0.1554035, -436.6009, -0.02327285, 0.9997279, 0.001595268,
6.610229, 0.1554035, -433.4005, -0.02265866, 0.9997409, 0.002194821,
6.856958, 0.1554035, -431.1944, -0.02300363, 0.9997282, 0.003811554,
7.103686, 0.1554035, -429.9443, -0.0184532, 0.9997798, 0.009989769,
7.350414, 0.1554035, -429.6144, 0.7617332, 0.03611936, 0.6468832,
7.597142, 0.1554035, -430.1718, 0.03159419, -0.9994132, 0.01323892,
7.84387, 0.1554035, -431.5856, 0.03352831, -0.9994237, 0.005287892,
8.090598, 0.1554035, -433.8273, 0.02498188, -0.9996849, 0.002476228,
8.337327, 0.1554035, -436.8699, 0.02328367, -0.9997275, 0.001729879,
8.584055, 0.1554035, -440.6884, 0.02236504, -0.9997491, 0.001342838,
8.830783, 0.1554035, -445.259, 0.02171319, -0.9997637, 0.001100939,
9.077511, 0.1554035, -450.5596, 0.02119089, -0.9997751, 0.0009342153,
9.324239, 0.1554035, -456.5692, 0.02074454, -0.9997845, 0.0008119341,
9.570968, 0.1554035, -463.2679, 0.02034833, -0.9997927, 0.0007182522,
9.817696, 0.1554035, -470.6372, 0.01998814, -0.9998001, 0.0006441122,
10.06442, 0.1554035, -478.6593, 0.01982014, -0.9998034, 0.0006110773,
2.909307, 0.1608016, -634.8219, -0.03556522, 0.9993674, 0.000349073,
3.156036, 0.1608016, -609.6731, -0.03487721, 0.9993916, 0.0003589832,
3.402764, 0.1608016, -586.7935, -0.03357029, 0.9994364, 0.0003799964,
3.649492, 0.1608016, -565.9935, -0.03238689, 0.9994753, 0.0004036262,
3.89622, 0.1608016, -547.1125, -0.0313064, 0.9995098, 0.0004303963,
4.142948, 0.1608016, -530.0129, -0.03031241, 0.9995403, 0.0004609802,
4.389677, 0.1608016, -514.5753, -0.02939155, 0.9995679, 0.0004962604,
4.636405, 0.1608016, -500.6954, -0.02853245, 0.9995928, 0.0005374158,
4.883132, 0.1608016, -488.2809, -0.02772526, 0.9996155, 0.0005860581,
5.129861, 0.1608016, -477.2501, -0.02696107, 0.9996363, 0.0006444526,
5.376589, 0.1608016, -467.5297, -0.02623128, 0.9996557, 0.0007158906,
5.623317, 0.1608016, -459.0538, -0.02552702, 0.9996739, 0.0008053518,
5.870045, 0.1608016, -451.7628, -0.0248384, 0.9996911, 0.000920769,
6.116773, 0.1608016, -445.6026, -0.02415312, 0.9997078, 0.001075651,
6.363502, 0.1608016, -440.5237, -0.02345517, 0.9997241, 0.001295219,
6.610229, 0.1608016, -436.4808, -0.02272409, 0.9997405, 0.001633487,
6.856958, 0.1608016, -433.4323, -0.02196073, 0.9997563, 0.002236904,
7.103686, 0.1608016, -431.3396, -0.02176128, 0.9997559, 0.00381461,
7.350414, 0.1608016, -430.1672, -0.0170745, 0.9998012, 0.01030173,
7.597142, 0.1608016, -429.8821, 0.8268293, 0.04248445, 0.5608461,
7.84387, 0.1608016, -430.4535, 0.03502256, -0.9992763, 0.01483798,
8.090598, 0.1608016, -431.8527, 0.03645421, -0.9993182, 0.005854231,
8.337327, 0.1608016, -434.0528, 0.02577614, -0.9996644, 0.002608856,
8.584055, 0.1608016, -437.0287, 0.02381548, -0.9997149, 0.001810897,
8.830783, 0.1608016, -440.7569, 0.02278109, -0.9997395, 0.001401729,
9.077511, 0.1608016, -445.215, 0.02206341, -0.999756, 0.001147297,
9.324239, 0.1608016, -450.3821, 0.02149918, -0.9997684, 0.000972463,
9.570968, 0.1608016, -456.2384, 0.02102419, -0.9997786, 0.000844493,
9.817696, 0.1608016, -462.7652, 0.02060766, -0.9997874, 0.0007465989,
10.06442, 0.1608016, -469.9447, 0.02041723, -0.9997913, 0.0007036753,
2.909307, 0.1661998, -650.8676, -0.0359458, 0.9993537, 0.0003417218,
3.156036, 0.1661998, -624.9041, -0.03525259, 0.9993784, 0.0003508824,
3.402764, 0.1661998, -601.2099, -0.03393517, 0.999424, 0.0003702406,
3.649492, 0.1661998, -579.5952, -0.03274155, 0.9994639, 0.0003918612,
3.89622, 0.1661998, -559.8995, -0.03165101, 0.9994989, 0.0004161674,
4.142948, 0.1661998, -541.9853, -0.03064715, 0.9995303, 0.000443695,
4.389677, 0.1661998, -525.733, -0.02971662, 0.9995583, 0.0004751339,
4.636405, 0.1661998, -511.0384, -0.02884799, 0.9995838, 0.0005113861,
4.883132, 0.1661998, -497.8093, -0.0280314, 0.9996069, 0.000553655,
5.129861, 0.1661998, -485.9638, -0.02725809, 0.9996282, 0.0006035852,
5.376589, 0.1661998, -475.4287, -0.02651962, 0.9996481, 0.0006634863,
5.623317, 0.1661998, -466.1381, -0.02580741, 0.9996668, 0.0007367073,
5.870045, 0.1661998, -458.0325, -0.02511211, 0.9996843, 0.000828308,
6.116773, 0.1661998, -451.0576, -0.02442224, 0.9997013, 0.0009463287,
6.363502, 0.1661998, -445.164, -0.02372265, 0.999718, 0.001104419,
6.610229, 0.1661998, -440.3065, -0.02299102, 0.9997349, 0.001327957,
6.856958, 0.1661998, -436.4432, -0.02219316, 0.9997523, 0.001670929,
7.103686, 0.1661998, -433.5359, -0.02128926, 0.9997708, 0.002277848,
7.350414, 0.1661998, -431.5489, -0.02061121, 0.9997804, 0.003820247,
7.597142, 0.1661998, -430.4491, -0.01580547, 0.9998174, 0.01073598,
7.84387, 0.1661998, -430.2058, 0.867516, 0.04937171, 0.494953,
8.090598, 0.1661998, -430.7903, 0.03921976, -0.9990881, 0.01687439,
8.337327, 0.1661998, -432.1758, 0.04002709, -0.9991772, 0.00654348,
8.584055, 0.1661998, -434.3371, 0.02660119, -0.9996424, 0.002746687,
8.830783, 0.1661998, -437.2505, 0.02435852, -0.9997015, 0.001893872,
9.077511, 0.1661998, -440.894, 0.02320259, -0.9997298, 0.00146168,
9.324239, 0.1661998, -445.2464, 0.02241614, -0.9997481, 0.001194327,
9.570968, 0.1661998, -450.288, 0.02180821, -0.9997618, 0.001011176,
9.817696, 0.1661998, -456.0002, 0.02130351, -0.9997727, 0.0008773954,
10.06442, 0.1661998, -462.3651, 0.02107928, -0.9997776, 0.0008199819,
2.909307, 0.1715979, -667.2203, -0.03632262, 0.9993401, 0.0003351112,
3.156036, 0.1715979, -640.4683, -0.03562467, 0.9993653, 0.0003436203,
3.402764, 0.1715979, -615.9854, -0.0342977, 0.9994116, 0.0003615477,
3.649492, 0.1715979, -593.5821, -0.03309486, 0.9994522, 0.0003814487,
3.89622, 0.1715979, -573.0978, -0.03199545, 0.9994879, 0.0004036703,
4.142948, 0.1715979, -554.3949, -0.03098308, 0.9995198, 0.0004286463,
4.389677, 0.1715979, -537.354, -0.03004435, 0.9995486, 0.0004569243,
4.636405, 0.1715979, -521.8707, -0.02916783, 0.9995745, 0.0004892084,
4.883132, 0.1715979, -507.853, -0.02834382, 0.9995981, 0.0005264202,
5.129861, 0.1715979, -495.2189, -0.02756373, 0.99962, 0.0005697882,
5.376589, 0.1715979, -483.8952, -0.02681928, 0.9996402, 0.0006209884,
5.623317, 0.1715979, -473.816, -0.02610243, 0.9996591, 0.0006823721,
5.870045, 0.1715979, -464.9217, -0.02540455, 0.999677, 0.0007573453,
6.116773, 0.1715979, -457.1582, -0.02471543, 0.9996942, 0.0008510415,
6.363502, 0.1715979, -450.476, -0.02402234, 0.999711, 0.0009716022,
6.610229, 0.1715979, -444.8298, -0.02330717, 0.9997278, 0.00113281,
6.856958, 0.1715979, -440.178, -0.02254183, 0.9997451, 0.00136018,
7.103686, 0.1715979, -436.482, -0.0216792, 0.9997636, 0.001707625,
7.350414, 0.1715979, -433.7064, -0.02064209, 0.9997844, 0.002317701,
7.597142, 0.1715979, -431.8179, -0.01954114, 0.9998018, 0.003827825,
7.84387, 0.1715979, -430.786, -0.01462961, 0.9998287, 0.01133946,
8.090598, 0.1715979, -430.5819, 0.8942016, 0.0578278, 0.4439136,
8.337327, 0.1715979, -431.1787, 0.04454366, -0.9988158, 0.01956482,
8.584055, 0.1715979, -432.5514, 0.04456029, -0.9989792, 0.007414429,
8.830783, 0.1715979, -434.6762, 0.02745909, -0.9996188, 0.002890114,
9.077511, 0.1715979, -437.531, 0.02491376, -0.9996877, 0.001978884,
9.324239, 0.1715979, -441.0948, 0.02362981, -0.9997196, 0.001522723,
9.570968, 0.1715979, -445.3478, 0.02277175, -0.9997399, 0.001242044,
9.817696, 0.1715979, -450.2714, 0.02211833, -0.9997548, 0.001050363,
10.06442, 0.1715979, -455.8476, 0.02183994, -0.9997611, 0.0009705469,
2.909307, 0.176996, -683.8611, -0.03669502, 0.9993265, 0.0003291333,
3.156036, 0.176996, -656.3448, -0.03599265, 0.9993521, 0.0003370712,
3.402764, 0.176996, -631.0978, -0.03465694, 0.9993992, 0.0003537507,
3.649492, 0.176996, -607.9303, -0.03344576, 0.9994405, 0.0003721664,
3.89622, 0.176996, -586.6818, -0.03233844, 0.9994769, 0.0003926058,
4.142948, 0.176996, -567.2147, -0.03131853, 0.9995095, 0.0004154238,
4.389677, 0.176996, -549.4096, -0.03037259, 0.9995385, 0.0004410624,
4.636405, 0.176996, -533.1622, -0.02948938, 0.9995651, 0.0004700816,
4.883132, 0.176996, -518.3802, -0.02865935, 0.9995891, 0.0005032019,
5.129861, 0.176996, -504.9819, -0.0278739, 0.9996113, 0.0005413627,
5.376589, 0.176996, -492.894, -0.02712507, 0.9996319, 0.0005858149,
5.623317, 0.176996, -482.0506, -0.0264053, 0.9996512, 0.0006382662,
5.870045, 0.176996, -472.3922, -0.0257066, 0.9996693, 0.0007011082,
6.116773, 0.176996, -463.8644, -0.02502003, 0.9996867, 0.0007777998,
6.363502, 0.176996, -456.4181, -0.02433501, 0.9997036, 0.0008735486,
6.610229, 0.176996, -450.0077, -0.02363715, 0.9997201, 0.0009965918,
6.856958, 0.176996, -444.5916, -0.02290547, 0.999737, 0.001160831,
7.103686, 0.176996, -440.1314, -0.02210639, 0.9997547, 0.001391894,
7.350414, 0.176996, -436.5916, -0.02118074, 0.9997742, 0.001743592,
7.597142, 0.176996, -433.939, -0.02001763, 0.9997969, 0.002356511,
7.84387, 0.176996, -432.1429, -0.01854133, 0.9998208, 0.003837064,
8.090598, 0.176996, -431.1746, -0.01353489, 0.999834, 0.01219509,
8.337327, 0.176996, -431.0072, 0.9122924, 0.06917952, 0.4036544,
8.584055, 0.176996, -431.6157, 0.0516334, -0.9983943, 0.02329677,
8.830783, 0.176996, -432.9763, 0.05059454, -0.9986826, 0.008569409,
9.077511, 0.176996, -435.0669, 0.02835298, -0.9995934, 0.003039563,
9.324239, 0.176996, -437.8665, 0.02548139, -0.9996732, 0.002066014,
9.570968, 0.176996, -441.3553, 0.02406312, -0.9997092, 0.00158488,
9.817696, 0.176996, -445.5146, 0.02313028, -0.9997317, 0.001290455,
10.06442, 0.176996, -450.3267, 0.02275754, -0.9997404, 0.001173368,
2.909307, 0.1823941, -700.7726, -0.03706273, 0.9993129, 0.0003237019,
3.156036, 0.1823941, -672.5152, -0.03635632, 0.9993389, 0.0003311363,
3.402764, 0.1823941, -646.5269, -0.03501258, 0.9993868, 0.0003467197,
3.649492, 0.1823941, -622.6181, -0.03379374, 0.9994288, 0.0003638412,
3.89622, 0.1823941, -600.6284, -0.0326792, 0.9994658, 0.0003827416,
4.142948, 0.1823941, -580.42, -0.03165247, 0.9994989, 0.0004037146,
4.389677, 0.1823941, -561.8737, -0.03070017, 0.9995285, 0.0004271226,
4.636405, 0.1823941, -544.8851, -0.0298112, 0.9995555, 0.0004534181,
4.883132, 0.1823941, -529.3619, -0.02897599, 0.9995801, 0.0004831724,
5.129861, 0.1823941, -515.2223, -0.02818603, 0.9996026, 0.0005171184,
5.376589, 0.1823941, -502.3932, -0.02743377, 0.9996235, 0.0005562146,
5.623317, 0.1823941, -490.8086, -0.02671202, 0.9996431, 0.0006017367,
5.870045, 0.1823941, -480.4088, -0.02601333, 0.9996614, 0.0006554216,
6.116773, 0.1823941, -471.1399, -0.02532976, 0.9996789, 0.000719699,
6.363502, 0.1823941, -462.9523, -0.02465231, 0.9996958, 0.0007980796,
6.610229, 0.1823941, -455.8006, -0.02396945, 0.9997123, 0.0008958386,
6.856958, 0.1823941, -449.6433, -0.02326532, 0.9997289, 0.001021304,
7.103686, 0.1823941, -444.442, -0.02251633, 0.9997458, 0.001188485,
7.350414, 0.1823941, -440.1609, -0.02168366, 0.999764, 0.001423108,
7.597142, 0.1823941, -436.767, -0.02069691, 0.9997842, 0.001778847,
7.84387, 0.1823941, -434.2296, -0.01941454, 0.9998087, 0.002394316,
8.090598, 0.1823941, -432.5201, -0.01760417, 0.9998376, 0.003847595,
8.337327, 0.1823941, -431.6115, -0.01250535, 0.9998314, 0.01345477,
8.584055, 0.1823941, -431.4787, 0.9245047, 0.08561902, 0.3714303,
8.830783, 0.1823941, -432.0981, 0.06174573, -0.9976745, 0.02886263,
9.077511, 0.1823941, -433.4475, 0.05920929, -0.9981933, 0.01021119,
9.324239, 0.1823941, -435.5059, 0.02928447, -0.9995661, 0.003195415,
9.570968, 0.1823941, -438.2534, 0.02606232, -0.9996581, 0.002155345,
9.817696, 0.1823941, -441.6715, 0.02450291, -0.9996984, 0.001648197,
10.06442, 0.1823941, -445.7423, 0.02394381, -0.9997123, 0.001462037,
2.909307, 0.1877922, -717.9391, -0.03742558, 0.9992995, 0.0003187452,
3.156036, 0.1877922, -688.962, -0.03671536, 0.9993258, 0.0003257324,
3.402764, 0.1877922, -662.2541, -0.0353641, 0.9993745, 0.0003403461,
3.649492, 0.1877922, -637.6257, -0.03413816, 0.9994171, 0.000356331,
3.89622, 0.1877922, -614.9164, -0.03301696, 0.9994548, 0.0003738909,
4.142948, 0.1877922, -593.9885, -0.03198403, 0.9994883, 0.0003932718,
4.389677, 0.1877922, -574.7225, -0.03102604, 0.9995186, 0.0004147741,
4.636405, 0.1877922, -557.0142, -0.03013193, 0.9995459, 0.0004387678,
4.883132, 0.1877922, -540.7714, -0.02929213, 0.9995708, 0.0004657134,
5.129861, 0.1877922, -525.9122, -0.02849835, 0.9995938, 0.0004961937,
5.376589, 0.1877922, -512.3635, -0.02774332, 0.999615, 0.000530957,
5.623317, 0.1877922, -500.0593, -0.02702006, 0.9996347, 0.0005709788,
5.870045, 0.1877922, -488.9399, -0.02632164, 0.9996534, 0.0006175566,
6.116773, 0.1877922, -478.9514, -0.02564088, 0.999671, 0.0006724564,
6.363502, 0.1877922, -470.0441, -0.02497004, 0.9996879, 0.0007381456,
6.610229, 0.1877922, -462.1729, -0.02429958, 0.9997045, 0.000818184,
6.856958, 0.1877922, -455.296, -0.02361719, 0.9997208, 0.0009179122,
7.103686, 0.1877922, -449.3749, -0.02290571, 0.9997371, 0.001045742,
7.350414, 0.1877922, -444.3742, -0.02213887, 0.9997543, 0.001215785,
7.597142, 0.1877922, -440.2608, -0.02127298, 0.9997727, 0.001453845,
7.84387, 0.1877922, -437.0038, -0.02022697, 0.9997938, 0.001813433,
8.090598, 0.1877922, -434.5746, -0.01883166, 0.9998197, 0.002431169,
8.337327, 0.1877922, -432.9464, -0.0167217, 0.9998527, 0.003859075,
8.584055, 0.1877922, -432.094, -0.0115276, 0.9998143, 0.01544288,
8.830783, 0.1877922, -431.9938, 0.931769, 0.1118716, 0.3453855,
9.077511, 0.1877922, -432.6236, 0.07779194, -0.9962391, 0.03816026,
9.324239, 0.1877922, -433.9623, 0.07275122, -0.9972683, 0.0127822,
9.570968, 0.1877922, -435.9903, 0.03025769, -0.9995365, 0.003358229,
9.817696, 0.1877922, -438.6887, 0.02665716, -0.9996421, 0.002246964,
10.06442, 0.1877922, -442.0399, 0.02564594, -0.9996693, 0.001907963,
2.909307, 0.1931904, -735.3461, -0.03778336, 0.9992859, 0.0003142031,
3.156036, 0.1931904, -705.6698, -0.03706952, 0.9993126, 0.0003207907,
3.402764, 0.1931904, -678.2626, -0.03571122, 0.9993621, 0.0003345412,
3.649492, 0.1931904, -652.9351, -0.03447873, 0.9994054, 0.0003495219,
3.89622, 0.1931904, -629.5266, -0.03335141, 0.9994437, 0.0003659061,
4.142948, 0.1931904, -607.8994, -0.03231277, 0.9994777, 0.0003839015,
4.389677, 0.1931904, -587.9342, -0.03134956, 0.9995084, 0.0004037594,
4.636405, 0.1931904, -569.5267, -0.03045074, 0.9995362, 0.0004257865,
4.883132, 0.1931904, -552.5846, -0.02960676, 0.9995616, 0.0004503593,
5.129861, 0.1931904, -537.0262, -0.02880966, 0.9995848, 0.0004779483,
5.376589, 0.1931904, -522.7783, -0.0280522, 0.9996064, 0.0005091478,
5.623317, 0.1931904, -509.7748, -0.02732765, 0.9996264, 0.0005447189,
5.870045, 0.1931904, -497.9562, -0.02662952, 0.9996453, 0.0005856542,
6.116773, 0.1931904, -487.2685, -0.02595126, 0.999663, 0.0006332736,
6.363502, 0.1931904, -477.662, -0.02528603, 0.99968, 0.0006893715,
6.610229, 0.1931904, -469.0915, -0.0246257, 0.9996964, 0.0007564506,
6.856958, 0.1931904, -461.5154, -0.02396041, 0.9997126, 0.0008381172,
7.103686, 0.1931904, -454.8952, -0.02327721, 0.9997287, 0.000939775,
7.350414, 0.1931904, -449.1952, -0.02255738, 0.9997451, 0.001069914,
7.597142, 0.1931904, -444.3825, -0.02177225, 0.9997622, 0.001242734,
7.84387, 0.1931904, -440.4263, -0.02087332, 0.9997811, 0.001484105,
8.090598, 0.1931904, -437.2979, -0.01976978, 0.9998029, 0.001847339,
8.337327, 0.1931904, -434.9705, -0.0182675, 0.9998302, 0.002467071,
8.584055, 0.1931904, -433.4189, -0.01588878, 0.9998663, 0.003871289,
8.830783, 0.1931904, -432.6195, -0.0105795, 0.9997641, 0.01897027,
9.077511, 0.1931904, -432.55, 0.9321175, 0.1610492, 0.3243763,
9.324239, 0.1931904, -433.1895, 0.1082789, -0.9924776, 0.05713007,
9.570968, 0.1931904, -434.5182, 0.0969011, -0.9951427, 0.01735342,
9.817696, 0.1931904, -436.5175, 0.03127594, -0.9995046, 0.00352859,
10.06442, 0.1931904, -439.1695, 0.02855658, -0.9995886, 0.002698796,
2.909307, 0.1985885, -752.9803, -0.03813612, 0.9992726, 0.0003100269,
3.156036, 0.1985885, -722.6241, -0.03741888, 0.9992996, 0.0003162558,
3.402764, 0.1985885, -694.537, -0.03605394, 0.9993499, 0.0003292337,
3.649492, 0.1985885, -668.5294, -0.03481527, 0.9993938, 0.0003433204,
3.89622, 0.1985885, -644.4409, -0.03368217, 0.9994326, 0.0003586654,
4.142948, 0.1985885, -622.1338, -0.03263819, 0.9994672, 0.0003754455,
4.389677, 0.1985885, -601.4887, -0.03167016, 0.9994984, 0.000393873,
4.636405, 0.1985885, -582.4012, -0.03076698, 0.9995265, 0.000414204,
4.883132, 0.1985885, -564.7792, -0.02991923, 0.9995523, 0.0004367507,
5.129861, 0.1985885, -548.5409, -0.02911909, 0.9995759, 0.0004618978,
5.376589, 0.1985885, -533.613, -0.02835944, 0.9995977, 0.0004901247,
5.623317, 0.1985885, -519.9296, -0.02763373, 0.9996181, 0.0005220358,
5.870045, 0.1985885, -507.4311, -0.02693582, 0.9996371, 0.0005584055,
6.116773, 0.1985885, -496.0633, -0.02625963, 0.999655, 0.0006002433,
6.363502, 0.1985885, -485.7769, -0.02559902, 0.9996722, 0.0006488909,
6.610229, 0.1985885, -476.5265, -0.02494692, 0.9996886, 0.0007061688,
6.856958, 0.1985885, -468.2704, -0.02429518, 0.9997045, 0.0007746148,
7.103686, 0.1985885, -460.9702, -0.02363367, 0.9997204, 0.0008578818,
7.350414, 0.1985885, -454.5903, -0.02294838, 0.9997362, 0.0009614304,
7.597142, 0.1985885, -449.0977, -0.02221943, 0.9997526, 0.001093823,
7.84387, 0.1985885, -444.4615, -0.02141573, 0.9997699, 0.001269345,
8.090598, 0.1985885, -440.6532, -0.02048416, 0.9997891, 0.001513914,
8.337327, 0.1985885, -437.6458, -0.01932504, 0.9998115, 0.00188062,
8.584055, 0.1985885, -435.4142, -0.01772146, 0.9998398, 0.002502122,
8.830783, 0.1985885, -433.9349, -0.01510072, 0.9998785, 0.003884195,
9.077511, 0.1985885, -433.1854, -0.009594099, 0.9995959, 0.02675993,
9.324239, 0.1985885, -433.145, 0.9060875, 0.2939886, 0.3042632,
9.570968, 0.1985885, -433.7938, 0.1898789, -0.9745942, 0.1187943,
9.817696, 0.1985885, -435.1131, 0.1423717, -0.9894729, 0.02595425,
10.06442, 0.1985885, -437.0851, 0.03584309, -0.9993469, 0.004599025,
2.909307, 0.2039866, -770.8296, -0.03848355, 0.9992592, 0.0003061718,
3.156036, 0.2039866, -739.8116, -0.03776311, 0.9992867, 0.0003120771,
3.402764, 0.2039866, -711.0628, -0.03639193, 0.9993376, 0.0003243602,
3.649492, 0.2039866, -684.3936, -0.03514744, 0.9993821, 0.0003376474,
3.89622, 0.2039866, -659.6433, -0.03400888, 0.9994215, 0.0003520681,
4.142948, 0.2039866, -636.6745, -0.03295992, 0.9994566, 0.0003677748,
4.389677, 0.2039866, -615.3677, -0.03198735, 0.9994882, 0.0003849479,
4.636405, 0.2039866, -595.6185, -0.03108011, 0.9995168, 0.0004038038,
4.883132, 0.2039866, -577.3348, -0.0302289, 0.999543, 0.000424604,
5.129861, 0.2039866, -560.4348, -0.02942597, 0.999567, 0.0004476667,
5.376589, 0.2039866, -544.8451, -0.02866423, 0.999589, 0.0004733831,
5.623317, 0.2039866, -530.4999, -0.02793738, 0.9996096, 0.000502241,
5.870045, 0.2039866, -517.3397, -0.02723954, 0.9996288, 0.0005348554,
6.116773, 0.2039866, -505.3103, -0.02656505, 0.999647, 0.0005720144,
6.363502, 0.2039866, -494.3622, -0.02590821, 0.9996642, 0.0006147439,
6.610229, 0.2039866, -484.45, -0.0252628, 0.9996806, 0.0006644055,
6.856958, 0.2039866, -475.5322, -0.02462189, 0.9996966, 0.0007228461,
7.103686, 0.2039866, -467.5703, -0.02397726, 0.9997123, 0.0007926373,
7.350414, 0.2039866, -460.5287, -0.02331803, 0.9997277, 0.0008774747,
7.597142, 0.2039866, -454.3744, -0.02262971, 0.9997435, 0.0009828749,
7.84387, 0.2039866, -449.0765, -0.02189107, 0.9997597, 0.001117469,
8.090598, 0.2039866, -444.6064, -0.02106838, 0.9997772, 0.001295617,
8.337327, 0.2039866, -440.9374, -0.02010474, 0.9997967, 0.001543266,
8.584055, 0.2039866, -438.0441, -0.01889198, 0.9998197, 0.00191327,
8.830783, 0.2039866, -435.903, -0.01719222, 0.9998491, 0.002536308,
9.077511, 0.2039866, -434.4919, -0.01435251, 0.9998895, 0.00389748,
9.324239, 0.2039866, -433.7897, -0.008104503, 0.9983678, 0.05653498,
9.570968, 0.2039866, -433.7768, 0.6922365, 0.6862104, 0.2234367,
9.817696, 0.2039866, -434.4343, 0.5360309, -0.7679999, 0.3504953,
10.06442, 0.2039866, -435.7447, 0.3571396, -0.9315735, 0.06798647,
2.909307, 0.2093847, -788.8827, -0.0388259, 0.999246, 0.0003026039,
3.156036, 0.2093847, -757.2203, -0.03810242, 0.9992738, 0.0003082158,
3.402764, 0.2093847, -727.827, -0.03672529, 0.9993254, 0.0003198706,
3.649492, 0.2093847, -700.5133, -0.03547523, 0.9993706, 0.0003324387,
3.89622, 0.2093847, -675.1187, -0.03433154, 0.9994105, 0.0003460331,
4.142948, 0.2093847, -651.5054, -0.03327789, 0.9994461, 0.0003607859,
4.389677, 0.2093847, -629.5541, -0.03230103, 0.9994781, 0.0003768518,
4.636405, 0.2093847, -609.1605, -0.03138997, 0.9995072, 0.000394415,
4.883132, 0.2093847, -590.2324, -0.03053552, 0.9995337, 0.0004136965,
5.129861, 0.2093847, -572.6879, -0.0297299, 0.999558, 0.0004349623,
5.376589, 0.2093847, -556.4539, -0.02896618, 0.9995803, 0.0004585359,
5.623317, 0.2093847, -541.4643, -0.02823817, 0.9996012, 0.0004848157,
5.870045, 0.2093847, -527.6597, -0.02754029, 0.9996207, 0.0005142982,
6.116773, 0.2093847, -514.9858, -0.02686713, 0.9996389, 0.0005476096,
6.363502, 0.2093847, -503.3932, -0.02621336, 0.9996563, 0.0005855496,
6.610229, 0.2093847, -492.8366, -0.02557339, 0.9996728, 0.00062916,
6.856958, 0.2093847, -483.2744, -0.0249412, 0.9996887, 0.0006798223,
7.103686, 0.2093847, -474.6681, -0.02430989, 0.9997043, 0.0007394091,
7.350414, 0.2093847, -466.9821, -0.02367076, 0.9997196, 0.0008105236,
7.597142, 0.2093847, -460.1833, -0.02301278, 0.9997348, 0.0008969038,
7.84387, 0.2093847, -454.241, -0.02232061, 0.9997504, 0.001004117,
8.090598, 0.2093847, -449.1265, -0.02157147, 0.9997666, 0.00114086,
8.337327, 0.2093847, -444.813, -0.02072992, 0.9997842, 0.00132156,
8.584055, 0.2093847, -441.2753, -0.01973478, 0.999804, 0.001572184,
8.830783, 0.2093847, -438.4897, -0.0184698, 0.9998276, 0.001945314,
9.077511, 0.2093847, -436.4342, -0.01667906, 0.9998576, 0.002569688,
9.324239, 0.2093847, -435.0876, -0.01364107, 0.9998994, 0.003911166,
9.570968, 0.2093847, -434.4302, -0.00019341, 0.9975343, 0.07018091,
9.817696, 0.2093847, -434.4434, 0.4106435, 0.9029208, 0.1269086,
10.06442, 0.2093847, -435.1093, 0.4994969, 0.8254371, 0.2629761,
2.909307, 0.2147828, -807.1292, -0.03900234, 0.9992391, 0.0003008882,
3.156036, 0.2147828, -774.8387, -0.03827117, 0.9992674, 0.0003063607,
3.402764, 0.2147828, -744.8174, -0.03689114, 0.9993193, 0.0003177164,
3.649492, 0.2147828, -716.8757, -0.03563834, 0.9993647, 0.0003299434,
3.89622, 0.2147828, -690.8531, -0.03449216, 0.999405, 0.0003431468,
4.142948, 0.2147828, -666.6118, -0.03343627, 0.9994408, 0.0003574499,
4.389677, 0.2147828, -644.0325, -0.03245738, 0.9994732, 0.0003729959,
4.636405, 0.2147828, -623.0109, -0.03154455, 0.9995024, 0.0003899543,
4.883132, 0.2147828, -603.4547, -0.03068858, 0.9995289, 0.0004085278,
5.129861, 0.2147828, -585.2822, -0.02988172, 0.9995534, 0.0004289594,
5.376589, 0.2147828, -568.4201, -0.02911716, 0.999576, 0.0004515439,
5.623317, 0.2147828, -552.8025, -0.02838872, 0.9995968, 0.0004766404,
5.870045, 0.2147828, -538.3699, -0.02769095, 0.9996165, 0.0005046932,
6.116773, 0.2147828, -525.0679, -0.02701853, 0.9996349, 0.0005362601,
6.363502, 0.2147828, -512.8474, -0.02636637, 0.9996523, 0.0005720465,
6.610229, 0.2147828, -501.6628, -0.02572913, 0.9996688, 0.0006129605,
6.856958, 0.2147828, -491.4725, -0.02510124, 0.9996847, 0.0006601948,
7.103686, 0.2147828, -482.2382, -0.0244764, 0.9997002, 0.0007153431,
7.350414, 0.2147828, -473.9241, -0.02384687, 0.9997153, 0.0007805845,
7.597142, 0.2147828, -466.4973, -0.02320312, 0.9997304, 0.0008589837,
7.84387, 0.2147828, -459.927, -0.02253215, 0.9997457, 0.0009549918,
8.090598, 0.2147828, -454.1845, -0.02181564, 0.9997615, 0.001075349,
8.337327, 0.2147828, -449.2429, -0.02102619, 0.9997782, 0.001230776,
8.584055, 0.2147828, -445.0772, -0.02011909, 0.9997966, 0.001439462,
8.830783, 0.2147828, -441.6636, -0.01901583, 0.9998177, 0.001735119,
9.077511, 0.2147828, -438.98, -0.01756278, 0.9998435, 0.002188683,
9.324239, 0.2147828, -437.0054, -0.01540613, 0.999877, 0.002983314,
9.570968, 0.2147828, -435.7201, -0.01147837, 0.9999225, 0.004834914,
9.817696, 0.2147828, -435.1052, 0.009082412, 0.9989594, 0.04469502,
10.06442, 0.2147828, -435.143, 0.2012609, 0.9763867, 0.07850391
]);
this.values[27] = v;
this.normLoc[27] = gl.getAttribLocation(this.prog[27], "aNorm");
f=new Uint16Array([
0, 30, 31, 0, 31, 1,
30, 60, 61, 30, 61, 31,
60, 90, 91, 60, 91, 61,
90, 120, 121, 90, 121, 91,
120, 150, 151, 120, 151, 121,
150, 180, 181, 150, 181, 151,
180, 210, 211, 180, 211, 181,
210, 240, 241, 210, 241, 211,
240, 270, 271, 240, 271, 241,
270, 300, 301, 270, 301, 271,
300, 330, 331, 300, 331, 301,
330, 360, 361, 330, 361, 331,
360, 390, 391, 360, 391, 361,
390, 420, 421, 390, 421, 391,
420, 450, 451, 420, 451, 421,
450, 480, 481, 450, 481, 451,
480, 510, 511, 480, 511, 481,
510, 540, 541, 510, 541, 511,
540, 570, 571, 540, 571, 541,
570, 600, 601, 570, 601, 571,
600, 630, 631, 600, 631, 601,
630, 660, 661, 630, 661, 631,
660, 690, 691, 660, 691, 661,
690, 720, 721, 690, 721, 691,
720, 750, 751, 720, 751, 721,
750, 780, 781, 750, 781, 751,
780, 810, 811, 780, 811, 781,
810, 840, 841, 810, 841, 811,
840, 870, 871, 840, 871, 841,
1, 31, 32, 1, 32, 2,
31, 61, 62, 31, 62, 32,
61, 91, 92, 61, 92, 62,
91, 121, 122, 91, 122, 92,
121, 151, 152, 121, 152, 122,
151, 181, 182, 151, 182, 152,
181, 211, 212, 181, 212, 182,
211, 241, 242, 211, 242, 212,
241, 271, 272, 241, 272, 242,
271, 301, 302, 271, 302, 272,
301, 331, 332, 301, 332, 302,
331, 361, 362, 331, 362, 332,
361, 391, 392, 361, 392, 362,
391, 421, 422, 391, 422, 392,
421, 451, 452, 421, 452, 422,
451, 481, 482, 451, 482, 452,
481, 511, 512, 481, 512, 482,
511, 541, 542, 511, 542, 512,
541, 571, 572, 541, 572, 542,
571, 601, 602, 571, 602, 572,
601, 631, 632, 601, 632, 602,
631, 661, 662, 631, 662, 632,
661, 691, 692, 661, 692, 662,
691, 721, 722, 691, 722, 692,
721, 751, 752, 721, 752, 722,
751, 781, 782, 751, 782, 752,
781, 811, 812, 781, 812, 782,
811, 841, 842, 811, 842, 812,
841, 871, 872, 841, 872, 842,
2, 32, 33, 2, 33, 3,
32, 62, 63, 32, 63, 33,
62, 92, 93, 62, 93, 63,
92, 122, 123, 92, 123, 93,
122, 152, 153, 122, 153, 123,
152, 182, 183, 152, 183, 153,
182, 212, 213, 182, 213, 183,
212, 242, 243, 212, 243, 213,
242, 272, 273, 242, 273, 243,
272, 302, 303, 272, 303, 273,
302, 332, 333, 302, 333, 303,
332, 362, 363, 332, 363, 333,
362, 392, 393, 362, 393, 363,
392, 422, 423, 392, 423, 393,
422, 452, 453, 422, 453, 423,
452, 482, 483, 452, 483, 453,
482, 512, 513, 482, 513, 483,
512, 542, 543, 512, 543, 513,
542, 572, 573, 542, 573, 543,
572, 602, 603, 572, 603, 573,
602, 632, 633, 602, 633, 603,
632, 662, 663, 632, 663, 633,
662, 692, 693, 662, 693, 663,
692, 722, 723, 692, 723, 693,
722, 752, 753, 722, 753, 723,
752, 782, 783, 752, 783, 753,
782, 812, 813, 782, 813, 783,
812, 842, 843, 812, 843, 813,
842, 872, 873, 842, 873, 843,
3, 33, 34, 3, 34, 4,
33, 63, 64, 33, 64, 34,
63, 93, 94, 63, 94, 64,
93, 123, 124, 93, 124, 94,
123, 153, 154, 123, 154, 124,
153, 183, 184, 153, 184, 154,
183, 213, 214, 183, 214, 184,
213, 243, 244, 213, 244, 214,
243, 273, 274, 243, 274, 244,
273, 303, 304, 273, 304, 274,
303, 333, 334, 303, 334, 304,
333, 363, 364, 333, 364, 334,
363, 393, 394, 363, 394, 364,
393, 423, 424, 393, 424, 394,
423, 453, 454, 423, 454, 424,
453, 483, 484, 453, 484, 454,
483, 513, 514, 483, 514, 484,
513, 543, 544, 513, 544, 514,
543, 573, 574, 543, 574, 544,
573, 603, 604, 573, 604, 574,
603, 633, 634, 603, 634, 604,
633, 663, 664, 633, 664, 634,
663, 693, 694, 663, 694, 664,
693, 723, 724, 693, 724, 694,
723, 753, 754, 723, 754, 724,
753, 783, 784, 753, 784, 754,
783, 813, 814, 783, 814, 784,
813, 843, 844, 813, 844, 814,
843, 873, 874, 843, 874, 844,
4, 34, 35, 4, 35, 5,
34, 64, 65, 34, 65, 35,
64, 94, 95, 64, 95, 65,
94, 124, 125, 94, 125, 95,
124, 154, 155, 124, 155, 125,
154, 184, 185, 154, 185, 155,
184, 214, 215, 184, 215, 185,
214, 244, 245, 214, 245, 215,
244, 274, 275, 244, 275, 245,
274, 304, 305, 274, 305, 275,
304, 334, 335, 304, 335, 305,
334, 364, 365, 334, 365, 335,
364, 394, 395, 364, 395, 365,
394, 424, 425, 394, 425, 395,
424, 454, 455, 424, 455, 425,
454, 484, 485, 454, 485, 455,
484, 514, 515, 484, 515, 485,
514, 544, 545, 514, 545, 515,
544, 574, 575, 544, 575, 545,
574, 604, 605, 574, 605, 575,
604, 634, 635, 604, 635, 605,
634, 664, 665, 634, 665, 635,
664, 694, 695, 664, 695, 665,
694, 724, 725, 694, 725, 695,
724, 754, 755, 724, 755, 725,
754, 784, 785, 754, 785, 755,
784, 814, 815, 784, 815, 785,
814, 844, 845, 814, 845, 815,
844, 874, 875, 844, 875, 845,
5, 35, 36, 5, 36, 6,
35, 65, 66, 35, 66, 36,
65, 95, 96, 65, 96, 66,
95, 125, 126, 95, 126, 96,
125, 155, 156, 125, 156, 126,
155, 185, 186, 155, 186, 156,
185, 215, 216, 185, 216, 186,
215, 245, 246, 215, 246, 216,
245, 275, 276, 245, 276, 246,
275, 305, 306, 275, 306, 276,
305, 335, 336, 305, 336, 306,
335, 365, 366, 335, 366, 336,
365, 395, 396, 365, 396, 366,
395, 425, 426, 395, 426, 396,
425, 455, 456, 425, 456, 426,
455, 485, 486, 455, 486, 456,
485, 515, 516, 485, 516, 486,
515, 545, 546, 515, 546, 516,
545, 575, 576, 545, 576, 546,
575, 605, 606, 575, 606, 576,
605, 635, 636, 605, 636, 606,
635, 665, 666, 635, 666, 636,
665, 695, 696, 665, 696, 666,
695, 725, 726, 695, 726, 696,
725, 755, 756, 725, 756, 726,
755, 785, 786, 755, 786, 756,
785, 815, 816, 785, 816, 786,
815, 845, 846, 815, 846, 816,
845, 875, 876, 845, 876, 846,
6, 36, 37, 6, 37, 7,
36, 66, 67, 36, 67, 37,
66, 96, 97, 66, 97, 67,
96, 126, 127, 96, 127, 97,
126, 156, 157, 126, 157, 127,
156, 186, 187, 156, 187, 157,
186, 216, 217, 186, 217, 187,
216, 246, 247, 216, 247, 217,
246, 276, 277, 246, 277, 247,
276, 306, 307, 276, 307, 277,
306, 336, 337, 306, 337, 307,
336, 366, 367, 336, 367, 337,
366, 396, 397, 366, 397, 367,
396, 426, 427, 396, 427, 397,
426, 456, 457, 426, 457, 427,
456, 486, 487, 456, 487, 457,
486, 516, 517, 486, 517, 487,
516, 546, 547, 516, 547, 517,
546, 576, 577, 546, 577, 547,
576, 606, 607, 576, 607, 577,
606, 636, 637, 606, 637, 607,
636, 666, 667, 636, 667, 637,
666, 696, 697, 666, 697, 667,
696, 726, 727, 696, 727, 697,
726, 756, 757, 726, 757, 727,
756, 786, 787, 756, 787, 757,
786, 816, 817, 786, 817, 787,
816, 846, 847, 816, 847, 817,
846, 876, 877, 846, 877, 847,
7, 37, 38, 7, 38, 8,
37, 67, 68, 37, 68, 38,
67, 97, 98, 67, 98, 68,
97, 127, 128, 97, 128, 98,
127, 157, 158, 127, 158, 128,
157, 187, 188, 157, 188, 158,
187, 217, 218, 187, 218, 188,
217, 247, 248, 217, 248, 218,
247, 277, 278, 247, 278, 248,
277, 307, 308, 277, 308, 278,
307, 337, 338, 307, 338, 308,
337, 367, 368, 337, 368, 338,
367, 397, 398, 367, 398, 368,
397, 427, 428, 397, 428, 398,
427, 457, 458, 427, 458, 428,
457, 487, 488, 457, 488, 458,
487, 517, 518, 487, 518, 488,
517, 547, 548, 517, 548, 518,
547, 577, 578, 547, 578, 548,
577, 607, 608, 577, 608, 578,
607, 637, 638, 607, 638, 608,
637, 667, 668, 637, 668, 638,
667, 697, 698, 667, 698, 668,
697, 727, 728, 697, 728, 698,
727, 757, 758, 727, 758, 728,
757, 787, 788, 757, 788, 758,
787, 817, 818, 787, 818, 788,
817, 847, 848, 817, 848, 818,
847, 877, 878, 847, 878, 848,
8, 38, 39, 8, 39, 9,
38, 68, 69, 38, 69, 39,
68, 98, 99, 68, 99, 69,
98, 128, 129, 98, 129, 99,
128, 158, 159, 128, 159, 129,
158, 188, 189, 158, 189, 159,
188, 218, 219, 188, 219, 189,
218, 248, 249, 218, 249, 219,
248, 278, 279, 248, 279, 249,
278, 308, 309, 278, 309, 279,
308, 338, 339, 308, 339, 309,
338, 368, 369, 338, 369, 339,
368, 398, 399, 368, 399, 369,
398, 428, 429, 398, 429, 399,
428, 458, 459, 428, 459, 429,
458, 488, 489, 458, 489, 459,
488, 518, 519, 488, 519, 489,
518, 548, 549, 518, 549, 519,
548, 578, 579, 548, 579, 549,
578, 608, 609, 578, 609, 579,
608, 638, 639, 608, 639, 609,
638, 668, 669, 638, 669, 639,
668, 698, 699, 668, 699, 669,
698, 728, 729, 698, 729, 699,
728, 758, 759, 728, 759, 729,
758, 788, 789, 758, 789, 759,
788, 818, 819, 788, 819, 789,
818, 848, 849, 818, 849, 819,
848, 878, 879, 848, 879, 849,
9, 39, 40, 9, 40, 10,
39, 69, 70, 39, 70, 40,
69, 99, 100, 69, 100, 70,
99, 129, 130, 99, 130, 100,
129, 159, 160, 129, 160, 130,
159, 189, 190, 159, 190, 160,
189, 219, 220, 189, 220, 190,
219, 249, 250, 219, 250, 220,
249, 279, 280, 249, 280, 250,
279, 309, 310, 279, 310, 280,
309, 339, 340, 309, 340, 310,
339, 369, 370, 339, 370, 340,
369, 399, 400, 369, 400, 370,
399, 429, 430, 399, 430, 400,
429, 459, 460, 429, 460, 430,
459, 489, 490, 459, 490, 460,
489, 519, 520, 489, 520, 490,
519, 549, 550, 519, 550, 520,
549, 579, 580, 549, 580, 550,
579, 609, 610, 579, 610, 580,
609, 639, 640, 609, 640, 610,
639, 669, 670, 639, 670, 640,
669, 699, 700, 669, 700, 670,
699, 729, 730, 699, 730, 700,
729, 759, 760, 729, 760, 730,
759, 789, 790, 759, 790, 760,
789, 819, 820, 789, 820, 790,
819, 849, 850, 819, 850, 820,
849, 879, 880, 849, 880, 850,
10, 40, 41, 10, 41, 11,
40, 70, 71, 40, 71, 41,
70, 100, 101, 70, 101, 71,
100, 130, 131, 100, 131, 101,
130, 160, 161, 130, 161, 131,
160, 190, 191, 160, 191, 161,
190, 220, 221, 190, 221, 191,
220, 250, 251, 220, 251, 221,
250, 280, 281, 250, 281, 251,
280, 310, 311, 280, 311, 281,
310, 340, 341, 310, 341, 311,
340, 370, 371, 340, 371, 341,
370, 400, 401, 370, 401, 371,
400, 430, 431, 400, 431, 401,
430, 460, 461, 430, 461, 431,
460, 490, 491, 460, 491, 461,
490, 520, 521, 490, 521, 491,
520, 550, 551, 520, 551, 521,
550, 580, 581, 550, 581, 551,
580, 610, 611, 580, 611, 581,
610, 640, 641, 610, 641, 611,
640, 670, 671, 640, 671, 641,
670, 700, 701, 670, 701, 671,
700, 730, 731, 700, 731, 701,
730, 760, 761, 730, 761, 731,
760, 790, 791, 760, 791, 761,
790, 820, 821, 790, 821, 791,
820, 850, 851, 820, 851, 821,
850, 880, 881, 850, 881, 851,
11, 41, 42, 11, 42, 12,
41, 71, 72, 41, 72, 42,
71, 101, 102, 71, 102, 72,
101, 131, 132, 101, 132, 102,
131, 161, 162, 131, 162, 132,
161, 191, 192, 161, 192, 162,
191, 221, 222, 191, 222, 192,
221, 251, 252, 221, 252, 222,
251, 281, 282, 251, 282, 252,
281, 311, 312, 281, 312, 282,
311, 341, 342, 311, 342, 312,
341, 371, 372, 341, 372, 342,
371, 401, 402, 371, 402, 372,
401, 431, 432, 401, 432, 402,
431, 461, 462, 431, 462, 432,
461, 491, 492, 461, 492, 462,
491, 521, 522, 491, 522, 492,
521, 551, 552, 521, 552, 522,
551, 581, 582, 551, 582, 552,
581, 611, 612, 581, 612, 582,
611, 641, 642, 611, 642, 612,
641, 671, 672, 641, 672, 642,
671, 701, 702, 671, 702, 672,
701, 731, 732, 701, 732, 702,
731, 761, 762, 731, 762, 732,
761, 791, 792, 761, 792, 762,
791, 821, 822, 791, 822, 792,
821, 851, 852, 821, 852, 822,
851, 881, 882, 851, 882, 852,
12, 42, 43, 12, 43, 13,
42, 72, 73, 42, 73, 43,
72, 102, 103, 72, 103, 73,
102, 132, 133, 102, 133, 103,
132, 162, 163, 132, 163, 133,
162, 192, 193, 162, 193, 163,
192, 222, 223, 192, 223, 193,
222, 252, 253, 222, 253, 223,
252, 282, 283, 252, 283, 253,
282, 312, 313, 282, 313, 283,
312, 342, 343, 312, 343, 313,
342, 372, 373, 342, 373, 343,
372, 402, 403, 372, 403, 373,
402, 432, 433, 402, 433, 403,
432, 462, 463, 432, 463, 433,
462, 492, 493, 462, 493, 463,
492, 522, 523, 492, 523, 493,
522, 552, 553, 522, 553, 523,
552, 582, 583, 552, 583, 553,
582, 612, 613, 582, 613, 583,
612, 642, 643, 612, 643, 613,
642, 672, 673, 642, 673, 643,
672, 702, 703, 672, 703, 673,
702, 732, 733, 702, 733, 703,
732, 762, 763, 732, 763, 733,
762, 792, 793, 762, 793, 763,
792, 822, 823, 792, 823, 793,
822, 852, 853, 822, 853, 823,
852, 882, 883, 852, 883, 853,
13, 43, 44, 13, 44, 14,
43, 73, 74, 43, 74, 44,
73, 103, 104, 73, 104, 74,
103, 133, 134, 103, 134, 104,
133, 163, 164, 133, 164, 134,
163, 193, 194, 163, 194, 164,
193, 223, 224, 193, 224, 194,
223, 253, 254, 223, 254, 224,
253, 283, 284, 253, 284, 254,
283, 313, 314, 283, 314, 284,
313, 343, 344, 313, 344, 314,
343, 373, 374, 343, 374, 344,
373, 403, 404, 373, 404, 374,
403, 433, 434, 403, 434, 404,
433, 463, 464, 433, 464, 434,
463, 493, 494, 463, 494, 464,
493, 523, 524, 493, 524, 494,
523, 553, 554, 523, 554, 524,
553, 583, 584, 553, 584, 554,
583, 613, 614, 583, 614, 584,
613, 643, 644, 613, 644, 614,
643, 673, 674, 643, 674, 644,
673, 703, 704, 673, 704, 674,
703, 733, 734, 703, 734, 704,
733, 763, 764, 733, 764, 734,
763, 793, 794, 763, 794, 764,
793, 823, 824, 793, 824, 794,
823, 853, 854, 823, 854, 824,
853, 883, 884, 853, 884, 854,
14, 44, 45, 14, 45, 15,
44, 74, 75, 44, 75, 45,
74, 104, 105, 74, 105, 75,
104, 134, 135, 104, 135, 105,
134, 164, 165, 134, 165, 135,
164, 194, 195, 164, 195, 165,
194, 224, 225, 194, 225, 195,
224, 254, 255, 224, 255, 225,
254, 284, 285, 254, 285, 255,
284, 314, 315, 284, 315, 285,
314, 344, 345, 314, 345, 315,
344, 374, 375, 344, 375, 345,
374, 404, 405, 374, 405, 375,
404, 434, 435, 404, 435, 405,
434, 464, 465, 434, 465, 435,
464, 494, 495, 464, 495, 465,
494, 524, 525, 494, 525, 495,
524, 554, 555, 524, 555, 525,
554, 584, 585, 554, 585, 555,
584, 614, 615, 584, 615, 585,
614, 644, 645, 614, 645, 615,
644, 674, 675, 644, 675, 645,
674, 704, 705, 674, 705, 675,
704, 734, 735, 704, 735, 705,
734, 764, 765, 734, 765, 735,
764, 794, 795, 764, 795, 765,
794, 824, 825, 794, 825, 795,
824, 854, 855, 824, 855, 825,
854, 884, 885, 854, 885, 855,
15, 45, 46, 15, 46, 16,
45, 75, 76, 45, 76, 46,
75, 105, 106, 75, 106, 76,
105, 135, 136, 105, 136, 106,
135, 165, 166, 135, 166, 136,
165, 195, 196, 165, 196, 166,
195, 225, 226, 195, 226, 196,
225, 255, 256, 225, 256, 226,
255, 285, 286, 255, 286, 256,
285, 315, 316, 285, 316, 286,
315, 345, 346, 315, 346, 316,
345, 375, 376, 345, 376, 346,
375, 405, 406, 375, 406, 376,
405, 435, 436, 405, 436, 406,
435, 465, 466, 435, 466, 436,
465, 495, 496, 465, 496, 466,
495, 525, 526, 495, 526, 496,
525, 555, 556, 525, 556, 526,
555, 585, 586, 555, 586, 556,
585, 615, 616, 585, 616, 586,
615, 645, 646, 615, 646, 616,
645, 675, 676, 645, 676, 646,
675, 705, 706, 675, 706, 676,
705, 735, 736, 705, 736, 706,
735, 765, 766, 735, 766, 736,
765, 795, 796, 765, 796, 766,
795, 825, 826, 795, 826, 796,
825, 855, 856, 825, 856, 826,
855, 885, 886, 855, 886, 856,
16, 46, 47, 16, 47, 17,
46, 76, 77, 46, 77, 47,
76, 106, 107, 76, 107, 77,
106, 136, 137, 106, 137, 107,
136, 166, 167, 136, 167, 137,
166, 196, 197, 166, 197, 167,
196, 226, 227, 196, 227, 197,
226, 256, 257, 226, 257, 227,
256, 286, 287, 256, 287, 257,
286, 316, 317, 286, 317, 287,
316, 346, 347, 316, 347, 317,
346, 376, 377, 346, 377, 347,
376, 406, 407, 376, 407, 377,
406, 436, 437, 406, 437, 407,
436, 466, 467, 436, 467, 437,
466, 496, 497, 466, 497, 467,
496, 526, 527, 496, 527, 497,
526, 556, 557, 526, 557, 527,
556, 586, 587, 556, 587, 557,
586, 616, 617, 586, 617, 587,
616, 646, 647, 616, 647, 617,
646, 676, 677, 646, 677, 647,
676, 706, 707, 676, 707, 677,
706, 736, 737, 706, 737, 707,
736, 766, 767, 736, 767, 737,
766, 796, 797, 766, 797, 767,
796, 826, 827, 796, 827, 797,
826, 856, 857, 826, 857, 827,
856, 886, 887, 856, 887, 857,
17, 47, 48, 17, 48, 18,
47, 77, 78, 47, 78, 48,
77, 107, 108, 77, 108, 78,
107, 137, 138, 107, 138, 108,
137, 167, 168, 137, 168, 138,
167, 197, 198, 167, 198, 168,
197, 227, 228, 197, 228, 198,
227, 257, 258, 227, 258, 228,
257, 287, 288, 257, 288, 258,
287, 317, 318, 287, 318, 288,
317, 347, 348, 317, 348, 318,
347, 377, 378, 347, 378, 348,
377, 407, 408, 377, 408, 378,
407, 437, 438, 407, 438, 408,
437, 467, 468, 437, 468, 438,
467, 497, 498, 467, 498, 468,
497, 527, 528, 497, 528, 498,
527, 557, 558, 527, 558, 528,
557, 587, 588, 557, 588, 558,
587, 617, 618, 587, 618, 588,
617, 647, 648, 617, 648, 618,
647, 677, 678, 647, 678, 648,
677, 707, 708, 677, 708, 678,
707, 737, 738, 707, 738, 708,
737, 767, 768, 737, 768, 738,
767, 797, 798, 767, 798, 768,
797, 827, 828, 797, 828, 798,
827, 857, 858, 827, 858, 828,
857, 887, 888, 857, 888, 858,
18, 48, 49, 18, 49, 19,
48, 78, 79, 48, 79, 49,
78, 108, 109, 78, 109, 79,
108, 138, 139, 108, 139, 109,
138, 168, 169, 138, 169, 139,
168, 198, 199, 168, 199, 169,
198, 228, 229, 198, 229, 199,
228, 258, 259, 228, 259, 229,
258, 288, 289, 258, 289, 259,
288, 318, 319, 288, 319, 289,
318, 348, 349, 318, 349, 319,
348, 378, 379, 348, 379, 349,
378, 408, 409, 378, 409, 379,
408, 438, 439, 408, 439, 409,
438, 468, 469, 438, 469, 439,
468, 498, 499, 468, 499, 469,
498, 528, 529, 498, 529, 499,
528, 558, 559, 528, 559, 529,
558, 588, 589, 558, 589, 559,
588, 618, 619, 588, 619, 589,
618, 648, 649, 618, 649, 619,
648, 678, 679, 648, 679, 649,
678, 708, 709, 678, 709, 679,
708, 738, 739, 708, 739, 709,
738, 768, 769, 738, 769, 739,
768, 798, 799, 768, 799, 769,
798, 828, 829, 798, 829, 799,
828, 858, 859, 828, 859, 829,
858, 888, 889, 858, 889, 859,
19, 49, 50, 19, 50, 20,
49, 79, 80, 49, 80, 50,
79, 109, 110, 79, 110, 80,
109, 139, 140, 109, 140, 110,
139, 169, 170, 139, 170, 140,
169, 199, 200, 169, 200, 170,
199, 229, 230, 199, 230, 200,
229, 259, 260, 229, 260, 230,
259, 289, 290, 259, 290, 260,
289, 319, 320, 289, 320, 290,
319, 349, 350, 319, 350, 320,
349, 379, 380, 349, 380, 350,
379, 409, 410, 379, 410, 380,
409, 439, 440, 409, 440, 410,
439, 469, 470, 439, 470, 440,
469, 499, 500, 469, 500, 470,
499, 529, 530, 499, 530, 500,
529, 559, 560, 529, 560, 530,
559, 589, 590, 559, 590, 560,
589, 619, 620, 589, 620, 590,
619, 649, 650, 619, 650, 620,
649, 679, 680, 649, 680, 650,
679, 709, 710, 679, 710, 680,
709, 739, 740, 709, 740, 710,
739, 769, 770, 739, 770, 740,
769, 799, 800, 769, 800, 770,
799, 829, 830, 799, 830, 800,
829, 859, 860, 829, 860, 830,
859, 889, 890, 859, 890, 860,
20, 50, 51, 20, 51, 21,
50, 80, 81, 50, 81, 51,
80, 110, 111, 80, 111, 81,
110, 140, 141, 110, 141, 111,
140, 170, 171, 140, 171, 141,
170, 200, 201, 170, 201, 171,
200, 230, 231, 200, 231, 201,
230, 260, 261, 230, 261, 231,
260, 290, 291, 260, 291, 261,
290, 320, 321, 290, 321, 291,
320, 350, 351, 320, 351, 321,
350, 380, 381, 350, 381, 351,
380, 410, 411, 380, 411, 381,
410, 440, 441, 410, 441, 411,
440, 470, 471, 440, 471, 441,
470, 500, 501, 470, 501, 471,
500, 530, 531, 500, 531, 501,
530, 560, 561, 530, 561, 531,
560, 590, 591, 560, 591, 561,
590, 620, 621, 590, 621, 591,
620, 650, 651, 620, 651, 621,
650, 680, 681, 650, 681, 651,
680, 710, 711, 680, 711, 681,
710, 740, 741, 710, 741, 711,
740, 770, 771, 740, 771, 741,
770, 800, 801, 770, 801, 771,
800, 830, 831, 800, 831, 801,
830, 860, 861, 830, 861, 831,
860, 890, 891, 860, 891, 861,
21, 51, 52, 21, 52, 22,
51, 81, 82, 51, 82, 52,
81, 111, 112, 81, 112, 82,
111, 141, 142, 111, 142, 112,
141, 171, 172, 141, 172, 142,
171, 201, 202, 171, 202, 172,
201, 231, 232, 201, 232, 202,
231, 261, 262, 231, 262, 232,
261, 291, 292, 261, 292, 262,
291, 321, 322, 291, 322, 292,
321, 351, 352, 321, 352, 322,
351, 381, 382, 351, 382, 352,
381, 411, 412, 381, 412, 382,
411, 441, 442, 411, 442, 412,
441, 471, 472, 441, 472, 442,
471, 501, 502, 471, 502, 472,
501, 531, 532, 501, 532, 502,
531, 561, 562, 531, 562, 532,
561, 591, 592, 561, 592, 562,
591, 621, 622, 591, 622, 592,
621, 651, 652, 621, 652, 622,
651, 681, 682, 651, 682, 652,
681, 711, 712, 681, 712, 682,
711, 741, 742, 711, 742, 712,
741, 771, 772, 741, 772, 742,
771, 801, 802, 771, 802, 772,
801, 831, 832, 801, 832, 802,
831, 861, 862, 831, 862, 832,
861, 891, 892, 861, 892, 862,
22, 52, 53, 22, 53, 23,
52, 82, 83, 52, 83, 53,
82, 112, 113, 82, 113, 83,
112, 142, 143, 112, 143, 113,
142, 172, 173, 142, 173, 143,
172, 202, 203, 172, 203, 173,
202, 232, 233, 202, 233, 203,
232, 262, 263, 232, 263, 233,
262, 292, 293, 262, 293, 263,
292, 322, 323, 292, 323, 293,
322, 352, 353, 322, 353, 323,
352, 382, 383, 352, 383, 353,
382, 412, 413, 382, 413, 383,
412, 442, 443, 412, 443, 413,
442, 472, 473, 442, 473, 443,
472, 502, 503, 472, 503, 473,
502, 532, 533, 502, 533, 503,
532, 562, 563, 532, 563, 533,
562, 592, 593, 562, 593, 563,
592, 622, 623, 592, 623, 593,
622, 652, 653, 622, 653, 623,
652, 682, 683, 652, 683, 653,
682, 712, 713, 682, 713, 683,
712, 742, 743, 712, 743, 713,
742, 772, 773, 742, 773, 743,
772, 802, 803, 772, 803, 773,
802, 832, 833, 802, 833, 803,
832, 862, 863, 832, 863, 833,
862, 892, 893, 862, 893, 863,
23, 53, 54, 23, 54, 24,
53, 83, 84, 53, 84, 54,
83, 113, 114, 83, 114, 84,
113, 143, 144, 113, 144, 114,
143, 173, 174, 143, 174, 144,
173, 203, 204, 173, 204, 174,
203, 233, 234, 203, 234, 204,
233, 263, 264, 233, 264, 234,
263, 293, 294, 263, 294, 264,
293, 323, 324, 293, 324, 294,
323, 353, 354, 323, 354, 324,
353, 383, 384, 353, 384, 354,
383, 413, 414, 383, 414, 384,
413, 443, 444, 413, 444, 414,
443, 473, 474, 443, 474, 444,
473, 503, 504, 473, 504, 474,
503, 533, 534, 503, 534, 504,
533, 563, 564, 533, 564, 534,
563, 593, 594, 563, 594, 564,
593, 623, 624, 593, 624, 594,
623, 653, 654, 623, 654, 624,
653, 683, 684, 653, 684, 654,
683, 713, 714, 683, 714, 684,
713, 743, 744, 713, 744, 714,
743, 773, 774, 743, 774, 744,
773, 803, 804, 773, 804, 774,
803, 833, 834, 803, 834, 804,
833, 863, 864, 833, 864, 834,
863, 893, 894, 863, 894, 864,
24, 54, 55, 24, 55, 25,
54, 84, 85, 54, 85, 55,
84, 114, 115, 84, 115, 85,
114, 144, 145, 114, 145, 115,
144, 174, 175, 144, 175, 145,
174, 204, 205, 174, 205, 175,
204, 234, 235, 204, 235, 205,
234, 264, 265, 234, 265, 235,
264, 294, 295, 264, 295, 265,
294, 324, 325, 294, 325, 295,
324, 354, 355, 324, 355, 325,
354, 384, 385, 354, 385, 355,
384, 414, 415, 384, 415, 385,
414, 444, 445, 414, 445, 415,
444, 474, 475, 444, 475, 445,
474, 504, 505, 474, 505, 475,
504, 534, 535, 504, 535, 505,
534, 564, 565, 534, 565, 535,
564, 594, 595, 564, 595, 565,
594, 624, 625, 594, 625, 595,
624, 654, 655, 624, 655, 625,
654, 684, 685, 654, 685, 655,
684, 714, 715, 684, 715, 685,
714, 744, 745, 714, 745, 715,
744, 774, 775, 744, 775, 745,
774, 804, 805, 774, 805, 775,
804, 834, 835, 804, 835, 805,
834, 864, 865, 834, 865, 835,
864, 894, 895, 864, 895, 865,
25, 55, 56, 25, 56, 26,
55, 85, 86, 55, 86, 56,
85, 115, 116, 85, 116, 86,
115, 145, 146, 115, 146, 116,
145, 175, 176, 145, 176, 146,
175, 205, 206, 175, 206, 176,
205, 235, 236, 205, 236, 206,
235, 265, 266, 235, 266, 236,
265, 295, 296, 265, 296, 266,
295, 325, 326, 295, 326, 296,
325, 355, 356, 325, 356, 326,
355, 385, 386, 355, 386, 356,
385, 415, 416, 385, 416, 386,
415, 445, 446, 415, 446, 416,
445, 475, 476, 445, 476, 446,
475, 505, 506, 475, 506, 476,
505, 535, 536, 505, 536, 506,
535, 565, 566, 535, 566, 536,
565, 595, 596, 565, 596, 566,
595, 625, 626, 595, 626, 596,
625, 655, 656, 625, 656, 626,
655, 685, 686, 655, 686, 656,
685, 715, 716, 685, 716, 686,
715, 745, 746, 715, 746, 716,
745, 775, 776, 745, 776, 746,
775, 805, 806, 775, 806, 776,
805, 835, 836, 805, 836, 806,
835, 865, 866, 835, 866, 836,
865, 895, 896, 865, 896, 866,
26, 56, 57, 26, 57, 27,
56, 86, 87, 56, 87, 57,
86, 116, 117, 86, 117, 87,
116, 146, 147, 116, 147, 117,
146, 176, 177, 146, 177, 147,
176, 206, 207, 176, 207, 177,
206, 236, 237, 206, 237, 207,
236, 266, 267, 236, 267, 237,
266, 296, 297, 266, 297, 267,
296, 326, 327, 296, 327, 297,
326, 356, 357, 326, 357, 327,
356, 386, 387, 356, 387, 357,
386, 416, 417, 386, 417, 387,
416, 446, 447, 416, 447, 417,
446, 476, 477, 446, 477, 447,
476, 506, 507, 476, 507, 477,
506, 536, 537, 506, 537, 507,
536, 566, 567, 536, 567, 537,
566, 596, 597, 566, 597, 567,
596, 626, 627, 596, 627, 597,
626, 656, 657, 626, 657, 627,
656, 686, 687, 656, 687, 657,
686, 716, 717, 686, 717, 687,
716, 746, 747, 716, 747, 717,
746, 776, 777, 746, 777, 747,
776, 806, 807, 776, 807, 777,
806, 836, 837, 806, 837, 807,
836, 866, 867, 836, 867, 837,
866, 896, 897, 866, 897, 867,
27, 57, 58, 27, 58, 28,
57, 87, 88, 57, 88, 58,
87, 117, 118, 87, 118, 88,
117, 147, 148, 117, 148, 118,
147, 177, 178, 147, 178, 148,
177, 207, 208, 177, 208, 178,
207, 237, 238, 207, 238, 208,
237, 267, 268, 237, 268, 238,
267, 297, 298, 267, 298, 268,
297, 327, 328, 297, 328, 298,
327, 357, 358, 327, 358, 328,
357, 387, 388, 357, 388, 358,
387, 417, 418, 387, 418, 388,
417, 447, 448, 417, 448, 418,
447, 477, 478, 447, 478, 448,
477, 507, 508, 477, 508, 478,
507, 537, 538, 507, 538, 508,
537, 567, 568, 537, 568, 538,
567, 597, 598, 567, 598, 568,
597, 627, 628, 597, 628, 598,
627, 657, 658, 627, 658, 628,
657, 687, 688, 657, 688, 658,
687, 717, 718, 687, 718, 688,
717, 747, 748, 717, 748, 718,
747, 777, 778, 747, 778, 748,
777, 807, 808, 777, 808, 778,
807, 837, 838, 807, 838, 808,
837, 867, 868, 837, 868, 838,
867, 897, 898, 867, 898, 868,
28, 58, 59, 28, 59, 29,
58, 88, 89, 58, 89, 59,
88, 118, 119, 88, 119, 89,
118, 148, 149, 118, 149, 119,
148, 178, 179, 148, 179, 149,
178, 208, 209, 178, 209, 179,
208, 238, 239, 208, 239, 209,
238, 268, 269, 238, 269, 239,
268, 298, 299, 268, 299, 269,
298, 328, 329, 298, 329, 299,
328, 358, 359, 328, 359, 329,
358, 388, 389, 358, 389, 359,
388, 418, 419, 388, 419, 389,
418, 448, 449, 418, 449, 419,
448, 478, 479, 448, 479, 449,
478, 508, 509, 478, 509, 479,
508, 538, 539, 508, 539, 509,
538, 568, 569, 538, 569, 539,
568, 598, 599, 568, 599, 569,
598, 628, 629, 598, 629, 599,
628, 658, 659, 628, 659, 629,
658, 688, 689, 658, 689, 659,
688, 718, 719, 688, 719, 689,
718, 748, 749, 718, 749, 719,
748, 778, 779, 748, 779, 749,
778, 808, 809, 778, 809, 779,
808, 838, 839, 808, 839, 809,
838, 868, 869, 838, 869, 839,
868, 898, 899, 868, 899, 869
]);
this.buf[27] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[27]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[27], gl.STATIC_DRAW);
this.ibuf[27] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[27]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[27] = gl.getUniformLocation(this.prog[27],"mvMatrix");
this.prMatLoc[27] = gl.getUniformLocation(this.prog[27],"prMatrix");
this.normMatLoc[27] = gl.getUniformLocation(this.prog[27],"normMatrix");
// ****** text object 29 ******
this.flags[29] = 40;
this.vshaders[29] = "	/* ****** text object 29 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[29] = "	/* ****** text object 29 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[29]  = gl.createProgram();
gl.attachShader(this.prog[29], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[29] ));
gl.attachShader(this.prog[29], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[29] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[29], 0, "aPos");
gl.bindAttribLocation(this.prog[29], 1, "aCol");
gl.linkProgram(this.prog[29]);
texts = [
"shape"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[29] = gl.getAttribLocation(this.prog[29], "aOfs");
this.texture[29] = gl.createTexture();
this.texLoc[29] = gl.getAttribLocation(this.prog[29], "aTexcoord");
this.sampler[29] = gl.getUniformLocation(this.prog[29],"uSampler");
handleLoadedTexture(this.texture[29], document.getElementById("persp3dtextureCanvas"));
this.offsets[29]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
6.486866, 0.03170295, -1102.303, 0, -0.5, 0.5, 0.5,
6.486866, 0.03170295, -1102.303, 1, -0.5, 0.5, 0.5,
6.486866, 0.03170295, -1102.303, 1, 1.5, 0.5, 0.5,
6.486866, 0.03170295, -1102.303, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[29].stride*(4*i + j) + this.offsets[29].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[29] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[29] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[29]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[29], gl.STATIC_DRAW);
this.ibuf[29] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[29]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[29] = gl.getUniformLocation(this.prog[29],"mvMatrix");
this.prMatLoc[29] = gl.getUniformLocation(this.prog[29],"prMatrix");
this.textScaleLoc[29] = gl.getUniformLocation(this.prog[29],"textScale");
// ****** text object 30 ******
this.flags[30] = 40;
this.vshaders[30] = "	/* ****** text object 30 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[30] = "	/* ****** text object 30 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[30]  = gl.createProgram();
gl.attachShader(this.prog[30], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[30] ));
gl.attachShader(this.prog[30], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[30] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[30], 0, "aPos");
gl.bindAttribLocation(this.prog[30], 1, "aCol");
gl.linkProgram(this.prog[30]);
texts = [
"rate"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[30] = gl.getAttribLocation(this.prog[30], "aOfs");
this.texture[30] = gl.createTexture();
this.texLoc[30] = gl.getAttribLocation(this.prog[30], "aTexcoord");
this.sampler[30] = gl.getUniformLocation(this.prog[30],"uSampler");
handleLoadedTexture(this.texture[30], document.getElementById("persp3dtextureCanvas"));
this.offsets[30]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
1.696515, 0.1365101, -1102.303, 0, -0.5, 0.5, 0.5,
1.696515, 0.1365101, -1102.303, 1, -0.5, 0.5, 0.5,
1.696515, 0.1365101, -1102.303, 1, 1.5, 0.5, 0.5,
1.696515, 0.1365101, -1102.303, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[30].stride*(4*i + j) + this.offsets[30].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[30] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[30] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[30]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[30], gl.STATIC_DRAW);
this.ibuf[30] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[30]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[30] = gl.getUniformLocation(this.prog[30],"mvMatrix");
this.prMatLoc[30] = gl.getUniformLocation(this.prog[30],"prMatrix");
this.textScaleLoc[30] = gl.getUniformLocation(this.prog[30],"textScale");
// ****** text object 31 ******
this.flags[31] = 40;
this.vshaders[31] = "	/* ****** text object 31 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[31] = "	/* ****** text object 31 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[31]  = gl.createProgram();
gl.attachShader(this.prog[31], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[31] ));
gl.attachShader(this.prog[31], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[31] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[31], 0, "aPos");
gl.bindAttribLocation(this.prog[31], 1, "aCol");
gl.linkProgram(this.prog[31]);
texts = [
"loglik"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[31] = gl.getAttribLocation(this.prog[31], "aOfs");
this.texture[31] = gl.createTexture();
this.texLoc[31] = gl.getAttribLocation(this.prog[31], "aTexcoord");
this.sampler[31] = gl.getUniformLocation(this.prog[31],"uSampler");
handleLoadedTexture(this.texture[31], document.getElementById("persp3dtextureCanvas"));
this.offsets[31]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
1.696515, 0.03170295, -716.9673, 0, -0.5, 0.5, 0.5,
1.696515, 0.03170295, -716.9673, 1, -0.5, 0.5, 0.5,
1.696515, 0.03170295, -716.9673, 1, 1.5, 0.5, 0.5,
1.696515, 0.03170295, -716.9673, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[31].stride*(4*i + j) + this.offsets[31].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[31] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[31] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[31]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[31], gl.STATIC_DRAW);
this.ibuf[31] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[31]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[31] = gl.getUniformLocation(this.prog[31],"mvMatrix");
this.prMatLoc[31] = gl.getUniformLocation(this.prog[31],"prMatrix");
this.textScaleLoc[31] = gl.getUniformLocation(this.prog[31],"textScale");
// ****** clipplanes object 33 ******
this.flags[33] = 2048;
this.vClipplane[33]=[
0, 0, 1, 433.7844,
0, 0, -1, -429.1792
];
// ****** surface object 34 ******
this.flags[34] = 11;
this.vshaders[34] = "	/* ****** surface object 34 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[34] = "	/* ****** surface object 34 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	uniform vec4 vClipplane1;\n	uniform vec4 vClipplane2;\n	void main(void) {\n	  if (dot(vPosition, vClipplane1) < 0.0) discard;\n	  if (dot(vPosition, vClipplane2) < 0.0) discard;\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[34]  = gl.createProgram();
gl.attachShader(this.prog[34], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[34] ));
gl.attachShader(this.prog[34], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[34] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[34], 0, "aPos");
gl.bindAttribLocation(this.prog[34], 1, "aCol");
gl.linkProgram(this.prog[34]);
this.offsets[34]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
2.909307, 0.0582374, -442.918, -0.1733823, -0.9846532, 0.01991898,
3.156036, 0.0582374, -442.828, -0.006314733, -0.9999165, 0.0112765,
3.402764, 0.0582374, -445.0072, 0.01110619, -0.9999374, 0.001380169,
3.649492, 0.0582374, -449.266, 0.01391447, -0.9999029, 0.0008538322,
3.89622, 0.0582374, -455.4438, 0.0149837, -0.9998875, 0.0006270157,
4.142948, 0.0582374, -463.403, 0.01538958, -0.9998815, 0.0004973433,
4.389677, 0.0582374, -473.0242, 0.01548466, -0.9998801, 0.0004127407,
4.636405, 0.0582374, -484.203, 0.01541809, -0.9998811, 0.0003529912,
4.883132, 0.0582374, -496.8474, 0.01526284, -0.9998835, 0.0003084721,
5.129861, 0.0582374, -510.8753, 0.01505807, -0.9998866, 0.0002739869,
5.376589, 0.0582374, -526.2137, 0.01482602, -0.9998901, 0.0002464719,
5.623317, 0.0582374, -542.7966, 0.01458001, -0.9998938, 0.0002239998,
5.870045, 0.0582374, -560.5645, 0.01432824, -0.9998974, 0.0002052962,
6.116773, 0.0582374, -579.463, 0.01407576, -0.9999009, 0.0001894841,
6.363502, 0.0582374, -599.4429, 0.01382584, -0.9999044, 0.0001759393,
6.610229, 0.0582374, -620.4588, 0.01358046, -0.9999079, 0.0001642057,
6.856958, 0.0582374, -642.4691, 0.01334087, -0.999911, 0.0001539422,
7.103686, 0.0582374, -665.4352, 0.01310784, -0.9999142, 0.0001448885,
7.350414, 0.0582374, -689.3216, 0.0128817, -0.9999171, 0.0001368422,
7.597142, 0.0582374, -714.0953, 0.01266264, -0.9999198, 0.0001296436,
7.84387, 0.0582374, -739.7254, 0.01245071, -0.9999225, 0.0001231655,
8.090598, 0.0582374, -766.1834, 0.01224574, -0.9999251, 0.0001173047,
8.337327, 0.0582374, -793.4423, 0.01204764, -0.9999275, 0.000111977,
8.584055, 0.0582374, -821.4771, 0.01185622, -0.9999298, 0.0001071126,
8.830783, 0.0582374, -850.264, 0.01167119, -0.999932, 0.0001026536,
9.077511, 0.0582374, -879.7809, 0.01149233, -0.999934, 9.855122e-05,
9.324239, 0.0582374, -910.0068, 0.01131938, -0.999936, 9.476439e-05,
9.570968, 0.0582374, -940.9219, 0.01115215, -0.9999378, 9.125804e-05,
9.817696, 0.0582374, -972.5074, 0.01099038, -0.9999396, 8.80021e-05,
10.06442, 0.0582374, -1004.746, 0.01091729, -0.9999405, 8.643325e-05,
2.909307, 0.06363552, -442.7806, -0.4404045, -0.8953233, 0.06663439,
3.156036, 0.06363552, -440.5035, -0.3564373, -0.9337018, 0.03396469,
3.402764, 0.06363552, -440.4956, 0.003059807, -0.9998619, 0.01634069,
3.649492, 0.06363552, -442.5673, 0.01267542, -0.9999191, 0.001198615,
3.89622, 0.06363552, -446.558, 0.01463138, -0.9998927, 0.0007852869,
4.142948, 0.06363552, -452.3301, 0.01537442, -0.9998817, 0.0005936368,
4.389677, 0.06363552, -459.7642, 0.01562779, -0.9998778, 0.0004793614,
4.636405, 0.06363552, -468.756, 0.01564475, -0.9998776, 0.0004027161,
4.883132, 0.06363552, -479.2132, 0.01553667, -0.9998793, 0.0003475111,
5.129861, 0.06363552, -491.0541, 0.01535957, -0.999882, 0.0003057659,
5.376589, 0.06363552, -504.2054, 0.01514392, -0.9998854, 0.0002730539,
5.623317, 0.06363552, -518.6012, 0.01490744, -0.9998889, 0.0002467106,
5.870045, 0.06363552, -534.1819, 0.01466086, -0.9998925, 0.0002250308,
6.116773, 0.06363552, -550.8934, 0.01441074, -0.9998962, 0.0002068713,
6.363502, 0.06363552, -568.6862, 0.01416126, -0.9998997, 0.0001914355,
6.610229, 0.06363552, -587.515, 0.01391504, -0.9999031, 0.0001781513,
6.856958, 0.06363552, -607.3381, 0.01367375, -0.9999065, 0.0001665966,
7.103686, 0.06363552, -628.1171, 0.01343839, -0.9999097, 0.0001564537,
7.350414, 0.06363552, -649.8165, 0.0132095, -0.9999128, 0.0001474779,
7.597142, 0.06363552, -672.403, 0.01298742, -0.9999157, 0.0001394783,
7.84387, 0.06363552, -695.8461, 0.01277228, -0.9999185, 0.0001323037,
8.090598, 0.06363552, -720.1169, 0.01256399, -0.9999211, 0.0001258323,
8.337327, 0.06363552, -745.1888, 0.0123625, -0.9999236, 0.0001199655,
8.584055, 0.06363552, -771.0364, 0.01216766, -0.999926, 0.0001146223,
8.830783, 0.06363552, -797.6363, 0.01197921, -0.9999283, 0.0001097353,
9.077511, 0.06363552, -824.9661, 0.01179694, -0.9999305, 0.0001052486,
9.324239, 0.06363552, -853.0048, 0.01162064, -0.9999325, 0.0001011147,
9.570968, 0.06363552, -881.7328, 0.01145008, -0.9999344, 9.729365e-05,
9.817696, 0.06363552, -911.1313, 0.01128504, -0.9999364, 9.375121e-05,
10.06442, 0.06363552, -941.1826, 0.0112041, -0.9999373, 9.204566e-05,
2.909307, 0.06903364, -444.7443, -0.3665033, 0.930172, 0.02133924,
3.156036, 0.06903364, -440.4583, -0.6675006, 0.7352419, 0.1177378,
3.402764, 0.06903364, -438.4415, -0.6590972, -0.7485873, 0.07216562,
3.649492, 0.06903364, -438.5043, 0.01219323, -0.9995008, 0.02914364,
3.89622, 0.06903364, -440.4861, 0.01333859, -0.9999102, 0.001329768,
4.142948, 0.06903364, -444.2493, 0.01513546, -0.9998852, 0.000862965,
4.389677, 0.06903364, -449.6745, 0.01582005, -0.9998747, 0.0006500814,
4.636405, 0.06903364, -456.6573, 0.01604742, -0.9998711, 0.000523932,
4.883132, 0.06903364, -465.1056, 0.01605271, -0.9998711, 0.0004396146,
5.129861, 0.06903364, -474.9376, 0.01594008, -0.999873, 0.0003790198,
5.376589, 0.06903364, -486.08, 0.01576199, -0.9998757, 0.000333272,
5.623317, 0.06903364, -498.4668, 0.01554718, -0.9998792, 0.0002974669,
5.870045, 0.06903364, -512.0386, 0.01531247, -0.9998828, 0.0002686595,
6.116773, 0.06903364, -526.7412, 0.01506793, -0.9998865, 0.0002449697,
6.363502, 0.06903364, -542.5251, 0.0148199, -0.9998902, 0.0002251388,
6.610229, 0.06903364, -559.345, 0.01457235, -0.9998938, 0.0002082911,
6.856958, 0.06903364, -577.1592, 0.01432787, -0.9998974, 0.000193798,
7.103686, 0.06903364, -595.9293, 0.01408804, -0.9999008, 0.0001811968,
7.350414, 0.06903364, -615.6198, 0.0138538, -0.999904, 0.0001701388,
7.597142, 0.06903364, -636.1974, 0.01362581, -0.9999072, 0.0001603563,
7.84387, 0.06903364, -657.6315, 0.01340436, -0.9999102, 0.0001516399,
8.090598, 0.06903364, -679.8935, 0.01318952, -0.999913, 0.0001438241,
8.337327, 0.06903364, -702.9564, 0.01298135, -0.9999158, 0.0001367759,
8.584055, 0.06903364, -726.7952, 0.01277977, -0.9999184, 0.0001303873,
8.830783, 0.06903364, -751.3861, 0.01258458, -0.9999209, 0.0001245699,
9.077511, 0.06903364, -776.707, 0.01239561, -0.9999232, 0.00011925,
9.324239, 0.06903364, -802.7368, 0.01221267, -0.9999255, 0.0001143665,
9.570968, 0.06903364, -829.4559, 0.01203557, -0.9999276, 0.0001098677,
9.817696, 0.06903364, -856.8455, 0.01186408, -0.9999297, 0.0001057099,
10.06442, 0.06903364, -884.8879, 0.01177998, -0.9999307, 0.0001037111,
2.909307, 0.07443175, -448.4924, -0.04158115, 0.9991336, 0.001706959,
3.156036, 0.07443175, -442.3488, -0.160208, 0.9870341, 0.009851196,
3.402764, 0.07443175, -438.4744, -0.2329365, 0.9708249, 0.05691927,
3.649492, 0.07443175, -436.6796, -0.9315635, -0.344452, 0.1163714,
3.89622, 0.07443175, -436.8038, 0.01058928, -0.9998778, 0.01149942,
4.142948, 0.07443175, -438.7094, 0.01403513, -0.9999005, 0.001467471,
4.389677, 0.07443175, -442.277, 0.01564566, -0.9998772, 0.0009427461,
4.636405, 0.07443175, -447.4023, 0.01626107, -0.9998676, 0.0007076225,
4.883132, 0.07443175, -453.993, 0.01645586, -0.9998645, 0.000569186,
5.129861, 0.07443175, -461.9673, 0.01644497, -0.9998647, 0.0004769824,
5.376589, 0.07443175, -471.2521, 0.01632439, -0.9998667, 0.0004108718,
5.623317, 0.07443175, -481.7815, 0.01614276, -0.9998696, 0.0003610406,
5.870045, 0.07443175, -493.4957, 0.01592689, -0.9998732, 0.0003220866,
6.116773, 0.07443175, -506.3406, 0.01569241, -0.9998769, 0.0002907756,
6.363502, 0.07443175, -520.267, 0.01544883, -0.9998807, 0.0002650466,
6.610229, 0.07443175, -535.2292, 0.01520202, -0.9998845, 0.0002435223,
6.856958, 0.07443175, -551.1859, 0.01495584, -0.9998882, 0.0002252453,
7.103686, 0.07443175, -568.0984, 0.01471266, -0.9998918, 0.00020953,
7.350414, 0.07443175, -585.9312, 0.01447394, -0.9998952, 0.0001958714,
7.597142, 0.07443175, -604.6513, 0.01424071, -0.9998987, 0.0001838894,
7.84387, 0.07443175, -624.2279, 0.01401353, -0.9999018, 0.0001732924,
8.090598, 0.07443175, -644.6323, 0.01379262, -0.9999049, 0.000163853,
8.337327, 0.07443175, -665.8376, 0.01357819, -0.9999079, 0.0001553907,
8.584055, 0.07443175, -687.8187, 0.01337025, -0.9999107, 0.0001477611,
8.830783, 0.07443175, -710.5521, 0.01316866, -0.9999133, 0.0001408469,
9.077511, 0.07443175, -734.0154, 0.01297332, -0.9999158, 0.0001345519,
9.324239, 0.07443175, -758.1876, 0.01278403, -0.9999183, 0.0001287963,
9.570968, 0.07443175, -783.0491, 0.01260067, -0.9999207, 0.0001235135,
9.817696, 0.07443175, -808.5811, 0.012423, -0.9999229, 0.0001186474,
10.06442, 0.07443175, -834.7659, 0.01233587, -0.999924, 0.0001163122,
2.909307, 0.07982987, -453.7747, -0.03489903, 0.9993902, 0.001108189,
3.156036, 0.07982987, -445.9037, -0.03704328, 0.9993126, 0.001446361,
3.402764, 0.07982987, -440.3018, -0.1097788, 0.9939289, 0.007334975,
3.649492, 0.07982987, -436.7795, -0.1250741, 0.9918209, 0.02544901,
3.89622, 0.07982987, -435.1763, -0.9750286, -0.1738242, 0.1382182,
4.142948, 0.07982987, -435.3544, 0.01092478, -0.9999043, 0.008479643,
4.389677, 0.07982987, -437.1945, 0.01476817, -0.9998897, 0.001612344,
4.636405, 0.07982987, -440.5923, 0.01616381, -0.9998689, 0.001024728,
4.883132, 0.07982987, -445.4556, 0.01669987, -0.9998603, 0.0007662957,
5.129861, 0.07982987, -451.7025, 0.01685612, -0.9998578, 0.0006151407,
5.376589, 0.07982987, -459.2598, 0.01682482, -0.9998584, 0.0005148292,
5.623317, 0.07982987, -468.0616, 0.01669315, -0.9998606, 0.0004430726,
5.870045, 0.07982987, -478.0484, 0.01650569, -0.9998637, 0.0003890747,
6.116773, 0.07982987, -489.1659, 0.01628695, -0.9998673, 0.0003469158,
6.363502, 0.07982987, -501.3647, 0.01605136, -0.9998712, 0.0003130611,
6.610229, 0.07982987, -514.5995, 0.01580762, -0.9998751, 0.0002852635,
6.856958, 0.07982987, -528.8287, 0.01556128, -0.9998789, 0.0002620232,
7.103686, 0.07982987, -544.0137, 0.01531584, -0.9998828, 0.0002422997,
7.350414, 0.07982987, -560.1191, 0.01507343, -0.9998864, 0.0002253482,
7.597142, 0.07982987, -577.1117, 0.01483554, -0.9998899, 0.0002106209,
7.84387, 0.07982987, -594.9608, 0.01460309, -0.9998934, 0.0001977058,
8.090598, 0.07982987, -613.6378, 0.01437649, -0.9998966, 0.0001862869,
8.337327, 0.07982987, -633.1156, 0.01415612, -0.9998998, 0.000176118,
8.584055, 0.07982987, -653.3693, 0.0139421, -0.9999028, 0.000167004,
8.830783, 0.07982987, -674.3751, 0.01373437, -0.9999058, 0.0001587885,
9.077511, 0.07982987, -696.111, 0.01353287, -0.9999084, 0.0001513447,
9.324239, 0.07982987, -718.5558, 0.01333746, -0.9999111, 0.0001445687,
9.570968, 0.07982987, -741.6898, 0.01314802, -0.9999136, 0.0001383743,
9.817696, 0.07982987, -765.4943, 0.01296438, -0.999916, 0.0001326895,
10.06442, 0.07982987, -789.9516, 0.01287431, -0.9999171, 0.0001299664,
2.909307, 0.08522799, -460.3904, -0.03286642, 0.9994595, 0.0008619254,
3.156036, 0.08522799, -450.9049, -0.03318557, 0.9994488, 0.001014286,
3.402764, 0.08522799, -443.6887, -0.03554334, 0.999367, 0.001512567,
3.649492, 0.08522799, -438.552, -0.08119119, 0.9966813, 0.005854142,
3.89622, 0.08522799, -435.3344, -0.08704181, 0.9960423, 0.01798728,
4.142948, 0.08522799, -433.8981, -0.9796101, -0.1190136, 0.1618639,
4.389677, 0.08522799, -434.1238, 0.01156124, -0.9999058, 0.007392605,
4.636405, 0.08522799, -435.9072, 0.01554139, -0.9998777, 0.001765108,
4.883132, 0.08522799, -439.1561, 0.01669141, -0.9998602, 0.001109007,
5.129861, 0.08522799, -443.7886, 0.01713837, -0.9998528, 0.0008261368,
5.376589, 0.08522799, -449.7315, 0.01725041, -0.9998511, 0.0006618132,
5.623317, 0.08522799, -456.9189, 0.01719479, -0.9998521, 0.000553165,
5.870045, 0.08522799, -465.2913, 0.01704931, -0.9998546, 0.0004756291,
6.116773, 0.08522799, -474.7944, 0.01685386, -0.999858, 0.0004173799,
6.363502, 0.08522799, -485.3788, 0.01663059, -0.9998617, 0.0003719582,
6.610229, 0.08522799, -496.9993, 0.01639254, -0.9998657, 0.0003355188,
6.856958, 0.08522799, -509.614, 0.01614769, -0.9998696, 0.0003056224,
7.103686, 0.08522799, -523.1847, 0.01590102, -0.9998736, 0.0002806433,
7.350414, 0.08522799, -537.6757, 0.01565561, -0.9998775, 0.0002594554,
7.597142, 0.08522799, -553.0539, 0.01541355, -0.9998812, 0.0002412537,
7.84387, 0.08522799, -569.2886, 0.01517616, -0.9998848, 0.0002254463,
8.090598, 0.08522799, -586.3511, 0.01494413, -0.9998884, 0.0002115888,
8.337327, 0.08522799, -604.2146, 0.01471802, -0.9998918, 0.0001993405,
8.584055, 0.08522799, -622.8539, 0.01449808, -0.999895, 0.0001884357,
8.830783, 0.08522799, -642.2453, 0.01428434, -0.999898, 0.0001786645,
9.077511, 0.08522799, -662.3668, 0.01407682, -0.999901, 0.0001698584,
9.324239, 0.08522799, -683.1971, 0.0138754, -0.9999037, 0.0001618811,
9.570968, 0.08522799, -704.7168, 0.01368004, -0.9999064, 0.0001546207,
9.817696, 0.08522799, -726.9069, 0.01349052, -0.999909, 0.0001479845,
10.06442, 0.08522799, -749.7498, 0.01339759, -0.9999103, 0.0001448119,
2.909307, 0.09062611, -468.1755, -0.03209225, 0.9994847, 0.000723801,
3.156036, 0.09062611, -457.1748, -0.03192701, 0.99949, 0.0008156221,
3.402764, 0.09062611, -448.4434, -0.03211552, 0.9994836, 0.001065454,
3.649492, 0.09062611, -441.7915, -0.03415856, 0.9994152, 0.0015763,
3.89622, 0.09062611, -437.0586, -0.06542395, 0.9978446, 0.005077059,
4.142948, 0.09062611, -434.1071, -0.06796914, 0.9975797, 0.01466025,
4.389677, 0.09062611, -432.8177, -0.9773642, -0.0909239, 0.1910292,
4.636405, 0.09062611, -433.0858, 0.01233514, -0.9998997, 0.006952934,
4.883132, 0.09062611, -434.8195, 0.01635944, -0.9998643, 0.001926618,
5.129861, 0.09062611, -437.9367, 0.01722991, -0.9998509, 0.001195695,
5.376589, 0.09062611, -442.3644, 0.01757808, -0.9998452, 0.0008871827,
5.623317, 0.09062611, -448.0367, 0.0176405, -0.9998443, 0.0007092215,
5.870045, 0.09062611, -454.8938, 0.01755709, -0.9998457, 0.0005919999,
6.116773, 0.09062611, -462.8817, 0.01739512, -0.9998487, 0.0005085473,
6.363502, 0.09062611, -471.9509, 0.01718963, -0.9998522, 0.0004459589,
6.610229, 0.09062611, -482.0561, 0.01696029, -0.9998561, 0.0003972156,
6.856958, 0.09062611, -493.1557, 0.01671864, -0.9998603, 0.0003581501,
7.103686, 0.09062611, -505.2112, 0.01647168, -0.9998643, 0.0003261241,
7.350414, 0.09062611, -518.1869, 0.01622383, -0.9998683, 0.000299383,
7.597142, 0.09062611, -532.0499, 0.01597791, -0.9998723, 0.000276713,
7.84387, 0.09062611, -546.7693, 0.01573576, -0.9998763, 0.0002572469,
8.090598, 0.09062611, -562.3167, 0.01549841, -0.9998799, 0.0002403481,
8.337327, 0.09062611, -578.6649, 0.0152666, -0.9998835, 0.0002255389,
8.584055, 0.09062611, -595.789, 0.01504077, -0.9998869, 0.0002124532,
8.830783, 0.09062611, -613.6652, 0.01482106, -0.9998901, 0.0002008062,
9.077511, 0.09062611, -632.2714, 0.01460754, -0.9998933, 0.0001903723,
9.324239, 0.09062611, -651.5866, 0.01440015, -0.9998963, 0.0001809711,
9.570968, 0.09062611, -671.5911, 0.01419887, -0.9998993, 0.0001724563,
9.817696, 0.09062611, -692.266, 0.01400352, -0.999902, 0.0001647079,
10.06442, 0.09062611, -713.5936, 0.01390775, -0.9999033, 0.0001610119,
2.909307, 0.09602423, -476.9947, -0.03184158, 0.9994928, 0.0006346626,
3.156036, 0.09602423, -464.5665, -0.0314744, 0.9995044, 0.0006978182,
3.402764, 0.09602423, -454.4075, -0.03099347, 0.9995192, 0.0008565079,
3.649492, 0.09602423, -446.3281, -0.03112755, 0.9995149, 0.00111539,
3.89622, 0.09602423, -440.1677, -0.03287223, 0.9994582, 0.001637746,
4.142948, 0.09602423, -435.7887, -0.05556506, 0.9984444, 0.004631756,
4.389677, 0.09602423, -433.0717, -0.05627217, 0.9983333, 0.01281051,
4.636405, 0.09602423, -431.9123, -0.9709981, -0.07372162, 0.2274372,
4.883132, 0.09602423, -432.2184, 0.01320791, -0.9998895, 0.006818702,
5.129861, 0.09602423, -433.9082, 0.01722731, -0.9998494, 0.002097878,
5.376589, 0.09602423, -436.9084, 0.01778057, -0.9998411, 0.001284907,
5.623317, 0.09602423, -441.1531, 0.01802015, -0.9998372, 0.0009494702,
5.870045, 0.09602423, -446.5827, 0.01802794, -0.9998373, 0.0007573829,
6.116773, 0.09602423, -453.1431, 0.01791327, -0.9998394, 0.0006313428,
6.363502, 0.09602423, -460.7848, 0.01773236, -0.9998427, 0.0005418319,
6.610229, 0.09602423, -469.4624, 0.01751508, -0.9998466, 0.0004748162,
6.856958, 0.09602423, -479.1345, 0.01727824, -0.9998507, 0.0004226915,
7.103686, 0.09602423, -489.7624, 0.01703179, -0.9998549, 0.0003809571,
7.350414, 0.09602423, -501.3106, 0.01678178, -0.9998592, 0.0003467706,
7.597142, 0.09602423, -513.7461, 0.01653206, -0.9998633, 0.0003182441,
7.84387, 0.09602423, -527.038, 0.01628508, -0.9998674, 0.0002940737,
8.090598, 0.09602423, -541.1578, 0.01604227, -0.9998714, 0.0002733288,
8.337327, 0.09602423, -556.0786, 0.01580463, -0.9998751, 0.000255327,
8.584055, 0.09602423, -571.7751, 0.01557278, -0.9998787, 0.0002395565,
8.830783, 0.09602423, -588.2238, 0.01534697, -0.9998823, 0.0002256259,
9.077511, 0.09602423, -605.4025, 0.01512732, -0.9998856, 0.00021323,
9.324239, 0.09602423, -623.2902, 0.01491386, -0.9998888, 0.0002021279,
9.570968, 0.09602423, -641.8671, 0.01470658, -0.9998918, 0.0001921267,
9.817696, 0.09602423, -661.1144, 0.01450536, -0.9998948, 0.0001830703,
10.06442, 0.09602423, -681.0146, 0.01440676, -0.9998963, 0.0001787608,
2.909307, 0.1014223, -486.7347, -0.0318547, 0.9994924, 0.0005721606,
3.156036, 0.1014223, -472.9571, -0.03138298, 0.9995073, 0.0006191117,
3.402764, 0.1014223, -461.4487, -0.03059925, 0.9995315, 0.0007318093,
3.649492, 0.1014223, -452.0198, -0.03013733, 0.9995454, 0.0008966583,
3.89622, 0.1014223, -444.51, -0.0302082, 0.999543, 0.001164141,
4.142948, 0.1014223, -438.7816, -0.03167045, 0.9994971, 0.001697026,
4.389677, 0.1014223, -434.7151, -0.04873248, 0.9988024, 0.004355338,
4.636405, 0.1014223, -432.2063, -0.04821124, 0.9987691, 0.01165826,
4.883132, 0.1014223, -431.1631, -0.959832, -0.06211196, 0.2736143,
5.129861, 0.1014223, -431.5034, 0.01416968, -0.999876, 0.006864647,
5.376589, 0.1014223, -433.1541, 0.01815088, -0.9998327, 0.002280026,
5.623317, 0.1014223, -436.0494, 0.01834447, -0.9998308, 0.001376766,
5.870045, 0.1014223, -440.1296, 0.0184658, -0.9998291, 0.001013043,
6.116773, 0.1014223, -445.3405, 0.01841387, -0.9998301, 0.0008063175,
6.363502, 0.1014223, -451.6328, 0.01826483, -0.999833, 0.0006712065,
6.610229, 0.1014223, -458.9611, 0.01806275, -0.9998367, 0.0005754927,
6.856958, 0.1014223, -467.2837, 0.01783188, -0.999841, 0.0005039573,
7.103686, 0.1014223, -476.5622, 0.01758617, -0.9998453, 0.0004483893,
7.350414, 0.1014223, -486.761, 0.01733381, -0.9998497, 0.0004039432,
7.597142, 0.1014223, -497.847, 0.0170799, -0.9998541, 0.0003675642,
7.84387, 0.1014223, -509.7895, 0.01682765, -0.9998584, 0.0003372282,
8.090598, 0.1014223, -522.5599, 0.01657893, -0.9998626, 0.0003115387,
8.337327, 0.1014223, -536.1312, 0.01633506, -0.9998666, 0.0002895004,
8.584055, 0.1014223, -550.4783, 0.01609684, -0.9998704, 0.0002703841,
8.830783, 0.1014223, -565.5776, 0.01586458, -0.9998741, 0.000253643,
9.077511, 0.1014223, -581.4069, 0.01563851, -0.9998777, 0.0002388592,
9.324239, 0.1014223, -597.9451, 0.01541873, -0.9998811, 0.0002257078,
9.570968, 0.1014223, -615.1725, 0.01520527, -0.9998844, 0.000213932,
9.817696, 0.1014223, -633.0705, 0.014998, -0.9998875, 0.0002033262,
10.06442, 0.1014223, -651.6213, 0.01489648, -0.999889, 0.0001982929,
2.909307, 0.1068205, -497.3001, -0.03201561, 0.9994872, 0.0005258295,
3.156036, 0.1068205, -482.243, -0.03148216, 0.9995043, 0.0005625835,
3.402764, 0.1068205, -469.4552, -0.03053358, 0.9995335, 0.000648194,
3.649492, 0.1068205, -458.7469, -0.02980184, 0.9995556, 0.0007653105,
3.89622, 0.1068205, -449.9576, -0.02934523, 0.999569, 0.0009360959,
4.142948, 0.1068205, -442.9497, -0.02934699, 0.9995686, 0.001211752,
4.389677, 0.1068205, -437.6039, -0.03054275, 0.999532, 0.001754283,
4.636405, 0.1068205, -433.8156, -0.0436473, 0.9990383, 0.00417496,
4.883132, 0.1068205, -431.4929, -0.04222779, 0.9990487, 0.01089563,
5.129861, 0.1068205, -430.5538, -0.9412521, -0.05366032, 0.3334144,
5.376589, 0.1068205, -430.9251, 0.01522084, -0.9998594, 0.007034805,
5.623317, 0.1068205, -432.541, 0.01913793, -0.9998138, 0.002474523,
5.870045, 0.1068205, -435.3417, 0.01892287, -0.9998199, 0.001471407,
6.116773, 0.1068205, -439.2733, 0.01891579, -0.9998206, 0.001077942,
6.363502, 0.1068205, -444.2861, 0.01879941, -0.9998229, 0.0008560438,
6.610229, 0.1068205, -450.3349, 0.01861291, -0.9998266, 0.0007115997,
6.856958, 0.1068205, -457.3781, 0.01838743, -0.9998308, 0.0006095336,
7.103686, 0.1068205, -465.3771, 0.01814139, -0.9998353, 0.0005333852,
7.350414, 0.1068205, -474.2965, 0.01788548, -0.99984, 0.0004743118,
7.597142, 0.1068205, -484.1031, 0.01762622, -0.9998447, 0.0004271094,
7.84387, 0.1068205, -494.7662, 0.01736763, -0.9998491, 0.0003885059,
8.090598, 0.1068205, -506.2571, 0.01711209, -0.9998536, 0.0003563364,
8.337327, 0.1068205, -518.549, 0.01686118, -0.9998578, 0.0003291094,
8.584055, 0.1068205, -531.6166, 0.01661585, -0.999862, 0.0003057629,
8.830783, 0.1068205, -545.4365, 0.01637653, -0.9998659, 0.0002855197,
9.077511, 0.1068205, -559.9863, 0.01614355, -0.9998697, 0.000267798,
9.324239, 0.1068205, -575.2451, 0.01591704, -0.9998733, 0.0002521533,
9.570968, 0.1068205, -591.1932, 0.015697, -0.9998769, 0.0002382398,
9.817696, 0.1068205, -607.8117, 0.01548335, -0.9998802, 0.0002257845,
10.06442, 0.1068205, -625.083, 0.01537879, -0.9998817, 0.0002198912,
2.909307, 0.1122186, -508.6093, -0.03226484, 0.9994793, 0.0004900796,
3.156036, 0.1122186, -492.336, -0.03169144, 0.9994977, 0.0005199328,
3.402764, 0.1122186, -478.3318, -0.03064208, 0.9995303, 0.0005879991,
3.649492, 0.1122186, -466.4071, -0.02976374, 0.9995568, 0.000676927,
3.89622, 0.1122186, -456.4015, -0.0290684, 0.9995771, 0.0007983343,
4.142948, 0.1122186, -448.1773, -0.02860674, 0.9995903, 0.0009748395,
4.389677, 0.1122186, -441.6151, -0.02853582, 0.999592, 0.001258262,
4.636405, 0.1122186, -436.6105, -0.0294802, 0.9995638, 0.001809623,
4.883132, 0.1122186, -433.0714, -0.0396577, 0.9992051, 0.004053008,
5.129861, 0.1122186, -430.916, -0.03755139, 0.9992408, 0.0103748,
5.376589, 0.1122186, -430.071, -0.9097114, -0.04695949, 0.4125772,
5.623317, 0.1122186, -430.4704, 0.01636896, -0.9998394, 0.007303543,
5.870045, 0.1122186, -432.0548, 0.02019704, -0.9997925, 0.002683054,
6.116773, 0.1122186, -434.77, 0.0195169, -0.9998083, 0.001568982,
6.363502, 0.1122186, -438.5665, 0.01937115, -0.9998117, 0.001144216,
6.610229, 0.1122186, -443.399, 0.01918544, -0.9998156, 0.0009065851,
6.856958, 0.1122186, -449.2258, 0.01895849, -0.99982, 0.0007525359,
7.103686, 0.1122186, -456.0085, 0.0187076, -0.9998248, 0.0006439632,
7.350414, 0.1122186, -463.7115, 0.01844475, -0.9998298, 0.0005631058,
7.597142, 0.1122186, -472.3018, 0.01817747, -0.9998347, 0.0005004626,
7.84387, 0.1122186, -481.7485, 0.01791037, -0.9998396, 0.0004504592,
8.090598, 0.1122186, -492.0231, 0.01764622, -0.9998443, 0.0004095981,
8.337327, 0.1122186, -503.0986, 0.01738681, -0.9998488, 0.0003755699,
8.584055, 0.1122186, -514.95, 0.01713317, -0.9998532, 0.0003467859,
8.830783, 0.1122186, -527.5535, 0.0168858, -0.9998574, 0.000322116,
9.077511, 0.1122186, -540.8869, 0.01664511, -0.9998614, 0.0003007344,
9.324239, 0.1122186, -554.9294, 0.01641116, -0.9998653, 0.0002820227,
9.570968, 0.1122186, -569.6611, 0.01618397, -0.9998691, 0.0002655088,
9.817696, 0.1122186, -585.0632, 0.01596346, -0.9998726, 0.0002508263,
10.06442, 0.1122186, -601.1182, 0.01585566, -0.9998743, 0.0002439027,
2.909307, 0.1176167, -520.5926, -0.03256882, 0.9994695, 0.0004616408,
3.156036, 0.1176167, -503.16, -0.0319677, 0.9994889, 0.0004865693,
3.402764, 0.1176167, -487.9966, -0.03085141, 0.9995239, 0.0005425034,
3.649492, 0.1176167, -474.9128, -0.02988372, 0.9995533, 0.0006131505,
3.89622, 0.1176167, -463.748, -0.02905907, 0.9995775, 0.0007053154,
4.142948, 0.1176167, -454.3646, -0.02838822, 0.9995967, 0.0008308898,
4.389677, 0.1176167, -446.6432, -0.02791398, 0.9996098, 0.001012909,
4.636405, 0.1176167, -440.4794, -0.02776834, 0.9996136, 0.001303719,
4.883132, 0.1176167, -435.7812, -0.02847561, 0.9995928, 0.001863166,
5.129861, 0.1176167, -432.4665, -0.03640631, 0.9993293, 0.003969145,
5.376589, 0.1176167, -430.4623, -0.03375597, 0.9993799, 0.01001781,
5.623317, 0.1176167, -429.7026, -0.8537433, -0.04087403, 0.5190873,
5.870045, 0.1176167, -430.1278, 0.01762461, -0.9998154, 0.00765938,
6.116773, 0.1176167, -431.6838, 0.02133911, -0.9997681, 0.002907709,
6.363502, 0.1176167, -434.3211, 0.02012778, -0.9997961, 0.001669634,
6.610229, 0.1176167, -437.9944, 0.01983256, -0.9998026, 0.001211911,
6.856958, 0.1176167, -442.662, 0.01957266, -0.9998081, 0.0009579602,
7.103686, 0.1176167, -448.2855, 0.01930244, -0.9998134, 0.0007940245,
7.350414, 0.1176167, -454.8293, 0.01902408, -0.9998188, 0.000678788,
7.597142, 0.1176167, -462.2604, 0.01874297, -0.9998242, 0.000593123,
7.84387, 0.1176167, -470.548, 0.01846317, -0.9998294, 0.0005268441,
8.090598, 0.1176167, -479.6634, 0.01818724, -0.9998346, 0.0004739938,
8.337327, 0.1176167, -489.5797, 0.01791686, -0.9998394, 0.0004308418,
8.584055, 0.1176167, -500.2719, 0.01765296, -0.9998441, 0.0003949301,
8.830783, 0.1176167, -511.7162, 0.01739601, -0.9998487, 0.0003645702,
9.077511, 0.1176167, -523.8904, 0.01714632, -0.999853, 0.0003385622,
9.324239, 0.1176167, -536.7737, 0.01690385, -0.9998571, 0.0003160296,
9.570968, 0.1176167, -550.3462, 0.01666863, -0.9998611, 0.0002963176,
9.817696, 0.1176167, -564.5892, 0.01644055, -0.9998649, 0.0002789265,
10.06442, 0.1176167, -579.485, 0.01632917, -0.9998667, 0.0002707567,
2.909307, 0.1230148, -533.1893, -0.03290743, 0.9994583, 0.0004384704,
3.156036, 0.1230148, -514.6496, -0.03228593, 0.9994786, 0.0004597388,
3.402764, 0.1230148, -498.379, -0.03112227, 0.9995155, 0.0005068688,
3.649492, 0.1230148, -484.188, -0.03009545, 0.9995469, 0.0005648672,
3.89622, 0.1230148, -471.9161, -0.02919234, 0.9995737, 0.0006380415,
4.142948, 0.1230148, -461.4255, -0.02840864, 0.9995961, 0.0007333657,
4.389677, 0.1230148, -452.597, -0.02775315, 0.9996145, 0.0008629868,
4.636405, 0.1230148, -445.326, -0.0272605, 0.9996278, 0.00105032,
4.883132, 0.1230148, -439.5206, -0.02703914, 0.9996336, 0.001348154,
5.129861, 0.1230148, -435.0988, -0.02752276, 0.9996194, 0.001914994,
5.376589, 0.1230148, -431.9874, -0.03367636, 0.9994252, 0.003910942,
5.623317, 0.1230148, -430.1205, -0.0305871, 0.9994842, 0.009779655,
5.870045, 0.1230148, -429.4386, -0.7498045, -0.03405491, 0.6607825,
6.116773, 0.1230148, -429.8874, 0.01900242, -0.9997867, 0.008100312,
6.363502, 0.1230148, -431.4175, 0.02257804, -0.9997401, 0.003151136,
6.610229, 0.1230148, -433.9837, 0.0207565, -0.999783, 0.001773517,
6.856958, 0.1230148, -437.5441, 0.02030051, -0.9997932, 0.001281064,
7.103686, 0.1230148, -442.0605, 0.01996182, -0.9998003, 0.00101019,
7.350414, 0.1230148, -447.4972, 0.01964537, -0.9998067, 0.0008360768,
7.597142, 0.1230148, -453.821, 0.01933759, -0.9998127, 0.0007140119,
7.84387, 0.1230148, -461.0015, 0.01903686, -0.9998186, 0.0006234398,
8.090598, 0.1230148, -469.0097, 0.01874339, -0.9998242, 0.0005534593,
8.337327, 0.1230148, -477.8188, 0.01845783, -0.9998296, 0.0004977151,
8.584055, 0.1230148, -487.4038, 0.01818051, -0.9998347, 0.0004522386,
8.830783, 0.1230148, -497.741, 0.0179115, -0.9998396, 0.0004144183,
9.077511, 0.1230148, -508.8081, 0.01765079, -0.9998443, 0.0003824625,
9.324239, 0.1230148, -520.5842, 0.01739824, -0.9998486, 0.0003551002,
9.570968, 0.1230148, -533.0496, 0.01715373, -0.9998529, 0.0003314046,
9.817696, 0.1230148, -546.1854, 0.016917, -0.9998569, 0.0003106825,
10.06442, 0.1230148, -559.974, 0.01680165, -0.9998588, 0.0003009902,
2.909307, 0.1284129, -546.3468, -0.03326781, 0.9994464, 0.0004192234,
3.156036, 0.1284129, -526.7474, -0.03263068, 0.9994674, 0.0004376838,
3.402764, 0.1284129, -509.4173, -0.0314318, 0.9995058, 0.0004781836,
3.649492, 0.1284129, -494.1667, -0.03036336, 0.9995388, 0.0005270031,
3.89622, 0.1284129, -480.8351, -0.02940853, 0.9995673, 0.0005870289,
4.142948, 0.1284129, -469.285, -0.02855671, 0.9995919, 0.0006626777,
4.389677, 0.1284129, -459.3968, -0.02780409, 0.9996132, 0.0007610857,
4.636405, 0.1284129, -451.0663, -0.02715672, 0.9996309, 0.000894638,
4.883132, 0.1284129, -444.2012, -0.0266413, 0.9996445, 0.001087095,
5.129861, 0.1284129, -438.7198, -0.02634401, 0.999652, 0.001391609,
5.376589, 0.1284129, -434.5488, -0.02661692, 0.9996439, 0.001965215,
5.623317, 0.1284129, -431.6224, -0.03133264, 0.9995015, 0.003870917,
5.870045, 0.1284129, -429.8808, -0.02788297, 0.9995648, 0.009634354,
6.116773, 0.1284129, -429.27, -0.5555333, -0.02451123, 0.8311328,
6.363502, 0.1284129, -429.7405, 0.02052295, -0.9997521, 0.008630321,
6.610229, 0.1284129, -431.247, 0.02393088, -0.9997078, 0.003416613,
6.856958, 0.1284129, -433.7479, 0.02140461, -0.9997692, 0.001880842,
7.103686, 0.1284129, -437.2047, 0.02077595, -0.9997832, 0.001351741,
7.350414, 0.1284129, -441.5817, 0.02035329, -0.9997923, 0.001063294,
7.597142, 0.1284129, -446.846, 0.01998797, -0.9997999, 0.0008787059,
7.84387, 0.1284129, -452.9668, 0.01964902, -0.9998067, 0.0007496474,
8.090598, 0.1284129, -459.9154, 0.01932712, -0.999813, 0.000654063,
8.337327, 0.1284129, -467.665, 0.019019, -0.9998189, 0.0005803119,
8.584055, 0.1284129, -476.1904, 0.018723, -0.9998246, 0.0005216266,
8.830783, 0.1284129, -485.4679, 0.01843797, -0.9998299, 0.0004737908,
9.077511, 0.1284129, -495.4754, 0.01816327, -0.999835, 0.0004340358,
9.324239, 0.1284129, -506.1919, 0.01789831, -0.9998397, 0.0004004642,
9.570968, 0.1284129, -517.5977, 0.01764262, -0.9998444, 0.0003717325,
9.817696, 0.1284129, -529.6739, 0.01739575, -0.9998487, 0.0003468612,
10.06442, 0.1284129, -542.4029, 0.0172758, -0.9998507, 0.0003352865,
2.909307, 0.1338111, -560.0189, -0.03364164, 0.9994339, 0.0004029789,
3.156036, 0.1338111, -539.4036, -0.03299213, 0.9994556, 0.0004192284,
3.402764, 0.1338111, -521.0574, -0.03176595, 0.9994953, 0.0004545863,
3.649492, 0.1338111, -504.7909, -0.03066658, 0.9995296, 0.0004964939,
3.89622, 0.1338111, -490.4433, -0.02967541, 0.9995595, 0.0005469747,
4.142948, 0.1338111, -477.8772, -0.02877896, 0.9995857, 0.0006089906,
4.389677, 0.1338111, -466.9731, -0.02796812, 0.9996086, 0.0006870633,
4.636405, 0.1338111, -457.6265, -0.02723862, 0.9996287, 0.0007884811,
4.883132, 0.1338111, -449.7455, -0.02659358, 0.9996459, 0.0009258504,
5.129861, 0.1338111, -443.2482, -0.02605208, 0.99966, 0.001123247,
5.376589, 0.1338111, -438.0612, -0.02567942, 0.9996692, 0.001434115,
5.623317, 0.1338111, -434.1188, -0.02575388, 0.9996663, 0.002013912,
5.870045, 0.1338111, -431.3612, -0.02928331, 0.9995638, 0.003843967,
6.116773, 0.1338111, -429.7345, -0.02553373, 0.9996281, 0.009566114,
6.363502, 0.1338111, -429.189, -0.2334967, -0.01043484, 0.9723016,
6.610229, 0.1338111, -429.6796, 0.02221267, -0.9997104, 0.00925927,
6.856958, 0.1338111, -431.1645, 0.02542051, -0.99967, 0.003708425,
7.103686, 0.1338111, -433.6053, 0.02207305, -0.9997544, 0.001991774,
7.350414, 0.1338111, -436.9663, 0.02125935, -0.9997731, 0.001423994,
7.597142, 0.1338111, -441.2147, 0.02074794, -0.9997841, 0.001117307,
7.84387, 0.1338111, -446.3195, 0.02033081, -0.9997929, 0.0009219242,
8.090598, 0.1338111, -452.2521, 0.01995868, -0.9998005, 0.0007856977,
8.337327, 0.1338111, -458.9857, 0.01961452, -0.9998074, 0.0006849972,
8.584055, 0.1338111, -466.4951, 0.01929075, -0.9998138, 0.0006074058,
8.830783, 0.1338111, -474.7567, 0.01898335, -0.9998196, 0.0005457305,
9.077511, 0.1338111, -483.7483, 0.01869, -0.9998252, 0.0004955006,
9.324239, 0.1338111, -493.4488, 0.01840909, -0.9998305, 0.0004537845,
9.570968, 0.1338111, -503.8386, 0.01813949, -0.9998354, 0.0004185773,
9.817696, 0.1338111, -514.8988, 0.01788029, -0.9998401, 0.0003884603,
10.06442, 0.1338111, -526.6119, 0.01775484, -0.9998423, 0.0003745258,
2.909307, 0.1392092, -574.1648, -0.03402332, 0.999421, 0.0003890833,
3.156036, 0.1392092, -552.5737, -0.0333636, 0.9994432, 0.0004035543,
3.402764, 0.1392092, -533.2518, -0.03211542, 0.9994841, 0.0004348261,
3.649492, 0.1392092, -516.0094, -0.03099206, 0.9995195, 0.000471374,
3.89622, 0.1392092, -500.6861, -0.0299741, 0.9995506, 0.0005146682,
4.142948, 0.1392092, -487.1442, -0.02904646, 0.9995779, 0.0005667841,
4.389677, 0.1392092, -475.2643, -0.02819769, 0.9996022, 0.0006307535,
4.636405, 0.1392092, -464.942, -0.02741943, 0.9996238, 0.0007111994,
4.883132, 0.1392092, -456.0852, -0.0267066, 0.999643, 0.0008155535,
5.129861, 0.1392092, -448.612, -0.02605954, 0.99966, 0.0009566316,
5.376589, 0.1392092, -442.4493, -0.02548951, 0.9996745, 0.001158792,
5.623317, 0.1392092, -437.5311, -0.02504232, 0.9996853, 0.001475701,
5.870045, 0.1392092, -433.7978, -0.02492923, 0.9996872, 0.002061136,
6.116773, 0.1392092, -431.1952, -0.02746486, 0.9996155, 0.003826541,
6.363502, 0.1392092, -429.674, -0.02346465, 0.9996789, 0.009566952,
6.610229, 0.1392092, -429.1888, 0.1529871, 0.006033534, 0.9882098,
6.856958, 0.1392092, -429.6979, 0.02410645, -0.9996594, 0.01000389,
7.103686, 0.1392092, -431.1629, 0.02707644, -0.9996252, 0.004032254,
7.350414, 0.1392092, -433.5482, 0.02276359, -0.9997387, 0.002106536,
7.597142, 0.1392092, -436.8207, 0.02175111, -0.9997624, 0.001497865,
7.84387, 0.1392092, -440.9498, 0.02114585, -0.9997758, 0.001172235,
8.090598, 0.1392092, -445.9066, 0.0206743, -0.9997858, 0.0009657423,
8.337327, 0.1392092, -451.6644, 0.02026733, -0.9997943, 0.0008221725,
8.584055, 0.1392092, -458.1981, 0.01989951, -0.9998018, 0.0007162456,
8.830783, 0.1392092, -465.4839, 0.019559, -0.9998085, 0.0006347423,
9.077511, 0.1392092, -473.4996, 0.0192395, -0.9998147, 0.0005700279,
9.324239, 0.1392092, -482.2244, 0.01893719, -0.9998206, 0.0005173679,
9.570968, 0.1392092, -491.6384, 0.01864959, -0.999826, 0.0004736641,
9.817696, 0.1392092, -501.7228, 0.01837491, -0.9998311, 0.0004368006,
10.06442, 0.1392092, -512.4601, 0.01824265, -0.9998335, 0.0004198614,
2.909307, 0.1446073, -588.7485, -0.03440886, 0.9994078, 0.0003770603,
3.156036, 0.1446073, -566.2187, -0.03374053, 0.9994306, 0.0003900742,
3.402764, 0.1446073, -545.9581, -0.03247415, 0.9994725, 0.0004180343,
3.649492, 0.1446073, -527.7772, -0.03133165, 0.999509, 0.0004503267,
3.89622, 0.1446073, -511.5152, -0.030293, 0.9995409, 0.0004880502,
4.142948, 0.1446073, -497.0346, -0.02934239, 0.9995694, 0.0005327112,
4.389677, 0.1446073, -484.216, -0.02846731, 0.9995946, 0.0005864348,
4.636405, 0.1446073, -472.9551, -0.0276576, 0.9996173, 0.0006523225,
4.883132, 0.1446073, -463.1596, -0.02690512, 0.9996378, 0.0007350933,
5.129861, 0.1446073, -454.7478, -0.02620396, 0.9996563, 0.0008423146,
5.376589, 0.1446073, -447.6465, -0.02555117, 0.9996731, 0.0009869935,
5.623317, 0.1446073, -441.7896, -0.02495066, 0.999688, 0.001193744,
5.870045, 0.1446073, -437.1176, -0.02443018, 0.9997004, 0.001516399,
6.116773, 0.1446073, -433.5764, -0.02414046, 0.9997064, 0.002106993,
6.363502, 0.1446073, -431.1165, -0.02583348, 0.999659, 0.003816444,
6.610229, 0.1446073, -429.6926, -0.02162038, 0.9997199, 0.009635058,
6.856958, 0.1446073, -429.2631, 0.4616211, 0.01963062, 0.88686,
7.103686, 0.1446073, -429.7894, 0.02625278, -0.9995961, 0.01088869,
7.350414, 0.1446073, -431.2361, 0.02893877, -0.9995715, 0.004395674,
7.597142, 0.1446073, -433.57, 0.02347731, -0.9997219, 0.002225363,
7.84387, 0.1446073, -436.7604, 0.02225212, -0.9997512, 0.001573432,
8.090598, 0.1446073, -440.7786, 0.02154782, -0.9997671, 0.001228119,
8.337327, 0.1446073, -445.5977, 0.02101899, -0.9997786, 0.001010177,
8.584055, 0.1446073, -451.1927, 0.02057537, -0.999788, 0.0008590793,
8.830783, 0.1446073, -457.5399, 0.02018259, -0.9997961, 0.0007478156,
9.077511, 0.1446073, -464.617, 0.01982439, -0.9998032, 0.0006623271,
9.324239, 0.1446073, -472.4031, 0.01949201, -0.9998099, 0.0005945225,
9.570968, 0.1446073, -480.8784, 0.01918018, -0.9998159, 0.0005393958,
9.817696, 0.1446073, -490.0242, 0.01888539, -0.9998215, 0.0004936772,
10.06442, 0.1446073, -499.8228, 0.01874448, -0.9998242, 0.0004728414,
2.909307, 0.1500054, -603.7379, -0.03479549, 0.9993944, 0.0003665541,
3.156036, 0.1500054, -580.3038, -0.03411977, 0.9994177, 0.0003783563,
3.402764, 0.1500054, -559.139, -0.03283802, 0.9994607, 0.0004035867,
3.649492, 0.1500054, -540.0538, -0.03167971, 0.9994981, 0.0004324317,
3.89622, 0.1500054, -522.8876, -0.03062447, 0.9995309, 0.0004657324,
4.142948, 0.1500054, -507.5027, -0.02965618, 0.9995601, 0.0005046148,
4.389677, 0.1500054, -493.7799, -0.02876186, 0.9995862, 0.0005506228,
4.636405, 0.1500054, -481.6147, -0.02793053, 0.9996098, 0.0006059291,
4.883132, 0.1500054, -470.915, -0.02715282, 0.9996311, 0.0006737006,
5.129861, 0.1500054, -461.599, -0.02642072, 0.9996507, 0.0007587484,
5.376589, 0.1500054, -453.5933, -0.02572696, 0.9996687, 0.0008687677,
5.623317, 0.1500054, -446.8322, -0.02506549, 0.9996853, 0.001016946,
5.870045, 0.1500054, -441.256, -0.0244334, 0.9997007, 0.001228126,
6.116773, 0.1500054, -436.8105, -0.02384106, 0.9997146, 0.00155625,
6.363502, 0.1500054, -433.4464, -0.02338434, 0.9997243, 0.002151532,
6.610229, 0.1500054, -431.1183, -0.02435505, 0.9996961, 0.003811901,
6.856958, 0.1500054, -429.7845, -0.01996024, 0.9997531, 0.009773142,
7.103686, 0.1500054, -429.4066, 0.6519807, 0.02907502, 0.757678,
7.350414, 0.1500054, -429.949, 0.02871723, -0.9995162, 0.0119492,
7.597142, 0.1500054, -431.3786, 0.03106259, -0.9995059, 0.004809166,
7.84387, 0.1500054, -433.6648, 0.02421637, -0.999704, 0.002348518,
8.090598, 0.1500054, -436.7787, 0.02276289, -0.9997395, 0.001650754,
8.337327, 0.1500054, -440.6936, 0.02195409, -0.9997582, 0.00128498,
8.584055, 0.1500054, -445.3844, 0.02136518, -0.9997712, 0.001055237,
8.830783, 0.1500054, -450.8273, 0.02088309, -0.9997816, 0.0008964232,
9.077511, 0.1500054, -457.0001, 0.02046409, -0.9997904, 0.000779709,
9.324239, 0.1500054, -463.882, 0.02008733, -0.9997981, 0.0006901623,
9.570968, 0.1500054, -471.453, 0.01974145, -0.999805, 0.0006192168,
9.817696, 0.1500054, -479.6946, 0.0194195, -0.9998114, 0.0005615866,
10.06442, 0.1500054, -488.589, 0.01926717, -0.9998143, 0.0005355844,
2.909307, 0.1554035, -619.1042, -0.03518141, 0.9993809, 0.000357295,
3.156036, 0.1554035, -594.798, -0.03449922, 0.9994047, 0.0003680761,
3.402764, 0.1554035, -572.7609, -0.0332041, 0.9994486, 0.0003910231,
3.649492, 0.1554035, -552.8033, -0.03203232, 0.9994868, 0.000417027,
3.89622, 0.1554035, -534.7648, -0.03096338, 0.9995204, 0.0004467461,
4.142948, 0.1554035, -518.5078, -0.02998104, 0.9995504, 0.0004810429,
4.389677, 0.1554035, -503.9126, -0.02907198, 0.9995772, 0.0005210699,
4.636405, 0.1554035, -490.8752, -0.02822489, 0.9996015, 0.0005684049,
4.883132, 0.1554035, -479.3032, -0.02743004, 0.9996236, 0.0006252676,
5.129861, 0.1554035, -469.1149, -0.02667868, 0.9996439, 0.0006948888,
5.376589, 0.1554035, -460.2369, -0.02596234, 0.9996627, 0.0007821658,
5.623317, 0.1554035, -452.6035, -0.02527259, 0.9996802, 0.0008949174,
5.870045, 0.1554035, -446.1551, -0.02460025, 0.9996969, 0.001046497,
6.116773, 0.1554035, -440.8373, -0.02393543, 0.9997127, 0.001261945,
6.363502, 0.1554035, -436.6009, -0.02327285, 0.9997279, 0.001595268,
6.610229, 0.1554035, -433.4005, -0.02265866, 0.9997409, 0.002194821,
6.856958, 0.1554035, -431.1944, -0.02300363, 0.9997282, 0.003811554,
7.103686, 0.1554035, -429.9443, -0.0184532, 0.9997798, 0.009989769,
7.350414, 0.1554035, -429.6144, 0.7617332, 0.03611936, 0.6468832,
7.597142, 0.1554035, -430.1718, 0.03159419, -0.9994132, 0.01323892,
7.84387, 0.1554035, -431.5856, 0.03352831, -0.9994237, 0.005287892,
8.090598, 0.1554035, -433.8273, 0.02498188, -0.9996849, 0.002476228,
8.337327, 0.1554035, -436.8699, 0.02328367, -0.9997275, 0.001729879,
8.584055, 0.1554035, -440.6884, 0.02236504, -0.9997491, 0.001342838,
8.830783, 0.1554035, -445.259, 0.02171319, -0.9997637, 0.001100939,
9.077511, 0.1554035, -450.5596, 0.02119089, -0.9997751, 0.0009342153,
9.324239, 0.1554035, -456.5692, 0.02074454, -0.9997845, 0.0008119341,
9.570968, 0.1554035, -463.2679, 0.02034833, -0.9997927, 0.0007182522,
9.817696, 0.1554035, -470.6372, 0.01998814, -0.9998001, 0.0006441122,
10.06442, 0.1554035, -478.6593, 0.01982014, -0.9998034, 0.0006110773,
2.909307, 0.1608016, -634.8219, -0.03556522, 0.9993674, 0.000349073,
3.156036, 0.1608016, -609.6731, -0.03487721, 0.9993916, 0.0003589832,
3.402764, 0.1608016, -586.7935, -0.03357029, 0.9994364, 0.0003799964,
3.649492, 0.1608016, -565.9935, -0.03238689, 0.9994753, 0.0004036262,
3.89622, 0.1608016, -547.1125, -0.0313064, 0.9995098, 0.0004303963,
4.142948, 0.1608016, -530.0129, -0.03031241, 0.9995403, 0.0004609802,
4.389677, 0.1608016, -514.5753, -0.02939155, 0.9995679, 0.0004962604,
4.636405, 0.1608016, -500.6954, -0.02853245, 0.9995928, 0.0005374158,
4.883132, 0.1608016, -488.2809, -0.02772526, 0.9996155, 0.0005860581,
5.129861, 0.1608016, -477.2501, -0.02696107, 0.9996363, 0.0006444526,
5.376589, 0.1608016, -467.5297, -0.02623128, 0.9996557, 0.0007158906,
5.623317, 0.1608016, -459.0538, -0.02552702, 0.9996739, 0.0008053518,
5.870045, 0.1608016, -451.7628, -0.0248384, 0.9996911, 0.000920769,
6.116773, 0.1608016, -445.6026, -0.02415312, 0.9997078, 0.001075651,
6.363502, 0.1608016, -440.5237, -0.02345517, 0.9997241, 0.001295219,
6.610229, 0.1608016, -436.4808, -0.02272409, 0.9997405, 0.001633487,
6.856958, 0.1608016, -433.4323, -0.02196073, 0.9997563, 0.002236904,
7.103686, 0.1608016, -431.3396, -0.02176128, 0.9997559, 0.00381461,
7.350414, 0.1608016, -430.1672, -0.0170745, 0.9998012, 0.01030173,
7.597142, 0.1608016, -429.8821, 0.8268293, 0.04248445, 0.5608461,
7.84387, 0.1608016, -430.4535, 0.03502256, -0.9992763, 0.01483798,
8.090598, 0.1608016, -431.8527, 0.03645421, -0.9993182, 0.005854231,
8.337327, 0.1608016, -434.0528, 0.02577614, -0.9996644, 0.002608856,
8.584055, 0.1608016, -437.0287, 0.02381548, -0.9997149, 0.001810897,
8.830783, 0.1608016, -440.7569, 0.02278109, -0.9997395, 0.001401729,
9.077511, 0.1608016, -445.215, 0.02206341, -0.999756, 0.001147297,
9.324239, 0.1608016, -450.3821, 0.02149918, -0.9997684, 0.000972463,
9.570968, 0.1608016, -456.2384, 0.02102419, -0.9997786, 0.000844493,
9.817696, 0.1608016, -462.7652, 0.02060766, -0.9997874, 0.0007465989,
10.06442, 0.1608016, -469.9447, 0.02041723, -0.9997913, 0.0007036753,
2.909307, 0.1661998, -650.8676, -0.0359458, 0.9993537, 0.0003417218,
3.156036, 0.1661998, -624.9041, -0.03525259, 0.9993784, 0.0003508824,
3.402764, 0.1661998, -601.2099, -0.03393517, 0.999424, 0.0003702406,
3.649492, 0.1661998, -579.5952, -0.03274155, 0.9994639, 0.0003918612,
3.89622, 0.1661998, -559.8995, -0.03165101, 0.9994989, 0.0004161674,
4.142948, 0.1661998, -541.9853, -0.03064715, 0.9995303, 0.000443695,
4.389677, 0.1661998, -525.733, -0.02971662, 0.9995583, 0.0004751339,
4.636405, 0.1661998, -511.0384, -0.02884799, 0.9995838, 0.0005113861,
4.883132, 0.1661998, -497.8093, -0.0280314, 0.9996069, 0.000553655,
5.129861, 0.1661998, -485.9638, -0.02725809, 0.9996282, 0.0006035852,
5.376589, 0.1661998, -475.4287, -0.02651962, 0.9996481, 0.0006634863,
5.623317, 0.1661998, -466.1381, -0.02580741, 0.9996668, 0.0007367073,
5.870045, 0.1661998, -458.0325, -0.02511211, 0.9996843, 0.000828308,
6.116773, 0.1661998, -451.0576, -0.02442224, 0.9997013, 0.0009463287,
6.363502, 0.1661998, -445.164, -0.02372265, 0.999718, 0.001104419,
6.610229, 0.1661998, -440.3065, -0.02299102, 0.9997349, 0.001327957,
6.856958, 0.1661998, -436.4432, -0.02219316, 0.9997523, 0.001670929,
7.103686, 0.1661998, -433.5359, -0.02128926, 0.9997708, 0.002277848,
7.350414, 0.1661998, -431.5489, -0.02061121, 0.9997804, 0.003820247,
7.597142, 0.1661998, -430.4491, -0.01580547, 0.9998174, 0.01073598,
7.84387, 0.1661998, -430.2058, 0.867516, 0.04937171, 0.494953,
8.090598, 0.1661998, -430.7903, 0.03921976, -0.9990881, 0.01687439,
8.337327, 0.1661998, -432.1758, 0.04002709, -0.9991772, 0.00654348,
8.584055, 0.1661998, -434.3371, 0.02660119, -0.9996424, 0.002746687,
8.830783, 0.1661998, -437.2505, 0.02435852, -0.9997015, 0.001893872,
9.077511, 0.1661998, -440.894, 0.02320259, -0.9997298, 0.00146168,
9.324239, 0.1661998, -445.2464, 0.02241614, -0.9997481, 0.001194327,
9.570968, 0.1661998, -450.288, 0.02180821, -0.9997618, 0.001011176,
9.817696, 0.1661998, -456.0002, 0.02130351, -0.9997727, 0.0008773954,
10.06442, 0.1661998, -462.3651, 0.02107928, -0.9997776, 0.0008199819,
2.909307, 0.1715979, -667.2203, -0.03632262, 0.9993401, 0.0003351112,
3.156036, 0.1715979, -640.4683, -0.03562467, 0.9993653, 0.0003436203,
3.402764, 0.1715979, -615.9854, -0.0342977, 0.9994116, 0.0003615477,
3.649492, 0.1715979, -593.5821, -0.03309486, 0.9994522, 0.0003814487,
3.89622, 0.1715979, -573.0978, -0.03199545, 0.9994879, 0.0004036703,
4.142948, 0.1715979, -554.3949, -0.03098308, 0.9995198, 0.0004286463,
4.389677, 0.1715979, -537.354, -0.03004435, 0.9995486, 0.0004569243,
4.636405, 0.1715979, -521.8707, -0.02916783, 0.9995745, 0.0004892084,
4.883132, 0.1715979, -507.853, -0.02834382, 0.9995981, 0.0005264202,
5.129861, 0.1715979, -495.2189, -0.02756373, 0.99962, 0.0005697882,
5.376589, 0.1715979, -483.8952, -0.02681928, 0.9996402, 0.0006209884,
5.623317, 0.1715979, -473.816, -0.02610243, 0.9996591, 0.0006823721,
5.870045, 0.1715979, -464.9217, -0.02540455, 0.999677, 0.0007573453,
6.116773, 0.1715979, -457.1582, -0.02471543, 0.9996942, 0.0008510415,
6.363502, 0.1715979, -450.476, -0.02402234, 0.999711, 0.0009716022,
6.610229, 0.1715979, -444.8298, -0.02330717, 0.9997278, 0.00113281,
6.856958, 0.1715979, -440.178, -0.02254183, 0.9997451, 0.00136018,
7.103686, 0.1715979, -436.482, -0.0216792, 0.9997636, 0.001707625,
7.350414, 0.1715979, -433.7064, -0.02064209, 0.9997844, 0.002317701,
7.597142, 0.1715979, -431.8179, -0.01954114, 0.9998018, 0.003827825,
7.84387, 0.1715979, -430.786, -0.01462961, 0.9998287, 0.01133946,
8.090598, 0.1715979, -430.5819, 0.8942016, 0.0578278, 0.4439136,
8.337327, 0.1715979, -431.1787, 0.04454366, -0.9988158, 0.01956482,
8.584055, 0.1715979, -432.5514, 0.04456029, -0.9989792, 0.007414429,
8.830783, 0.1715979, -434.6762, 0.02745909, -0.9996188, 0.002890114,
9.077511, 0.1715979, -437.531, 0.02491376, -0.9996877, 0.001978884,
9.324239, 0.1715979, -441.0948, 0.02362981, -0.9997196, 0.001522723,
9.570968, 0.1715979, -445.3478, 0.02277175, -0.9997399, 0.001242044,
9.817696, 0.1715979, -450.2714, 0.02211833, -0.9997548, 0.001050363,
10.06442, 0.1715979, -455.8476, 0.02183994, -0.9997611, 0.0009705469,
2.909307, 0.176996, -683.8611, -0.03669502, 0.9993265, 0.0003291333,
3.156036, 0.176996, -656.3448, -0.03599265, 0.9993521, 0.0003370712,
3.402764, 0.176996, -631.0978, -0.03465694, 0.9993992, 0.0003537507,
3.649492, 0.176996, -607.9303, -0.03344576, 0.9994405, 0.0003721664,
3.89622, 0.176996, -586.6818, -0.03233844, 0.9994769, 0.0003926058,
4.142948, 0.176996, -567.2147, -0.03131853, 0.9995095, 0.0004154238,
4.389677, 0.176996, -549.4096, -0.03037259, 0.9995385, 0.0004410624,
4.636405, 0.176996, -533.1622, -0.02948938, 0.9995651, 0.0004700816,
4.883132, 0.176996, -518.3802, -0.02865935, 0.9995891, 0.0005032019,
5.129861, 0.176996, -504.9819, -0.0278739, 0.9996113, 0.0005413627,
5.376589, 0.176996, -492.894, -0.02712507, 0.9996319, 0.0005858149,
5.623317, 0.176996, -482.0506, -0.0264053, 0.9996512, 0.0006382662,
5.870045, 0.176996, -472.3922, -0.0257066, 0.9996693, 0.0007011082,
6.116773, 0.176996, -463.8644, -0.02502003, 0.9996867, 0.0007777998,
6.363502, 0.176996, -456.4181, -0.02433501, 0.9997036, 0.0008735486,
6.610229, 0.176996, -450.0077, -0.02363715, 0.9997201, 0.0009965918,
6.856958, 0.176996, -444.5916, -0.02290547, 0.999737, 0.001160831,
7.103686, 0.176996, -440.1314, -0.02210639, 0.9997547, 0.001391894,
7.350414, 0.176996, -436.5916, -0.02118074, 0.9997742, 0.001743592,
7.597142, 0.176996, -433.939, -0.02001763, 0.9997969, 0.002356511,
7.84387, 0.176996, -432.1429, -0.01854133, 0.9998208, 0.003837064,
8.090598, 0.176996, -431.1746, -0.01353489, 0.999834, 0.01219509,
8.337327, 0.176996, -431.0072, 0.9122924, 0.06917952, 0.4036544,
8.584055, 0.176996, -431.6157, 0.0516334, -0.9983943, 0.02329677,
8.830783, 0.176996, -432.9763, 0.05059454, -0.9986826, 0.008569409,
9.077511, 0.176996, -435.0669, 0.02835298, -0.9995934, 0.003039563,
9.324239, 0.176996, -437.8665, 0.02548139, -0.9996732, 0.002066014,
9.570968, 0.176996, -441.3553, 0.02406312, -0.9997092, 0.00158488,
9.817696, 0.176996, -445.5146, 0.02313028, -0.9997317, 0.001290455,
10.06442, 0.176996, -450.3267, 0.02275754, -0.9997404, 0.001173368,
2.909307, 0.1823941, -700.7726, -0.03706273, 0.9993129, 0.0003237019,
3.156036, 0.1823941, -672.5152, -0.03635632, 0.9993389, 0.0003311363,
3.402764, 0.1823941, -646.5269, -0.03501258, 0.9993868, 0.0003467197,
3.649492, 0.1823941, -622.6181, -0.03379374, 0.9994288, 0.0003638412,
3.89622, 0.1823941, -600.6284, -0.0326792, 0.9994658, 0.0003827416,
4.142948, 0.1823941, -580.42, -0.03165247, 0.9994989, 0.0004037146,
4.389677, 0.1823941, -561.8737, -0.03070017, 0.9995285, 0.0004271226,
4.636405, 0.1823941, -544.8851, -0.0298112, 0.9995555, 0.0004534181,
4.883132, 0.1823941, -529.3619, -0.02897599, 0.9995801, 0.0004831724,
5.129861, 0.1823941, -515.2223, -0.02818603, 0.9996026, 0.0005171184,
5.376589, 0.1823941, -502.3932, -0.02743377, 0.9996235, 0.0005562146,
5.623317, 0.1823941, -490.8086, -0.02671202, 0.9996431, 0.0006017367,
5.870045, 0.1823941, -480.4088, -0.02601333, 0.9996614, 0.0006554216,
6.116773, 0.1823941, -471.1399, -0.02532976, 0.9996789, 0.000719699,
6.363502, 0.1823941, -462.9523, -0.02465231, 0.9996958, 0.0007980796,
6.610229, 0.1823941, -455.8006, -0.02396945, 0.9997123, 0.0008958386,
6.856958, 0.1823941, -449.6433, -0.02326532, 0.9997289, 0.001021304,
7.103686, 0.1823941, -444.442, -0.02251633, 0.9997458, 0.001188485,
7.350414, 0.1823941, -440.1609, -0.02168366, 0.999764, 0.001423108,
7.597142, 0.1823941, -436.767, -0.02069691, 0.9997842, 0.001778847,
7.84387, 0.1823941, -434.2296, -0.01941454, 0.9998087, 0.002394316,
8.090598, 0.1823941, -432.5201, -0.01760417, 0.9998376, 0.003847595,
8.337327, 0.1823941, -431.6115, -0.01250535, 0.9998314, 0.01345477,
8.584055, 0.1823941, -431.4787, 0.9245047, 0.08561902, 0.3714303,
8.830783, 0.1823941, -432.0981, 0.06174573, -0.9976745, 0.02886263,
9.077511, 0.1823941, -433.4475, 0.05920929, -0.9981933, 0.01021119,
9.324239, 0.1823941, -435.5059, 0.02928447, -0.9995661, 0.003195415,
9.570968, 0.1823941, -438.2534, 0.02606232, -0.9996581, 0.002155345,
9.817696, 0.1823941, -441.6715, 0.02450291, -0.9996984, 0.001648197,
10.06442, 0.1823941, -445.7423, 0.02394381, -0.9997123, 0.001462037,
2.909307, 0.1877922, -717.9391, -0.03742558, 0.9992995, 0.0003187452,
3.156036, 0.1877922, -688.962, -0.03671536, 0.9993258, 0.0003257324,
3.402764, 0.1877922, -662.2541, -0.0353641, 0.9993745, 0.0003403461,
3.649492, 0.1877922, -637.6257, -0.03413816, 0.9994171, 0.000356331,
3.89622, 0.1877922, -614.9164, -0.03301696, 0.9994548, 0.0003738909,
4.142948, 0.1877922, -593.9885, -0.03198403, 0.9994883, 0.0003932718,
4.389677, 0.1877922, -574.7225, -0.03102604, 0.9995186, 0.0004147741,
4.636405, 0.1877922, -557.0142, -0.03013193, 0.9995459, 0.0004387678,
4.883132, 0.1877922, -540.7714, -0.02929213, 0.9995708, 0.0004657134,
5.129861, 0.1877922, -525.9122, -0.02849835, 0.9995938, 0.0004961937,
5.376589, 0.1877922, -512.3635, -0.02774332, 0.999615, 0.000530957,
5.623317, 0.1877922, -500.0593, -0.02702006, 0.9996347, 0.0005709788,
5.870045, 0.1877922, -488.9399, -0.02632164, 0.9996534, 0.0006175566,
6.116773, 0.1877922, -478.9514, -0.02564088, 0.999671, 0.0006724564,
6.363502, 0.1877922, -470.0441, -0.02497004, 0.9996879, 0.0007381456,
6.610229, 0.1877922, -462.1729, -0.02429958, 0.9997045, 0.000818184,
6.856958, 0.1877922, -455.296, -0.02361719, 0.9997208, 0.0009179122,
7.103686, 0.1877922, -449.3749, -0.02290571, 0.9997371, 0.001045742,
7.350414, 0.1877922, -444.3742, -0.02213887, 0.9997543, 0.001215785,
7.597142, 0.1877922, -440.2608, -0.02127298, 0.9997727, 0.001453845,
7.84387, 0.1877922, -437.0038, -0.02022697, 0.9997938, 0.001813433,
8.090598, 0.1877922, -434.5746, -0.01883166, 0.9998197, 0.002431169,
8.337327, 0.1877922, -432.9464, -0.0167217, 0.9998527, 0.003859075,
8.584055, 0.1877922, -432.094, -0.0115276, 0.9998143, 0.01544288,
8.830783, 0.1877922, -431.9938, 0.931769, 0.1118716, 0.3453855,
9.077511, 0.1877922, -432.6236, 0.07779194, -0.9962391, 0.03816026,
9.324239, 0.1877922, -433.9623, 0.07275122, -0.9972683, 0.0127822,
9.570968, 0.1877922, -435.9903, 0.03025769, -0.9995365, 0.003358229,
9.817696, 0.1877922, -438.6887, 0.02665716, -0.9996421, 0.002246964,
10.06442, 0.1877922, -442.0399, 0.02564594, -0.9996693, 0.001907963,
2.909307, 0.1931904, -735.3461, -0.03778336, 0.9992859, 0.0003142031,
3.156036, 0.1931904, -705.6698, -0.03706952, 0.9993126, 0.0003207907,
3.402764, 0.1931904, -678.2626, -0.03571122, 0.9993621, 0.0003345412,
3.649492, 0.1931904, -652.9351, -0.03447873, 0.9994054, 0.0003495219,
3.89622, 0.1931904, -629.5266, -0.03335141, 0.9994437, 0.0003659061,
4.142948, 0.1931904, -607.8994, -0.03231277, 0.9994777, 0.0003839015,
4.389677, 0.1931904, -587.9342, -0.03134956, 0.9995084, 0.0004037594,
4.636405, 0.1931904, -569.5267, -0.03045074, 0.9995362, 0.0004257865,
4.883132, 0.1931904, -552.5846, -0.02960676, 0.9995616, 0.0004503593,
5.129861, 0.1931904, -537.0262, -0.02880966, 0.9995848, 0.0004779483,
5.376589, 0.1931904, -522.7783, -0.0280522, 0.9996064, 0.0005091478,
5.623317, 0.1931904, -509.7748, -0.02732765, 0.9996264, 0.0005447189,
5.870045, 0.1931904, -497.9562, -0.02662952, 0.9996453, 0.0005856542,
6.116773, 0.1931904, -487.2685, -0.02595126, 0.999663, 0.0006332736,
6.363502, 0.1931904, -477.662, -0.02528603, 0.99968, 0.0006893715,
6.610229, 0.1931904, -469.0915, -0.0246257, 0.9996964, 0.0007564506,
6.856958, 0.1931904, -461.5154, -0.02396041, 0.9997126, 0.0008381172,
7.103686, 0.1931904, -454.8952, -0.02327721, 0.9997287, 0.000939775,
7.350414, 0.1931904, -449.1952, -0.02255738, 0.9997451, 0.001069914,
7.597142, 0.1931904, -444.3825, -0.02177225, 0.9997622, 0.001242734,
7.84387, 0.1931904, -440.4263, -0.02087332, 0.9997811, 0.001484105,
8.090598, 0.1931904, -437.2979, -0.01976978, 0.9998029, 0.001847339,
8.337327, 0.1931904, -434.9705, -0.0182675, 0.9998302, 0.002467071,
8.584055, 0.1931904, -433.4189, -0.01588878, 0.9998663, 0.003871289,
8.830783, 0.1931904, -432.6195, -0.0105795, 0.9997641, 0.01897027,
9.077511, 0.1931904, -432.55, 0.9321175, 0.1610492, 0.3243763,
9.324239, 0.1931904, -433.1895, 0.1082789, -0.9924776, 0.05713007,
9.570968, 0.1931904, -434.5182, 0.0969011, -0.9951427, 0.01735342,
9.817696, 0.1931904, -436.5175, 0.03127594, -0.9995046, 0.00352859,
10.06442, 0.1931904, -439.1695, 0.02855658, -0.9995886, 0.002698796,
2.909307, 0.1985885, -752.9803, -0.03813612, 0.9992726, 0.0003100269,
3.156036, 0.1985885, -722.6241, -0.03741888, 0.9992996, 0.0003162558,
3.402764, 0.1985885, -694.537, -0.03605394, 0.9993499, 0.0003292337,
3.649492, 0.1985885, -668.5294, -0.03481527, 0.9993938, 0.0003433204,
3.89622, 0.1985885, -644.4409, -0.03368217, 0.9994326, 0.0003586654,
4.142948, 0.1985885, -622.1338, -0.03263819, 0.9994672, 0.0003754455,
4.389677, 0.1985885, -601.4887, -0.03167016, 0.9994984, 0.000393873,
4.636405, 0.1985885, -582.4012, -0.03076698, 0.9995265, 0.000414204,
4.883132, 0.1985885, -564.7792, -0.02991923, 0.9995523, 0.0004367507,
5.129861, 0.1985885, -548.5409, -0.02911909, 0.9995759, 0.0004618978,
5.376589, 0.1985885, -533.613, -0.02835944, 0.9995977, 0.0004901247,
5.623317, 0.1985885, -519.9296, -0.02763373, 0.9996181, 0.0005220358,
5.870045, 0.1985885, -507.4311, -0.02693582, 0.9996371, 0.0005584055,
6.116773, 0.1985885, -496.0633, -0.02625963, 0.999655, 0.0006002433,
6.363502, 0.1985885, -485.7769, -0.02559902, 0.9996722, 0.0006488909,
6.610229, 0.1985885, -476.5265, -0.02494692, 0.9996886, 0.0007061688,
6.856958, 0.1985885, -468.2704, -0.02429518, 0.9997045, 0.0007746148,
7.103686, 0.1985885, -460.9702, -0.02363367, 0.9997204, 0.0008578818,
7.350414, 0.1985885, -454.5903, -0.02294838, 0.9997362, 0.0009614304,
7.597142, 0.1985885, -449.0977, -0.02221943, 0.9997526, 0.001093823,
7.84387, 0.1985885, -444.4615, -0.02141573, 0.9997699, 0.001269345,
8.090598, 0.1985885, -440.6532, -0.02048416, 0.9997891, 0.001513914,
8.337327, 0.1985885, -437.6458, -0.01932504, 0.9998115, 0.00188062,
8.584055, 0.1985885, -435.4142, -0.01772146, 0.9998398, 0.002502122,
8.830783, 0.1985885, -433.9349, -0.01510072, 0.9998785, 0.003884195,
9.077511, 0.1985885, -433.1854, -0.009594099, 0.9995959, 0.02675993,
9.324239, 0.1985885, -433.145, 0.9060875, 0.2939886, 0.3042632,
9.570968, 0.1985885, -433.7938, 0.1898789, -0.9745942, 0.1187943,
9.817696, 0.1985885, -435.1131, 0.1423717, -0.9894729, 0.02595425,
10.06442, 0.1985885, -437.0851, 0.03584309, -0.9993469, 0.004599025,
2.909307, 0.2039866, -770.8296, -0.03848355, 0.9992592, 0.0003061718,
3.156036, 0.2039866, -739.8116, -0.03776311, 0.9992867, 0.0003120771,
3.402764, 0.2039866, -711.0628, -0.03639193, 0.9993376, 0.0003243602,
3.649492, 0.2039866, -684.3936, -0.03514744, 0.9993821, 0.0003376474,
3.89622, 0.2039866, -659.6433, -0.03400888, 0.9994215, 0.0003520681,
4.142948, 0.2039866, -636.6745, -0.03295992, 0.9994566, 0.0003677748,
4.389677, 0.2039866, -615.3677, -0.03198735, 0.9994882, 0.0003849479,
4.636405, 0.2039866, -595.6185, -0.03108011, 0.9995168, 0.0004038038,
4.883132, 0.2039866, -577.3348, -0.0302289, 0.999543, 0.000424604,
5.129861, 0.2039866, -560.4348, -0.02942597, 0.999567, 0.0004476667,
5.376589, 0.2039866, -544.8451, -0.02866423, 0.999589, 0.0004733831,
5.623317, 0.2039866, -530.4999, -0.02793738, 0.9996096, 0.000502241,
5.870045, 0.2039866, -517.3397, -0.02723954, 0.9996288, 0.0005348554,
6.116773, 0.2039866, -505.3103, -0.02656505, 0.999647, 0.0005720144,
6.363502, 0.2039866, -494.3622, -0.02590821, 0.9996642, 0.0006147439,
6.610229, 0.2039866, -484.45, -0.0252628, 0.9996806, 0.0006644055,
6.856958, 0.2039866, -475.5322, -0.02462189, 0.9996966, 0.0007228461,
7.103686, 0.2039866, -467.5703, -0.02397726, 0.9997123, 0.0007926373,
7.350414, 0.2039866, -460.5287, -0.02331803, 0.9997277, 0.0008774747,
7.597142, 0.2039866, -454.3744, -0.02262971, 0.9997435, 0.0009828749,
7.84387, 0.2039866, -449.0765, -0.02189107, 0.9997597, 0.001117469,
8.090598, 0.2039866, -444.6064, -0.02106838, 0.9997772, 0.001295617,
8.337327, 0.2039866, -440.9374, -0.02010474, 0.9997967, 0.001543266,
8.584055, 0.2039866, -438.0441, -0.01889198, 0.9998197, 0.00191327,
8.830783, 0.2039866, -435.903, -0.01719222, 0.9998491, 0.002536308,
9.077511, 0.2039866, -434.4919, -0.01435251, 0.9998895, 0.00389748,
9.324239, 0.2039866, -433.7897, -0.008104503, 0.9983678, 0.05653498,
9.570968, 0.2039866, -433.7768, 0.6922365, 0.6862104, 0.2234367,
9.817696, 0.2039866, -434.4343, 0.5360309, -0.7679999, 0.3504953,
10.06442, 0.2039866, -435.7447, 0.3571396, -0.9315735, 0.06798647,
2.909307, 0.2093847, -788.8827, -0.0388259, 0.999246, 0.0003026039,
3.156036, 0.2093847, -757.2203, -0.03810242, 0.9992738, 0.0003082158,
3.402764, 0.2093847, -727.827, -0.03672529, 0.9993254, 0.0003198706,
3.649492, 0.2093847, -700.5133, -0.03547523, 0.9993706, 0.0003324387,
3.89622, 0.2093847, -675.1187, -0.03433154, 0.9994105, 0.0003460331,
4.142948, 0.2093847, -651.5054, -0.03327789, 0.9994461, 0.0003607859,
4.389677, 0.2093847, -629.5541, -0.03230103, 0.9994781, 0.0003768518,
4.636405, 0.2093847, -609.1605, -0.03138997, 0.9995072, 0.000394415,
4.883132, 0.2093847, -590.2324, -0.03053552, 0.9995337, 0.0004136965,
5.129861, 0.2093847, -572.6879, -0.0297299, 0.999558, 0.0004349623,
5.376589, 0.2093847, -556.4539, -0.02896618, 0.9995803, 0.0004585359,
5.623317, 0.2093847, -541.4643, -0.02823817, 0.9996012, 0.0004848157,
5.870045, 0.2093847, -527.6597, -0.02754029, 0.9996207, 0.0005142982,
6.116773, 0.2093847, -514.9858, -0.02686713, 0.9996389, 0.0005476096,
6.363502, 0.2093847, -503.3932, -0.02621336, 0.9996563, 0.0005855496,
6.610229, 0.2093847, -492.8366, -0.02557339, 0.9996728, 0.00062916,
6.856958, 0.2093847, -483.2744, -0.0249412, 0.9996887, 0.0006798223,
7.103686, 0.2093847, -474.6681, -0.02430989, 0.9997043, 0.0007394091,
7.350414, 0.2093847, -466.9821, -0.02367076, 0.9997196, 0.0008105236,
7.597142, 0.2093847, -460.1833, -0.02301278, 0.9997348, 0.0008969038,
7.84387, 0.2093847, -454.241, -0.02232061, 0.9997504, 0.001004117,
8.090598, 0.2093847, -449.1265, -0.02157147, 0.9997666, 0.00114086,
8.337327, 0.2093847, -444.813, -0.02072992, 0.9997842, 0.00132156,
8.584055, 0.2093847, -441.2753, -0.01973478, 0.999804, 0.001572184,
8.830783, 0.2093847, -438.4897, -0.0184698, 0.9998276, 0.001945314,
9.077511, 0.2093847, -436.4342, -0.01667906, 0.9998576, 0.002569688,
9.324239, 0.2093847, -435.0876, -0.01364107, 0.9998994, 0.003911166,
9.570968, 0.2093847, -434.4302, -0.00019341, 0.9975343, 0.07018091,
9.817696, 0.2093847, -434.4434, 0.4106435, 0.9029208, 0.1269086,
10.06442, 0.2093847, -435.1093, 0.4994969, 0.8254371, 0.2629761,
2.909307, 0.2147828, -807.1292, -0.03900234, 0.9992391, 0.0003008882,
3.156036, 0.2147828, -774.8387, -0.03827117, 0.9992674, 0.0003063607,
3.402764, 0.2147828, -744.8174, -0.03689114, 0.9993193, 0.0003177164,
3.649492, 0.2147828, -716.8757, -0.03563834, 0.9993647, 0.0003299434,
3.89622, 0.2147828, -690.8531, -0.03449216, 0.999405, 0.0003431468,
4.142948, 0.2147828, -666.6118, -0.03343627, 0.9994408, 0.0003574499,
4.389677, 0.2147828, -644.0325, -0.03245738, 0.9994732, 0.0003729959,
4.636405, 0.2147828, -623.0109, -0.03154455, 0.9995024, 0.0003899543,
4.883132, 0.2147828, -603.4547, -0.03068858, 0.9995289, 0.0004085278,
5.129861, 0.2147828, -585.2822, -0.02988172, 0.9995534, 0.0004289594,
5.376589, 0.2147828, -568.4201, -0.02911716, 0.999576, 0.0004515439,
5.623317, 0.2147828, -552.8025, -0.02838872, 0.9995968, 0.0004766404,
5.870045, 0.2147828, -538.3699, -0.02769095, 0.9996165, 0.0005046932,
6.116773, 0.2147828, -525.0679, -0.02701853, 0.9996349, 0.0005362601,
6.363502, 0.2147828, -512.8474, -0.02636637, 0.9996523, 0.0005720465,
6.610229, 0.2147828, -501.6628, -0.02572913, 0.9996688, 0.0006129605,
6.856958, 0.2147828, -491.4725, -0.02510124, 0.9996847, 0.0006601948,
7.103686, 0.2147828, -482.2382, -0.0244764, 0.9997002, 0.0007153431,
7.350414, 0.2147828, -473.9241, -0.02384687, 0.9997153, 0.0007805845,
7.597142, 0.2147828, -466.4973, -0.02320312, 0.9997304, 0.0008589837,
7.84387, 0.2147828, -459.927, -0.02253215, 0.9997457, 0.0009549918,
8.090598, 0.2147828, -454.1845, -0.02181564, 0.9997615, 0.001075349,
8.337327, 0.2147828, -449.2429, -0.02102619, 0.9997782, 0.001230776,
8.584055, 0.2147828, -445.0772, -0.02011909, 0.9997966, 0.001439462,
8.830783, 0.2147828, -441.6636, -0.01901583, 0.9998177, 0.001735119,
9.077511, 0.2147828, -438.98, -0.01756278, 0.9998435, 0.002188683,
9.324239, 0.2147828, -437.0054, -0.01540613, 0.999877, 0.002983314,
9.570968, 0.2147828, -435.7201, -0.01147837, 0.9999225, 0.004834914,
9.817696, 0.2147828, -435.1052, 0.009082412, 0.9989594, 0.04469502,
10.06442, 0.2147828, -435.143, 0.2012609, 0.9763867, 0.07850391
]);
this.values[34] = v;
this.normLoc[34] = gl.getAttribLocation(this.prog[34], "aNorm");
this.clipLoc[34] = [];
this.clipLoc[34][0] = gl.getUniformLocation(this.prog[34], "vClipplane1");
this.clipLoc[34][1] = gl.getUniformLocation(this.prog[34], "vClipplane2");
f=new Uint16Array([
0, 30, 31, 0, 31, 1,
30, 60, 61, 30, 61, 31,
60, 90, 91, 60, 91, 61,
90, 120, 121, 90, 121, 91,
120, 150, 151, 120, 151, 121,
150, 180, 181, 150, 181, 151,
180, 210, 211, 180, 211, 181,
210, 240, 241, 210, 241, 211,
240, 270, 271, 240, 271, 241,
270, 300, 301, 270, 301, 271,
300, 330, 331, 300, 331, 301,
330, 360, 361, 330, 361, 331,
360, 390, 391, 360, 391, 361,
390, 420, 421, 390, 421, 391,
420, 450, 451, 420, 451, 421,
450, 480, 481, 450, 481, 451,
480, 510, 511, 480, 511, 481,
510, 540, 541, 510, 541, 511,
540, 570, 571, 540, 571, 541,
570, 600, 601, 570, 601, 571,
600, 630, 631, 600, 631, 601,
630, 660, 661, 630, 661, 631,
660, 690, 691, 660, 691, 661,
690, 720, 721, 690, 721, 691,
720, 750, 751, 720, 751, 721,
750, 780, 781, 750, 781, 751,
780, 810, 811, 780, 811, 781,
810, 840, 841, 810, 841, 811,
840, 870, 871, 840, 871, 841,
1, 31, 32, 1, 32, 2,
31, 61, 62, 31, 62, 32,
61, 91, 92, 61, 92, 62,
91, 121, 122, 91, 122, 92,
121, 151, 152, 121, 152, 122,
151, 181, 182, 151, 182, 152,
181, 211, 212, 181, 212, 182,
211, 241, 242, 211, 242, 212,
241, 271, 272, 241, 272, 242,
271, 301, 302, 271, 302, 272,
301, 331, 332, 301, 332, 302,
331, 361, 362, 331, 362, 332,
361, 391, 392, 361, 392, 362,
391, 421, 422, 391, 422, 392,
421, 451, 452, 421, 452, 422,
451, 481, 482, 451, 482, 452,
481, 511, 512, 481, 512, 482,
511, 541, 542, 511, 542, 512,
541, 571, 572, 541, 572, 542,
571, 601, 602, 571, 602, 572,
601, 631, 632, 601, 632, 602,
631, 661, 662, 631, 662, 632,
661, 691, 692, 661, 692, 662,
691, 721, 722, 691, 722, 692,
721, 751, 752, 721, 752, 722,
751, 781, 782, 751, 782, 752,
781, 811, 812, 781, 812, 782,
811, 841, 842, 811, 842, 812,
841, 871, 872, 841, 872, 842,
2, 32, 33, 2, 33, 3,
32, 62, 63, 32, 63, 33,
62, 92, 93, 62, 93, 63,
92, 122, 123, 92, 123, 93,
122, 152, 153, 122, 153, 123,
152, 182, 183, 152, 183, 153,
182, 212, 213, 182, 213, 183,
212, 242, 243, 212, 243, 213,
242, 272, 273, 242, 273, 243,
272, 302, 303, 272, 303, 273,
302, 332, 333, 302, 333, 303,
332, 362, 363, 332, 363, 333,
362, 392, 393, 362, 393, 363,
392, 422, 423, 392, 423, 393,
422, 452, 453, 422, 453, 423,
452, 482, 483, 452, 483, 453,
482, 512, 513, 482, 513, 483,
512, 542, 543, 512, 543, 513,
542, 572, 573, 542, 573, 543,
572, 602, 603, 572, 603, 573,
602, 632, 633, 602, 633, 603,
632, 662, 663, 632, 663, 633,
662, 692, 693, 662, 693, 663,
692, 722, 723, 692, 723, 693,
722, 752, 753, 722, 753, 723,
752, 782, 783, 752, 783, 753,
782, 812, 813, 782, 813, 783,
812, 842, 843, 812, 843, 813,
842, 872, 873, 842, 873, 843,
3, 33, 34, 3, 34, 4,
33, 63, 64, 33, 64, 34,
63, 93, 94, 63, 94, 64,
93, 123, 124, 93, 124, 94,
123, 153, 154, 123, 154, 124,
153, 183, 184, 153, 184, 154,
183, 213, 214, 183, 214, 184,
213, 243, 244, 213, 244, 214,
243, 273, 274, 243, 274, 244,
273, 303, 304, 273, 304, 274,
303, 333, 334, 303, 334, 304,
333, 363, 364, 333, 364, 334,
363, 393, 394, 363, 394, 364,
393, 423, 424, 393, 424, 394,
423, 453, 454, 423, 454, 424,
453, 483, 484, 453, 484, 454,
483, 513, 514, 483, 514, 484,
513, 543, 544, 513, 544, 514,
543, 573, 574, 543, 574, 544,
573, 603, 604, 573, 604, 574,
603, 633, 634, 603, 634, 604,
633, 663, 664, 633, 664, 634,
663, 693, 694, 663, 694, 664,
693, 723, 724, 693, 724, 694,
723, 753, 754, 723, 754, 724,
753, 783, 784, 753, 784, 754,
783, 813, 814, 783, 814, 784,
813, 843, 844, 813, 844, 814,
843, 873, 874, 843, 874, 844,
4, 34, 35, 4, 35, 5,
34, 64, 65, 34, 65, 35,
64, 94, 95, 64, 95, 65,
94, 124, 125, 94, 125, 95,
124, 154, 155, 124, 155, 125,
154, 184, 185, 154, 185, 155,
184, 214, 215, 184, 215, 185,
214, 244, 245, 214, 245, 215,
244, 274, 275, 244, 275, 245,
274, 304, 305, 274, 305, 275,
304, 334, 335, 304, 335, 305,
334, 364, 365, 334, 365, 335,
364, 394, 395, 364, 395, 365,
394, 424, 425, 394, 425, 395,
424, 454, 455, 424, 455, 425,
454, 484, 485, 454, 485, 455,
484, 514, 515, 484, 515, 485,
514, 544, 545, 514, 545, 515,
544, 574, 575, 544, 575, 545,
574, 604, 605, 574, 605, 575,
604, 634, 635, 604, 635, 605,
634, 664, 665, 634, 665, 635,
664, 694, 695, 664, 695, 665,
694, 724, 725, 694, 725, 695,
724, 754, 755, 724, 755, 725,
754, 784, 785, 754, 785, 755,
784, 814, 815, 784, 815, 785,
814, 844, 845, 814, 845, 815,
844, 874, 875, 844, 875, 845,
5, 35, 36, 5, 36, 6,
35, 65, 66, 35, 66, 36,
65, 95, 96, 65, 96, 66,
95, 125, 126, 95, 126, 96,
125, 155, 156, 125, 156, 126,
155, 185, 186, 155, 186, 156,
185, 215, 216, 185, 216, 186,
215, 245, 246, 215, 246, 216,
245, 275, 276, 245, 276, 246,
275, 305, 306, 275, 306, 276,
305, 335, 336, 305, 336, 306,
335, 365, 366, 335, 366, 336,
365, 395, 396, 365, 396, 366,
395, 425, 426, 395, 426, 396,
425, 455, 456, 425, 456, 426,
455, 485, 486, 455, 486, 456,
485, 515, 516, 485, 516, 486,
515, 545, 546, 515, 546, 516,
545, 575, 576, 545, 576, 546,
575, 605, 606, 575, 606, 576,
605, 635, 636, 605, 636, 606,
635, 665, 666, 635, 666, 636,
665, 695, 696, 665, 696, 666,
695, 725, 726, 695, 726, 696,
725, 755, 756, 725, 756, 726,
755, 785, 786, 755, 786, 756,
785, 815, 816, 785, 816, 786,
815, 845, 846, 815, 846, 816,
845, 875, 876, 845, 876, 846,
6, 36, 37, 6, 37, 7,
36, 66, 67, 36, 67, 37,
66, 96, 97, 66, 97, 67,
96, 126, 127, 96, 127, 97,
126, 156, 157, 126, 157, 127,
156, 186, 187, 156, 187, 157,
186, 216, 217, 186, 217, 187,
216, 246, 247, 216, 247, 217,
246, 276, 277, 246, 277, 247,
276, 306, 307, 276, 307, 277,
306, 336, 337, 306, 337, 307,
336, 366, 367, 336, 367, 337,
366, 396, 397, 366, 397, 367,
396, 426, 427, 396, 427, 397,
426, 456, 457, 426, 457, 427,
456, 486, 487, 456, 487, 457,
486, 516, 517, 486, 517, 487,
516, 546, 547, 516, 547, 517,
546, 576, 577, 546, 577, 547,
576, 606, 607, 576, 607, 577,
606, 636, 637, 606, 637, 607,
636, 666, 667, 636, 667, 637,
666, 696, 697, 666, 697, 667,
696, 726, 727, 696, 727, 697,
726, 756, 757, 726, 757, 727,
756, 786, 787, 756, 787, 757,
786, 816, 817, 786, 817, 787,
816, 846, 847, 816, 847, 817,
846, 876, 877, 846, 877, 847,
7, 37, 38, 7, 38, 8,
37, 67, 68, 37, 68, 38,
67, 97, 98, 67, 98, 68,
97, 127, 128, 97, 128, 98,
127, 157, 158, 127, 158, 128,
157, 187, 188, 157, 188, 158,
187, 217, 218, 187, 218, 188,
217, 247, 248, 217, 248, 218,
247, 277, 278, 247, 278, 248,
277, 307, 308, 277, 308, 278,
307, 337, 338, 307, 338, 308,
337, 367, 368, 337, 368, 338,
367, 397, 398, 367, 398, 368,
397, 427, 428, 397, 428, 398,
427, 457, 458, 427, 458, 428,
457, 487, 488, 457, 488, 458,
487, 517, 518, 487, 518, 488,
517, 547, 548, 517, 548, 518,
547, 577, 578, 547, 578, 548,
577, 607, 608, 577, 608, 578,
607, 637, 638, 607, 638, 608,
637, 667, 668, 637, 668, 638,
667, 697, 698, 667, 698, 668,
697, 727, 728, 697, 728, 698,
727, 757, 758, 727, 758, 728,
757, 787, 788, 757, 788, 758,
787, 817, 818, 787, 818, 788,
817, 847, 848, 817, 848, 818,
847, 877, 878, 847, 878, 848,
8, 38, 39, 8, 39, 9,
38, 68, 69, 38, 69, 39,
68, 98, 99, 68, 99, 69,
98, 128, 129, 98, 129, 99,
128, 158, 159, 128, 159, 129,
158, 188, 189, 158, 189, 159,
188, 218, 219, 188, 219, 189,
218, 248, 249, 218, 249, 219,
248, 278, 279, 248, 279, 249,
278, 308, 309, 278, 309, 279,
308, 338, 339, 308, 339, 309,
338, 368, 369, 338, 369, 339,
368, 398, 399, 368, 399, 369,
398, 428, 429, 398, 429, 399,
428, 458, 459, 428, 459, 429,
458, 488, 489, 458, 489, 459,
488, 518, 519, 488, 519, 489,
518, 548, 549, 518, 549, 519,
548, 578, 579, 548, 579, 549,
578, 608, 609, 578, 609, 579,
608, 638, 639, 608, 639, 609,
638, 668, 669, 638, 669, 639,
668, 698, 699, 668, 699, 669,
698, 728, 729, 698, 729, 699,
728, 758, 759, 728, 759, 729,
758, 788, 789, 758, 789, 759,
788, 818, 819, 788, 819, 789,
818, 848, 849, 818, 849, 819,
848, 878, 879, 848, 879, 849,
9, 39, 40, 9, 40, 10,
39, 69, 70, 39, 70, 40,
69, 99, 100, 69, 100, 70,
99, 129, 130, 99, 130, 100,
129, 159, 160, 129, 160, 130,
159, 189, 190, 159, 190, 160,
189, 219, 220, 189, 220, 190,
219, 249, 250, 219, 250, 220,
249, 279, 280, 249, 280, 250,
279, 309, 310, 279, 310, 280,
309, 339, 340, 309, 340, 310,
339, 369, 370, 339, 370, 340,
369, 399, 400, 369, 400, 370,
399, 429, 430, 399, 430, 400,
429, 459, 460, 429, 460, 430,
459, 489, 490, 459, 490, 460,
489, 519, 520, 489, 520, 490,
519, 549, 550, 519, 550, 520,
549, 579, 580, 549, 580, 550,
579, 609, 610, 579, 610, 580,
609, 639, 640, 609, 640, 610,
639, 669, 670, 639, 670, 640,
669, 699, 700, 669, 700, 670,
699, 729, 730, 699, 730, 700,
729, 759, 760, 729, 760, 730,
759, 789, 790, 759, 790, 760,
789, 819, 820, 789, 820, 790,
819, 849, 850, 819, 850, 820,
849, 879, 880, 849, 880, 850,
10, 40, 41, 10, 41, 11,
40, 70, 71, 40, 71, 41,
70, 100, 101, 70, 101, 71,
100, 130, 131, 100, 131, 101,
130, 160, 161, 130, 161, 131,
160, 190, 191, 160, 191, 161,
190, 220, 221, 190, 221, 191,
220, 250, 251, 220, 251, 221,
250, 280, 281, 250, 281, 251,
280, 310, 311, 280, 311, 281,
310, 340, 341, 310, 341, 311,
340, 370, 371, 340, 371, 341,
370, 400, 401, 370, 401, 371,
400, 430, 431, 400, 431, 401,
430, 460, 461, 430, 461, 431,
460, 490, 491, 460, 491, 461,
490, 520, 521, 490, 521, 491,
520, 550, 551, 520, 551, 521,
550, 580, 581, 550, 581, 551,
580, 610, 611, 580, 611, 581,
610, 640, 641, 610, 641, 611,
640, 670, 671, 640, 671, 641,
670, 700, 701, 670, 701, 671,
700, 730, 731, 700, 731, 701,
730, 760, 761, 730, 761, 731,
760, 790, 791, 760, 791, 761,
790, 820, 821, 790, 821, 791,
820, 850, 851, 820, 851, 821,
850, 880, 881, 850, 881, 851,
11, 41, 42, 11, 42, 12,
41, 71, 72, 41, 72, 42,
71, 101, 102, 71, 102, 72,
101, 131, 132, 101, 132, 102,
131, 161, 162, 131, 162, 132,
161, 191, 192, 161, 192, 162,
191, 221, 222, 191, 222, 192,
221, 251, 252, 221, 252, 222,
251, 281, 282, 251, 282, 252,
281, 311, 312, 281, 312, 282,
311, 341, 342, 311, 342, 312,
341, 371, 372, 341, 372, 342,
371, 401, 402, 371, 402, 372,
401, 431, 432, 401, 432, 402,
431, 461, 462, 431, 462, 432,
461, 491, 492, 461, 492, 462,
491, 521, 522, 491, 522, 492,
521, 551, 552, 521, 552, 522,
551, 581, 582, 551, 582, 552,
581, 611, 612, 581, 612, 582,
611, 641, 642, 611, 642, 612,
641, 671, 672, 641, 672, 642,
671, 701, 702, 671, 702, 672,
701, 731, 732, 701, 732, 702,
731, 761, 762, 731, 762, 732,
761, 791, 792, 761, 792, 762,
791, 821, 822, 791, 822, 792,
821, 851, 852, 821, 852, 822,
851, 881, 882, 851, 882, 852,
12, 42, 43, 12, 43, 13,
42, 72, 73, 42, 73, 43,
72, 102, 103, 72, 103, 73,
102, 132, 133, 102, 133, 103,
132, 162, 163, 132, 163, 133,
162, 192, 193, 162, 193, 163,
192, 222, 223, 192, 223, 193,
222, 252, 253, 222, 253, 223,
252, 282, 283, 252, 283, 253,
282, 312, 313, 282, 313, 283,
312, 342, 343, 312, 343, 313,
342, 372, 373, 342, 373, 343,
372, 402, 403, 372, 403, 373,
402, 432, 433, 402, 433, 403,
432, 462, 463, 432, 463, 433,
462, 492, 493, 462, 493, 463,
492, 522, 523, 492, 523, 493,
522, 552, 553, 522, 553, 523,
552, 582, 583, 552, 583, 553,
582, 612, 613, 582, 613, 583,
612, 642, 643, 612, 643, 613,
642, 672, 673, 642, 673, 643,
672, 702, 703, 672, 703, 673,
702, 732, 733, 702, 733, 703,
732, 762, 763, 732, 763, 733,
762, 792, 793, 762, 793, 763,
792, 822, 823, 792, 823, 793,
822, 852, 853, 822, 853, 823,
852, 882, 883, 852, 883, 853,
13, 43, 44, 13, 44, 14,
43, 73, 74, 43, 74, 44,
73, 103, 104, 73, 104, 74,
103, 133, 134, 103, 134, 104,
133, 163, 164, 133, 164, 134,
163, 193, 194, 163, 194, 164,
193, 223, 224, 193, 224, 194,
223, 253, 254, 223, 254, 224,
253, 283, 284, 253, 284, 254,
283, 313, 314, 283, 314, 284,
313, 343, 344, 313, 344, 314,
343, 373, 374, 343, 374, 344,
373, 403, 404, 373, 404, 374,
403, 433, 434, 403, 434, 404,
433, 463, 464, 433, 464, 434,
463, 493, 494, 463, 494, 464,
493, 523, 524, 493, 524, 494,
523, 553, 554, 523, 554, 524,
553, 583, 584, 553, 584, 554,
583, 613, 614, 583, 614, 584,
613, 643, 644, 613, 644, 614,
643, 673, 674, 643, 674, 644,
673, 703, 704, 673, 704, 674,
703, 733, 734, 703, 734, 704,
733, 763, 764, 733, 764, 734,
763, 793, 794, 763, 794, 764,
793, 823, 824, 793, 824, 794,
823, 853, 854, 823, 854, 824,
853, 883, 884, 853, 884, 854,
14, 44, 45, 14, 45, 15,
44, 74, 75, 44, 75, 45,
74, 104, 105, 74, 105, 75,
104, 134, 135, 104, 135, 105,
134, 164, 165, 134, 165, 135,
164, 194, 195, 164, 195, 165,
194, 224, 225, 194, 225, 195,
224, 254, 255, 224, 255, 225,
254, 284, 285, 254, 285, 255,
284, 314, 315, 284, 315, 285,
314, 344, 345, 314, 345, 315,
344, 374, 375, 344, 375, 345,
374, 404, 405, 374, 405, 375,
404, 434, 435, 404, 435, 405,
434, 464, 465, 434, 465, 435,
464, 494, 495, 464, 495, 465,
494, 524, 525, 494, 525, 495,
524, 554, 555, 524, 555, 525,
554, 584, 585, 554, 585, 555,
584, 614, 615, 584, 615, 585,
614, 644, 645, 614, 645, 615,
644, 674, 675, 644, 675, 645,
674, 704, 705, 674, 705, 675,
704, 734, 735, 704, 735, 705,
734, 764, 765, 734, 765, 735,
764, 794, 795, 764, 795, 765,
794, 824, 825, 794, 825, 795,
824, 854, 855, 824, 855, 825,
854, 884, 885, 854, 885, 855,
15, 45, 46, 15, 46, 16,
45, 75, 76, 45, 76, 46,
75, 105, 106, 75, 106, 76,
105, 135, 136, 105, 136, 106,
135, 165, 166, 135, 166, 136,
165, 195, 196, 165, 196, 166,
195, 225, 226, 195, 226, 196,
225, 255, 256, 225, 256, 226,
255, 285, 286, 255, 286, 256,
285, 315, 316, 285, 316, 286,
315, 345, 346, 315, 346, 316,
345, 375, 376, 345, 376, 346,
375, 405, 406, 375, 406, 376,
405, 435, 436, 405, 436, 406,
435, 465, 466, 435, 466, 436,
465, 495, 496, 465, 496, 466,
495, 525, 526, 495, 526, 496,
525, 555, 556, 525, 556, 526,
555, 585, 586, 555, 586, 556,
585, 615, 616, 585, 616, 586,
615, 645, 646, 615, 646, 616,
645, 675, 676, 645, 676, 646,
675, 705, 706, 675, 706, 676,
705, 735, 736, 705, 736, 706,
735, 765, 766, 735, 766, 736,
765, 795, 796, 765, 796, 766,
795, 825, 826, 795, 826, 796,
825, 855, 856, 825, 856, 826,
855, 885, 886, 855, 886, 856,
16, 46, 47, 16, 47, 17,
46, 76, 77, 46, 77, 47,
76, 106, 107, 76, 107, 77,
106, 136, 137, 106, 137, 107,
136, 166, 167, 136, 167, 137,
166, 196, 197, 166, 197, 167,
196, 226, 227, 196, 227, 197,
226, 256, 257, 226, 257, 227,
256, 286, 287, 256, 287, 257,
286, 316, 317, 286, 317, 287,
316, 346, 347, 316, 347, 317,
346, 376, 377, 346, 377, 347,
376, 406, 407, 376, 407, 377,
406, 436, 437, 406, 437, 407,
436, 466, 467, 436, 467, 437,
466, 496, 497, 466, 497, 467,
496, 526, 527, 496, 527, 497,
526, 556, 557, 526, 557, 527,
556, 586, 587, 556, 587, 557,
586, 616, 617, 586, 617, 587,
616, 646, 647, 616, 647, 617,
646, 676, 677, 646, 677, 647,
676, 706, 707, 676, 707, 677,
706, 736, 737, 706, 737, 707,
736, 766, 767, 736, 767, 737,
766, 796, 797, 766, 797, 767,
796, 826, 827, 796, 827, 797,
826, 856, 857, 826, 857, 827,
856, 886, 887, 856, 887, 857,
17, 47, 48, 17, 48, 18,
47, 77, 78, 47, 78, 48,
77, 107, 108, 77, 108, 78,
107, 137, 138, 107, 138, 108,
137, 167, 168, 137, 168, 138,
167, 197, 198, 167, 198, 168,
197, 227, 228, 197, 228, 198,
227, 257, 258, 227, 258, 228,
257, 287, 288, 257, 288, 258,
287, 317, 318, 287, 318, 288,
317, 347, 348, 317, 348, 318,
347, 377, 378, 347, 378, 348,
377, 407, 408, 377, 408, 378,
407, 437, 438, 407, 438, 408,
437, 467, 468, 437, 468, 438,
467, 497, 498, 467, 498, 468,
497, 527, 528, 497, 528, 498,
527, 557, 558, 527, 558, 528,
557, 587, 588, 557, 588, 558,
587, 617, 618, 587, 618, 588,
617, 647, 648, 617, 648, 618,
647, 677, 678, 647, 678, 648,
677, 707, 708, 677, 708, 678,
707, 737, 738, 707, 738, 708,
737, 767, 768, 737, 768, 738,
767, 797, 798, 767, 798, 768,
797, 827, 828, 797, 828, 798,
827, 857, 858, 827, 858, 828,
857, 887, 888, 857, 888, 858,
18, 48, 49, 18, 49, 19,
48, 78, 79, 48, 79, 49,
78, 108, 109, 78, 109, 79,
108, 138, 139, 108, 139, 109,
138, 168, 169, 138, 169, 139,
168, 198, 199, 168, 199, 169,
198, 228, 229, 198, 229, 199,
228, 258, 259, 228, 259, 229,
258, 288, 289, 258, 289, 259,
288, 318, 319, 288, 319, 289,
318, 348, 349, 318, 349, 319,
348, 378, 379, 348, 379, 349,
378, 408, 409, 378, 409, 379,
408, 438, 439, 408, 439, 409,
438, 468, 469, 438, 469, 439,
468, 498, 499, 468, 499, 469,
498, 528, 529, 498, 529, 499,
528, 558, 559, 528, 559, 529,
558, 588, 589, 558, 589, 559,
588, 618, 619, 588, 619, 589,
618, 648, 649, 618, 649, 619,
648, 678, 679, 648, 679, 649,
678, 708, 709, 678, 709, 679,
708, 738, 739, 708, 739, 709,
738, 768, 769, 738, 769, 739,
768, 798, 799, 768, 799, 769,
798, 828, 829, 798, 829, 799,
828, 858, 859, 828, 859, 829,
858, 888, 889, 858, 889, 859,
19, 49, 50, 19, 50, 20,
49, 79, 80, 49, 80, 50,
79, 109, 110, 79, 110, 80,
109, 139, 140, 109, 140, 110,
139, 169, 170, 139, 170, 140,
169, 199, 200, 169, 200, 170,
199, 229, 230, 199, 230, 200,
229, 259, 260, 229, 260, 230,
259, 289, 290, 259, 290, 260,
289, 319, 320, 289, 320, 290,
319, 349, 350, 319, 350, 320,
349, 379, 380, 349, 380, 350,
379, 409, 410, 379, 410, 380,
409, 439, 440, 409, 440, 410,
439, 469, 470, 439, 470, 440,
469, 499, 500, 469, 500, 470,
499, 529, 530, 499, 530, 500,
529, 559, 560, 529, 560, 530,
559, 589, 590, 559, 590, 560,
589, 619, 620, 589, 620, 590,
619, 649, 650, 619, 650, 620,
649, 679, 680, 649, 680, 650,
679, 709, 710, 679, 710, 680,
709, 739, 740, 709, 740, 710,
739, 769, 770, 739, 770, 740,
769, 799, 800, 769, 800, 770,
799, 829, 830, 799, 830, 800,
829, 859, 860, 829, 860, 830,
859, 889, 890, 859, 890, 860,
20, 50, 51, 20, 51, 21,
50, 80, 81, 50, 81, 51,
80, 110, 111, 80, 111, 81,
110, 140, 141, 110, 141, 111,
140, 170, 171, 140, 171, 141,
170, 200, 201, 170, 201, 171,
200, 230, 231, 200, 231, 201,
230, 260, 261, 230, 261, 231,
260, 290, 291, 260, 291, 261,
290, 320, 321, 290, 321, 291,
320, 350, 351, 320, 351, 321,
350, 380, 381, 350, 381, 351,
380, 410, 411, 380, 411, 381,
410, 440, 441, 410, 441, 411,
440, 470, 471, 440, 471, 441,
470, 500, 501, 470, 501, 471,
500, 530, 531, 500, 531, 501,
530, 560, 561, 530, 561, 531,
560, 590, 591, 560, 591, 561,
590, 620, 621, 590, 621, 591,
620, 650, 651, 620, 651, 621,
650, 680, 681, 650, 681, 651,
680, 710, 711, 680, 711, 681,
710, 740, 741, 710, 741, 711,
740, 770, 771, 740, 771, 741,
770, 800, 801, 770, 801, 771,
800, 830, 831, 800, 831, 801,
830, 860, 861, 830, 861, 831,
860, 890, 891, 860, 891, 861,
21, 51, 52, 21, 52, 22,
51, 81, 82, 51, 82, 52,
81, 111, 112, 81, 112, 82,
111, 141, 142, 111, 142, 112,
141, 171, 172, 141, 172, 142,
171, 201, 202, 171, 202, 172,
201, 231, 232, 201, 232, 202,
231, 261, 262, 231, 262, 232,
261, 291, 292, 261, 292, 262,
291, 321, 322, 291, 322, 292,
321, 351, 352, 321, 352, 322,
351, 381, 382, 351, 382, 352,
381, 411, 412, 381, 412, 382,
411, 441, 442, 411, 442, 412,
441, 471, 472, 441, 472, 442,
471, 501, 502, 471, 502, 472,
501, 531, 532, 501, 532, 502,
531, 561, 562, 531, 562, 532,
561, 591, 592, 561, 592, 562,
591, 621, 622, 591, 622, 592,
621, 651, 652, 621, 652, 622,
651, 681, 682, 651, 682, 652,
681, 711, 712, 681, 712, 682,
711, 741, 742, 711, 742, 712,
741, 771, 772, 741, 772, 742,
771, 801, 802, 771, 802, 772,
801, 831, 832, 801, 832, 802,
831, 861, 862, 831, 862, 832,
861, 891, 892, 861, 892, 862,
22, 52, 53, 22, 53, 23,
52, 82, 83, 52, 83, 53,
82, 112, 113, 82, 113, 83,
112, 142, 143, 112, 143, 113,
142, 172, 173, 142, 173, 143,
172, 202, 203, 172, 203, 173,
202, 232, 233, 202, 233, 203,
232, 262, 263, 232, 263, 233,
262, 292, 293, 262, 293, 263,
292, 322, 323, 292, 323, 293,
322, 352, 353, 322, 353, 323,
352, 382, 383, 352, 383, 353,
382, 412, 413, 382, 413, 383,
412, 442, 443, 412, 443, 413,
442, 472, 473, 442, 473, 443,
472, 502, 503, 472, 503, 473,
502, 532, 533, 502, 533, 503,
532, 562, 563, 532, 563, 533,
562, 592, 593, 562, 593, 563,
592, 622, 623, 592, 623, 593,
622, 652, 653, 622, 653, 623,
652, 682, 683, 652, 683, 653,
682, 712, 713, 682, 713, 683,
712, 742, 743, 712, 743, 713,
742, 772, 773, 742, 773, 743,
772, 802, 803, 772, 803, 773,
802, 832, 833, 802, 833, 803,
832, 862, 863, 832, 863, 833,
862, 892, 893, 862, 893, 863,
23, 53, 54, 23, 54, 24,
53, 83, 84, 53, 84, 54,
83, 113, 114, 83, 114, 84,
113, 143, 144, 113, 144, 114,
143, 173, 174, 143, 174, 144,
173, 203, 204, 173, 204, 174,
203, 233, 234, 203, 234, 204,
233, 263, 264, 233, 264, 234,
263, 293, 294, 263, 294, 264,
293, 323, 324, 293, 324, 294,
323, 353, 354, 323, 354, 324,
353, 383, 384, 353, 384, 354,
383, 413, 414, 383, 414, 384,
413, 443, 444, 413, 444, 414,
443, 473, 474, 443, 474, 444,
473, 503, 504, 473, 504, 474,
503, 533, 534, 503, 534, 504,
533, 563, 564, 533, 564, 534,
563, 593, 594, 563, 594, 564,
593, 623, 624, 593, 624, 594,
623, 653, 654, 623, 654, 624,
653, 683, 684, 653, 684, 654,
683, 713, 714, 683, 714, 684,
713, 743, 744, 713, 744, 714,
743, 773, 774, 743, 774, 744,
773, 803, 804, 773, 804, 774,
803, 833, 834, 803, 834, 804,
833, 863, 864, 833, 864, 834,
863, 893, 894, 863, 894, 864,
24, 54, 55, 24, 55, 25,
54, 84, 85, 54, 85, 55,
84, 114, 115, 84, 115, 85,
114, 144, 145, 114, 145, 115,
144, 174, 175, 144, 175, 145,
174, 204, 205, 174, 205, 175,
204, 234, 235, 204, 235, 205,
234, 264, 265, 234, 265, 235,
264, 294, 295, 264, 295, 265,
294, 324, 325, 294, 325, 295,
324, 354, 355, 324, 355, 325,
354, 384, 385, 354, 385, 355,
384, 414, 415, 384, 415, 385,
414, 444, 445, 414, 445, 415,
444, 474, 475, 444, 475, 445,
474, 504, 505, 474, 505, 475,
504, 534, 535, 504, 535, 505,
534, 564, 565, 534, 565, 535,
564, 594, 595, 564, 595, 565,
594, 624, 625, 594, 625, 595,
624, 654, 655, 624, 655, 625,
654, 684, 685, 654, 685, 655,
684, 714, 715, 684, 715, 685,
714, 744, 745, 714, 745, 715,
744, 774, 775, 744, 775, 745,
774, 804, 805, 774, 805, 775,
804, 834, 835, 804, 835, 805,
834, 864, 865, 834, 865, 835,
864, 894, 895, 864, 895, 865,
25, 55, 56, 25, 56, 26,
55, 85, 86, 55, 86, 56,
85, 115, 116, 85, 116, 86,
115, 145, 146, 115, 146, 116,
145, 175, 176, 145, 176, 146,
175, 205, 206, 175, 206, 176,
205, 235, 236, 205, 236, 206,
235, 265, 266, 235, 266, 236,
265, 295, 296, 265, 296, 266,
295, 325, 326, 295, 326, 296,
325, 355, 356, 325, 356, 326,
355, 385, 386, 355, 386, 356,
385, 415, 416, 385, 416, 386,
415, 445, 446, 415, 446, 416,
445, 475, 476, 445, 476, 446,
475, 505, 506, 475, 506, 476,
505, 535, 536, 505, 536, 506,
535, 565, 566, 535, 566, 536,
565, 595, 596, 565, 596, 566,
595, 625, 626, 595, 626, 596,
625, 655, 656, 625, 656, 626,
655, 685, 686, 655, 686, 656,
685, 715, 716, 685, 716, 686,
715, 745, 746, 715, 746, 716,
745, 775, 776, 745, 776, 746,
775, 805, 806, 775, 806, 776,
805, 835, 836, 805, 836, 806,
835, 865, 866, 835, 866, 836,
865, 895, 896, 865, 896, 866,
26, 56, 57, 26, 57, 27,
56, 86, 87, 56, 87, 57,
86, 116, 117, 86, 117, 87,
116, 146, 147, 116, 147, 117,
146, 176, 177, 146, 177, 147,
176, 206, 207, 176, 207, 177,
206, 236, 237, 206, 237, 207,
236, 266, 267, 236, 267, 237,
266, 296, 297, 266, 297, 267,
296, 326, 327, 296, 327, 297,
326, 356, 357, 326, 357, 327,
356, 386, 387, 356, 387, 357,
386, 416, 417, 386, 417, 387,
416, 446, 447, 416, 447, 417,
446, 476, 477, 446, 477, 447,
476, 506, 507, 476, 507, 477,
506, 536, 537, 506, 537, 507,
536, 566, 567, 536, 567, 537,
566, 596, 597, 566, 597, 567,
596, 626, 627, 596, 627, 597,
626, 656, 657, 626, 657, 627,
656, 686, 687, 656, 687, 657,
686, 716, 717, 686, 717, 687,
716, 746, 747, 716, 747, 717,
746, 776, 777, 746, 777, 747,
776, 806, 807, 776, 807, 777,
806, 836, 837, 806, 837, 807,
836, 866, 867, 836, 867, 837,
866, 896, 897, 866, 897, 867,
27, 57, 58, 27, 58, 28,
57, 87, 88, 57, 88, 58,
87, 117, 118, 87, 118, 88,
117, 147, 148, 117, 148, 118,
147, 177, 178, 147, 178, 148,
177, 207, 208, 177, 208, 178,
207, 237, 238, 207, 238, 208,
237, 267, 268, 237, 268, 238,
267, 297, 298, 267, 298, 268,
297, 327, 328, 297, 328, 298,
327, 357, 358, 327, 358, 328,
357, 387, 388, 357, 388, 358,
387, 417, 418, 387, 418, 388,
417, 447, 448, 417, 448, 418,
447, 477, 478, 447, 478, 448,
477, 507, 508, 477, 508, 478,
507, 537, 538, 507, 538, 508,
537, 567, 568, 537, 568, 538,
567, 597, 598, 567, 598, 568,
597, 627, 628, 597, 628, 598,
627, 657, 658, 627, 658, 628,
657, 687, 688, 657, 688, 658,
687, 717, 718, 687, 718, 688,
717, 747, 748, 717, 748, 718,
747, 777, 778, 747, 778, 748,
777, 807, 808, 777, 808, 778,
807, 837, 838, 807, 838, 808,
837, 867, 868, 837, 868, 838,
867, 897, 898, 867, 898, 868,
28, 58, 59, 28, 59, 29,
58, 88, 89, 58, 89, 59,
88, 118, 119, 88, 119, 89,
118, 148, 149, 118, 149, 119,
148, 178, 179, 148, 179, 149,
178, 208, 209, 178, 209, 179,
208, 238, 239, 208, 239, 209,
238, 268, 269, 238, 269, 239,
268, 298, 299, 268, 299, 269,
298, 328, 329, 298, 329, 299,
328, 358, 359, 328, 359, 329,
358, 388, 389, 358, 389, 359,
388, 418, 419, 388, 419, 389,
418, 448, 449, 418, 449, 419,
448, 478, 479, 448, 479, 449,
478, 508, 509, 478, 509, 479,
508, 538, 539, 508, 539, 509,
538, 568, 569, 538, 569, 539,
568, 598, 599, 568, 599, 569,
598, 628, 629, 598, 629, 599,
628, 658, 659, 628, 659, 629,
658, 688, 689, 658, 689, 659,
688, 718, 719, 688, 719, 689,
718, 748, 749, 718, 749, 719,
748, 778, 779, 748, 779, 749,
778, 808, 809, 778, 809, 779,
808, 838, 839, 808, 839, 809,
838, 868, 869, 838, 869, 839,
868, 898, 899, 868, 899, 869
]);
this.buf[34] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[34]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[34], gl.STATIC_DRAW);
this.ibuf[34] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[34]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[34] = gl.getUniformLocation(this.prog[34],"mvMatrix");
this.prMatLoc[34] = gl.getUniformLocation(this.prog[34],"prMatrix");
this.normMatLoc[34] = gl.getUniformLocation(this.prog[34],"normMatrix");
// ****** lines object 35 ******
this.flags[35] = 128;
this.vshaders[35] = "	/* ****** lines object 35 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[35] = "	/* ****** lines object 35 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[35]  = gl.createProgram();
gl.attachShader(this.prog[35], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[35] ));
gl.attachShader(this.prog[35], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[35] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[35], 0, "aPos");
gl.bindAttribLocation(this.prog[35], 1, "aCol");
gl.linkProgram(this.prog[35]);
this.offsets[35]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
2.909307, 0.0582374, -433.7844,
2.909307, 0.0582374, -433.7844,
10.06442, 0.2147828, -429.1792,
10.06442, 0.2147828, -429.1792
]);
this.values[35] = v;
this.buf[35] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[35]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[35], gl.STATIC_DRAW);
this.mvMatLoc[35] = gl.getUniformLocation(this.prog[35],"mvMatrix");
this.prMatLoc[35] = gl.getUniformLocation(this.prog[35],"prMatrix");
// ****** text object 37 ******
this.flags[37] = 40;
this.vshaders[37] = "	/* ****** text object 37 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[37] = "	/* ****** text object 37 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[37]  = gl.createProgram();
gl.attachShader(this.prog[37], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[37] ));
gl.attachShader(this.prog[37], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[37] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[37], 0, "aPos");
gl.bindAttribLocation(this.prog[37], 1, "aCol");
gl.linkProgram(this.prog[37]);
texts = [
"shape"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[37] = gl.getAttribLocation(this.prog[37], "aOfs");
this.texture[37] = gl.createTexture();
this.texLoc[37] = gl.getAttribLocation(this.prog[37], "aTexcoord");
this.sampler[37] = gl.getUniformLocation(this.prog[37],"uSampler");
handleLoadedTexture(this.texture[37], document.getElementById("persp3dtextureCanvas"));
this.offsets[37]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
6.486866, 0.03170295, -434.5649, 0, -0.5, 0.5, 0.5,
6.486866, 0.03170295, -434.5649, 1, -0.5, 0.5, 0.5,
6.486866, 0.03170295, -434.5649, 1, 1.5, 0.5, 0.5,
6.486866, 0.03170295, -434.5649, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[37].stride*(4*i + j) + this.offsets[37].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[37] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[37] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[37]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[37], gl.STATIC_DRAW);
this.ibuf[37] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[37]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[37] = gl.getUniformLocation(this.prog[37],"mvMatrix");
this.prMatLoc[37] = gl.getUniformLocation(this.prog[37],"prMatrix");
this.textScaleLoc[37] = gl.getUniformLocation(this.prog[37],"textScale");
// ****** text object 38 ******
this.flags[38] = 40;
this.vshaders[38] = "	/* ****** text object 38 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[38] = "	/* ****** text object 38 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[38]  = gl.createProgram();
gl.attachShader(this.prog[38], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[38] ));
gl.attachShader(this.prog[38], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[38] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[38], 0, "aPos");
gl.bindAttribLocation(this.prog[38], 1, "aCol");
gl.linkProgram(this.prog[38]);
texts = [
"rate"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[38] = gl.getAttribLocation(this.prog[38], "aOfs");
this.texture[38] = gl.createTexture();
this.texLoc[38] = gl.getAttribLocation(this.prog[38], "aTexcoord");
this.sampler[38] = gl.getUniformLocation(this.prog[38],"uSampler");
handleLoadedTexture(this.texture[38], document.getElementById("persp3dtextureCanvas"));
this.offsets[38]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
1.696515, 0.1365101, -434.5649, 0, -0.5, 0.5, 0.5,
1.696515, 0.1365101, -434.5649, 1, -0.5, 0.5, 0.5,
1.696515, 0.1365101, -434.5649, 1, 1.5, 0.5, 0.5,
1.696515, 0.1365101, -434.5649, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[38].stride*(4*i + j) + this.offsets[38].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[38] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[38] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[38]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[38], gl.STATIC_DRAW);
this.ibuf[38] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[38]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[38] = gl.getUniformLocation(this.prog[38],"mvMatrix");
this.prMatLoc[38] = gl.getUniformLocation(this.prog[38],"prMatrix");
this.textScaleLoc[38] = gl.getUniformLocation(this.prog[38],"textScale");
// ****** text object 39 ******
this.flags[39] = 40;
this.vshaders[39] = "	/* ****** text object 39 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[39] = "	/* ****** text object 39 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[39]  = gl.createProgram();
gl.attachShader(this.prog[39], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[39] ));
gl.attachShader(this.prog[39], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[39] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[39], 0, "aPos");
gl.bindAttribLocation(this.prog[39], 1, "aCol");
gl.linkProgram(this.prog[39]);
texts = [
"loglik"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[39] = gl.getAttribLocation(this.prog[39], "aOfs");
this.texture[39] = gl.createTexture();
this.texLoc[39] = gl.getAttribLocation(this.prog[39], "aTexcoord");
this.sampler[39] = gl.getUniformLocation(this.prog[39],"uSampler");
handleLoadedTexture(this.texture[39], document.getElementById("persp3dtextureCanvas"));
this.offsets[39]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
1.696515, 0.03170295, -431.4818, 0, -0.5, 0.5, 0.5,
1.696515, 0.03170295, -431.4818, 1, -0.5, 0.5, 0.5,
1.696515, 0.03170295, -431.4818, 1, 1.5, 0.5, 0.5,
1.696515, 0.03170295, -431.4818, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[39].stride*(4*i + j) + this.offsets[39].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[39] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[39] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[39]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[39], gl.STATIC_DRAW);
this.ibuf[39] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[39]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[39] = gl.getUniformLocation(this.prog[39],"mvMatrix");
this.prMatLoc[39] = gl.getUniformLocation(this.prog[39],"prMatrix");
this.textScaleLoc[39] = gl.getUniformLocation(this.prog[39],"textScale");
// ****** lines object 40 ******
this.flags[40] = 128;
this.vshaders[40] = "	/* ****** lines object 40 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[40] = "	/* ****** lines object 40 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[40]  = gl.createProgram();
gl.attachShader(this.prog[40], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[40] ));
gl.attachShader(this.prog[40], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[40] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[40], 0, "aPos");
gl.bindAttribLocation(this.prog[40], 1, "aCol");
gl.linkProgram(this.prog[40]);
this.offsets[40]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
4, 0.05588922, -1013.379,
10, 0.05588922, -1013.379,
4, 0.05588922, -1013.379,
4, 0.05185817, -1028.2,
6, 0.05588922, -1013.379,
6, 0.05185817, -1028.2,
8, 0.05588922, -1013.379,
8, 0.05185817, -1028.2,
10, 0.05588922, -1013.379,
10, 0.05185817, -1028.2
]);
this.values[40] = v;
this.buf[40] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[40]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[40], gl.STATIC_DRAW);
this.mvMatLoc[40] = gl.getUniformLocation(this.prog[40],"mvMatrix");
this.prMatLoc[40] = gl.getUniformLocation(this.prog[40],"prMatrix");
// ****** text object 41 ******
this.flags[41] = 40;
this.vshaders[41] = "	/* ****** text object 41 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[41] = "	/* ****** text object 41 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[41]  = gl.createProgram();
gl.attachShader(this.prog[41], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[41] ));
gl.attachShader(this.prog[41], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[41] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[41], 0, "aPos");
gl.bindAttribLocation(this.prog[41], 1, "aCol");
gl.linkProgram(this.prog[41]);
texts = [
"4",
"6",
"8",
"10"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[41] = gl.getAttribLocation(this.prog[41], "aOfs");
this.texture[41] = gl.createTexture();
this.texLoc[41] = gl.getAttribLocation(this.prog[41], "aTexcoord");
this.sampler[41] = gl.getUniformLocation(this.prog[41],"uSampler");
handleLoadedTexture(this.texture[41], document.getElementById("persp3dtextureCanvas"));
this.offsets[41]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
4, 0.04379608, -1057.841, 0, -0.5, 0.5, 0.5,
4, 0.04379608, -1057.841, 1, -0.5, 0.5, 0.5,
4, 0.04379608, -1057.841, 1, 1.5, 0.5, 0.5,
4, 0.04379608, -1057.841, 0, 1.5, 0.5, 0.5,
6, 0.04379608, -1057.841, 0, -0.5, 0.5, 0.5,
6, 0.04379608, -1057.841, 1, -0.5, 0.5, 0.5,
6, 0.04379608, -1057.841, 1, 1.5, 0.5, 0.5,
6, 0.04379608, -1057.841, 0, 1.5, 0.5, 0.5,
8, 0.04379608, -1057.841, 0, -0.5, 0.5, 0.5,
8, 0.04379608, -1057.841, 1, -0.5, 0.5, 0.5,
8, 0.04379608, -1057.841, 1, 1.5, 0.5, 0.5,
8, 0.04379608, -1057.841, 0, 1.5, 0.5, 0.5,
10, 0.04379608, -1057.841, 0, -0.5, 0.5, 0.5,
10, 0.04379608, -1057.841, 1, -0.5, 0.5, 0.5,
10, 0.04379608, -1057.841, 1, 1.5, 0.5, 0.5,
10, 0.04379608, -1057.841, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<4; i++)
for (j=0; j<4; j++) {
ind = this.offsets[41].stride*(4*i + j) + this.offsets[41].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[41] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15
]);
this.buf[41] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[41]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[41], gl.STATIC_DRAW);
this.ibuf[41] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[41]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[41] = gl.getUniformLocation(this.prog[41],"mvMatrix");
this.prMatLoc[41] = gl.getUniformLocation(this.prog[41],"prMatrix");
this.textScaleLoc[41] = gl.getUniformLocation(this.prog[41],"textScale");
// ****** lines object 42 ******
this.flags[42] = 128;
this.vshaders[42] = "	/* ****** lines object 42 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[42] = "	/* ****** lines object 42 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[42]  = gl.createProgram();
gl.attachShader(this.prog[42], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[42] ));
gl.attachShader(this.prog[42], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[42] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[42], 0, "aPos");
gl.bindAttribLocation(this.prog[42], 1, "aCol");
gl.linkProgram(this.prog[42]);
this.offsets[42]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
2.801981, 0.1, -1013.379,
2.801981, 0.2, -1013.379,
2.801981, 0.1, -1013.379,
2.617737, 0.1, -1028.2,
2.801981, 0.15, -1013.379,
2.617737, 0.15, -1028.2,
2.801981, 0.2, -1013.379,
2.617737, 0.2, -1028.2
]);
this.values[42] = v;
this.buf[42] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[42]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[42], gl.STATIC_DRAW);
this.mvMatLoc[42] = gl.getUniformLocation(this.prog[42],"mvMatrix");
this.prMatLoc[42] = gl.getUniformLocation(this.prog[42],"prMatrix");
// ****** text object 43 ******
this.flags[43] = 40;
this.vshaders[43] = "	/* ****** text object 43 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[43] = "	/* ****** text object 43 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[43]  = gl.createProgram();
gl.attachShader(this.prog[43], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[43] ));
gl.attachShader(this.prog[43], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[43] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[43], 0, "aPos");
gl.bindAttribLocation(this.prog[43], 1, "aCol");
gl.linkProgram(this.prog[43]);
texts = [
"0.1",
"0.15",
"0.2"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[43] = gl.getAttribLocation(this.prog[43], "aOfs");
this.texture[43] = gl.createTexture();
this.texLoc[43] = gl.getAttribLocation(this.prog[43], "aTexcoord");
this.sampler[43] = gl.getUniformLocation(this.prog[43],"uSampler");
handleLoadedTexture(this.texture[43], document.getElementById("persp3dtextureCanvas"));
this.offsets[43]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
2.249248, 0.1, -1057.841, 0, -0.5, 0.5, 0.5,
2.249248, 0.1, -1057.841, 1, -0.5, 0.5, 0.5,
2.249248, 0.1, -1057.841, 1, 1.5, 0.5, 0.5,
2.249248, 0.1, -1057.841, 0, 1.5, 0.5, 0.5,
2.249248, 0.15, -1057.841, 0, -0.5, 0.5, 0.5,
2.249248, 0.15, -1057.841, 1, -0.5, 0.5, 0.5,
2.249248, 0.15, -1057.841, 1, 1.5, 0.5, 0.5,
2.249248, 0.15, -1057.841, 0, 1.5, 0.5, 0.5,
2.249248, 0.2, -1057.841, 0, -0.5, 0.5, 0.5,
2.249248, 0.2, -1057.841, 1, -0.5, 0.5, 0.5,
2.249248, 0.2, -1057.841, 1, 1.5, 0.5, 0.5,
2.249248, 0.2, -1057.841, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<3; i++)
for (j=0; j<4; j++) {
ind = this.offsets[43].stride*(4*i + j) + this.offsets[43].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[43] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11
]);
this.buf[43] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[43]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[43], gl.STATIC_DRAW);
this.ibuf[43] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[43]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[43] = gl.getUniformLocation(this.prog[43],"mvMatrix");
this.prMatLoc[43] = gl.getUniformLocation(this.prog[43],"prMatrix");
this.textScaleLoc[43] = gl.getUniformLocation(this.prog[43],"textScale");
// ****** lines object 44 ******
this.flags[44] = 128;
this.vshaders[44] = "	/* ****** lines object 44 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[44] = "	/* ****** lines object 44 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[44]  = gl.createProgram();
gl.attachShader(this.prog[44], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[44] ));
gl.attachShader(this.prog[44], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[44] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[44], 0, "aPos");
gl.bindAttribLocation(this.prog[44], 1, "aCol");
gl.linkProgram(this.prog[44]);
this.offsets[44]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
2.801981, 0.05588922, -1000,
2.801981, 0.05588922, -500,
2.801981, 0.05588922, -1000,
2.617737, 0.05185817, -1000,
2.801981, 0.05588922, -900,
2.617737, 0.05185817, -900,
2.801981, 0.05588922, -800,
2.617737, 0.05185817, -800,
2.801981, 0.05588922, -700,
2.617737, 0.05185817, -700,
2.801981, 0.05588922, -600,
2.617737, 0.05185817, -600,
2.801981, 0.05588922, -500,
2.617737, 0.05185817, -500
]);
this.values[44] = v;
this.buf[44] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[44]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[44], gl.STATIC_DRAW);
this.mvMatLoc[44] = gl.getUniformLocation(this.prog[44],"mvMatrix");
this.prMatLoc[44] = gl.getUniformLocation(this.prog[44],"prMatrix");
// ****** text object 45 ******
this.flags[45] = 40;
this.vshaders[45] = "	/* ****** text object 45 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[45] = "	/* ****** text object 45 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[45]  = gl.createProgram();
gl.attachShader(this.prog[45], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[45] ));
gl.attachShader(this.prog[45], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[45] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[45], 0, "aPos");
gl.bindAttribLocation(this.prog[45], 1, "aCol");
gl.linkProgram(this.prog[45]);
texts = [
"-1000",
"-900",
"-800",
"-700",
"-600",
"-500"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[45] = gl.getAttribLocation(this.prog[45], "aOfs");
this.texture[45] = gl.createTexture();
this.texLoc[45] = gl.getAttribLocation(this.prog[45], "aTexcoord");
this.sampler[45] = gl.getUniformLocation(this.prog[45],"uSampler");
handleLoadedTexture(this.texture[45], document.getElementById("persp3dtextureCanvas"));
this.offsets[45]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
2.249248, 0.04379608, -1000, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -1000, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -1000, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -1000, 0, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -900, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -900, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -900, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -900, 0, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -800, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -800, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -800, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -800, 0, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -700, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -700, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -700, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -700, 0, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -600, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -600, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -600, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -600, 0, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -500, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -500, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -500, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -500, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<6; i++)
for (j=0; j<4; j++) {
ind = this.offsets[45].stride*(4*i + j) + this.offsets[45].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[45] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23
]);
this.buf[45] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[45]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[45], gl.STATIC_DRAW);
this.ibuf[45] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[45]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[45] = gl.getUniformLocation(this.prog[45],"mvMatrix");
this.prMatLoc[45] = gl.getUniformLocation(this.prog[45],"prMatrix");
this.textScaleLoc[45] = gl.getUniformLocation(this.prog[45],"textScale");
// ****** lines object 46 ******
this.flags[46] = 128;
this.vshaders[46] = "	/* ****** lines object 46 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[46] = "	/* ****** lines object 46 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[46]  = gl.createProgram();
gl.attachShader(this.prog[46], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[46] ));
gl.attachShader(this.prog[46], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[46] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[46], 0, "aPos");
gl.bindAttribLocation(this.prog[46], 1, "aCol");
gl.linkProgram(this.prog[46]);
this.offsets[46]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
2.801981, 0.05588922, -1013.379,
2.801981, 0.217131, -1013.379,
2.801981, 0.05588922, -420.5554,
2.801981, 0.217131, -420.5554,
2.801981, 0.05588922, -1013.379,
2.801981, 0.05588922, -420.5554,
2.801981, 0.217131, -1013.379,
2.801981, 0.217131, -420.5554,
2.801981, 0.05588922, -1013.379,
10.17175, 0.05588922, -1013.379,
2.801981, 0.05588922, -420.5554,
10.17175, 0.05588922, -420.5554,
2.801981, 0.217131, -1013.379,
10.17175, 0.217131, -1013.379,
2.801981, 0.217131, -420.5554,
10.17175, 0.217131, -420.5554,
10.17175, 0.05588922, -1013.379,
10.17175, 0.217131, -1013.379,
10.17175, 0.05588922, -420.5554,
10.17175, 0.217131, -420.5554,
10.17175, 0.05588922, -1013.379,
10.17175, 0.05588922, -420.5554,
10.17175, 0.217131, -1013.379,
10.17175, 0.217131, -420.5554
]);
this.values[46] = v;
this.buf[46] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[46]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[46], gl.STATIC_DRAW);
this.mvMatLoc[46] = gl.getUniformLocation(this.prog[46],"mvMatrix");
this.prMatLoc[46] = gl.getUniformLocation(this.prog[46],"prMatrix");
// ****** lines object 47 ******
this.flags[47] = 128;
this.vshaders[47] = "	/* ****** lines object 47 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[47] = "	/* ****** lines object 47 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[47]  = gl.createProgram();
gl.attachShader(this.prog[47], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[47] ));
gl.attachShader(this.prog[47], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[47] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[47], 0, "aPos");
gl.bindAttribLocation(this.prog[47], 1, "aCol");
gl.linkProgram(this.prog[47]);
this.offsets[47]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
4, 0.05588922, -433.8535,
10, 0.05588922, -433.8535,
4, 0.05588922, -433.8535,
4, 0.05185817, -433.972,
6, 0.05588922, -433.8535,
6, 0.05185817, -433.972,
8, 0.05588922, -433.8535,
8, 0.05185817, -433.972,
10, 0.05588922, -433.8535,
10, 0.05185817, -433.972
]);
this.values[47] = v;
this.buf[47] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[47]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[47], gl.STATIC_DRAW);
this.mvMatLoc[47] = gl.getUniformLocation(this.prog[47],"mvMatrix");
this.prMatLoc[47] = gl.getUniformLocation(this.prog[47],"prMatrix");
// ****** text object 48 ******
this.flags[48] = 40;
this.vshaders[48] = "	/* ****** text object 48 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[48] = "	/* ****** text object 48 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[48]  = gl.createProgram();
gl.attachShader(this.prog[48], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[48] ));
gl.attachShader(this.prog[48], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[48] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[48], 0, "aPos");
gl.bindAttribLocation(this.prog[48], 1, "aCol");
gl.linkProgram(this.prog[48]);
texts = [
"4",
"6",
"8",
"10"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[48] = gl.getAttribLocation(this.prog[48], "aOfs");
this.texture[48] = gl.createTexture();
this.texLoc[48] = gl.getAttribLocation(this.prog[48], "aTexcoord");
this.sampler[48] = gl.getUniformLocation(this.prog[48],"uSampler");
handleLoadedTexture(this.texture[48], document.getElementById("persp3dtextureCanvas"));
this.offsets[48]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
4, 0.04379608, -434.2092, 0, -0.5, 0.5, 0.5,
4, 0.04379608, -434.2092, 1, -0.5, 0.5, 0.5,
4, 0.04379608, -434.2092, 1, 1.5, 0.5, 0.5,
4, 0.04379608, -434.2092, 0, 1.5, 0.5, 0.5,
6, 0.04379608, -434.2092, 0, -0.5, 0.5, 0.5,
6, 0.04379608, -434.2092, 1, -0.5, 0.5, 0.5,
6, 0.04379608, -434.2092, 1, 1.5, 0.5, 0.5,
6, 0.04379608, -434.2092, 0, 1.5, 0.5, 0.5,
8, 0.04379608, -434.2092, 0, -0.5, 0.5, 0.5,
8, 0.04379608, -434.2092, 1, -0.5, 0.5, 0.5,
8, 0.04379608, -434.2092, 1, 1.5, 0.5, 0.5,
8, 0.04379608, -434.2092, 0, 1.5, 0.5, 0.5,
10, 0.04379608, -434.2092, 0, -0.5, 0.5, 0.5,
10, 0.04379608, -434.2092, 1, -0.5, 0.5, 0.5,
10, 0.04379608, -434.2092, 1, 1.5, 0.5, 0.5,
10, 0.04379608, -434.2092, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<4; i++)
for (j=0; j<4; j++) {
ind = this.offsets[48].stride*(4*i + j) + this.offsets[48].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[48] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15
]);
this.buf[48] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[48]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[48], gl.STATIC_DRAW);
this.ibuf[48] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[48]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[48] = gl.getUniformLocation(this.prog[48],"mvMatrix");
this.prMatLoc[48] = gl.getUniformLocation(this.prog[48],"prMatrix");
this.textScaleLoc[48] = gl.getUniformLocation(this.prog[48],"textScale");
// ****** lines object 49 ******
this.flags[49] = 128;
this.vshaders[49] = "	/* ****** lines object 49 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[49] = "	/* ****** lines object 49 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[49]  = gl.createProgram();
gl.attachShader(this.prog[49], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[49] ));
gl.attachShader(this.prog[49], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[49] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[49], 0, "aPos");
gl.bindAttribLocation(this.prog[49], 1, "aCol");
gl.linkProgram(this.prog[49]);
this.offsets[49]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
2.801981, 0.1, -433.8535,
2.801981, 0.2, -433.8535,
2.801981, 0.1, -433.8535,
2.617737, 0.1, -433.972,
2.801981, 0.15, -433.8535,
2.617737, 0.15, -433.972,
2.801981, 0.2, -433.8535,
2.617737, 0.2, -433.972
]);
this.values[49] = v;
this.buf[49] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[49]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[49], gl.STATIC_DRAW);
this.mvMatLoc[49] = gl.getUniformLocation(this.prog[49],"mvMatrix");
this.prMatLoc[49] = gl.getUniformLocation(this.prog[49],"prMatrix");
// ****** text object 50 ******
this.flags[50] = 40;
this.vshaders[50] = "	/* ****** text object 50 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[50] = "	/* ****** text object 50 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[50]  = gl.createProgram();
gl.attachShader(this.prog[50], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[50] ));
gl.attachShader(this.prog[50], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[50] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[50], 0, "aPos");
gl.bindAttribLocation(this.prog[50], 1, "aCol");
gl.linkProgram(this.prog[50]);
texts = [
"0.1",
"0.15",
"0.2"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[50] = gl.getAttribLocation(this.prog[50], "aOfs");
this.texture[50] = gl.createTexture();
this.texLoc[50] = gl.getAttribLocation(this.prog[50], "aTexcoord");
this.sampler[50] = gl.getUniformLocation(this.prog[50],"uSampler");
handleLoadedTexture(this.texture[50], document.getElementById("persp3dtextureCanvas"));
this.offsets[50]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
2.249248, 0.1, -434.2092, 0, -0.5, 0.5, 0.5,
2.249248, 0.1, -434.2092, 1, -0.5, 0.5, 0.5,
2.249248, 0.1, -434.2092, 1, 1.5, 0.5, 0.5,
2.249248, 0.1, -434.2092, 0, 1.5, 0.5, 0.5,
2.249248, 0.15, -434.2092, 0, -0.5, 0.5, 0.5,
2.249248, 0.15, -434.2092, 1, -0.5, 0.5, 0.5,
2.249248, 0.15, -434.2092, 1, 1.5, 0.5, 0.5,
2.249248, 0.15, -434.2092, 0, 1.5, 0.5, 0.5,
2.249248, 0.2, -434.2092, 0, -0.5, 0.5, 0.5,
2.249248, 0.2, -434.2092, 1, -0.5, 0.5, 0.5,
2.249248, 0.2, -434.2092, 1, 1.5, 0.5, 0.5,
2.249248, 0.2, -434.2092, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<3; i++)
for (j=0; j<4; j++) {
ind = this.offsets[50].stride*(4*i + j) + this.offsets[50].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[50] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11
]);
this.buf[50] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[50]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[50], gl.STATIC_DRAW);
this.ibuf[50] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[50]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[50] = gl.getUniformLocation(this.prog[50],"mvMatrix");
this.prMatLoc[50] = gl.getUniformLocation(this.prog[50],"prMatrix");
this.textScaleLoc[50] = gl.getUniformLocation(this.prog[50],"textScale");
// ****** lines object 51 ******
this.flags[51] = 128;
this.vshaders[51] = "	/* ****** lines object 51 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[51] = "	/* ****** lines object 51 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[51]  = gl.createProgram();
gl.attachShader(this.prog[51], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[51] ));
gl.attachShader(this.prog[51], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[51] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[51], 0, "aPos");
gl.bindAttribLocation(this.prog[51], 1, "aCol");
gl.linkProgram(this.prog[51]);
this.offsets[51]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
2.801981, 0.05588922, -433,
2.801981, 0.05588922, -430,
2.801981, 0.05588922, -433,
2.617737, 0.05185817, -433,
2.801981, 0.05588922, -432,
2.617737, 0.05185817, -432,
2.801981, 0.05588922, -431,
2.617737, 0.05185817, -431,
2.801981, 0.05588922, -430,
2.617737, 0.05185817, -430
]);
this.values[51] = v;
this.buf[51] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[51]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[51], gl.STATIC_DRAW);
this.mvMatLoc[51] = gl.getUniformLocation(this.prog[51],"mvMatrix");
this.prMatLoc[51] = gl.getUniformLocation(this.prog[51],"prMatrix");
// ****** text object 52 ******
this.flags[52] = 40;
this.vshaders[52] = "	/* ****** text object 52 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[52] = "	/* ****** text object 52 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[52]  = gl.createProgram();
gl.attachShader(this.prog[52], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[52] ));
gl.attachShader(this.prog[52], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[52] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[52], 0, "aPos");
gl.bindAttribLocation(this.prog[52], 1, "aCol");
gl.linkProgram(this.prog[52]);
texts = [
"-433",
"-432",
"-431",
"-430"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[52] = gl.getAttribLocation(this.prog[52], "aOfs");
this.texture[52] = gl.createTexture();
this.texLoc[52] = gl.getAttribLocation(this.prog[52], "aTexcoord");
this.sampler[52] = gl.getUniformLocation(this.prog[52],"uSampler");
handleLoadedTexture(this.texture[52], document.getElementById("persp3dtextureCanvas"));
this.offsets[52]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
2.249248, 0.04379608, -433, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -433, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -433, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -433, 0, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -432, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -432, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -432, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -432, 0, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -431, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -431, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -431, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -431, 0, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -430, 0, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -430, 1, -0.5, 0.5, 0.5,
2.249248, 0.04379608, -430, 1, 1.5, 0.5, 0.5,
2.249248, 0.04379608, -430, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<4; i++)
for (j=0; j<4; j++) {
ind = this.offsets[52].stride*(4*i + j) + this.offsets[52].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[52] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15
]);
this.buf[52] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[52]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[52], gl.STATIC_DRAW);
this.ibuf[52] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[52]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[52] = gl.getUniformLocation(this.prog[52],"mvMatrix");
this.prMatLoc[52] = gl.getUniformLocation(this.prog[52],"prMatrix");
this.textScaleLoc[52] = gl.getUniformLocation(this.prog[52],"textScale");
// ****** lines object 53 ******
this.flags[53] = 128;
this.vshaders[53] = "	/* ****** lines object 53 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[53] = "	/* ****** lines object 53 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[53]  = gl.createProgram();
gl.attachShader(this.prog[53], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[53] ));
gl.attachShader(this.prog[53], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[53] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[53], 0, "aPos");
gl.bindAttribLocation(this.prog[53], 1, "aCol");
gl.linkProgram(this.prog[53]);
this.offsets[53]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
2.801981, 0.05588922, -433.8535,
2.801981, 0.217131, -433.8535,
2.801981, 0.05588922, -429.1101,
2.801981, 0.217131, -429.1101,
2.801981, 0.05588922, -433.8535,
2.801981, 0.05588922, -429.1101,
2.801981, 0.217131, -433.8535,
2.801981, 0.217131, -429.1101,
2.801981, 0.05588922, -433.8535,
10.17175, 0.05588922, -433.8535,
2.801981, 0.05588922, -429.1101,
10.17175, 0.05588922, -429.1101,
2.801981, 0.217131, -433.8535,
10.17175, 0.217131, -433.8535,
2.801981, 0.217131, -429.1101,
10.17175, 0.217131, -429.1101,
10.17175, 0.05588922, -433.8535,
10.17175, 0.217131, -433.8535,
10.17175, 0.05588922, -429.1101,
10.17175, 0.217131, -429.1101,
10.17175, 0.05588922, -433.8535,
10.17175, 0.05588922, -429.1101,
10.17175, 0.217131, -433.8535,
10.17175, 0.217131, -429.1101
]);
this.values[53] = v;
this.buf[53] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[53]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[53], gl.STATIC_DRAW);
this.mvMatLoc[53] = gl.getUniformLocation(this.prog[53],"mvMatrix");
this.prMatLoc[53] = gl.getUniformLocation(this.prog[53],"prMatrix");
gl.enable(gl.DEPTH_TEST);
gl.depthFunc(gl.LEQUAL);
gl.clearDepth(1.0);
gl.clearColor(1,1,1,1);
var drag  = 0;
this.drawScene = function() {
gl.depthMask(true);
gl.disable(gl.BLEND);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
this.drawFns[19].call(this, 19);
gl.flush();
};
// ****** surface object 27 *******
this.drawFns[27] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0.7450981, 0.7450981, 0.7450981, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 5046, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 29 *******
this.drawFns[29] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 30 *******
this.drawFns[30] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 31 *******
this.drawFns[31] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** clipplanes object 33 *******
this.drawFns[33] = function(id, clipplanes) {
var i;
this.IMVClip[id] = [];
this.IMVClip[id][0] = this.multMV(this.invMatrix, this.vClipplane[id].slice(0, 4));
this.IMVClip[id][1] = this.multMV(this.invMatrix, this.vClipplane[id].slice(4, 8));
};
this.clipFns[33] = function(id, objid, count) {
for (i=0; i<2; i++)
gl.uniform4fv(this.clipLoc[objid][count + i], this.IMVClip[id][i]);
return(count + 2);
};
// ****** surface object 34 *******
this.drawFns[34] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0.7450981, 0.7450981, 0.7450981, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 5046, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 35 *******
this.drawFns[35] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 4);
};
// ****** text object 37 *******
this.drawFns[37] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 38 *******
this.drawFns[38] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 39 *******
this.drawFns[39] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 40 *******
this.drawFns[40] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 10);
};
// ****** text object 41 *******
this.drawFns[41] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 42 *******
this.drawFns[42] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 8);
};
// ****** text object 43 *******
this.drawFns[43] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 18, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 44 *******
this.drawFns[44] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 14);
};
// ****** text object 45 *******
this.drawFns[45] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 46 *******
this.drawFns[46] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 24);
};
// ****** lines object 47 *******
this.drawFns[47] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 10);
};
// ****** text object 48 *******
this.drawFns[48] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 49 *******
this.drawFns[49] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 8);
};
// ****** text object 50 *******
this.drawFns[50] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 18, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 51 *******
this.drawFns[51] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 10);
};
// ****** text object 52 *******
this.drawFns[52] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 53 *******
this.drawFns[53] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 24);
};
// ***** subscene 19 ****
this.drawFns[19] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.clearColor(1, 1, 1, 1);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 25 ****
this.drawFns[25] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 316.5808,
distance = 1408.504,
t = tan(this.FOV[25]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[25];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -6.486866, -0.1365101, 716.9673 );
this.mvMatrix.scale( 46.44561, 2122.858, 0.5773949 );
this.mvMatrix.multRight( persp3drgl.userMatrix[25] );
this.mvMatrix.translate(-0, -0, -1408.504);
normMatrix.makeIdentity();
normMatrix.scale( 0.02153056, 0.0004710631, 1.731917 );
normMatrix.multRight( persp3drgl.userMatrix[25] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 26 ****
this.drawFns[26] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 4.680746,
distance = 20.82515,
t = tan(this.FOV[26]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[26];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -6.486866, -0.1365101, 431.4818 );
this.mvMatrix.scale( 0.6867127, 31.38711, 1.066957 );
this.mvMatrix.multRight( persp3drgl.userMatrix[26] );
this.mvMatrix.translate(-0, -0, -20.82515);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 32 ****
this.drawFns[32] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 4.680746,
distance = 20.82515,
t = tan(this.FOV[26]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[26];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -6.486866, -0.1365101, 431.4818 );
this.mvMatrix.scale( 0.6867127, 31.38711, 1.066957 );
this.mvMatrix.multRight( persp3drgl.userMatrix[26] );
this.mvMatrix.translate(-0, -0, -20.82515);
normMatrix.makeIdentity();
normMatrix.scale( 1.456213, 0.03186021, 0.9372453 );
normMatrix.multRight( persp3drgl.userMatrix[26] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
this.drawScene();
var vpx0 = {
32: 216, 26: 216, 25: 0, 19: 0
};
var vpy0 = {
32: 0, 26: 0, 25: 0, 19: 0
};
var vpWidths = {
32: 216, 26: 216, 25: 216, 19: 216
};
var vpHeights = {
32: 216, 26: 216, 25: 216, 19: 216
};
var activeModel = {
32: 26, 26: 26, 25: 25, 19: 19
};
var activeProjection = {
32: 26, 26: 26, 25: 25, 19: 19
};
persp3drgl.listeners = {
32: [ 25,26 ], 26: [ 25,26 ],
25: [ 25,26 ], 19: [ 19 ]
};
var whichSubscene = function(coords){
if (216 <= coords.x && coords.x <= 432 && 0 <= coords.y && coords.y <= 216) return(32);
if (216 <= coords.x && coords.x <= 432 && 0 <= coords.y && coords.y <= 216) return(26);
if (0 <= coords.x && coords.x <= 216 && 0 <= coords.y && coords.y <= 216) return(25);
if (0 <= coords.x && coords.x <= 216 && 0 <= coords.y && coords.y <= 216) return(19);
return(19);
};
var translateCoords = function(subsceneid, coords){
return {x:coords.x - vpx0[subsceneid], y:coords.y - vpy0[subsceneid]};
};
var vlen = function(v) {
return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
};
var xprod = function(a, b) {
return [a[1]*b[2] - a[2]*b[1],
a[2]*b[0] - a[0]*b[2],
a[0]*b[1] - a[1]*b[0]];
};
var screenToVector = function(x, y) {
var width = vpWidths[activeSubscene],
height = vpHeights[activeSubscene],
radius = max(width, height)/2.0,
cx = width/2.0,
cy = height/2.0,
px = (x-cx)/radius,
py = (y-cy)/radius,
plen = sqrt(px*px+py*py);
if (plen > 1.e-6) {
px = px/plen;
py = py/plen;
}
var angle = (SQRT2 - plen)/SQRT2*PI/2,
z = sin(angle),
zlen = sqrt(1.0 - z*z);
px = px * zlen;
py = py * zlen;
return [px, py, z];
};
var rotBase;
var trackballdown = function(x,y) {
rotBase = screenToVector(x, y);
var l = persp3drgl.listeners[activeModel[activeSubscene]];
saveMat = {};
for (var i = 0; i < l.length; i++)
saveMat[l[i]] = new CanvasMatrix4(persp3drgl.userMatrix[l[i]]);
};
var trackballmove = function(x,y) {
var rotCurrent = screenToVector(x,y),
dot = rotBase[0]*rotCurrent[0] +
rotBase[1]*rotCurrent[1] +
rotBase[2]*rotCurrent[2],
angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180.0/PI,
axis = xprod(rotBase, rotCurrent),
l = persp3drgl.listeners[activeModel[activeSubscene]],
i;
for (i = 0; i < l.length; i++) {
persp3drgl.userMatrix[l[i]].load(saveMat[l[i]]);
persp3drgl.userMatrix[l[i]].rotate(angle, axis[0], axis[1], axis[2]);
}
persp3drgl.drawScene();
};
var trackballend = 0;
var y0zoom = 0;
var zoom0 = 0;
var zoomdown = function(x, y) {
y0zoom = y;
zoom0 = {};
l = persp3drgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
zoom0[l[i]] = log(persp3drgl.zoom[l[i]]);
};
var zoommove = function(x, y) {
l = persp3drgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
persp3drgl.zoom[l[i]] = exp(zoom0[l[i]] + (y-y0zoom)/height);
persp3drgl.drawScene();
};
var zoomend = 0;
var y0fov = 0;
var fov0 = 0;
var fovdown = function(x, y) {
y0fov = y;
fov0 = {};
l = persp3drgl.listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
fov0[l[i]] = persp3drgl.FOV[l[i]];
};
var fovmove = function(x, y) {
l = persp3drgl.listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
persp3drgl.FOV[l[i]] = max(1, min(179, fov0[l[i]] + 180*(y-y0fov)/height));
persp3drgl.drawScene();
};
var fovend = 0;
var mousedown = [trackballdown, zoomdown, fovdown];
var mousemove = [trackballmove, zoommove, fovmove];
var mouseend = [trackballend, zoomend, fovend];
function relMouseCoords(event){
var totalOffsetX = 0,
totalOffsetY = 0,
currentElement = canvas;
do{
totalOffsetX += currentElement.offsetLeft;
totalOffsetY += currentElement.offsetTop;
currentElement = currentElement.offsetParent;
}
while(currentElement);
var canvasX = event.pageX - totalOffsetX,
canvasY = event.pageY - totalOffsetY;
return {x:canvasX, y:canvasY};
}
canvas.onmousedown = function ( ev ){
if (!ev.which) // Use w3c defns in preference to MS
switch (ev.button) {
case 0: ev.which = 1; break;
case 1:
case 4: ev.which = 2; break;
case 2: ev.which = 3;
}
drag = ev.which;
var f = mousedown[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height-coords.y;
activeSubscene = whichSubscene(coords);
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
ev.preventDefault();
}
};
canvas.onmouseup = function ( ev ){
if ( drag === 0 ) return;
var f = mouseend[drag-1];
if (f)
f();
drag = 0;
};
canvas.onmouseout = canvas.onmouseup;
canvas.onmousemove = function ( ev ){
if ( drag === 0 ) return;
var f = mousemove[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height - coords.y;
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
}
};
var wheelHandler = function(ev) {
var del = 1.1;
if (ev.shiftKey) del = 1.01;
var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
l = persp3drgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
persp3drgl.zoom[l[i]] *= ds;
persp3drgl.drawScene();
ev.preventDefault();
};
canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
canvas.addEventListener("mousewheel", wheelHandler, false);
};
</script>
<canvas id="persp3dcanvas" class="rglWebGL" width="1" height="1"></canvas>
<p id="persp3ddebug">
You must enable Javascript to view this page properly.</p>
<script>persp3drgl.start();</script>

 On the left, the whole surface over a range of the parameters; on the right, only the 
parts of the surface with log likelihood values near the maximum.

## Adding Graphical Elements

### Primitive shapes

Just as we have <a href="../../graphics/help/points">`points`</a> and 
<a href="../../graphics/help/lines">`lines`</a> in classic graphics, there are a number
of low level functions in `rgl` to add graphical elements to the
currently active plot.  The "primitive" shapes are those that are 
native to OpenGL:

----------------------------- | -----------
<a name="points3d"><a href="../../rgl/help/points3d">`points3d`</a></a>:     | adds points
<a name="lines3d"><a href="../../rgl/help/lines3d">`lines3d`</a></a>:      | adds lines
<a name="segments3d"><a href="../../rgl/help/segments3d">`segments3d`</a></a>:   | adds line segments
<a name="triangles3d"><a href="../../rgl/help/triangles3d">`triangles3d`</a></a>:  | adds triangles
<a name="quads3d"><a href="../../rgl/help/quads3d">`quads3d`</a></a>:      | adds quadrilaterals

Each of the above functions takes arguments `x`, `y` and `z`, again
using <a href="../../grDevices/help/xyz.coords">`xyz.coords`</a> for flexibility.
They group successive entries
as necessary.  For example, the <a href="#triangles3d">`triangles3d`</a> function takes each
successive triple of points as the vertices of a triangle.

You can use these functions to annotate the current graph, or to 
construct a figure from scratch.

### Constructed shapes

`rgl` also has a number of objects which it constructs
from the primitives.

----------------------------- | -----------
<a name="text3d"><a href="../../rgl/help/text3d">`text3d`</a></a>, <a name="texts3d"><a href="../../rgl/help/texts3d">`texts3d`</a></a>: | adds text
<a name="abclines3d"><a href="../../rgl/help/abclines3d">`abclines3d`</a></a>:   | adds straight lines to plot (like `abline`)
<a name="planes3d"><a href="../../rgl/help/planes3d">`planes3d`</a></a>:     | adds planes to plot
<a name="clipplanes3d"><a href="../../rgl/help/clipplanes3d">`clipplanes3d`</a></a>: | add clipping planes to plot
<a name="sprites3d"><a href="../../rgl/help/sprites3d">`sprites3d`</a></a>, <a name="particles3d"><a href="../../rgl/help/particles3d">`particles3d`</a></a>: | add sprites (fixed shapes or images) to plot
<a name="spheres3d"><a href="../../rgl/help/spheres3d">`spheres3d`</a></a>:    | adds spheres
<a name="surface3d"><a href="../../rgl/help/surface3d">`surface3d`</a></a>, <a name="terrain3d"><a href="../../rgl/help/terrain3d">`terrain3d`</a></a>:    | a surface (as used in <a href="#persp3d">`persp3d`</a>)

### Axes and other "decorations"

The following low-level functions control the look of the graph:

------------------------------------ | -----------
<a name="axes3d"><a href="../../rgl/help/axes3d">`axes3d`</a></a>, <a name="axis3d"><a href="../../rgl/help/axis3d">`axis3d`</a></a>: | add axes to plot
<a name="box3d"><a href="../../rgl/help/box3d">`box3d`</a></a>, <a name="bbox3d"><a href="../../rgl/help/bbox3d">`bbox3d`</a></a>:               | add box around plot
<a name="title3d"><a href="../../rgl/help/title3d">`title3d`</a></a>:             | add title to plot
<a name="mtext3d"><a href="../../rgl/help/mtext3d">`mtext3d`</a></a>:             | add marginal text to plot
<a name="decorate3d"><a href="../../rgl/help/decorate3d">`decorate3d`</a></a>:          | add multiple "decorations" (scales, etc.) to plot
<a name="aspect3d"><a href="../../rgl/help/aspect3d">`aspect3d`</a></a>:            | set the aspect ratios for the plot
<a name="bg3d"><a href="../../rgl/help/bg3d">`bg3d`</a></a>, <a name="bgplot3d"><a href="../../rgl/help/bgplot3d">`bgplot3d`</a></a>: | set the background of the scene
<a name="legend3d"><a href="../../rgl/help/legend3d">`legend3d`</a></a>:            | set a legend for the scene
<a name="grid3d"><a href="../../rgl/help/grid3d">`grid3d`</a></a>:              | add a reference grid to a graph

For example, to plot three random triangles, one could use

```r
triangles3d(cbind(x=rnorm(9), y=rnorm(9), z=rnorm(9)), col = "green")
decorate3d()
bg3d("lightgray")
aspect3d(1,1,1)
```

<canvas id="unnamed_chunk_1textureCanvas" style="display: none;" width="256" height="256">
Your browser does not support the HTML5 canvas element.</canvas>
<script type="text/javascript">
var unnamed_chunk_1rgl = new rglClass();
unnamed_chunk_1rgl.start = function() {
var i, j, v, ind, texts, f, texinfo;
var debug = function(msg) {
document.getElementById("unnamed_chunk_1debug").innerHTML = msg;
};
debug("");
var canvas = document.getElementById("unnamed_chunk_1canvas");
if (!window.WebGLRenderingContext){
debug(" Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
try {
// Try to grab the standard context. If it fails, fallback to experimental.
this.gl = canvas.getContext("webgl") ||
canvas.getContext("experimental-webgl");
}
catch(e) {}
if ( !this.gl ) {
debug(" Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var gl = this.gl,
width = 217, height = 217;
canvas.width = width;   canvas.height = height;
var normMatrix = new CanvasMatrix4(),
saveMat = {},
distance,
posLoc = 0,
colLoc = 1;
var activeSubscene = 54;
this.flags[54] = 1195;
this.zoom[54] = 1;
this.FOV[54] = 30;
this.viewport[54] = [0, 0, 216, 216];
this.userMatrix[54] = new CanvasMatrix4();
this.userMatrix[54].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[54] = [];
this.opaque[54] = [60,62,63,64,66,67,68,69,70,71,72];
this.transparent[54] = [];
this.subscenes[54] = [];
function getPowerOfTwo(value) {
var pow = 1;
while(pow<value) {
pow *= 2;
}
return pow;
}
function handleLoadedTexture(texture, textureCanvas) {
gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
gl.bindTexture(gl.TEXTURE_2D, texture);
gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
gl.generateMipmap(gl.TEXTURE_2D);
gl.bindTexture(gl.TEXTURE_2D, null);
}
function loadImageToTexture(filename, texture) {
var canvas = document.getElementById("unnamed_chunk_1textureCanvas"),
ctx = canvas.getContext("2d"),
image = new Image();
image.onload = function() {
var w = image.width,
h = image.height,
canvasX = getPowerOfTwo(w),
canvasY = getPowerOfTwo(h);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.imageSmoothingEnabled = true;
ctx.drawImage(image, 0, 0, canvasX, canvasY);
handleLoadedTexture(texture, canvas);
unnamed_chunk_1rgl.drawScene();
};
image.src = filename;
}
function drawTextToCanvas(text, cex) {
var canvasX, canvasY,
textX, textY,
textHeight = 20 * cex,
textColour = "white",
fontFamily = "Arial",
backgroundColour = "rgba(0,0,0,0)",
canvas = document.getElementById("unnamed_chunk_1textureCanvas"),
ctx = canvas.getContext("2d"),
i;
ctx.font = textHeight+"px "+fontFamily;
canvasX = 1;
var widths = [];
for (i = 0; i < text.length; i++)  {
widths[i] = ctx.measureText(text[i]).width;
canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
}
canvasX = getPowerOfTwo(canvasX);
var offset = 2*textHeight, // offset to first baseline
skip = 2*textHeight;   // skip between baselines
canvasY = getPowerOfTwo(offset + text.length*skip);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.fillStyle = backgroundColour;
ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
ctx.fillStyle = textColour;
ctx.textAlign = "left";
ctx.textBaseline = "alphabetic";
ctx.font = textHeight+"px "+fontFamily;
for(i = 0; i < text.length; i++) {
textY = i*skip + offset;
ctx.fillText(text[i], 0,  textY);
}
return {canvasX:canvasX, canvasY:canvasY,
widths:widths, textHeight:textHeight,
offset:offset, skip:skip};
}
// ****** triangles object 60 ******
this.flags[60] = 3;
this.vshaders[60] = "	/* ****** triangles object 60 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[60] = "	/* ****** triangles object 60 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[60]  = gl.createProgram();
gl.attachShader(this.prog[60], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[60] ));
gl.attachShader(this.prog[60], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[60] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[60], 0, "aPos");
gl.bindAttribLocation(this.prog[60], 1, "aCol");
gl.linkProgram(this.prog[60]);
this.offsets[60]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
0.6028703, -0.3925536, -0.2639929, -0.19687, 0.4126596, 0.8893561,
-0.7661688, 0.007051324, -0.7524627, -0.19687, 0.4126596, 0.8893561,
-0.6203265, -2.494835, 0.4406921, -0.19687, 0.4126596, 0.8893561,
0.7901903, -0.9772964, -1.277451, 0.3610578, 0.8426577, -0.3994564,
-0.2419765, 0.6285688, 1.177192, 0.3610578, 0.8426577, -0.3994564,
1.117486, -0.08414047, 0.9025058, 0.3610578, 0.8426577, -0.3994564,
1.184931, 0.3821316, -1.261304, 0.8436591, -0.3339899, -0.4203451,
1.646475, -1.093414, 0.8374552, 0.8436591, -0.3339899, -0.4203451,
0.1929962, -0.755464, -2.34829, 0.8436591, -0.3339899, -0.4203451
]);
this.values[60] = v;
this.normLoc[60] = gl.getAttribLocation(this.prog[60], "aNorm");
this.buf[60] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[60]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[60], gl.STATIC_DRAW);
this.mvMatLoc[60] = gl.getUniformLocation(this.prog[60],"mvMatrix");
this.prMatLoc[60] = gl.getUniformLocation(this.prog[60],"prMatrix");
this.normMatLoc[60] = gl.getUniformLocation(this.prog[60],"normMatrix");
// ****** text object 62 ******
this.flags[62] = 40;
this.vshaders[62] = "	/* ****** text object 62 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[62] = "	/* ****** text object 62 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[62]  = gl.createProgram();
gl.attachShader(this.prog[62], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[62] ));
gl.attachShader(this.prog[62], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[62] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[62], 0, "aPos");
gl.bindAttribLocation(this.prog[62], 1, "aCol");
gl.linkProgram(this.prog[62]);
texts = [
"x"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[62] = gl.getAttribLocation(this.prog[62], "aOfs");
this.texture[62] = gl.createTexture();
this.texLoc[62] = gl.getAttribLocation(this.prog[62], "aTexcoord");
this.sampler[62] = gl.getUniformLocation(this.prog[62],"uSampler");
handleLoadedTexture(this.texture[62], document.getElementById("unnamed_chunk_1textureCanvas"));
this.offsets[62]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
0.440153, -3.024252, -2.945859, 0, -0.5, 0.5, 0.5,
0.440153, -3.024252, -2.945859, 1, -0.5, 0.5, 0.5,
0.440153, -3.024252, -2.945859, 1, 1.5, 0.5, 0.5,
0.440153, -3.024252, -2.945859, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[62].stride*(4*i + j) + this.offsets[62].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[62] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[62] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[62]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[62], gl.STATIC_DRAW);
this.ibuf[62] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[62]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[62] = gl.getUniformLocation(this.prog[62],"mvMatrix");
this.prMatLoc[62] = gl.getUniformLocation(this.prog[62],"prMatrix");
this.textScaleLoc[62] = gl.getUniformLocation(this.prog[62],"textScale");
// ****** text object 63 ******
this.flags[63] = 40;
this.vshaders[63] = "	/* ****** text object 63 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[63] = "	/* ****** text object 63 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[63]  = gl.createProgram();
gl.attachShader(this.prog[63], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[63] ));
gl.attachShader(this.prog[63], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[63] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[63], 0, "aPos");
gl.bindAttribLocation(this.prog[63], 1, "aCol");
gl.linkProgram(this.prog[63]);
texts = [
"y"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[63] = gl.getAttribLocation(this.prog[63], "aOfs");
this.texture[63] = gl.createTexture();
this.texLoc[63] = gl.getAttribLocation(this.prog[63], "aTexcoord");
this.sampler[63] = gl.getUniformLocation(this.prog[63],"uSampler");
handleLoadedTexture(this.texture[63], document.getElementById("unnamed_chunk_1textureCanvas"));
this.offsets[63]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
-1.175112, -0.9331332, -2.945859, 0, -0.5, 0.5, 0.5,
-1.175112, -0.9331332, -2.945859, 1, -0.5, 0.5, 0.5,
-1.175112, -0.9331332, -2.945859, 1, 1.5, 0.5, 0.5,
-1.175112, -0.9331332, -2.945859, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[63].stride*(4*i + j) + this.offsets[63].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[63] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[63] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[63]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[63], gl.STATIC_DRAW);
this.ibuf[63] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[63]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[63] = gl.getUniformLocation(this.prog[63],"mvMatrix");
this.prMatLoc[63] = gl.getUniformLocation(this.prog[63],"prMatrix");
this.textScaleLoc[63] = gl.getUniformLocation(this.prog[63],"textScale");
// ****** text object 64 ******
this.flags[64] = 40;
this.vshaders[64] = "	/* ****** text object 64 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[64] = "	/* ****** text object 64 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[64]  = gl.createProgram();
gl.attachShader(this.prog[64], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[64] ));
gl.attachShader(this.prog[64], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[64] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[64], 0, "aPos");
gl.bindAttribLocation(this.prog[64], 1, "aCol");
gl.linkProgram(this.prog[64]);
texts = [
"z"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[64] = gl.getAttribLocation(this.prog[64], "aOfs");
this.texture[64] = gl.createTexture();
this.texLoc[64] = gl.getAttribLocation(this.prog[64], "aTexcoord");
this.sampler[64] = gl.getUniformLocation(this.prog[64],"uSampler");
handleLoadedTexture(this.texture[64], document.getElementById("unnamed_chunk_1textureCanvas"));
this.offsets[64]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
-1.175112, -3.024252, -0.5855491, 0, -0.5, 0.5, 0.5,
-1.175112, -3.024252, -0.5855491, 1, -0.5, 0.5, 0.5,
-1.175112, -3.024252, -0.5855491, 1, 1.5, 0.5, 0.5,
-1.175112, -3.024252, -0.5855491, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[64].stride*(4*i + j) + this.offsets[64].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[64] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[64] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[64]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[64], gl.STATIC_DRAW);
this.ibuf[64] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[64]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[64] = gl.getUniformLocation(this.prog[64],"mvMatrix");
this.prMatLoc[64] = gl.getUniformLocation(this.prog[64],"prMatrix");
this.textScaleLoc[64] = gl.getUniformLocation(this.prog[64],"textScale");
// ****** lines object 66 ******
this.flags[66] = 128;
this.vshaders[66] = "	/* ****** lines object 66 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[66] = "	/* ****** lines object 66 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[66]  = gl.createProgram();
gl.attachShader(this.prog[66], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[66] ));
gl.attachShader(this.prog[66], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[66] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[66], 0, "aPos");
gl.bindAttribLocation(this.prog[66], 1, "aCol");
gl.linkProgram(this.prog[66]);
this.offsets[66]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
-0.5, -2.541687, -2.401172,
1.5, -2.541687, -2.401172,
-0.5, -2.541687, -2.401172,
-0.5, -2.622114, -2.491954,
0, -2.541687, -2.401172,
0, -2.622114, -2.491954,
0.5, -2.541687, -2.401172,
0.5, -2.622114, -2.491954,
1, -2.541687, -2.401172,
1, -2.622114, -2.491954,
1.5, -2.541687, -2.401172,
1.5, -2.622114, -2.491954
]);
this.values[66] = v;
this.buf[66] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[66]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[66], gl.STATIC_DRAW);
this.mvMatLoc[66] = gl.getUniformLocation(this.prog[66],"mvMatrix");
this.prMatLoc[66] = gl.getUniformLocation(this.prog[66],"prMatrix");
// ****** text object 67 ******
this.flags[67] = 40;
this.vshaders[67] = "	/* ****** text object 67 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[67] = "	/* ****** text object 67 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[67]  = gl.createProgram();
gl.attachShader(this.prog[67], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[67] ));
gl.attachShader(this.prog[67], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[67] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[67], 0, "aPos");
gl.bindAttribLocation(this.prog[67], 1, "aCol");
gl.linkProgram(this.prog[67]);
texts = [
"-0.5",
"0",
"0.5",
"1",
"1.5"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[67] = gl.getAttribLocation(this.prog[67], "aOfs");
this.texture[67] = gl.createTexture();
this.texLoc[67] = gl.getAttribLocation(this.prog[67], "aTexcoord");
this.sampler[67] = gl.getUniformLocation(this.prog[67],"uSampler");
handleLoadedTexture(this.texture[67], document.getElementById("unnamed_chunk_1textureCanvas"));
this.offsets[67]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
-0.5, -2.782969, -2.673516, 0, -0.5, 0.5, 0.5,
-0.5, -2.782969, -2.673516, 1, -0.5, 0.5, 0.5,
-0.5, -2.782969, -2.673516, 1, 1.5, 0.5, 0.5,
-0.5, -2.782969, -2.673516, 0, 1.5, 0.5, 0.5,
0, -2.782969, -2.673516, 0, -0.5, 0.5, 0.5,
0, -2.782969, -2.673516, 1, -0.5, 0.5, 0.5,
0, -2.782969, -2.673516, 1, 1.5, 0.5, 0.5,
0, -2.782969, -2.673516, 0, 1.5, 0.5, 0.5,
0.5, -2.782969, -2.673516, 0, -0.5, 0.5, 0.5,
0.5, -2.782969, -2.673516, 1, -0.5, 0.5, 0.5,
0.5, -2.782969, -2.673516, 1, 1.5, 0.5, 0.5,
0.5, -2.782969, -2.673516, 0, 1.5, 0.5, 0.5,
1, -2.782969, -2.673516, 0, -0.5, 0.5, 0.5,
1, -2.782969, -2.673516, 1, -0.5, 0.5, 0.5,
1, -2.782969, -2.673516, 1, 1.5, 0.5, 0.5,
1, -2.782969, -2.673516, 0, 1.5, 0.5, 0.5,
1.5, -2.782969, -2.673516, 0, -0.5, 0.5, 0.5,
1.5, -2.782969, -2.673516, 1, -0.5, 0.5, 0.5,
1.5, -2.782969, -2.673516, 1, 1.5, 0.5, 0.5,
1.5, -2.782969, -2.673516, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<5; i++)
for (j=0; j<4; j++) {
ind = this.offsets[67].stride*(4*i + j) + this.offsets[67].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[67] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19
]);
this.buf[67] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[67]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[67], gl.STATIC_DRAW);
this.ibuf[67] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[67]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[67] = gl.getUniformLocation(this.prog[67],"mvMatrix");
this.prMatLoc[67] = gl.getUniformLocation(this.prog[67],"prMatrix");
this.textScaleLoc[67] = gl.getUniformLocation(this.prog[67],"textScale");
// ****** lines object 68 ******
this.flags[68] = 128;
this.vshaders[68] = "	/* ****** lines object 68 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[68] = "	/* ****** lines object 68 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[68]  = gl.createProgram();
gl.attachShader(this.prog[68], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[68] ));
gl.attachShader(this.prog[68], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[68] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[68], 0, "aPos");
gl.bindAttribLocation(this.prog[68], 1, "aCol");
gl.linkProgram(this.prog[68]);
this.offsets[68]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
-0.8023585, -2, -2.401172,
-0.8023585, 0.5, -2.401172,
-0.8023585, -2, -2.401172,
-0.8644841, -2, -2.491954,
-0.8023585, -1.5, -2.401172,
-0.8644841, -1.5, -2.491954,
-0.8023585, -1, -2.401172,
-0.8644841, -1, -2.491954,
-0.8023585, -0.5, -2.401172,
-0.8644841, -0.5, -2.491954,
-0.8023585, 0, -2.401172,
-0.8644841, 0, -2.491954,
-0.8023585, 0.5, -2.401172,
-0.8644841, 0.5, -2.491954
]);
this.values[68] = v;
this.buf[68] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[68]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[68], gl.STATIC_DRAW);
this.mvMatLoc[68] = gl.getUniformLocation(this.prog[68],"mvMatrix");
this.prMatLoc[68] = gl.getUniformLocation(this.prog[68],"prMatrix");
// ****** text object 69 ******
this.flags[69] = 40;
this.vshaders[69] = "	/* ****** text object 69 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[69] = "	/* ****** text object 69 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[69]  = gl.createProgram();
gl.attachShader(this.prog[69], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[69] ));
gl.attachShader(this.prog[69], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[69] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[69], 0, "aPos");
gl.bindAttribLocation(this.prog[69], 1, "aCol");
gl.linkProgram(this.prog[69]);
texts = [
"-2",
"-1.5",
"-1",
"-0.5",
"0",
"0.5"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[69] = gl.getAttribLocation(this.prog[69], "aOfs");
this.texture[69] = gl.createTexture();
this.texLoc[69] = gl.getAttribLocation(this.prog[69], "aTexcoord");
this.sampler[69] = gl.getUniformLocation(this.prog[69],"uSampler");
handleLoadedTexture(this.texture[69], document.getElementById("unnamed_chunk_1textureCanvas"));
this.offsets[69]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
-0.9887352, -2, -2.673516, 0, -0.5, 0.5, 0.5,
-0.9887352, -2, -2.673516, 1, -0.5, 0.5, 0.5,
-0.9887352, -2, -2.673516, 1, 1.5, 0.5, 0.5,
-0.9887352, -2, -2.673516, 0, 1.5, 0.5, 0.5,
-0.9887352, -1.5, -2.673516, 0, -0.5, 0.5, 0.5,
-0.9887352, -1.5, -2.673516, 1, -0.5, 0.5, 0.5,
-0.9887352, -1.5, -2.673516, 1, 1.5, 0.5, 0.5,
-0.9887352, -1.5, -2.673516, 0, 1.5, 0.5, 0.5,
-0.9887352, -1, -2.673516, 0, -0.5, 0.5, 0.5,
-0.9887352, -1, -2.673516, 1, -0.5, 0.5, 0.5,
-0.9887352, -1, -2.673516, 1, 1.5, 0.5, 0.5,
-0.9887352, -1, -2.673516, 0, 1.5, 0.5, 0.5,
-0.9887352, -0.5, -2.673516, 0, -0.5, 0.5, 0.5,
-0.9887352, -0.5, -2.673516, 1, -0.5, 0.5, 0.5,
-0.9887352, -0.5, -2.673516, 1, 1.5, 0.5, 0.5,
-0.9887352, -0.5, -2.673516, 0, 1.5, 0.5, 0.5,
-0.9887352, 0, -2.673516, 0, -0.5, 0.5, 0.5,
-0.9887352, 0, -2.673516, 1, -0.5, 0.5, 0.5,
-0.9887352, 0, -2.673516, 1, 1.5, 0.5, 0.5,
-0.9887352, 0, -2.673516, 0, 1.5, 0.5, 0.5,
-0.9887352, 0.5, -2.673516, 0, -0.5, 0.5, 0.5,
-0.9887352, 0.5, -2.673516, 1, -0.5, 0.5, 0.5,
-0.9887352, 0.5, -2.673516, 1, 1.5, 0.5, 0.5,
-0.9887352, 0.5, -2.673516, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<6; i++)
for (j=0; j<4; j++) {
ind = this.offsets[69].stride*(4*i + j) + this.offsets[69].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[69] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23
]);
this.buf[69] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[69]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[69], gl.STATIC_DRAW);
this.ibuf[69] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[69]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[69] = gl.getUniformLocation(this.prog[69],"mvMatrix");
this.prMatLoc[69] = gl.getUniformLocation(this.prog[69],"prMatrix");
this.textScaleLoc[69] = gl.getUniformLocation(this.prog[69],"textScale");
// ****** lines object 70 ******
this.flags[70] = 128;
this.vshaders[70] = "	/* ****** lines object 70 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[70] = "	/* ****** lines object 70 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[70]  = gl.createProgram();
gl.attachShader(this.prog[70], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[70] ));
gl.attachShader(this.prog[70], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[70] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[70], 0, "aPos");
gl.bindAttribLocation(this.prog[70], 1, "aCol");
gl.linkProgram(this.prog[70]);
this.offsets[70]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
-0.8023585, -2.541687, -2,
-0.8023585, -2.541687, 1,
-0.8023585, -2.541687, -2,
-0.8644841, -2.622114, -2,
-0.8023585, -2.541687, -1,
-0.8644841, -2.622114, -1,
-0.8023585, -2.541687, 0,
-0.8644841, -2.622114, 0,
-0.8023585, -2.541687, 1,
-0.8644841, -2.622114, 1
]);
this.values[70] = v;
this.buf[70] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[70]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[70], gl.STATIC_DRAW);
this.mvMatLoc[70] = gl.getUniformLocation(this.prog[70],"mvMatrix");
this.prMatLoc[70] = gl.getUniformLocation(this.prog[70],"prMatrix");
// ****** text object 71 ******
this.flags[71] = 40;
this.vshaders[71] = "	/* ****** text object 71 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[71] = "	/* ****** text object 71 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[71]  = gl.createProgram();
gl.attachShader(this.prog[71], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[71] ));
gl.attachShader(this.prog[71], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[71] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[71], 0, "aPos");
gl.bindAttribLocation(this.prog[71], 1, "aCol");
gl.linkProgram(this.prog[71]);
texts = [
"-2",
"-1",
"0",
"1"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[71] = gl.getAttribLocation(this.prog[71], "aOfs");
this.texture[71] = gl.createTexture();
this.texLoc[71] = gl.getAttribLocation(this.prog[71], "aTexcoord");
this.sampler[71] = gl.getUniformLocation(this.prog[71],"uSampler");
handleLoadedTexture(this.texture[71], document.getElementById("unnamed_chunk_1textureCanvas"));
this.offsets[71]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
-0.9887352, -2.782969, -2, 0, -0.5, 0.5, 0.5,
-0.9887352, -2.782969, -2, 1, -0.5, 0.5, 0.5,
-0.9887352, -2.782969, -2, 1, 1.5, 0.5, 0.5,
-0.9887352, -2.782969, -2, 0, 1.5, 0.5, 0.5,
-0.9887352, -2.782969, -1, 0, -0.5, 0.5, 0.5,
-0.9887352, -2.782969, -1, 1, -0.5, 0.5, 0.5,
-0.9887352, -2.782969, -1, 1, 1.5, 0.5, 0.5,
-0.9887352, -2.782969, -1, 0, 1.5, 0.5, 0.5,
-0.9887352, -2.782969, 0, 0, -0.5, 0.5, 0.5,
-0.9887352, -2.782969, 0, 1, -0.5, 0.5, 0.5,
-0.9887352, -2.782969, 0, 1, 1.5, 0.5, 0.5,
-0.9887352, -2.782969, 0, 0, 1.5, 0.5, 0.5,
-0.9887352, -2.782969, 1, 0, -0.5, 0.5, 0.5,
-0.9887352, -2.782969, 1, 1, -0.5, 0.5, 0.5,
-0.9887352, -2.782969, 1, 1, 1.5, 0.5, 0.5,
-0.9887352, -2.782969, 1, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<4; i++)
for (j=0; j<4; j++) {
ind = this.offsets[71].stride*(4*i + j) + this.offsets[71].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[71] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15
]);
this.buf[71] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[71]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[71], gl.STATIC_DRAW);
this.ibuf[71] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[71]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[71] = gl.getUniformLocation(this.prog[71],"mvMatrix");
this.prMatLoc[71] = gl.getUniformLocation(this.prog[71],"prMatrix");
this.textScaleLoc[71] = gl.getUniformLocation(this.prog[71],"textScale");
// ****** lines object 72 ******
this.flags[72] = 128;
this.vshaders[72] = "	/* ****** lines object 72 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	}";
this.fshaders[72] = "	/* ****** lines object 72 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  gl_FragColor = lighteffect;\n	}";
this.prog[72]  = gl.createProgram();
gl.attachShader(this.prog[72], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[72] ));
gl.attachShader(this.prog[72], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[72] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[72], 0, "aPos");
gl.bindAttribLocation(this.prog[72], 1, "aCol");
gl.linkProgram(this.prog[72]);
this.offsets[72]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:-1, tofs:-1, stride:3};
v=new Float32Array([
-0.8023585, -2.541687, -2.401172,
-0.8023585, 0.6754199, -2.401172,
-0.8023585, -2.541687, 1.230074,
-0.8023585, 0.6754199, 1.230074,
-0.8023585, -2.541687, -2.401172,
-0.8023585, -2.541687, 1.230074,
-0.8023585, 0.6754199, -2.401172,
-0.8023585, 0.6754199, 1.230074,
-0.8023585, -2.541687, -2.401172,
1.682665, -2.541687, -2.401172,
-0.8023585, -2.541687, 1.230074,
1.682665, -2.541687, 1.230074,
-0.8023585, 0.6754199, -2.401172,
1.682665, 0.6754199, -2.401172,
-0.8023585, 0.6754199, 1.230074,
1.682665, 0.6754199, 1.230074,
1.682665, -2.541687, -2.401172,
1.682665, 0.6754199, -2.401172,
1.682665, -2.541687, 1.230074,
1.682665, 0.6754199, 1.230074,
1.682665, -2.541687, -2.401172,
1.682665, -2.541687, 1.230074,
1.682665, 0.6754199, -2.401172,
1.682665, 0.6754199, 1.230074
]);
this.values[72] = v;
this.buf[72] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[72]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[72], gl.STATIC_DRAW);
this.mvMatLoc[72] = gl.getUniformLocation(this.prog[72],"mvMatrix");
this.prMatLoc[72] = gl.getUniformLocation(this.prog[72],"prMatrix");
gl.enable(gl.DEPTH_TEST);
gl.depthFunc(gl.LEQUAL);
gl.clearDepth(1.0);
gl.clearColor(1,1,1,1);
var drag  = 0;
this.drawScene = function() {
gl.depthMask(true);
gl.disable(gl.BLEND);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
this.drawFns[54].call(this, 54);
gl.flush();
};
// ****** triangles object 60 *******
this.drawFns[60] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 1, 0, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.TRIANGLES, 0, 9);
};
// ****** text object 62 *******
this.drawFns[62] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 63 *******
this.drawFns[63] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 64 *******
this.drawFns[64] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 66 *******
this.drawFns[66] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 12);
};
// ****** text object 67 *******
this.drawFns[67] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 68 *******
this.drawFns[68] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 14);
};
// ****** text object 69 *******
this.drawFns[69] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 70 *******
this.drawFns[70] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 10);
};
// ****** text object 71 *******
this.drawFns[71] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
};
// ****** lines object 72 *******
this.drawFns[72] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.LINES, 0, 24);
};
// ***** subscene 54 ****
this.drawFns[54] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.clearColor(0.827451, 0.827451, 0.827451, 1);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
this.prMatrix.makeIdentity();
var radius = 2.910614,
distance = 12.94965,
t = tan(this.FOV[54]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[54];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0.440153, 0.9331333, 0.5855491 );
this.mvMatrix.scale( 1.266392, 0.9782122, 0.866648 );
this.mvMatrix.multRight( unnamed_chunk_1rgl.userMatrix[54] );
this.mvMatrix.translate(-0, -0, -12.94965);
normMatrix.makeIdentity();
normMatrix.scale( 0.7896451, 1.022273, 1.153871 );
normMatrix.multRight( unnamed_chunk_1rgl.userMatrix[54] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
this.drawScene();
var vpx0 = {
54: 0
};
var vpy0 = {
54: 0
};
var vpWidths = {
54: 216
};
var vpHeights = {
54: 216
};
var activeModel = {
54: 54
};
var activeProjection = {
54: 54
};
unnamed_chunk_1rgl.listeners = {
54: [ 54 ]
};
var whichSubscene = function(coords){
if (0 <= coords.x && coords.x <= 216 && 0 <= coords.y && coords.y <= 216) return(54);
return(54);
};
var translateCoords = function(subsceneid, coords){
return {x:coords.x - vpx0[subsceneid], y:coords.y - vpy0[subsceneid]};
};
var vlen = function(v) {
return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
};
var xprod = function(a, b) {
return [a[1]*b[2] - a[2]*b[1],
a[2]*b[0] - a[0]*b[2],
a[0]*b[1] - a[1]*b[0]];
};
var screenToVector = function(x, y) {
var width = vpWidths[activeSubscene],
height = vpHeights[activeSubscene],
radius = max(width, height)/2.0,
cx = width/2.0,
cy = height/2.0,
px = (x-cx)/radius,
py = (y-cy)/radius,
plen = sqrt(px*px+py*py);
if (plen > 1.e-6) {
px = px/plen;
py = py/plen;
}
var angle = (SQRT2 - plen)/SQRT2*PI/2,
z = sin(angle),
zlen = sqrt(1.0 - z*z);
px = px * zlen;
py = py * zlen;
return [px, py, z];
};
var rotBase;
var trackballdown = function(x,y) {
rotBase = screenToVector(x, y);
var l = unnamed_chunk_1rgl.listeners[activeModel[activeSubscene]];
saveMat = {};
for (var i = 0; i < l.length; i++)
saveMat[l[i]] = new CanvasMatrix4(unnamed_chunk_1rgl.userMatrix[l[i]]);
};
var trackballmove = function(x,y) {
var rotCurrent = screenToVector(x,y),
dot = rotBase[0]*rotCurrent[0] +
rotBase[1]*rotCurrent[1] +
rotBase[2]*rotCurrent[2],
angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180.0/PI,
axis = xprod(rotBase, rotCurrent),
l = unnamed_chunk_1rgl.listeners[activeModel[activeSubscene]],
i;
for (i = 0; i < l.length; i++) {
unnamed_chunk_1rgl.userMatrix[l[i]].load(saveMat[l[i]]);
unnamed_chunk_1rgl.userMatrix[l[i]].rotate(angle, axis[0], axis[1], axis[2]);
}
unnamed_chunk_1rgl.drawScene();
};
var trackballend = 0;
var y0zoom = 0;
var zoom0 = 0;
var zoomdown = function(x, y) {
y0zoom = y;
zoom0 = {};
l = unnamed_chunk_1rgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
zoom0[l[i]] = log(unnamed_chunk_1rgl.zoom[l[i]]);
};
var zoommove = function(x, y) {
l = unnamed_chunk_1rgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
unnamed_chunk_1rgl.zoom[l[i]] = exp(zoom0[l[i]] + (y-y0zoom)/height);
unnamed_chunk_1rgl.drawScene();
};
var zoomend = 0;
var y0fov = 0;
var fov0 = 0;
var fovdown = function(x, y) {
y0fov = y;
fov0 = {};
l = unnamed_chunk_1rgl.listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
fov0[l[i]] = unnamed_chunk_1rgl.FOV[l[i]];
};
var fovmove = function(x, y) {
l = unnamed_chunk_1rgl.listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
unnamed_chunk_1rgl.FOV[l[i]] = max(1, min(179, fov0[l[i]] + 180*(y-y0fov)/height));
unnamed_chunk_1rgl.drawScene();
};
var fovend = 0;
var mousedown = [trackballdown, zoomdown, fovdown];
var mousemove = [trackballmove, zoommove, fovmove];
var mouseend = [trackballend, zoomend, fovend];
function relMouseCoords(event){
var totalOffsetX = 0,
totalOffsetY = 0,
currentElement = canvas;
do{
totalOffsetX += currentElement.offsetLeft;
totalOffsetY += currentElement.offsetTop;
currentElement = currentElement.offsetParent;
}
while(currentElement);
var canvasX = event.pageX - totalOffsetX,
canvasY = event.pageY - totalOffsetY;
return {x:canvasX, y:canvasY};
}
canvas.onmousedown = function ( ev ){
if (!ev.which) // Use w3c defns in preference to MS
switch (ev.button) {
case 0: ev.which = 1; break;
case 1:
case 4: ev.which = 2; break;
case 2: ev.which = 3;
}
drag = ev.which;
var f = mousedown[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height-coords.y;
activeSubscene = whichSubscene(coords);
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
ev.preventDefault();
}
};
canvas.onmouseup = function ( ev ){
if ( drag === 0 ) return;
var f = mouseend[drag-1];
if (f)
f();
drag = 0;
};
canvas.onmouseout = canvas.onmouseup;
canvas.onmousemove = function ( ev ){
if ( drag === 0 ) return;
var f = mousemove[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height - coords.y;
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
}
};
var wheelHandler = function(ev) {
var del = 1.1;
if (ev.shiftKey) del = 1.01;
var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
l = unnamed_chunk_1rgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
unnamed_chunk_1rgl.zoom[l[i]] *= ds;
unnamed_chunk_1rgl.drawScene();
ev.preventDefault();
};
canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
canvas.addEventListener("mousewheel", wheelHandler, false);
};
</script>
<canvas id="unnamed_chunk_1canvas" class="rglWebGL" width="1" height="1"></canvas>
<p id="unnamed_chunk_1debug">
You must enable Javascript to view this page properly.</p>
<script>unnamed_chunk_1rgl.start();</script>

Besides the `*3d` functions mentioned above, there are even lower-level
functions 
<a name="rgl.primitive"><a href="../../rgl/help/rgl.primitive">`rgl.primitive`</a></a>, <a name="rgl.points"><a href="../../rgl/help/rgl.points">`rgl.points`</a></a>, <a name="rgl.linestrips"><a href="../../rgl/help/rgl.linestrips">`rgl.linestrips`</a></a>, <a name="rgl.lines"><a href="../../rgl/help/rgl.lines">`rgl.lines`</a></a>, <a name="rgl.triangles"><a href="../../rgl/help/rgl.triangles">`rgl.triangles`</a></a>, <a name="rgl.quads"><a href="../../rgl/help/rgl.quads">`rgl.quads`</a></a>, <a name="rgl.texts"><a href="../../rgl/help/rgl.texts">`rgl.texts`</a></a>, <a name="rgl.abclines"><a href="../../rgl/help/rgl.abclines">`rgl.abclines`</a></a>, <a name="rgl.planes"><a href="../../rgl/help/rgl.planes">`rgl.planes`</a></a>, <a name="rgl.bg"><a href="../../rgl/help/rgl.bg">`rgl.bg`</a></a>, <a name="rgl.clipplanes"><a href="../../rgl/help/rgl.clipplanes">`rgl.clipplanes`</a></a>, <a name="rgl.bbox"><a href="../../rgl/help/rgl.bbox">`rgl.bbox`</a></a>, <a name="rgl.spheres"><a href="../../rgl/help/rgl.spheres">`rgl.spheres`</a></a>, <a name="rgl.sprites"><a href="../../rgl/help/rgl.sprites">`rgl.sprites`</a></a>, <a name="rgl.surface"><a href="../../rgl/help/rgl.surface">`rgl.surface`</a></a>.  
You should avoid using these functions, which do not
work well with the higher level `*3d` functions.  See the 
<a href="../../rgl/help/r3d">?r3d</a> help
topic for details.

## Controlling the Look of the Scene

### Lighting

In most scenes, objects are "lit", meaning that their appearance
depends on their position and orientation relative to lights
in the scene.  The lights themselves don't normally show up,
but their effect on the objects does.

Use the <a name="light3d"><a href="../../rgl/help/light3d">`light3d`</a></a> function to 
specify the position and characteristics of a light.
Lights may be infinitely distant, or may be embedded
within the scene.  Their characteristics include 
`ambient`, `diffuse`, and `specular` components, all
defaulting to white.  The `ambient` component appears
the same from any direction.  The `diffuse` component 
depends on the angle between the surface and the light, 
while the `specular` component also takes the viewer's
position into account.

The <a name="rgl.light"><a href="../../rgl/help/rgl.light">`rgl.light`</a></a> function is a lower-level
function with different defaults; users should normally
use <a href="#light3d">`light3d`</a>.

### Materials

The mental model used in `rgl` is that the objects being shown
in scenes are physical objects in space, with material properties
that affect how light reflects from them (or is emitted by them).
These are mainly controlled by the <a name="material3d"><a href="../../rgl/help/material3d">`material3d`</a></a> function,
or by arguments to other functions that are passed to it.

The material properties that can be set by calls to `material3d` are
described in detail in the 
<a href="../../rgl/help/material3d">?material3d</a> help page.
Here we give an overview.

Property  | Default | Meaning 
--------- | ------- | ------------------
color     | white   | vector of surface colors to apply to successive vertices for diffuse light
alpha     | 1       | transparency:  0 is invisible, 1 is opaque
lit       | TRUE    | whether lighting calculations should be done
ambient   | black   | color in ambient  light
specular  | white   | color in specular light
emission  | black   | color emitted by the surface
shininess | 50      | controls the specular lighting:  high values look shiny
smooth    | TRUE    | whether shading should be interpolated between vertices
texture   | NULL    | optional path to a "texture" bitmap to be displayed on the surface
front, back | fill  | should polygons be filled, or outlined? 
size      | 3       | size of points in pixels
lwd       | 1       | width of lines in pixels

Other properties include 
"texmipmap", "texmagfilter", "texminfilter", "texenvmap", "fog", 
"point\_antialias", "line\_antialias", "depth\_mask", and "depth\_test"; 
see the help page for details.

There is also an <a name="rgl.material"><a href="../../rgl/help/rgl.material">`rgl.material`</a></a> function that works
at a lower level; users should normally avoid it.

### par3d:  Miscellaneous graphical parameters

The <a name="par3d"><a href="../../rgl/help/par3d">`par3d`</a></a> function, modelled after the classic
graphics <a href="../../graphics/help/par">`par`</a> function, sets or reads 
a variety of different `rgl` internal
parameters.  Some parameters are completely read-only; others are
fixed at the time the window is opened, and others may be changed 
at any time.

Name        |  Changeable?     | Description
----------- | ----- | -----------
antialias   | fixed | Amount of hardware antialiasing 
cex         |       | Default size for text
family      |       | Device-independent font family name; see <a href="../../rgl/help/text3d">?text3d</a>
font        |       | Integer font number
useFreeType |       | Should FreeType fonts be used if available?
fontname    | read-only | System-dependent font name set by <a name="rglFonts"><a href="../../rgl/help/rglFonts">`rglFonts`</a></a>
FOV         |       | Field of view, in degrees.  Zero means isometric perspective
ignoreExtent |      | Should `rgl` ignore the size of new objects when computing the bounding box?
skipRedraw   |      | Should `rgl` suppress updates to the display? 
maxClipPlanes | read-only | How many clip planes can be defined?
modelMatrix | read-only | The OpenGL ModelView matrix; partly set by <a name="view3d"><a href="../../rgl/help/view3d">`view3d`</a></a> or the obsolete <a name="rgl.viewpoint"><a href="../../rgl/help/rgl.viewpoint">`rgl.viewpoint`</a></a>
projMatrix  | read-only | The OpenGL Projection matrix
bbox        | read-only | Current bounding-box of the scene
viewport    |       | Dimensions in pixels of the scene within the window
windowRect  |           | Dimensions in pixels of the window on the whole screen
listeners   |           | Which subscenes respond to mouse actions in the current one
mouseMode   |       | What the mouse buttons do.  See <a href="#mouseMode"><code>"mouseMode"</code></a>
observer    | read-only | The position of the observer; set by <a name="observer3d"><a href="../../rgl/help/observer3d">`observer3d`</a></a>
scale       |           | Rescaling for each coordinate; see <a href="#aspect3d">`aspect3d`</a>
zoom        |           | Magnification of the scene

### Default settings

The <a name="r3dDefaults"><a href="../../rgl/help/r3dDefaults">`r3dDefaults`</a></a> list and the <a name="getr3dDefaults"><a href="../../rgl/help/getr3dDefaults">`getr3dDefaults`</a></a> 
function control defaults in new windows opened by <a href="#open3d">`open3d`</a>.  
The function looks for the variable in the user's global environment,
and if not found there, finds the one in the `rgl` namespace.  This
allows the user to override the default settings for new windows.

Once found, the `r3dDefaults` list provides initial values for <a href="#par3d">`par3d`</a> parameters, as well as defaults for <a href="#material3d">`material3d`</a> and <a href="#bg3d">`bg3d`</a> in components `"material"`
and `"bg"` respectively.


## Meshes:  Constructing Shapes 

`rgl` includes a number of functions to construct and display 
various solid shapes.  These generate objects of class `"shape3d"`,
`"mesh3d"` or `"shapelist3d"`.  The details of the classes are 
described below.  We start with functions to generate them.

### Specific solids

These functions generate specific shapes.  Optional arguments allow
attributes such as colour or transformations to be specified.

------------------------------------ | -----------
<a name="tetrahedron3d"><a href="../../rgl/help/tetrahedron3d">`tetrahedron3d`</a></a>, <a name="cube3d"><a href="../../rgl/help/cube3d">`cube3d`</a></a>, <a name="octahedron3d"><a href="../../rgl/help/octahedron3d">`octahedron3d`</a></a>, <a name="dodecahedron3d"><a href="../../rgl/help/dodecahedron3d">`dodecahedron3d`</a></a>, <a name="icosahedron3d"><a href="../../rgl/help/icosahedron3d">`icosahedron3d`</a></a>: | Platonic solids
<a name="cuboctahedron3d"><a href="../../rgl/help/cuboctahedron3d">`cuboctahedron3d`</a></a>, <a name="oh3d"><a href="../../rgl/help/oh3d">`oh3d`</a></a>:             | other solids


```r
open3d()
cols <- rainbow(7)
layout3d(matrix(1:16, 4,4), heights=c(1,3,1,3))
text3d(0,0,0,"tetrahedron3d"); next3d()
shade3d(tetrahedron3d(col=cols[1])); next3d()
text3d(0,0,0,"cube3d"); next3d()
shade3d(cube3d(col=cols[2])); next3d()
text3d(0,0,0,"octahedron3d"); next3d()
shade3d(octahedron3d(col=cols[3])); next3d()
text3d(0,0,0,"dodecahedron3d"); next3d()
shade3d(dodecahedron3d(col=cols[4])); next3d()
text3d(0,0,0,"icosahedron3d"); next3d()
shade3d(icosahedron3d(col=cols[5])); next3d()
text3d(0,0,0,"cuboctahedron3d"); next3d()
shade3d(cuboctahedron3d(col=cols[6])); next3d()
text3d(0,0,0,"oh3d"); next3d()
shade3d(oh3d(col=cols[7]))
```

<canvas id="unnamed_chunk_2textureCanvas" style="display: none;" width="256" height="256">
Your browser does not support the HTML5 canvas element.</canvas>
<script type="text/javascript">
var unnamed_chunk_2rgl = new rglClass();
unnamed_chunk_2rgl.start = function() {
var i, j, v, ind, texts, f, texinfo;
var debug = function(msg) {
document.getElementById("unnamed_chunk_2debug").innerHTML = msg;
};
debug("");
var canvas = document.getElementById("unnamed_chunk_2canvas");
if (!window.WebGLRenderingContext){
debug(" Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
try {
// Try to grab the standard context. If it fails, fallback to experimental.
this.gl = canvas.getContext("webgl") ||
canvas.getContext("experimental-webgl");
}
catch(e) {}
if ( !this.gl ) {
debug(" Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var gl = this.gl,
width = 505, height = 505;
canvas.width = width;   canvas.height = height;
var normMatrix = new CanvasMatrix4(),
saveMat = {},
distance,
posLoc = 0,
colLoc = 1;
var activeSubscene = 79;
this.flags[79] = 1024;
this.zoom[79] = 1;
this.FOV[79] = 30;
this.viewport[79] = [0, 0, 504, 504];
this.userMatrix[79] = new CanvasMatrix4();
this.userMatrix[79].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[79] = [];
this.opaque[79] = [];
this.transparent[79] = [];
this.subscenes[79] = [85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100];
this.flags[85] = 1064;
this.zoom[85] = 1;
this.FOV[85] = 30;
this.viewport[85] = [0, 441, 126, 63];
this.userMatrix[85] = new CanvasMatrix4();
this.userMatrix[85].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[85] = [];
this.opaque[85] = [101];
this.transparent[85] = [];
this.subscenes[85] = [];
this.flags[86] = 1027;
this.zoom[86] = 1;
this.FOV[86] = 30;
this.viewport[86] = [0, 252, 126, 189];
this.userMatrix[86] = new CanvasMatrix4();
this.userMatrix[86].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[86] = [];
this.opaque[86] = [102];
this.transparent[86] = [];
this.subscenes[86] = [];
this.flags[87] = 1064;
this.zoom[87] = 1;
this.FOV[87] = 30;
this.viewport[87] = [0, 189, 126, 63];
this.userMatrix[87] = new CanvasMatrix4();
this.userMatrix[87].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[87] = [];
this.opaque[87] = [103];
this.transparent[87] = [];
this.subscenes[87] = [];
this.flags[88] = 1035;
this.zoom[88] = 1;
this.FOV[88] = 30;
this.viewport[88] = [0, 0, 126, 189];
this.userMatrix[88] = new CanvasMatrix4();
this.userMatrix[88].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[88] = [];
this.opaque[88] = [104];
this.transparent[88] = [];
this.subscenes[88] = [];
this.flags[89] = 1064;
this.zoom[89] = 1;
this.FOV[89] = 30;
this.viewport[89] = [126, 441, 126, 63];
this.userMatrix[89] = new CanvasMatrix4();
this.userMatrix[89].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[89] = [];
this.opaque[89] = [105];
this.transparent[89] = [];
this.subscenes[89] = [];
this.flags[90] = 1027;
this.zoom[90] = 1;
this.FOV[90] = 30;
this.viewport[90] = [126, 252, 126, 189];
this.userMatrix[90] = new CanvasMatrix4();
this.userMatrix[90].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[90] = [];
this.opaque[90] = [106];
this.transparent[90] = [];
this.subscenes[90] = [];
this.flags[91] = 1064;
this.zoom[91] = 1;
this.FOV[91] = 30;
this.viewport[91] = [126, 189, 126, 63];
this.userMatrix[91] = new CanvasMatrix4();
this.userMatrix[91].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[91] = [];
this.opaque[91] = [107];
this.transparent[91] = [];
this.subscenes[91] = [];
this.flags[92] = 1027;
this.zoom[92] = 1;
this.FOV[92] = 30;
this.viewport[92] = [126, 0, 126, 189];
this.userMatrix[92] = new CanvasMatrix4();
this.userMatrix[92].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[92] = [];
this.opaque[92] = [108];
this.transparent[92] = [];
this.subscenes[92] = [];
this.flags[93] = 1064;
this.zoom[93] = 1;
this.FOV[93] = 30;
this.viewport[93] = [252, 441, 126, 63];
this.userMatrix[93] = new CanvasMatrix4();
this.userMatrix[93].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[93] = [];
this.opaque[93] = [109];
this.transparent[93] = [];
this.subscenes[93] = [];
this.flags[94] = 1027;
this.zoom[94] = 1;
this.FOV[94] = 30;
this.viewport[94] = [252, 252, 126, 189];
this.userMatrix[94] = new CanvasMatrix4();
this.userMatrix[94].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[94] = [];
this.opaque[94] = [110];
this.transparent[94] = [];
this.subscenes[94] = [];
this.flags[95] = 1064;
this.zoom[95] = 1;
this.FOV[95] = 30;
this.viewport[95] = [252, 189, 126, 63];
this.userMatrix[95] = new CanvasMatrix4();
this.userMatrix[95].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[95] = [];
this.opaque[95] = [111];
this.transparent[95] = [];
this.subscenes[95] = [];
this.flags[96] = 1035;
this.zoom[96] = 1;
this.FOV[96] = 30;
this.viewport[96] = [252, 0, 126, 189];
this.userMatrix[96] = new CanvasMatrix4();
this.userMatrix[96].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[96] = [];
this.opaque[96] = [112,113];
this.transparent[96] = [];
this.subscenes[96] = [];
this.flags[97] = 1064;
this.zoom[97] = 1;
this.FOV[97] = 30;
this.viewport[97] = [378, 441, 126, 63];
this.userMatrix[97] = new CanvasMatrix4();
this.userMatrix[97].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[97] = [];
this.opaque[97] = [114];
this.transparent[97] = [];
this.subscenes[97] = [];
this.flags[98] = 1035;
this.zoom[98] = 1;
this.FOV[98] = 30;
this.viewport[98] = [378, 252, 126, 189];
this.userMatrix[98] = new CanvasMatrix4();
this.userMatrix[98].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[98] = [];
this.opaque[98] = [115];
this.transparent[98] = [];
this.subscenes[98] = [];
this.flags[99] = 1024;
this.zoom[99] = 1;
this.FOV[99] = 30;
this.viewport[99] = [378, 189, 126, 63];
this.userMatrix[99] = new CanvasMatrix4();
this.userMatrix[99].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[99] = [];
this.opaque[99] = [];
this.transparent[99] = [];
this.subscenes[99] = [];
this.flags[100] = 1024;
this.zoom[100] = 1;
this.FOV[100] = 30;
this.viewport[100] = [378, 0, 126, 189];
this.userMatrix[100] = new CanvasMatrix4();
this.userMatrix[100].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
this.clipplanes[100] = [];
this.opaque[100] = [];
this.transparent[100] = [];
this.subscenes[100] = [];
function getPowerOfTwo(value) {
var pow = 1;
while(pow<value) {
pow *= 2;
}
return pow;
}
function handleLoadedTexture(texture, textureCanvas) {
gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
gl.bindTexture(gl.TEXTURE_2D, texture);
gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
gl.generateMipmap(gl.TEXTURE_2D);
gl.bindTexture(gl.TEXTURE_2D, null);
}
function loadImageToTexture(filename, texture) {
var canvas = document.getElementById("unnamed_chunk_2textureCanvas"),
ctx = canvas.getContext("2d"),
image = new Image();
image.onload = function() {
var w = image.width,
h = image.height,
canvasX = getPowerOfTwo(w),
canvasY = getPowerOfTwo(h);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.imageSmoothingEnabled = true;
ctx.drawImage(image, 0, 0, canvasX, canvasY);
handleLoadedTexture(texture, canvas);
unnamed_chunk_2rgl.drawScene();
};
image.src = filename;
}
function drawTextToCanvas(text, cex) {
var canvasX, canvasY,
textX, textY,
textHeight = 20 * cex,
textColour = "white",
fontFamily = "Arial",
backgroundColour = "rgba(0,0,0,0)",
canvas = document.getElementById("unnamed_chunk_2textureCanvas"),
ctx = canvas.getContext("2d"),
i;
ctx.font = textHeight+"px "+fontFamily;
canvasX = 1;
var widths = [];
for (i = 0; i < text.length; i++)  {
widths[i] = ctx.measureText(text[i]).width;
canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
}
canvasX = getPowerOfTwo(canvasX);
var offset = 2*textHeight, // offset to first baseline
skip = 2*textHeight;   // skip between baselines
canvasY = getPowerOfTwo(offset + text.length*skip);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.fillStyle = backgroundColour;
ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
ctx.fillStyle = textColour;
ctx.textAlign = "left";
ctx.textBaseline = "alphabetic";
ctx.font = textHeight+"px "+fontFamily;
for(i = 0; i < text.length; i++) {
textY = i*skip + offset;
ctx.fillText(text[i], 0,  textY);
}
return {canvasX:canvasX, canvasY:canvasY,
widths:widths, textHeight:textHeight,
offset:offset, skip:skip};
}
// ****** text object 101 ******
this.flags[101] = 40;
this.vshaders[101] = "	/* ****** text object 101 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[101] = "	/* ****** text object 101 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[101]  = gl.createProgram();
gl.attachShader(this.prog[101], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[101] ));
gl.attachShader(this.prog[101], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[101] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[101], 0, "aPos");
gl.bindAttribLocation(this.prog[101], 1, "aCol");
gl.linkProgram(this.prog[101]);
texts = [
"tetrahedron3d"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[101] = gl.getAttribLocation(this.prog[101], "aOfs");
this.texture[101] = gl.createTexture();
this.texLoc[101] = gl.getAttribLocation(this.prog[101], "aTexcoord");
this.sampler[101] = gl.getUniformLocation(this.prog[101],"uSampler");
handleLoadedTexture(this.texture[101], document.getElementById("unnamed_chunk_2textureCanvas"));
this.offsets[101]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
0, 0, 0, 0, -0.5, 0.5, 0.5,
0, 0, 0, 1, -0.5, 0.5, 0.5,
0, 0, 0, 1, 1.5, 0.5, 0.5,
0, 0, 0, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[101].stride*(4*i + j) + this.offsets[101].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[101] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[101] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[101]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[101], gl.STATIC_DRAW);
this.ibuf[101] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[101]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[101] = gl.getUniformLocation(this.prog[101],"mvMatrix");
this.prMatLoc[101] = gl.getUniformLocation(this.prog[101],"prMatrix");
this.textScaleLoc[101] = gl.getUniformLocation(this.prog[101],"textScale");
// ****** triangles object 102 ******
this.flags[102] = 3;
this.vshaders[102] = "	/* ****** triangles object 102 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[102] = "	/* ****** triangles object 102 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[102]  = gl.createProgram();
gl.attachShader(this.prog[102], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[102] ));
gl.attachShader(this.prog[102], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[102] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[102], 0, "aPos");
gl.bindAttribLocation(this.prog[102], 1, "aCol");
gl.linkProgram(this.prog[102]);
this.offsets[102]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
-1, -1, -1, 0.5773503, -0.5773503, -0.5773503,
1, 1, -1, 0.5773503, -0.5773503, -0.5773503,
1, -1, 1, 0.5773503, -0.5773503, -0.5773503,
1, -1, 1, 0.5773503, 0.5773503, 0.5773503,
1, 1, -1, 0.5773503, 0.5773503, 0.5773503,
-1, 1, 1, 0.5773503, 0.5773503, 0.5773503,
-1, 1, 1, -0.5773503, 0.5773503, -0.5773503,
1, 1, -1, -0.5773503, 0.5773503, -0.5773503,
-1, -1, -1, -0.5773503, 0.5773503, -0.5773503,
-1, -1, -1, -0.5773503, -0.5773503, 0.5773503,
1, -1, 1, -0.5773503, -0.5773503, 0.5773503,
-1, 1, 1, -0.5773503, -0.5773503, 0.5773503
]);
this.values[102] = v;
this.normLoc[102] = gl.getAttribLocation(this.prog[102], "aNorm");
this.buf[102] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[102]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[102], gl.STATIC_DRAW);
this.mvMatLoc[102] = gl.getUniformLocation(this.prog[102],"mvMatrix");
this.prMatLoc[102] = gl.getUniformLocation(this.prog[102],"prMatrix");
this.normMatLoc[102] = gl.getUniformLocation(this.prog[102],"normMatrix");
// ****** text object 103 ******
this.flags[103] = 40;
this.vshaders[103] = "	/* ****** text object 103 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[103] = "	/* ****** text object 103 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[103]  = gl.createProgram();
gl.attachShader(this.prog[103], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[103] ));
gl.attachShader(this.prog[103], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[103] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[103], 0, "aPos");
gl.bindAttribLocation(this.prog[103], 1, "aCol");
gl.linkProgram(this.prog[103]);
texts = [
"cube3d"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[103] = gl.getAttribLocation(this.prog[103], "aOfs");
this.texture[103] = gl.createTexture();
this.texLoc[103] = gl.getAttribLocation(this.prog[103], "aTexcoord");
this.sampler[103] = gl.getUniformLocation(this.prog[103],"uSampler");
handleLoadedTexture(this.texture[103], document.getElementById("unnamed_chunk_2textureCanvas"));
this.offsets[103]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
0, 0, 0, 0, -0.5, 0.5, 0.5,
0, 0, 0, 1, -0.5, 0.5, 0.5,
0, 0, 0, 1, 1.5, 0.5, 0.5,
0, 0, 0, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[103].stride*(4*i + j) + this.offsets[103].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[103] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[103] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[103]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[103], gl.STATIC_DRAW);
this.ibuf[103] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[103]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[103] = gl.getUniformLocation(this.prog[103],"mvMatrix");
this.prMatLoc[103] = gl.getUniformLocation(this.prog[103],"prMatrix");
this.textScaleLoc[103] = gl.getUniformLocation(this.prog[103],"textScale");
// ****** quads object 104 ******
this.flags[104] = 11;
this.vshaders[104] = "	/* ****** quads object 104 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[104] = "	/* ****** quads object 104 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[104]  = gl.createProgram();
gl.attachShader(this.prog[104], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[104] ));
gl.attachShader(this.prog[104], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[104] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[104], 0, "aPos");
gl.bindAttribLocation(this.prog[104], 1, "aCol");
gl.linkProgram(this.prog[104]);
this.offsets[104]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
-1, -1, -1, 0, 0, -1,
-1, 1, -1, 0, 0, -1,
1, 1, -1, 0, 0, -1,
1, -1, -1, 0, 0, -1,
-1, 1, -1, -0, 1, 0,
-1, 1, 1, -0, 1, 0,
1, 1, 1, -0, 1, 0,
1, 1, -1, -0, 1, 0,
1, -1, -1, 1, 0, -0,
1, 1, -1, 1, 0, -0,
1, 1, 1, 1, 0, -0,
1, -1, 1, 1, 0, -0,
-1, -1, -1, -1, 0, 0,
-1, -1, 1, -1, 0, 0,
-1, 1, 1, -1, 0, 0,
-1, 1, -1, -1, 0, 0,
-1, -1, -1, 0, -1, 0,
1, -1, -1, 0, -1, 0,
1, -1, 1, 0, -1, 0,
-1, -1, 1, 0, -1, 0,
-1, -1, 1, 0, -0, 1,
1, -1, 1, 0, -0, 1,
1, 1, 1, 0, -0, 1,
-1, 1, 1, 0, -0, 1
]);
this.values[104] = v;
this.normLoc[104] = gl.getAttribLocation(this.prog[104], "aNorm");
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23
]);
this.buf[104] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[104]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[104], gl.STATIC_DRAW);
this.ibuf[104] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[104]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[104] = gl.getUniformLocation(this.prog[104],"mvMatrix");
this.prMatLoc[104] = gl.getUniformLocation(this.prog[104],"prMatrix");
this.normMatLoc[104] = gl.getUniformLocation(this.prog[104],"normMatrix");
// ****** text object 105 ******
this.flags[105] = 40;
this.vshaders[105] = "	/* ****** text object 105 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[105] = "	/* ****** text object 105 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[105]  = gl.createProgram();
gl.attachShader(this.prog[105], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[105] ));
gl.attachShader(this.prog[105], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[105] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[105], 0, "aPos");
gl.bindAttribLocation(this.prog[105], 1, "aCol");
gl.linkProgram(this.prog[105]);
texts = [
"octahedron3d"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[105] = gl.getAttribLocation(this.prog[105], "aOfs");
this.texture[105] = gl.createTexture();
this.texLoc[105] = gl.getAttribLocation(this.prog[105], "aTexcoord");
this.sampler[105] = gl.getUniformLocation(this.prog[105],"uSampler");
handleLoadedTexture(this.texture[105], document.getElementById("unnamed_chunk_2textureCanvas"));
this.offsets[105]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
0, 0, 0, 0, -0.5, 0.5, 0.5,
0, 0, 0, 1, -0.5, 0.5, 0.5,
0, 0, 0, 1, 1.5, 0.5, 0.5,
0, 0, 0, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[105].stride*(4*i + j) + this.offsets[105].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[105] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[105] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[105]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[105], gl.STATIC_DRAW);
this.ibuf[105] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[105]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[105] = gl.getUniformLocation(this.prog[105],"mvMatrix");
this.prMatLoc[105] = gl.getUniformLocation(this.prog[105],"prMatrix");
this.textScaleLoc[105] = gl.getUniformLocation(this.prog[105],"textScale");
// ****** triangles object 106 ******
this.flags[106] = 3;
this.vshaders[106] = "	/* ****** triangles object 106 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[106] = "	/* ****** triangles object 106 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[106]  = gl.createProgram();
gl.attachShader(this.prog[106], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[106] ));
gl.attachShader(this.prog[106], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[106] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[106], 0, "aPos");
gl.bindAttribLocation(this.prog[106], 1, "aCol");
gl.linkProgram(this.prog[106]);
this.offsets[106]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
-1, 0, 0, -0.5773503, -0.5773503, -0.5773503,
0, 0, -1, -0.5773503, -0.5773503, -0.5773503,
0, -1, 0, -0.5773503, -0.5773503, -0.5773503,
-1, 0, 0, -0.5773503, -0.5773503, 0.5773503,
0, -1, 0, -0.5773503, -0.5773503, 0.5773503,
0, 0, 1, -0.5773503, -0.5773503, 0.5773503,
-1, 0, 0, -0.5773503, 0.5773503, -0.5773503,
0, 1, 0, -0.5773503, 0.5773503, -0.5773503,
0, 0, -1, -0.5773503, 0.5773503, -0.5773503,
-1, 0, 0, -0.5773503, 0.5773503, 0.5773503,
0, 0, 1, -0.5773503, 0.5773503, 0.5773503,
0, 1, 0, -0.5773503, 0.5773503, 0.5773503,
1, 0, 0, 0.5773503, -0.5773503, -0.5773503,
0, -1, 0, 0.5773503, -0.5773503, -0.5773503,
0, 0, -1, 0.5773503, -0.5773503, -0.5773503,
1, 0, 0, 0.5773503, -0.5773503, 0.5773503,
0, 0, 1, 0.5773503, -0.5773503, 0.5773503,
0, -1, 0, 0.5773503, -0.5773503, 0.5773503,
1, 0, 0, 0.5773503, 0.5773503, -0.5773503,
0, 0, -1, 0.5773503, 0.5773503, -0.5773503,
0, 1, 0, 0.5773503, 0.5773503, -0.5773503,
1, 0, 0, 0.5773503, 0.5773503, 0.5773503,
0, 1, 0, 0.5773503, 0.5773503, 0.5773503,
0, 0, 1, 0.5773503, 0.5773503, 0.5773503
]);
this.values[106] = v;
this.normLoc[106] = gl.getAttribLocation(this.prog[106], "aNorm");
this.buf[106] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[106]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[106], gl.STATIC_DRAW);
this.mvMatLoc[106] = gl.getUniformLocation(this.prog[106],"mvMatrix");
this.prMatLoc[106] = gl.getUniformLocation(this.prog[106],"prMatrix");
this.normMatLoc[106] = gl.getUniformLocation(this.prog[106],"normMatrix");
// ****** text object 107 ******
this.flags[107] = 40;
this.vshaders[107] = "	/* ****** text object 107 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[107] = "	/* ****** text object 107 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[107]  = gl.createProgram();
gl.attachShader(this.prog[107], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[107] ));
gl.attachShader(this.prog[107], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[107] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[107], 0, "aPos");
gl.bindAttribLocation(this.prog[107], 1, "aCol");
gl.linkProgram(this.prog[107]);
texts = [
"dodecahedron3d"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[107] = gl.getAttribLocation(this.prog[107], "aOfs");
this.texture[107] = gl.createTexture();
this.texLoc[107] = gl.getAttribLocation(this.prog[107], "aTexcoord");
this.sampler[107] = gl.getUniformLocation(this.prog[107],"uSampler");
handleLoadedTexture(this.texture[107], document.getElementById("unnamed_chunk_2textureCanvas"));
this.offsets[107]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
0, 0, 0, 0, -0.5, 0.5, 0.5,
0, 0, 0, 1, -0.5, 0.5, 0.5,
0, 0, 0, 1, 1.5, 0.5, 0.5,
0, 0, 0, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[107].stride*(4*i + j) + this.offsets[107].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[107] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[107] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[107]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[107], gl.STATIC_DRAW);
this.ibuf[107] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[107]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[107] = gl.getUniformLocation(this.prog[107],"mvMatrix");
this.prMatLoc[107] = gl.getUniformLocation(this.prog[107],"prMatrix");
this.textScaleLoc[107] = gl.getUniformLocation(this.prog[107],"textScale");
// ****** triangles object 108 ******
this.flags[108] = 3;
this.vshaders[108] = "	/* ****** triangles object 108 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[108] = "	/* ****** triangles object 108 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[108]  = gl.createProgram();
gl.attachShader(this.prog[108], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[108] ));
gl.attachShader(this.prog[108], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[108] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[108], 0, "aPos");
gl.bindAttribLocation(this.prog[108], 1, "aCol");
gl.linkProgram(this.prog[108]);
this.offsets[108]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
-0.618034, -0.618034, -0.618034, 0, -0.8506507, -0.5257311,
0, -0.381966, -1, 0, -0.8506507, -0.5257311,
0.618034, -0.618034, -0.618034, 0, -0.8506507, -0.5257311,
-0.618034, -0.618034, -0.618034, -0, -0.8506508, -0.5257311,
0.618034, -0.618034, -0.618034, -0, -0.8506508, -0.5257311,
0.381966, -1, 0, -0, -0.8506508, -0.5257311,
-0.618034, -0.618034, -0.618034, -0, -0.8506508, -0.525731,
0.381966, -1, 0, -0, -0.8506508, -0.525731,
-0.381966, -1, 0, -0, -0.8506508, -0.525731,
-0.618034, -0.618034, -0.618034, -0.8506507, -0.5257311, 0,
-0.381966, -1, 0, -0.8506507, -0.5257311, 0,
-0.618034, -0.618034, 0.618034, -0.8506507, -0.5257311, 0,
-0.618034, -0.618034, -0.618034, -0.8506508, -0.5257311, -0,
-0.618034, -0.618034, 0.618034, -0.8506508, -0.5257311, -0,
-1, 0, 0.381966, -0.8506508, -0.5257311, -0,
-0.618034, -0.618034, -0.618034, -0.8506508, -0.525731, -0,
-1, 0, 0.381966, -0.8506508, -0.525731, -0,
-1, 0, -0.381966, -0.8506508, -0.525731, -0,
-0.618034, -0.618034, -0.618034, -0.5257311, 0, -0.8506507,
-1, 0, -0.381966, -0.5257311, 0, -0.8506507,
-0.618034, 0.618034, -0.618034, -0.5257311, 0, -0.8506507,
-0.618034, -0.618034, -0.618034, -0.5257311, -0, -0.8506508,
-0.618034, 0.618034, -0.618034, -0.5257311, -0, -0.8506508,
0, 0.381966, -1, -0.5257311, -0, -0.8506508,
-0.618034, -0.618034, -0.618034, -0.525731, -0, -0.8506508,
0, 0.381966, -1, -0.525731, -0, -0.8506508,
0, -0.381966, -1, -0.525731, -0, -0.8506508,
0.618034, -0.618034, -0.618034, 0.525731, 0, -0.8506508,
0, -0.381966, -1, 0.525731, 0, -0.8506508,
0, 0.381966, -1, 0.525731, 0, -0.8506508,
0.618034, -0.618034, -0.618034, 0.5257311, 0, -0.8506508,
0, 0.381966, -1, 0.5257311, 0, -0.8506508,
0.618034, 0.618034, -0.618034, 0.5257311, 0, -0.8506508,
0.618034, -0.618034, -0.618034, 0.5257311, 0, -0.8506507,
0.618034, 0.618034, -0.618034, 0.5257311, 0, -0.8506507,
1, 0, -0.381966, 0.5257311, 0, -0.8506507,
0.618034, -0.618034, -0.618034, 0.8506508, -0.525731, 0,
1, 0, -0.381966, 0.8506508, -0.525731, 0,
1, 0, 0.381966, 0.8506508, -0.525731, 0,
0.618034, -0.618034, -0.618034, 0.8506508, -0.5257311, 0,
1, 0, 0.381966, 0.8506508, -0.5257311, 0,
0.618034, -0.618034, 0.618034, 0.8506508, -0.5257311, 0,
0.618034, -0.618034, -0.618034, 0.8506507, -0.5257311, 0,
0.618034, -0.618034, 0.618034, 0.8506507, -0.5257311, 0,
0.381966, -1, 0, 0.8506507, -0.5257311, 0,
-0.618034, 0.618034, -0.618034, 0, 0.8506508, -0.525731,
-0.381966, 1, 0, 0, 0.8506508, -0.525731,
0.381966, 1, 0, 0, 0.8506508, -0.525731,
-0.618034, 0.618034, -0.618034, 0, 0.8506508, -0.5257311,
0.381966, 1, 0, 0, 0.8506508, -0.5257311,
0.618034, 0.618034, -0.618034, 0, 0.8506508, -0.5257311,
-0.618034, 0.618034, -0.618034, 0, 0.8506507, -0.5257311,
0.618034, 0.618034, -0.618034, 0, 0.8506507, -0.5257311,
0, 0.381966, -1, 0, 0.8506507, -0.5257311,
-0.618034, 0.618034, -0.618034, -0.8506508, 0.525731, 0,
-1, 0, -0.381966, -0.8506508, 0.525731, 0,
-1, 0, 0.381966, -0.8506508, 0.525731, 0,
-0.618034, 0.618034, -0.618034, -0.8506508, 0.5257311, 0,
-1, 0, 0.381966, -0.8506508, 0.5257311, 0,
-0.618034, 0.618034, 0.618034, -0.8506508, 0.5257311, 0,
-0.618034, 0.618034, -0.618034, -0.8506507, 0.5257311, 0,
-0.618034, 0.618034, 0.618034, -0.8506507, 0.5257311, 0,
-0.381966, 1, 0, -0.8506507, 0.5257311, 0,
0.618034, 0.618034, -0.618034, 0.8506507, 0.5257311, 0,
0.381966, 1, 0, 0.8506507, 0.5257311, 0,
0.618034, 0.618034, 0.618034, 0.8506507, 0.5257311, 0,
0.618034, 0.618034, -0.618034, 0.8506508, 0.5257311, 0,
0.618034, 0.618034, 0.618034, 0.8506508, 0.5257311, 0,
1, 0, 0.381966, 0.8506508, 0.5257311, 0,
0.618034, 0.618034, -0.618034, 0.8506508, 0.525731, 0,
1, 0, 0.381966, 0.8506508, 0.525731, 0,
1, 0, -0.381966, 0.8506508, 0.525731, 0,
-0.618034, -0.618034, 0.618034, -0.525731, 0, 0.8506508,
0, -0.381966, 1, -0.525731, 0, 0.8506508,
0, 0.381966, 1, -0.525731, 0, 0.8506508,
-0.618034, -0.618034, 0.618034, -0.5257311, 0, 0.8506508,
0, 0.381966, 1, -0.5257311, 0, 0.8506508,
-0.618034, 0.618034, 0.618034, -0.5257311, 0, 0.8506508,
-0.618034, -0.618034, 0.618034, -0.5257311, 0, 0.8506507,
-0.618034, 0.618034, 0.618034, -0.5257311, 0, 0.8506507,
-1, 0, 0.381966, -0.5257311, 0, 0.8506507,
-0.618034, -0.618034, 0.618034, 0, -0.8506508, 0.525731,
-0.381966, -1, 0, 0, -0.8506508, 0.525731,
0.381966, -1, 0, 0, -0.8506508, 0.525731,
-0.618034, -0.618034, 0.618034, 0, -0.8506508, 0.5257311,
0.381966, -1, 0, 0, -0.8506508, 0.5257311,
0.618034, -0.618034, 0.618034, 0, -0.8506508, 0.5257311,
-0.618034, -0.618034, 0.618034, 0, -0.8506507, 0.5257311,
0.618034, -0.618034, 0.618034, 0, -0.8506507, 0.5257311,
0, -0.381966, 1, 0, -0.8506507, 0.5257311,
0.618034, -0.618034, 0.618034, 0.5257311, 0, 0.8506507,
1, 0, 0.381966, 0.5257311, 0, 0.8506507,
0.618034, 0.618034, 0.618034, 0.5257311, 0, 0.8506507,
0.618034, -0.618034, 0.618034, 0.5257311, 0, 0.8506508,
0.618034, 0.618034, 0.618034, 0.5257311, 0, 0.8506508,
0, 0.381966, 1, 0.5257311, 0, 0.8506508,
0.618034, -0.618034, 0.618034, 0.525731, 0, 0.8506508,
0, 0.381966, 1, 0.525731, 0, 0.8506508,
0, -0.381966, 1, 0.525731, 0, 0.8506508,
-0.618034, 0.618034, 0.618034, 0, 0.8506507, 0.5257311,
0, 0.381966, 1, 0, 0.8506507, 0.5257311,
0.618034, 0.618034, 0.618034, 0, 0.8506507, 0.5257311,
-0.618034, 0.618034, 0.618034, 0, 0.8506508, 0.5257311,
0.618034, 0.618034, 0.618034, 0, 0.8506508, 0.5257311,
0.381966, 1, 0, 0, 0.8506508, 0.5257311,
-0.618034, 0.618034, 0.618034, 0, 0.8506508, 0.525731,
0.381966, 1, 0, 0, 0.8506508, 0.525731,
-0.381966, 1, 0, 0, 0.8506508, 0.525731
]);
this.values[108] = v;
this.normLoc[108] = gl.getAttribLocation(this.prog[108], "aNorm");
this.buf[108] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[108]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[108], gl.STATIC_DRAW);
this.mvMatLoc[108] = gl.getUniformLocation(this.prog[108],"mvMatrix");
this.prMatLoc[108] = gl.getUniformLocation(this.prog[108],"prMatrix");
this.normMatLoc[108] = gl.getUniformLocation(this.prog[108],"normMatrix");
// ****** text object 109 ******
this.flags[109] = 40;
this.vshaders[109] = "	/* ****** text object 109 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[109] = "	/* ****** text object 109 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[109]  = gl.createProgram();
gl.attachShader(this.prog[109], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[109] ));
gl.attachShader(this.prog[109], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[109] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[109], 0, "aPos");
gl.bindAttribLocation(this.prog[109], 1, "aCol");
gl.linkProgram(this.prog[109]);
texts = [
"icosahedron3d"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[109] = gl.getAttribLocation(this.prog[109], "aOfs");
this.texture[109] = gl.createTexture();
this.texLoc[109] = gl.getAttribLocation(this.prog[109], "aTexcoord");
this.sampler[109] = gl.getUniformLocation(this.prog[109],"uSampler");
handleLoadedTexture(this.texture[109], document.getElementById("unnamed_chunk_2textureCanvas"));
this.offsets[109]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
0, 0, 0, 0, -0.5, 0.5, 0.5,
0, 0, 0, 1, -0.5, 0.5, 0.5,
0, 0, 0, 1, 1.5, 0.5, 0.5,
0, 0, 0, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[109].stride*(4*i + j) + this.offsets[109].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[109] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[109] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[109]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[109], gl.STATIC_DRAW);
this.ibuf[109] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[109]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[109] = gl.getUniformLocation(this.prog[109],"mvMatrix");
this.prMatLoc[109] = gl.getUniformLocation(this.prog[109],"prMatrix");
this.textScaleLoc[109] = gl.getUniformLocation(this.prog[109],"textScale");
// ****** triangles object 110 ******
this.flags[110] = 3;
this.vshaders[110] = "	/* ****** triangles object 110 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[110] = "	/* ****** triangles object 110 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[110]  = gl.createProgram();
gl.attachShader(this.prog[110], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[110] ));
gl.attachShader(this.prog[110], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[110] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[110], 0, "aPos");
gl.bindAttribLocation(this.prog[110], 1, "aCol");
gl.linkProgram(this.prog[110]);
this.offsets[110]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
0, 0.618034, 1, 0.3568221, -0, 0.9341723,
0, -0.618034, 1, 0.3568221, -0, 0.9341723,
1, 0, 0.618034, 0.3568221, -0, 0.9341723,
0, 0.618034, 1, 0.5773503, 0.5773503, 0.5773503,
1, 0, 0.618034, 0.5773503, 0.5773503, 0.5773503,
0.618034, 1, 0, 0.5773503, 0.5773503, 0.5773503,
0, 0.618034, 1, 0, 0.9341723, 0.3568221,
0.618034, 1, 0, 0, 0.9341723, 0.3568221,
-0.618034, 1, 0, 0, 0.9341723, 0.3568221,
0, 0.618034, 1, -0.5773503, 0.5773503, 0.5773503,
-0.618034, 1, 0, -0.5773503, 0.5773503, 0.5773503,
-1, 0, 0.618034, -0.5773503, 0.5773503, 0.5773503,
0, 0.618034, 1, -0.3568221, 0, 0.9341723,
-1, 0, 0.618034, -0.3568221, 0, 0.9341723,
0, -0.618034, 1, -0.3568221, 0, 0.9341723,
0, -0.618034, -1, -0.3568221, 0, -0.9341723,
-1, 0, -0.618034, -0.3568221, 0, -0.9341723,
0, 0.618034, -1, -0.3568221, 0, -0.9341723,
0, -0.618034, -1, 0.3568221, 0, -0.9341723,
0, 0.618034, -1, 0.3568221, 0, -0.9341723,
1, 0, -0.618034, 0.3568221, 0, -0.9341723,
0, -0.618034, -1, 0.5773503, -0.5773503, -0.5773503,
1, 0, -0.618034, 0.5773503, -0.5773503, -0.5773503,
0.618034, -1, 0, 0.5773503, -0.5773503, -0.5773503,
0, -0.618034, -1, -0, -0.9341723, -0.3568221,
0.618034, -1, 0, -0, -0.9341723, -0.3568221,
-0.618034, -1, 0, -0, -0.9341723, -0.3568221,
0, -0.618034, -1, -0.5773503, -0.5773503, -0.5773503,
-0.618034, -1, 0, -0.5773503, -0.5773503, -0.5773503,
-1, 0, -0.618034, -0.5773503, -0.5773503, -0.5773503,
1, 0, 0.618034, 0.5773503, -0.5773503, 0.5773503,
0, -0.618034, 1, 0.5773503, -0.5773503, 0.5773503,
0.618034, -1, 0, 0.5773503, -0.5773503, 0.5773503,
0.618034, 1, 0, 0.9341723, 0.3568221, 0,
1, 0, 0.618034, 0.9341723, 0.3568221, 0,
1, 0, -0.618034, 0.9341723, 0.3568221, 0,
-0.618034, 1, 0, 0, 0.9341723, -0.3568221,
0.618034, 1, 0, 0, 0.9341723, -0.3568221,
0, 0.618034, -1, 0, 0.9341723, -0.3568221,
-1, 0, 0.618034, -0.9341723, 0.3568221, 0,
-0.618034, 1, 0, -0.9341723, 0.3568221, 0,
-1, 0, -0.618034, -0.9341723, 0.3568221, 0,
0, -0.618034, 1, -0.5773503, -0.5773503, 0.5773503,
-1, 0, 0.618034, -0.5773503, -0.5773503, 0.5773503,
-0.618034, -1, 0, -0.5773503, -0.5773503, 0.5773503,
0, 0.618034, -1, -0.5773503, 0.5773503, -0.5773503,
-1, 0, -0.618034, -0.5773503, 0.5773503, -0.5773503,
-0.618034, 1, 0, -0.5773503, 0.5773503, -0.5773503,
1, 0, -0.618034, 0.5773503, 0.5773503, -0.5773503,
0, 0.618034, -1, 0.5773503, 0.5773503, -0.5773503,
0.618034, 1, 0, 0.5773503, 0.5773503, -0.5773503,
0.618034, -1, 0, 0.9341723, -0.3568221, 0,
1, 0, -0.618034, 0.9341723, -0.3568221, 0,
1, 0, 0.618034, 0.9341723, -0.3568221, 0,
-0.618034, -1, 0, 0, -0.9341723, 0.3568221,
0.618034, -1, 0, 0, -0.9341723, 0.3568221,
0, -0.618034, 1, 0, -0.9341723, 0.3568221,
-1, 0, -0.618034, -0.9341723, -0.3568221, 0,
-0.618034, -1, 0, -0.9341723, -0.3568221, 0,
-1, 0, 0.618034, -0.9341723, -0.3568221, 0
]);
this.values[110] = v;
this.normLoc[110] = gl.getAttribLocation(this.prog[110], "aNorm");
this.buf[110] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[110]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[110], gl.STATIC_DRAW);
this.mvMatLoc[110] = gl.getUniformLocation(this.prog[110],"mvMatrix");
this.prMatLoc[110] = gl.getUniformLocation(this.prog[110],"prMatrix");
this.normMatLoc[110] = gl.getUniformLocation(this.prog[110],"normMatrix");
// ****** text object 111 ******
this.flags[111] = 40;
this.vshaders[111] = "	/* ****** text object 111 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[111] = "	/* ****** text object 111 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[111]  = gl.createProgram();
gl.attachShader(this.prog[111], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[111] ));
gl.attachShader(this.prog[111], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[111] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[111], 0, "aPos");
gl.bindAttribLocation(this.prog[111], 1, "aCol");
gl.linkProgram(this.prog[111]);
texts = [
"cuboctahedron3d"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[111] = gl.getAttribLocation(this.prog[111], "aOfs");
this.texture[111] = gl.createTexture();
this.texLoc[111] = gl.getAttribLocation(this.prog[111], "aTexcoord");
this.sampler[111] = gl.getUniformLocation(this.prog[111],"uSampler");
handleLoadedTexture(this.texture[111], document.getElementById("unnamed_chunk_2textureCanvas"));
this.offsets[111]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
0, 0, 0, 0, -0.5, 0.5, 0.5,
0, 0, 0, 1, -0.5, 0.5, 0.5,
0, 0, 0, 1, 1.5, 0.5, 0.5,
0, 0, 0, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[111].stride*(4*i + j) + this.offsets[111].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[111] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[111] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[111]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[111], gl.STATIC_DRAW);
this.ibuf[111] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[111]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[111] = gl.getUniformLocation(this.prog[111],"mvMatrix");
this.prMatLoc[111] = gl.getUniformLocation(this.prog[111],"prMatrix");
this.textScaleLoc[111] = gl.getUniformLocation(this.prog[111],"textScale");
// ****** triangles object 112 ******
this.flags[112] = 3;
this.vshaders[112] = "	/* ****** triangles object 112 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[112] = "	/* ****** triangles object 112 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[112]  = gl.createProgram();
gl.attachShader(this.prog[112], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[112] ));
gl.attachShader(this.prog[112], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[112] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[112], 0, "aPos");
gl.bindAttribLocation(this.prog[112], 1, "aCol");
gl.linkProgram(this.prog[112]);
this.offsets[112]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
-1, -1, 0, -0.5773503, -0.5773503, -0.5773503,
-1, 0, -1, -0.5773503, -0.5773503, -0.5773503,
0, -1, -1, -0.5773503, -0.5773503, -0.5773503,
-1, -1, 0, -0.5773503, -0.5773503, 0.5773503,
0, -1, 1, -0.5773503, -0.5773503, 0.5773503,
-1, 0, 1, -0.5773503, -0.5773503, 0.5773503,
-1, 1, 0, -0.5773503, 0.5773503, -0.5773503,
0, 1, -1, -0.5773503, 0.5773503, -0.5773503,
-1, 0, -1, -0.5773503, 0.5773503, -0.5773503,
-1, 1, 0, -0.5773503, 0.5773503, 0.5773503,
-1, 0, 1, -0.5773503, 0.5773503, 0.5773503,
0, 1, 1, -0.5773503, 0.5773503, 0.5773503,
1, -1, 0, 0.5773503, -0.5773503, -0.5773503,
0, -1, -1, 0.5773503, -0.5773503, -0.5773503,
1, 0, -1, 0.5773503, -0.5773503, -0.5773503,
1, -1, 0, 0.5773503, -0.5773503, 0.5773503,
1, 0, 1, 0.5773503, -0.5773503, 0.5773503,
0, -1, 1, 0.5773503, -0.5773503, 0.5773503,
1, 1, 0, 0.5773503, 0.5773503, -0.5773503,
1, 0, -1, 0.5773503, 0.5773503, -0.5773503,
0, 1, -1, 0.5773503, 0.5773503, -0.5773503,
1, 1, 0, 0.5773503, 0.5773503, 0.5773503,
0, 1, 1, 0.5773503, 0.5773503, 0.5773503,
1, 0, 1, 0.5773503, 0.5773503, 0.5773503
]);
this.values[112] = v;
this.normLoc[112] = gl.getAttribLocation(this.prog[112], "aNorm");
this.buf[112] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[112]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[112], gl.STATIC_DRAW);
this.mvMatLoc[112] = gl.getUniformLocation(this.prog[112],"mvMatrix");
this.prMatLoc[112] = gl.getUniformLocation(this.prog[112],"prMatrix");
this.normMatLoc[112] = gl.getUniformLocation(this.prog[112],"normMatrix");
// ****** quads object 113 ******
this.flags[113] = 11;
this.vshaders[113] = "	/* ****** quads object 113 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[113] = "	/* ****** quads object 113 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[113]  = gl.createProgram();
gl.attachShader(this.prog[113], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[113] ));
gl.attachShader(this.prog[113], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[113] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[113], 0, "aPos");
gl.bindAttribLocation(this.prog[113], 1, "aCol");
gl.linkProgram(this.prog[113]);
this.offsets[113]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
-1, -1, 0, -1, 0, -0,
-1, 0, 1, -1, 0, -0,
-1, 1, 0, -1, 0, -0,
-1, 0, -1, -1, 0, -0,
-1, -1, 0, 0, -1, 0,
0, -1, -1, 0, -1, 0,
1, -1, 0, 0, -1, 0,
0, -1, 1, 0, -1, 0,
-1, 1, 0, 0, 1, 0,
0, 1, 1, 0, 1, 0,
1, 1, 0, 0, 1, 0,
0, 1, -1, 0, 1, 0,
1, -1, 0, 1, 0, -0,
1, 0, -1, 1, 0, -0,
1, 1, 0, 1, 0, -0,
1, 0, 1, 1, 0, -0,
-1, 0, -1, 0, -0, -1,
0, 1, -1, 0, -0, -1,
1, 0, -1, 0, -0, -1,
0, -1, -1, 0, -0, -1,
-1, 0, 1, 0, -0, 1,
0, -1, 1, 0, -0, 1,
1, 0, 1, 0, -0, 1,
0, 1, 1, 0, -0, 1
]);
this.values[113] = v;
this.normLoc[113] = gl.getAttribLocation(this.prog[113], "aNorm");
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23
]);
this.buf[113] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[113]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[113], gl.STATIC_DRAW);
this.ibuf[113] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[113]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[113] = gl.getUniformLocation(this.prog[113],"mvMatrix");
this.prMatLoc[113] = gl.getUniformLocation(this.prog[113],"prMatrix");
this.normMatLoc[113] = gl.getUniformLocation(this.prog[113],"normMatrix");
// ****** text object 114 ******
this.flags[114] = 40;
this.vshaders[114] = "	/* ****** text object 114 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec2 aTexcoord;\n	varying vec2 vTexcoord;\n	uniform vec2 textScale;\n	attribute vec2 aOfs;\n	void main(void) {\n	  vCol = aCol;\n	  vTexcoord = aTexcoord;\n	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);\n	  pos = pos/pos.w;\n	  gl_Position = pos + vec4(aOfs*textScale, 0.,0.);\n	}";
this.fshaders[114] = "	/* ****** text object 114 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec2 vTexcoord;\n	uniform sampler2D uSampler;\n	void main(void) {\n      vec4 colDiff = vCol;\n	  vec4 lighteffect = colDiff;\n	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);\n	  if (textureColor.a < 0.1)\n	    discard;\n	  else\n	    gl_FragColor = textureColor;\n	}";
this.prog[114]  = gl.createProgram();
gl.attachShader(this.prog[114], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[114] ));
gl.attachShader(this.prog[114], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[114] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[114], 0, "aPos");
gl.bindAttribLocation(this.prog[114], 1, "aCol");
gl.linkProgram(this.prog[114]);
texts = [
"oh3d"
];
texinfo = drawTextToCanvas(texts, 1);
this.ofsLoc[114] = gl.getAttribLocation(this.prog[114], "aOfs");
this.texture[114] = gl.createTexture();
this.texLoc[114] = gl.getAttribLocation(this.prog[114], "aTexcoord");
this.sampler[114] = gl.getUniformLocation(this.prog[114],"uSampler");
handleLoadedTexture(this.texture[114], document.getElementById("unnamed_chunk_2textureCanvas"));
this.offsets[114]={vofs:0, cofs:-1, nofs:-1, radofs:-1, oofs:5, tofs:3, stride:7};
v=new Float32Array([
0, 0, 0, 0, -0.5, 0.5, 0.5,
0, 0, 0, 1, -0.5, 0.5, 0.5,
0, 0, 0, 1, 1.5, 0.5, 0.5,
0, 0, 0, 0, 1.5, 0.5, 0.5
]);
for (i=0; i<1; i++)
for (j=0; j<4; j++) {
ind = this.offsets[114].stride*(4*i + j) + this.offsets[114].tofs;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip -
v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
this.values[114] = v;
f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
this.buf[114] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[114]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[114], gl.STATIC_DRAW);
this.ibuf[114] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[114]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[114] = gl.getUniformLocation(this.prog[114],"mvMatrix");
this.prMatLoc[114] = gl.getUniformLocation(this.prog[114],"prMatrix");
this.textScaleLoc[114] = gl.getUniformLocation(this.prog[114],"textScale");
// ****** quads object 115 ******
this.flags[115] = 11;
this.vshaders[115] = "	/* ****** quads object 115 vertex shader ****** */\n	attribute vec3 aPos;\n	attribute vec4 aCol;\n	uniform mat4 mvMatrix;\n	uniform mat4 prMatrix;\n	varying vec4 vCol;\n	varying vec4 vPosition;\n	attribute vec3 aNorm;\n	uniform mat4 normMatrix;\n	varying vec3 vNormal;\n	void main(void) {\n	  vPosition = mvMatrix * vec4(aPos, 1.);\n	  gl_Position = prMatrix * vPosition;\n	  vCol = aCol;\n	  vNormal = normalize((normMatrix * vec4(aNorm, 1.)).xyz);\n	}";
this.fshaders[115] = "	/* ****** quads object 115 fragment shader ****** */\n	#ifdef GL_ES\n	precision highp float;\n	#endif\n	varying vec4 vCol; // carries alpha\n	varying vec4 vPosition;\n	varying vec3 vNormal;\n	void main(void) {\n	  vec3 eye = normalize(-vPosition.xyz);\n	  const vec3 emission = vec3(0., 0., 0.);\n	  const vec3 ambient1 = vec3(0., 0., 0.);\n	  const vec3 specular1 = vec3(1., 1., 1.);// light*material\n	  const float shininess1 = 50.;\n	  vec4 colDiff1 = vec4(vCol.rgb * vec3(1., 1., 1.), vCol.a);\n	  const vec3 lightDir1 = vec3(0., 0., 1.);\n	  vec3 halfVec1 = normalize(lightDir1 + eye);\n      vec4 lighteffect = vec4(emission, 0.);\n	  vec3 n = normalize(vNormal);\n	  n = -faceforward(n, n, eye);\n	  vec3 col1 = ambient1;\n	  float nDotL1 = dot(n, lightDir1);\n	  col1 = col1 + max(nDotL1, 0.) * colDiff1.rgb;\n	  col1 = col1 + pow(max(dot(halfVec1, n), 0.), shininess1) * specular1;\n	  lighteffect = lighteffect + vec4(col1, colDiff1.a);\n	  gl_FragColor = lighteffect;\n	}";
this.prog[115]  = gl.createProgram();
gl.attachShader(this.prog[115], this.getShader( gl, gl.VERTEX_SHADER, this.vshaders[115] ));
gl.attachShader(this.prog[115], this.getShader( gl, gl.FRAGMENT_SHADER, this.fshaders[115] ));
//  Force aPos to location 0, aCol to location 1
gl.bindAttribLocation(this.prog[115], 0, "aPos");
gl.bindAttribLocation(this.prog[115], 1, "aCol");
gl.linkProgram(this.prog[115]);
this.offsets[115]={vofs:0, cofs:-1, nofs:3, radofs:-1, oofs:-1, tofs:-1, stride:6};
v=new Float32Array([
-1.5, -1.5, -0.5, 0, 0, -1,
-1.5, -0.5, -0.5, 0, 0, -1,
-0.5, -0.5, -0.5, 0, 0, -1,
-0.5, -1.5, -0.5, 0, 0, -1,
-0.5, -1.5, -0.5, 0, 0, -1,
-0.5, -0.5, -0.5, 0, 0, -1,
0.5, -0.5, -0.5, 0, 0, -1,
0.5, -1.5, -0.5, 0, 0, -1,
0.5, -1.5, -0.5, 0, 0, -1,
0.5, -0.5, -0.5, 0, 0, -1,
1.5, -0.5, -0.5, 0, 0, -1,
1.5, -1.5, -0.5, 0, 0, -1,
-1.5, -0.5, -0.5, 0, 0, -1,
-1.5, 0.5, -0.5, 0, 0, -1,
-0.5, 0.5, -0.5, 0, 0, -1,
-0.5, -0.5, -0.5, 0, 0, -1,
0.5, -0.5, -0.5, 0, 0, -1,
0.5, 0.5, -0.5, 0, 0, -1,
1.5, 0.5, -0.5, 0, 0, -1,
1.5, -0.5, -0.5, 0, 0, -1,
-1.5, 0.5, -0.5, 0, 0, -1,
-1.5, 1.5, -0.5, 0, 0, -1,
-0.5, 1.5, -0.5, 0, 0, -1,
-0.5, 0.5, -0.5, 0, 0, -1,
-0.5, 0.5, -0.5, 0, 0, -1,
-0.5, 1.5, -0.5, 0, 0, -1,
0.5, 1.5, -0.5, 0, 0, -1,
0.5, 0.5, -0.5, 0, 0, -1,
0.5, 0.5, -0.5, 0, 0, -1,
0.5, 1.5, -0.5, 0, 0, -1,
1.5, 1.5, -0.5, 0, 0, -1,
1.5, 0.5, -0.5, 0, 0, -1,
-1.5, -1.5, 0.5, 0, -0, 1,
-0.5, -1.5, 0.5, 0, -0, 1,
-0.5, -0.5, 0.5, 0, -0, 1,
-1.5, -0.5, 0.5, 0, -0, 1,
-0.5, -1.5, 0.5, 0, -0, 1,
0.5, -1.5, 0.5, 0, -0, 1,
0.5, -0.5, 0.5, 0, -0, 1,
-0.5, -0.5, 0.5, 0, -0, 1,
0.5, -1.5, 0.5, 0, -0, 1,
1.5, -1.5, 0.5, 0, -0, 1,
1.5, -0.5, 0.5, 0, -0, 1,
0.5, -0.5, 0.5, 0, -0, 1,
-1.5, -0.5, 0.5, 0, -0, 1,
-0.5, -0.5, 0.5, 0, -0, 1,
-0.5, 0.5, 0.5, 0, -0, 1,
-1.5, 0.5, 0.5, 0, -0, 1,
0.5, -0.5, 0.5, 0, -0, 1,
1.5, -0.5, 0.5, 0, -0, 1,
1.5, 0.5, 0.5, 0, -0, 1,
0.5, 0.5, 0.5, 0, -0, 1,
-1.5, 0.5, 0.5, 0, -0, 1,
-0.5, 0.5, 0.5, 0, -0, 1,
-0.5, 1.5, 0.5, 0, -0, 1,
-1.5, 1.5, 0.5, 0, -0, 1,
-0.5, 0.5, 0.5, 0, -0, 1,
0.5, 0.5, 0.5, 0, -0, 1,
0.5, 1.5, 0.5, 0, -0, 1,
-0.5, 1.5, 0.5, 0, -0, 1,
0.5, 0.5, 0.5, 0, -0, 1,
1.5, 0.5, 0.5, 0, -0, 1,
1.5, 1.5, 0.5, 0, -0, 1,
0.5, 1.5, 0.5, 0, -0, 1,
-1.5, -1.5, -0.5, 0, -1, 0,
-0.5, -1.5, -0.5, 0, -1, 0,
-0.5, -1.5, 0.5, 0, -1, 0,
-1.5, -1.5, 0.5, 0, -1, 0,
-0.5, -1.5, -0.5, 0, -1, 0,
0.5, -1.5, -0.5, 0, -1, 0,
0.5, -1.5, 0.5, 0, -1, 0,
-0.5, -1.5, 0.5, 0, -1, 0,
0.5, -1.5, -0.5, 0, -1, 0,
1.5, -1.5, -0.5, 0, -1, 0,
1.5, -1.5, 0.5, 0, -1, 0,
0.5, -1.5, 0.5, 0, -1, 0,
-0.5, -0.5, -0.5, -0, 1, 0,
-0.5, -0.5, 0.5, -0, 1, 0,
0.5, -0.5, 0.5, -0, 1, 0,
0.5, -0.5, -0.5, -0, 1, 0,
-0.5, 0.5, -0.5, 0, -1, 0,
0.5, 0.5, -0.5, 0, -1, 0,
0.5, 0.5, 0.5, 0, -1, 0,
-0.5, 0.5, 0.5, 0, -1, 0,
-1.5, 1.5, -0.5, -0, 1, 0,
-1.5, 1.5, 0.5, -0, 1, 0,
-0.5, 1.5, 0.5, -0, 1, 0,
-0.5, 1.5, -0.5, -0, 1, 0,
-0.5, 1.5, -0.5, -0, 1, 0,
-0.5, 1.5, 0.5, -0, 1, 0,
0.5, 1.5, 0.5, -0, 1, 0,
0.5, 1.5, -0.5, -0, 1, 0,
0.5, 1.5, -0.5, -0, 1, 0,
0.5, 1.5, 0.5, -0, 1, 0,
1.5, 1.5, 0.5, -0, 1, 0,
1.5, 1.5, -0.5, -0, 1, 0,
-1.5, -1.5, 0.5, -1, -0, -0,
-1.5, -0.5, 0.5, -1, -0, -0,
-1.5, -0.5, -0.5, -1, -0, -0,
-1.5, -1.5, -0.5, -1, -0, -0,
-1.5, -0.5, 0.5, -1, -0, -0,
-1.5, 0.5, 0.5, -1, -0, -0,
-1.5, 0.5, -0.5, -1, -0, -0,
-1.5, -0.5, -0.5, -1, -0, -0,
-1.5, 0.5, 0.5, -1, -0, -0,
-1.5, 1.5, 0.5, -1, -0, -0,
-1.5, 1.5, -0.5, -1, -0, -0,
-1.5, 0.5, -0.5, -1, -0, -0,
1.5, -1.5, -0.5, 1, 0, -0,
1.5, -0.5, -0.5, 1, 0, -0,
1.5, -0.5, 0.5, 1, 0, -0,
1.5, -1.5, 0.5, 1, 0, -0,
1.5, -0.5, -0.5, 1, 0, -0,
1.5, 0.5, -0.5, 1, 0, -0,
1.5, 0.5, 0.5, 1, 0, -0,
1.5, -0.5, 0.5, 1, 0, -0,
1.5, 0.5, -0.5, 1, 0, -0,
1.5, 1.5, -0.5, 1, 0, -0,
1.5, 1.5, 0.5, 1, 0, -0,
1.5, 0.5, 0.5, 1, 0, -0,
-0.5, -0.5, -0.5, 1, 0, -0,
-0.5, 0.5, -0.5, 1, 0, -0,
-0.5, 0.5, 0.5, 1, 0, -0,
-0.5, -0.5, 0.5, 1, 0, -0,
0.5, -0.5, -0.5, -1, 0, 0,
0.5, -0.5, 0.5, -1, 0, 0,
0.5, 0.5, 0.5, -1, 0, 0,
0.5, 0.5, -0.5, -1, 0, 0
]);
this.values[115] = v;
this.normLoc[115] = gl.getAttribLocation(this.prog[115], "aNorm");
f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23,
24, 25, 26, 24, 26, 27,
28, 29, 30, 28, 30, 31,
32, 33, 34, 32, 34, 35,
36, 37, 38, 36, 38, 39,
40, 41, 42, 40, 42, 43,
44, 45, 46, 44, 46, 47,
48, 49, 50, 48, 50, 51,
52, 53, 54, 52, 54, 55,
56, 57, 58, 56, 58, 59,
60, 61, 62, 60, 62, 63,
64, 65, 66, 64, 66, 67,
68, 69, 70, 68, 70, 71,
72, 73, 74, 72, 74, 75,
76, 77, 78, 76, 78, 79,
80, 81, 82, 80, 82, 83,
84, 85, 86, 84, 86, 87,
88, 89, 90, 88, 90, 91,
92, 93, 94, 92, 94, 95,
96, 97, 98, 96, 98, 99,
100, 101, 102, 100, 102, 103,
104, 105, 106, 104, 106, 107,
108, 109, 110, 108, 110, 111,
112, 113, 114, 112, 114, 115,
116, 117, 118, 116, 118, 119,
120, 121, 122, 120, 122, 123,
124, 125, 126, 124, 126, 127
]);
this.buf[115] = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[115]);
gl.bufferData(gl.ARRAY_BUFFER, this.values[115], gl.STATIC_DRAW);
this.ibuf[115] = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[115]);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
this.mvMatLoc[115] = gl.getUniformLocation(this.prog[115],"mvMatrix");
this.prMatLoc[115] = gl.getUniformLocation(this.prog[115],"prMatrix");
this.normMatLoc[115] = gl.getUniformLocation(this.prog[115],"normMatrix");
gl.enable(gl.DEPTH_TEST);
gl.depthFunc(gl.LEQUAL);
gl.clearDepth(1.0);
gl.clearColor(1,1,1,1);
var drag  = 0;
this.drawScene = function() {
gl.depthMask(true);
gl.disable(gl.BLEND);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
this.drawFns[79].call(this, 79);
gl.flush();
};
// ****** text object 101 *******
this.drawFns[101] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** triangles object 102 *******
this.drawFns[102] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.TRIANGLES, 0, 12);
};
// ****** text object 103 *******
this.drawFns[103] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** quads object 104 *******
this.drawFns[104] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0.8588235, 0, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 105 *******
this.drawFns[105] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** triangles object 106 *******
this.drawFns[106] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0.2862745, 1, 0, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.TRIANGLES, 0, 24);
};
// ****** text object 107 *******
this.drawFns[107] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** triangles object 108 *******
this.drawFns[108] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 1, 0.572549, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.TRIANGLES, 0, 108);
};
// ****** text object 109 *******
this.drawFns[109] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** triangles object 110 *******
this.drawFns[110] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0.572549, 1, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.TRIANGLES, 0, 60);
};
// ****** text object 111 *******
this.drawFns[111] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** triangles object 112 *******
this.drawFns[112] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0.2862745, 0, 1, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawArrays(gl.TRIANGLES, 0, 24);
};
// ****** quads object 113 *******
this.drawFns[113] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0.2862745, 0, 1, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
};
// ****** text object 114 *******
this.drawFns[114] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniform2f( this.textScaleLoc[id], 0.75/this.vp[2], 0.75/this.vp[3]);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( this.texLoc[id] );
gl.vertexAttribPointer(this.texLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].tofs);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, this.texture[id]);
gl.uniform1i( this.sampler[id], 0);
gl.enableVertexAttribArray( this.ofsLoc[id] );
gl.vertexAttribPointer(this.ofsLoc[id], 2, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].oofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
};
// ****** quads object 115 *******
this.drawFns[115] = function(id, clipplanes) {
var i;
gl.useProgram(this.prog[id]);
gl.bindBuffer(gl.ARRAY_BUFFER, this.buf[id]);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, this.ibuf[id]);
gl.uniformMatrix4fv( this.prMatLoc[id], false, new Float32Array(this.prMatrix.getAsArray()) );
gl.uniformMatrix4fv( this.mvMatLoc[id], false, new Float32Array(this.mvMatrix.getAsArray()) );
var clipcheck = 0;
for (i=0; i < clipplanes.length; i++)
clipcheck = this.clipFns[clipplanes[i]].call(this, clipplanes[i], id, clipcheck);
gl.uniformMatrix4fv( this.normMatLoc[id], false, new Float32Array(normMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0.8588235, 1 );
gl.enableVertexAttribArray( this.normLoc[id] );
gl.vertexAttribPointer(this.normLoc[id], 3, gl.FLOAT, false, 4*this.offsets[id].stride, 4*this.offsets[id].nofs);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 4*this.offsets[id].stride,  4*this.offsets[id].vofs);
gl.drawElements(gl.TRIANGLES, 192, gl.UNSIGNED_SHORT, 0);
};
// ***** subscene 79 ****
this.drawFns[79] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.clearColor(1, 1, 1, 1);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 85 ****
this.drawFns[85] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1,
distance = 3.863703,
t = tan(this.FOV[85]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[85];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[85] );
this.mvMatrix.translate(-0, -0, -3.863703);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 86 ****
this.drawFns[86] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1.905256,
distance = 6.692131,
t = tan(this.FOV[86]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[86];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[86] );
this.mvMatrix.translate(-0, -0, -6.692131);
normMatrix.makeIdentity();
normMatrix.scale( 1, 1, 1 );
normMatrix.multRight( unnamed_chunk_2rgl.userMatrix[86] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 87 ****
this.drawFns[87] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1,
distance = 3.863703,
t = tan(this.FOV[87]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[87];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[87] );
this.mvMatrix.translate(-0, -0, -3.863703);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 88 ****
this.drawFns[88] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1.905256,
distance = 6.692131,
t = tan(this.FOV[88]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[88];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[88] );
this.mvMatrix.translate(-0, -0, -6.692131);
normMatrix.makeIdentity();
normMatrix.scale( 1, 1, 1 );
normMatrix.multRight( unnamed_chunk_2rgl.userMatrix[88] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 89 ****
this.drawFns[89] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1,
distance = 3.863703,
t = tan(this.FOV[89]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[89];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[89] );
this.mvMatrix.translate(-0, -0, -3.863703);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 90 ****
this.drawFns[90] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1.905256,
distance = 6.692131,
t = tan(this.FOV[90]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[90];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[90] );
this.mvMatrix.translate(-0, -0, -6.692131);
normMatrix.makeIdentity();
normMatrix.scale( 1, 1, 1 );
normMatrix.multRight( unnamed_chunk_2rgl.userMatrix[90] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 91 ****
this.drawFns[91] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1,
distance = 3.863703,
t = tan(this.FOV[91]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[91];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[91] );
this.mvMatrix.translate(-0, -0, -3.863703);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 92 ****
this.drawFns[92] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1.905256,
distance = 6.692131,
t = tan(this.FOV[92]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[92];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[92] );
this.mvMatrix.translate(-0, -0, -6.692131);
normMatrix.makeIdentity();
normMatrix.scale( 1, 1, 1 );
normMatrix.multRight( unnamed_chunk_2rgl.userMatrix[92] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 93 ****
this.drawFns[93] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1,
distance = 3.863703,
t = tan(this.FOV[93]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[93];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[93] );
this.mvMatrix.translate(-0, -0, -3.863703);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 94 ****
this.drawFns[94] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1.905256,
distance = 6.692131,
t = tan(this.FOV[94]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[94];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[94] );
this.mvMatrix.translate(-0, -0, -6.692131);
normMatrix.makeIdentity();
normMatrix.scale( 1, 1, 1 );
normMatrix.multRight( unnamed_chunk_2rgl.userMatrix[94] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 95 ****
this.drawFns[95] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1,
distance = 3.863703,
t = tan(this.FOV[95]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[95];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[95] );
this.mvMatrix.translate(-0, -0, -3.863703);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 96 ****
this.drawFns[96] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1.905256,
distance = 6.692131,
t = tan(this.FOV[96]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[96];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[96] );
this.mvMatrix.translate(-0, -0, -6.692131);
normMatrix.makeIdentity();
normMatrix.scale( 1, 1, 1 );
normMatrix.multRight( unnamed_chunk_2rgl.userMatrix[96] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 97 ****
this.drawFns[97] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 1,
distance = 3.863703,
t = tan(this.FOV[97]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[97];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[97] );
this.mvMatrix.translate(-0, -0, -3.863703);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 98 ****
this.drawFns[98] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
this.prMatrix.makeIdentity();
var radius = 2.397394,
distance = 8.420747,
t = tan(this.FOV[98]*PI/360),
near = distance - radius,
far = distance + radius,
hlen = t*near,
aspect = this.vp[2]/this.vp[3],
z = this.zoom[98];
if (aspect > 1)
this.prMatrix.frustum(-hlen*aspect*z, hlen*aspect*z,
-hlen*z, hlen*z, near, far);
else
this.prMatrix.frustum(-hlen*z, hlen*z,
-hlen*z/aspect, hlen*z/aspect,
near, far);
this.mvMatrix.makeIdentity();
this.mvMatrix.translate( -0, -0, -0 );
this.mvMatrix.scale( 1, 1, 1 );
this.mvMatrix.multRight( unnamed_chunk_2rgl.userMatrix[98] );
this.mvMatrix.translate(-0, -0, -8.420747);
normMatrix.makeIdentity();
normMatrix.scale( 1, 1, 1 );
normMatrix.multRight( unnamed_chunk_2rgl.userMatrix[98] );
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 99 ****
this.drawFns[99] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
// ***** subscene 100 ****
this.drawFns[100] = function(id) {
var i;
this.vp = this.viewport[id];
gl.viewport(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
gl.scissor(this.vp[0], this.vp[1], this.vp[2], this.vp[3]);
var clipids = this.clipplanes[id];
if (clipids.length > 0) {
this.invMatrix = new CanvasMatrix4(this.mvMatrix);
this.invMatrix.invert();
for (i = 0; i < this.clipplanes[id].length; i++)
this.drawFns[clipids[i]].call(this, clipids[i]);
}
var subids = this.opaque[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
subids = this.transparent[id];
if (subids.length > 0) {
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i], clipids);
}
subids = this.subscenes[id];
for (i = 0; i < subids.length; i++)
this.drawFns[subids[i]].call(this, subids[i]);
};
this.drawScene();
var vpx0 = {
100: 378, 99: 378, 98: 378, 97: 378, 96: 252, 95: 252,
94: 252, 93: 252, 92: 126, 91: 126, 90: 126, 89: 126,
88: 0, 87: 0, 86: 0, 85: 0, 79: 0
};
var vpy0 = {
100: 0, 99: 189, 98: 252, 97: 441, 96: 0, 95: 189,
94: 252, 93: 441, 92: 0, 91: 189, 90: 252, 89: 441,
88: 0, 87: 189, 86: 252, 85: 441, 79: 441
};
var vpWidths = {
100: 126, 99: 126, 98: 126, 97: 126, 96: 126, 95: 126,
94: 126, 93: 126, 92: 126, 91: 126, 90: 126, 89: 126,
88: 126, 87: 126, 86: 126, 85: 126, 79: 126
};
var vpHeights = {
100: 189, 99: 63, 98: 189, 97: 63, 96: 189, 95: 63,
94: 189, 93: 63, 92: 189, 91: 63, 90: 189, 89: 63,
88: 189, 87: 63, 86: 189, 85: 63, 79: 63
};
var activeModel = {
100: 100, 99: 99, 98: 98, 97: 97, 96: 96, 95: 95,
94: 94, 93: 93, 92: 92, 91: 91, 90: 90, 89: 89,
88: 88, 87: 87, 86: 86, 85: 85, 79: 79
};
var activeProjection = {
100: 100, 99: 99, 98: 98, 97: 97, 96: 96, 95: 95,
94: 94, 93: 93, 92: 92, 91: 91, 90: 90, 89: 89,
88: 88, 87: 87, 86: 86, 85: 85, 79: 79
};
unnamed_chunk_2rgl.listeners = {
100: [ 100 ], 99: [ 99 ],
98: [ 98 ], 97: [ 97 ],
96: [ 96 ], 95: [ 95 ],
94: [ 94 ], 93: [ 93 ],
92: [ 92 ], 91: [ 91 ],
90: [ 90 ], 89: [ 89 ],
88: [ 88 ], 87: [ 87 ],
86: [ 86 ], 85: [ 85 ],
79: [ 79 ]
};
var whichSubscene = function(coords){
if (378 <= coords.x && coords.x <= 504 && 0 <= coords.y && coords.y <= 189) return(100);
if (378 <= coords.x && coords.x <= 504 && 189 <= coords.y && coords.y <= 252) return(99);
if (378 <= coords.x && coords.x <= 504 && 252 <= coords.y && coords.y <= 441) return(98);
if (378 <= coords.x && coords.x <= 504 && 441 <= coords.y && coords.y <= 504) return(97);
if (252 <= coords.x && coords.x <= 378 && 0 <= coords.y && coords.y <= 189) return(96);
if (252 <= coords.x && coords.x <= 378 && 189 <= coords.y && coords.y <= 252) return(95);
if (252 <= coords.x && coords.x <= 378 && 252 <= coords.y && coords.y <= 441) return(94);
if (252 <= coords.x && coords.x <= 378 && 441 <= coords.y && coords.y <= 504) return(93);
if (126 <= coords.x && coords.x <= 252 && 0 <= coords.y && coords.y <= 189) return(92);
if (126 <= coords.x && coords.x <= 252 && 189 <= coords.y && coords.y <= 252) return(91);
if (126 <= coords.x && coords.x <= 252 && 252 <= coords.y && coords.y <= 441) return(90);
if (126 <= coords.x && coords.x <= 252 && 441 <= coords.y && coords.y <= 504) return(89);
if (0 <= coords.x && coords.x <= 126 && 0 <= coords.y && coords.y <= 189) return(88);
if (0 <= coords.x && coords.x <= 126 && 189 <= coords.y && coords.y <= 252) return(87);
if (0 <= coords.x && coords.x <= 126 && 252 <= coords.y && coords.y <= 441) return(86);
if (0 <= coords.x && coords.x <= 126 && 441 <= coords.y && coords.y <= 504) return(85);
if (0 <= coords.x && coords.x <= 126 && 441 <= coords.y && coords.y <= 504) return(79);
return(79);
};
var translateCoords = function(subsceneid, coords){
return {x:coords.x - vpx0[subsceneid], y:coords.y - vpy0[subsceneid]};
};
var vlen = function(v) {
return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
};
var xprod = function(a, b) {
return [a[1]*b[2] - a[2]*b[1],
a[2]*b[0] - a[0]*b[2],
a[0]*b[1] - a[1]*b[0]];
};
var screenToVector = function(x, y) {
var width = vpWidths[activeSubscene],
height = vpHeights[activeSubscene],
radius = max(width, height)/2.0,
cx = width/2.0,
cy = height/2.0,
px = (x-cx)/radius,
py = (y-cy)/radius,
plen = sqrt(px*px+py*py);
if (plen > 1.e-6) {
px = px/plen;
py = py/plen;
}
var angle = (SQRT2 - plen)/SQRT2*PI/2,
z = sin(angle),
zlen = sqrt(1.0 - z*z);
px = px * zlen;
py = py * zlen;
return [px, py, z];
};
var rotBase;
var trackballdown = function(x,y) {
rotBase = screenToVector(x, y);
var l = unnamed_chunk_2rgl.listeners[activeModel[activeSubscene]];
saveMat = {};
for (var i = 0; i < l.length; i++)
saveMat[l[i]] = new CanvasMatrix4(unnamed_chunk_2rgl.userMatrix[l[i]]);
};
var trackballmove = function(x,y) {
var rotCurrent = screenToVector(x,y),
dot = rotBase[0]*rotCurrent[0] +
rotBase[1]*rotCurrent[1] +
rotBase[2]*rotCurrent[2],
angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180.0/PI,
axis = xprod(rotBase, rotCurrent),
l = unnamed_chunk_2rgl.listeners[activeModel[activeSubscene]],
i;
for (i = 0; i < l.length; i++) {
unnamed_chunk_2rgl.userMatrix[l[i]].load(saveMat[l[i]]);
unnamed_chunk_2rgl.userMatrix[l[i]].rotate(angle, axis[0], axis[1], axis[2]);
}
unnamed_chunk_2rgl.drawScene();
};
var trackballend = 0;
var y0zoom = 0;
var zoom0 = 0;
var zoomdown = function(x, y) {
y0zoom = y;
zoom0 = {};
l = unnamed_chunk_2rgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
zoom0[l[i]] = log(unnamed_chunk_2rgl.zoom[l[i]]);
};
var zoommove = function(x, y) {
l = unnamed_chunk_2rgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
unnamed_chunk_2rgl.zoom[l[i]] = exp(zoom0[l[i]] + (y-y0zoom)/height);
unnamed_chunk_2rgl.drawScene();
};
var zoomend = 0;
var y0fov = 0;
var fov0 = 0;
var fovdown = function(x, y) {
y0fov = y;
fov0 = {};
l = unnamed_chunk_2rgl.listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
fov0[l[i]] = unnamed_chunk_2rgl.FOV[l[i]];
};
var fovmove = function(x, y) {
l = unnamed_chunk_2rgl.listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
unnamed_chunk_2rgl.FOV[l[i]] = max(1, min(179, fov0[l[i]] + 180*(y-y0fov)/height));
unnamed_chunk_2rgl.drawScene();
};
var fovend = 0;
var mousedown = [trackballdown, zoomdown, fovdown];
var mousemove = [trackballmove, zoommove, fovmove];
var mouseend = [trackballend, zoomend, fovend];
function relMouseCoords(event){
var totalOffsetX = 0,
totalOffsetY = 0,
currentElement = canvas;
do{
totalOffsetX += currentElement.offsetLeft;
totalOffsetY += currentElement.offsetTop;
currentElement = currentElement.offsetParent;
}
while(currentElement);
var canvasX = event.pageX - totalOffsetX,
canvasY = event.pageY - totalOffsetY;
return {x:canvasX, y:canvasY};
}
canvas.onmousedown = function ( ev ){
if (!ev.which) // Use w3c defns in preference to MS
switch (ev.button) {
case 0: ev.which = 1; break;
case 1:
case 4: ev.which = 2; break;
case 2: ev.which = 3;
}
drag = ev.which;
var f = mousedown[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height-coords.y;
activeSubscene = whichSubscene(coords);
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
ev.preventDefault();
}
};
canvas.onmouseup = function ( ev ){
if ( drag === 0 ) return;
var f = mouseend[drag-1];
if (f)
f();
drag = 0;
};
canvas.onmouseout = canvas.onmouseup;
canvas.onmousemove = function ( ev ){
if ( drag === 0 ) return;
var f = mousemove[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height - coords.y;
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
}
};
var wheelHandler = function(ev) {
var del = 1.1;
if (ev.shiftKey) del = 1.01;
var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
l = unnamed_chunk_2rgl.listeners[activeProjection[activeSubscene]];
for (var i = 0; i < l.length; i++)
unnamed_chunk_2rgl.zoom[l[i]] *= ds;
unnamed_chunk_2rgl.drawScene();
ev.preventDefault();
};
canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
canvas.addEventListener("mousewheel", wheelHandler, false);
};
</script>
<canvas id="unnamed_chunk_2canvas" class="rglWebGL" width="1" height="1"></canvas>
<p id="unnamed_chunk_2debug">
You must enable Javascript to view this page properly.</p>
<script>unnamed_chunk_2rgl.start();</script>

### Generating new shapes 

These functions generate new shapes:

------------------------------------ | -----------
<a name="cylinder3d"><a href="../../rgl/help/cylinder3d">`cylinder3d`</a></a>: | generate a tube or cylinder
<a name="polygon3d"><a href="../../rgl/help/polygon3d">`polygon3d`</a></a>:  | generate a flat polygon by triangulation
<a name="extrude3d"><a href="../../rgl/help/extrude3d">`extrude3d`</a></a>:  | generate an "extrusion" of a polygon
<a name="turn3d"><a href="../../rgl/help/turn3d">`turn3d`</a></a>:     | generate a solid of rotation
<a name="ellipse3d"><a href="../../rgl/help/ellipse3d">`ellipse3d`</a></a>:  | generate an ellipsoid in various ways
<a name="tmesh3d"><a href="../../rgl/help/tmesh3d">`tmesh3d`</a></a>, <a name="qmesh3d"><a href="../../rgl/help/qmesh3d">`qmesh3d`</a></a>:  | generate a shape from vertices and faces
<a name="shapelist3d"><a href="../../rgl/help/shapelist3d">`shapelist3d`</a></a>: | generate a shape by combining other shapes

A related function is <a name="triangulate"><a href="../../rgl/help/triangulate">`triangulate`</a></a>, which takes a
two dimensional polygon and divides it up into triangles using the 
"ear-clipping" algorithm.

### The underlying class structure for shapes

`"shape3d"` is the basic abstract type.  Objects of this class can be
displayed by <a name="shade3d"><a href="../../rgl/help/shade3d">`shade3d`</a></a> (which shades faces), 
<a name="wire3d"><a href="../../rgl/help/wire3d">`wire3d`</a></a> (which draws edges), or <a name="dot3d"><a href="../../rgl/help/dot3d">`dot3d`</a></a>
(which draws points at each vertex.)  Note that `wire3d` and `dot3d`
only work within R; in HTML output from <a href="#writeWebGL">`writeWebGL`</a> only
`shade3d` is supported.

`"mesh3d"` is a descendant type.  Objects of this type contain the following 
fields:

Field        | Meaning
------------ | ---------------
vb           | A 4 by n matrix of vertices in homogeneous coordinates.  Each column is a point.
it           | (optional) A 3 by t matrix of vertex indices.  Each column is a triangle.
ib           | (optional) A 4 by q matrix of vertex indices.  Each column is a quadrilateral.
material     | (optional) A list of material properties.
normals      | (optional) A matrix of the same shape as vb, containing normal vectors at each vertex.
texcoords    | (optional) A 2 by n matrix of texture coordinates corresponding to each vertex.

### Manipulating shapes

The final set of functions manipulate and modify mesh objects:

------------------------------------ | -----------
<a name="addNormals"><a href="../../rgl/help/addNormals">`addNormals`</a></a>: | add normal vectors to make a shape look smooth
<a name="subdivision3d"><a href="../../rgl/help/subdivision3d">`subdivision3d`</a></a>: | add extra vertices to make it look even smoother

## Multi-figure Layouts

`rgl` has several functions to support displaying multiple different
"subscenes" in the same window.  The high level functions are

------------------------------------ | -----------
<a name="mfrow3d"><a href="../../rgl/help/mfrow3d">`mfrow3d`</a></a>:  | Multiple figures (like <a href="../../graphics/help/par">par("mfrow")</a>
<a name="layout3d"><a href="../../rgl/help/layout3d">`layout3d`</a></a>: | Multiple figures (like <a href="../../graphics/help/layout">`layout`</a>)
<a name="next3d"><a href="../../rgl/help/next3d">`next3d`</a></a>:   | Move to the next figure (like <a href="../../graphics/help/plot.new">`plot.new`</a> or <a href="../../graphics/help/frame">`frame`</a>)
<a name="subsceneList"><a href="../../rgl/help/subsceneList">`subsceneList`</a></a>: | List all the subscenes in the current layout
<a name="clearSubsceneList"><a href="../../rgl/help/clearSubsceneList">`clearSubsceneList`</a></a> | Clear the current list and revert to the previous one

There are also lower level functions.

------------------------------------ | -----------
<a name="newSubscene3d"><a href="../../rgl/help/newSubscene3d">`newSubscene3d`</a></a>:     | Create a new subscene, with fine control over what is inherited from the parent
<a name="currentSubscene3d"><a href="../../rgl/help/currentSubscene3d">`currentSubscene3d`</a></a>: | Report on the active subscene
<a name="subsceneInfo"><a href="../../rgl/help/subsceneInfo">`subsceneInfo`</a></a>:      | Get information on current subscene
<a name="useSubscene3d"><a href="../../rgl/help/useSubscene3d">`useSubscene3d`</a></a>:     | Make a different subscene active
<a name="addToSubscene3d"><a href="../../rgl/help/addToSubscene3d">`addToSubscene3d`</a></a>, <a name="delFromSubscene3d"><a href="../../rgl/help/delFromSubscene3d">`delFromSubscene3d`</a></a>: | Add objects to a subscene, or delete them
<a name="gc3d"><a href="../../rgl/help/gc3d">`gc3d`</a></a>:              | Do "garbage collection":  delete objects that are not displayed in any subscene


## Utility Functions


### User interaction

By default, `rgl` detects and handles mouse clicks within your scene,
and uses these to control its appearance.  You can find out the current
handlers using the following code:

```r
par3d("mouseMode")
```

```
##        left       right      middle       wheel 
## "trackball"      "zoom"       "fov"      "pull"
```
The labels `c("left", "right", "middle")` refer to the buttons on
a three button mouse, or simulations of them on other mice.  `"wheel"` 
refers to the mouse wheel.

The button actions generally correspond to click and drag operations.
Possible values for <a name="mouseMode"><a href="../../rgl/help/mouseMode"><code>"mouseMode"</code></a></a> for buttons or the wheel are as follows:

--------       | ---------
`"none"`       | No action
`"trackball"`  | The mouse acts as a virtual trackball. Clicking and dragging rotates the scene
`"xAxis"`, `"yAxis"`, `"zAxis"`      | Like `"trackball"`, but restricted to rotation about one axis
`"polar"`      | The mouse affects rotations by controlling polar coordinates directly
`"selecting"`  | The mouse is being used by the <a href="#select3d">`select3d`</a> function
`"zoom"`       | The mouse zooms the display
`"fov"`        | The mouse affects perspective by changing the field of view
`"pull"`       | Rotating the mouse wheel towards the user "pulls the scene closer"
`"push"`       | The same rotation "pushes the scene away"
`"user"`       | A user action set by <a name="rgl.setMouseCallbacks"><a href="../../rgl/help/rgl.setMouseCallbacks">`rgl.setMouseCallbacks`</a></a>, <a name="rgl.setWheelCallback"><a href="../../rgl/help/rgl.setWheelCallback">`rgl.setWheelCallback`</a></a>.  Use <a name="rgl.getMouseCallbacks"><a href="../../rgl/help/rgl.getMouseCallbacks">`rgl.getMouseCallbacks`</a></a> and <a name="rgl.getWheelCallback"><a href="../../rgl/help/rgl.getWheelCallback">`rgl.getWheelCallback`</a></a> to retrieve

The following functions make use of the mouse for selection within a 
scene.

---------------------------- | -----------
<a name="identify3d"><a href="../../rgl/help/identify3d">`identify3d`</a></a>   | like the classic graphics <a href="../../graphics/help/identify">`identify`</a> function
<a name="select3d"><a href="../../rgl/help/select3d">`select3d`</a></a>     | returns a function that tests whether a coordinate was selected
<a name="selectpoints3d"><a href="../../rgl/help/selectpoints3d">`selectpoints3d`</a></a> | selects from specific objects

The <a name="rgl.select3d"><a href="../../rgl/help/rgl.select3d">`rgl.select3d`</a></a> function is an obsolete version of
`select3d`, and <a name="rgl.select"><a href="../../rgl/help/rgl.select">`rgl.select`</a></a> is a low-level support
function.

### Animations

`rgl` has several functions that can be used to construct
animations.  These are based on functions that update the
scene according to the current real-world time, and repeated
calls to those.  The functions are:

---------------------- | -------------
<a name="play3d"><a href="../../rgl/help/play3d">`play3d`</a></a> | Repeatedly call the update function 
<a name="spin3d"><a href="../../rgl/help/spin3d">`spin3d`</a></a> | Update the display by rotating at a constant rate
<a name="par3dinterp"><a href="../../rgl/help/par3dinterp">`par3dinterp`</a></a> | Compute new values of some <a href="#par3d">`par3d`</a> parameters by interpolation over time

See the <a href="#movie3d">`movie3d`</a> function for a way to output an animation
to a file on disk.  
Animations are not currently supported 
in the HTML written by <a href="#writeWebGL">`writeWebGL`</a>. 

### Exporting and importing scenes

`rgl` contains several functions to write scenes to disk for use
by other software, or to read them in.

In order from highest fidelity to lowest, the functions are:

----------- | -------------
<a name="scene3d"><a href="../../rgl/help/scene3d">`scene3d`</a></a>    | Save a scene to an R variable, which can be saved and reloaded
<a name="writeWebGL"><a href="../../rgl/help/writeWebGL">`writeWebGL`</a></a> | Write HTML and Javascript to display a scene in a web browser.  (This vignette uses `writeWebGL`; see also [User Interaction in WebGL](WebGL.html).)
<a name="writePLY"><a href="../../rgl/help/writePLY">`writePLY`</a></a>   | Write PLY files (commonly used in 3D printing)
<a name="readOBJ"><a href="../../rgl/help/readOBJ">`readOBJ`</a></a>, <a name="writeOBJ"><a href="../../rgl/help/writeOBJ">`writeOBJ`</a></a>   | Read or write OBJ files (commonly used in 3D graphics)
<a name="readSTL"><a href="../../rgl/help/readSTL">`readSTL`</a></a>, <a name="writeSTL"><a href="../../rgl/help/writeSTL">`writeSTL`</a></a>   | Read or write STL files (also common in 3D printing)
<a name="rgl.useNULL"><a href="../../rgl/help/rgl.useNULL">`rgl.useNULL`</a></a>  | A helper function for setting a NULL device

See the help page <a href="../../rgl/help/rgl.useNULL">`rgl.useNULL`</a> for instructions on how
to use `rgl` on a "headless" system.

There are also functions to save snapshots or other recordings of a scene,
without any 3D information being saved:

------------ | -------------
<a name="snapshot3d"><a href="../../rgl/help/snapshot3d">`snapshot3d`</a></a> | Save a PNG file bitmap of the scene
<a name="rgl.postscript"><a href="../../rgl/help/rgl.postscript">`rgl.postscript`</a></a> | Save a Postscript, LaTeX, PDF, SVG or PGF vector rendering of the scene
<a name="movie3d"><a href="../../rgl/help/movie3d">`movie3d`</a></a>    | Save a series of bitmaps to be assembled into a movie
<a name="rgl.pixels"><a href="../../rgl/help/rgl.pixels">`rgl.pixels`</a></a> | Obtain pixel-level information about the scene in an R variable
<a name="rgl.Sweave"><a href="../../rgl/help/rgl.Sweave">`rgl.Sweave`</a></a> | Driver function for inserting a snapshot into a Sweave document.
<a name="hook_rgl"><a href="../../rgl/help/hook_rgl">`hook_rgl`</a></a>, <a name="hook_webgl"><a href="../../rgl/help/hook_webgl">`hook_webgl`</a></a> | `knitr` hook functions for inserting images into a document.

The <a name="rgl.snapshot"><a href="../../rgl/help/rgl.snapshot">`rgl.snapshot`</a></a> function is identical to `snapshot3d`.
The functions <a name="rgl.Sweave.off"><a href="../../rgl/help/rgl.Sweave.off">`rgl.Sweave.off`</a></a>, <a name="Sweave.snapshot"><a href="../../rgl/help/Sweave.snapshot">`Sweave.snapshot`</a></a> are 
involved in Sweave processing and not normally called by users.

### Working with WebGL scenes

The `writeWebGL` function exports a scene to HTML and Javascript code.  
The functions below write HTML and Javascript for working with the 
exported scene.  More details are given in the vignette 
[User Interaction in WebGL](WebGL.html).

------------------------------------ | -------------
<a name="propertySlider"><a href="../../rgl/help/propertySlider">`propertySlider`</a></a>       | insert a slider to make changes to a scene
<a name="clipplaneSlider"><a href="../../rgl/help/clipplaneSlider">`clipplaneSlider`</a></a>      | insert a slider to control a clipping plane
<a name="subsetSlider"><a href="../../rgl/help/subsetSlider">`subsetSlider`</a></a>         | insert a slider to control which objects are displayed
<a name="toggleButton"><a href="../../rgl/help/toggleButton">`toggleButton`</a></a>         | insert a button to toggle some items
<a name="propertySetter"><a href="../../rgl/help/propertySetter">`propertySetter`</a></a>       | function to modify properties
<a name="subsetSetter"><a href="../../rgl/help/subsetSetter">`subsetSetter`</a></a>         | function to choose subsets
<a name="ageSetter"><a href="../../rgl/help/ageSetter">`ageSetter`</a></a>            | function to "age" vertices
<a name="par3dinterpSetter"><a href="../../rgl/help/par3dinterpSetter">`par3dinterpSetter`</a></a>    | function like <a href="#par3dinterp">`par3dinterp`</a>

### Working with the scene

`rgl` maintains internal structures for all the scenes it displays.
The following functions allow users to find information about them
and manipulate them.

------------------------------------ | -----------
<a name="open3d"><a href="../../rgl/help/open3d">`open3d`</a></a>               | open a new window
<a name="rgl.close"><a href="../../rgl/help/rgl.close">`rgl.close`</a></a>            | close the current window
<a name="rgl.bringtotop"><a href="../../rgl/help/rgl.bringtotop">`rgl.bringtotop`</a></a>       | bring the current window to the top
<a name="rgl.cur"><a href="../../rgl/help/rgl.cur">`rgl.cur`</a></a>              | id of the active device
<a name="rgl.dev.list"><a href="../../rgl/help/rgl.dev.list">`rgl.dev.list`</a></a>         | ids of all active devices
<a name="rgl.set"><a href="../../rgl/help/rgl.set">`rgl.set`</a></a>              | set a particular device to be active
<a name="rgl.ids"><a href="../../rgl/help/rgl.ids">`rgl.ids`</a></a>              | ids and types of all current objects
<a name="rgl.attrib"><a href="../../rgl/help/rgl.attrib">`rgl.attrib`</a></a>, <a name="rgl.attrib.count"><a href="../../rgl/help/rgl.attrib.count">`rgl.attrib.count`</a></a>: | attributes of objects in the scene
<a name="pop3d"><a href="../../rgl/help/pop3d">`pop3d`</a></a>, <a name="rgl.pop"><a href="../../rgl/help/rgl.pop">`rgl.pop`</a></a>     | delete an object from the scene
<a name="clear3d"><a href="../../rgl/help/clear3d">`clear3d`</a></a>, <a name="rgl.clear"><a href="../../rgl/help/rgl.clear">`rgl.clear`</a></a>            | delete all objects of certain classes
<a name="rgl.projection"><a href="../../rgl/help/rgl.projection">`rgl.projection`</a></a>        | return information about the current projection
<a name="rgl.user2window"><a href="../../rgl/help/rgl.user2window">`rgl.user2window`</a></a>, <a name="rgl.window2user"><a href="../../rgl/help/rgl.window2user">`rgl.window2user`</a></a> | convert between coordinates in the current projection

In addition to these, there are some other related functions which
should rarely be called by users: <a name="rgl.init"><a href="../../rgl/help/rgl.init">`rgl.init`</a></a>, <a name="rgl.open"><a href="../../rgl/help/rgl.open">`rgl.open`</a></a>, <a name="rgl.quit"><a href="../../rgl/help/rgl.quit">`rgl.quit`</a></a>.  


### Working with 3-D vectors

Most `rgl` functions work internally with "homogeneous" coordinates.
In this system, 3-D points are represented with 4 coordinates, generally
called (x, y, z, w).  The corresponding Euclidean point is
(x/w, y/w, z/w), if w is nonzero; zero values of w correspond to 
"points at infinity".  The advantage of this system is that
affine transformations including translations and perspective shifts
become linear transformations, with multiplication by a 4 by 4 matrix.

`rgl` has the following functions to work with homogeneous coordinates:

------------------------------------ | -----------
<a name="asEuclidean"><a href="../../rgl/help/asEuclidean">`asEuclidean`</a></a>, <a name="asHomogeneous"><a href="../../rgl/help/asHomogeneous">`asHomogeneous`</a></a>: | convert between homogeneous and Euclidean coordinates
<a name="rotate3d"><a href="../../rgl/help/rotate3d">`rotate3d`</a></a>, <a name="scale3d"><a href="../../rgl/help/scale3d">`scale3d`</a></a>, <a name="translate3d"><a href="../../rgl/help/translate3d">`translate3d`</a></a>:  | apply a transformation
<a name="transform3d"><a href="../../rgl/help/transform3d">`transform3d`</a></a>:  | apply a general transformation
<a name="rotationMatrix"><a href="../../rgl/help/rotationMatrix">`rotationMatrix`</a></a>, <a name="scaleMatrix"><a href="../../rgl/help/scaleMatrix">`scaleMatrix`</a></a>, <a name="translationMatrix"><a href="../../rgl/help/translationMatrix">`translationMatrix`</a></a>:  | compute the transformation matrix
<a name="identityMatrix"><a href="../../rgl/help/identityMatrix">`identityMatrix`</a></a> | return a 4 x 4 identity matrix

There is also a function <a name="GramSchmidt"><a href="../../rgl/help/GramSchmidt">`GramSchmidt`</a></a>, mainly for internal
use:  it does a Gram-Schmidt orthogonalization of a 3x3 matrix,
with some specializations for its use in <a href="#cylinder3d">`cylinder3d`</a>.

## Warning:  Work in Progress!

This vignette is in a preliminary form.  Many aspects of the rgl
package are not described, or do not have examples.  There may
even be functions that are missed completely, if the following
list is not empty:

```
## [1] "matrixSetter" "setupKnitr"   "vertexSetter"
```

## Index of Functions

The following functions and constants are described in this document:<br>


<div class="nostripes">


---------------------------------------------------------------  ---------------------------------------------------------------  -----------------------------------------------------------------------  -----------------------------------------------------------------------  ---------------------------------------------------------------
<a href="#abclines3d">abclines3d</a>&nbsp;&nbsp;                 <a href="#hook_webgl">hook_webgl</a>&nbsp;&nbsp;                 <a href="#qmesh3d">qmesh3d</a>&nbsp;&nbsp;                               <a href="#rgl.quads">rgl.quads</a>&nbsp;&nbsp;                           <a href="#spin3d">spin3d</a>&nbsp;&nbsp;                       
<a href="#addNormals">addNormals</a>&nbsp;&nbsp;                 <a href="#icosahedron3d">icosahedron3d</a>&nbsp;&nbsp;           <a href="#quads3d">quads3d</a>&nbsp;&nbsp;                               <a href="#rgl.quit">rgl.quit</a>&nbsp;&nbsp;                             <a href="#sprites3d">sprites3d</a>&nbsp;&nbsp;                 
<a href="#addToSubscene3d">addToSubscene3d</a>&nbsp;&nbsp;       <a href="#identify3d">identify3d</a>&nbsp;&nbsp;                 <a href="#r3dDefaults">r3dDefaults</a>&nbsp;&nbsp;                       <a href="#rgl.select">rgl.select</a>&nbsp;&nbsp;                         <a href="#subdivision3d">subdivision3d</a>&nbsp;&nbsp;         
<a href="#ageSetter">ageSetter</a>&nbsp;&nbsp;                   <a href="#identityMatrix">identityMatrix</a>&nbsp;&nbsp;         <a href="#readOBJ">readOBJ</a>&nbsp;&nbsp;                               <a href="#rgl.select3d">rgl.select3d</a>&nbsp;&nbsp;                     <a href="#subsceneInfo">subsceneInfo</a>&nbsp;&nbsp;           
<a href="#asEuclidean">asEuclidean</a>&nbsp;&nbsp;               <a href="#layout3d">layout3d</a>&nbsp;&nbsp;                     <a href="#readSTL">readSTL</a>&nbsp;&nbsp;                               <a href="#rgl.set">rgl.set</a>&nbsp;&nbsp;                               <a href="#subsceneList">subsceneList</a>&nbsp;&nbsp;           
<a href="#asHomogeneous">asHomogeneous</a>&nbsp;&nbsp;           <a href="#legend3d">legend3d</a>&nbsp;&nbsp;                     <a href="#rgl.abclines">rgl.abclines</a>&nbsp;&nbsp;                     <a href="#rgl.setMouseCallbacks">rgl.setMouseCallbacks</a>&nbsp;&nbsp;   <a href="#subsetSetter">subsetSetter</a>&nbsp;&nbsp;           
<a href="#aspect3d">aspect3d</a>&nbsp;&nbsp;                     <a href="#light3d">light3d</a>&nbsp;&nbsp;                       <a href="#rgl.attrib">rgl.attrib</a>&nbsp;&nbsp;                         <a href="#rgl.setWheelCallback">rgl.setWheelCallback</a>&nbsp;&nbsp;     <a href="#subsetSlider">subsetSlider</a>&nbsp;&nbsp;           
<a href="#axes3d">axes3d</a>&nbsp;&nbsp;                         <a href="#lines3d">lines3d</a>&nbsp;&nbsp;                       <a href="#rgl.attrib.count">rgl.attrib.count</a>&nbsp;&nbsp;             <a href="#rgl.snapshot">rgl.snapshot</a>&nbsp;&nbsp;                     <a href="#surface3d">surface3d</a>&nbsp;&nbsp;                 
<a href="#axis3d">axis3d</a>&nbsp;&nbsp;                         <a href="#material3d">material3d</a>&nbsp;&nbsp;                 <a href="#rgl.bbox">rgl.bbox</a>&nbsp;&nbsp;                             <a href="#rgl.spheres">rgl.spheres</a>&nbsp;&nbsp;                       <a href="#Sweave.snapshot">Sweave.snapshot</a>&nbsp;&nbsp;     
<a href="#bbox3d">bbox3d</a>&nbsp;&nbsp;                         <a href="#mfrow3d">mfrow3d</a>&nbsp;&nbsp;                       <a href="#rgl.bg">rgl.bg</a>&nbsp;&nbsp;                                 <a href="#rgl.sprites">rgl.sprites</a>&nbsp;&nbsp;                       <a href="#terrain3d">terrain3d</a>&nbsp;&nbsp;                 
<a href="#bg3d">bg3d</a>&nbsp;&nbsp;                             <a href="#mouseMode">mouseMode</a>&nbsp;&nbsp;                   <a href="#rgl.bringtotop">rgl.bringtotop</a>&nbsp;&nbsp;                 <a href="#rgl.surface">rgl.surface</a>&nbsp;&nbsp;                       <a href="#tetrahedron3d">tetrahedron3d</a>&nbsp;&nbsp;         
<a href="#bgplot3d">bgplot3d</a>&nbsp;&nbsp;                     <a href="#movie3d">movie3d</a>&nbsp;&nbsp;                       <a href="#rgl.clear">rgl.clear</a>&nbsp;&nbsp;                           <a href="#rgl.Sweave">rgl.Sweave</a>&nbsp;&nbsp;                         <a href="#text3d">text3d</a>&nbsp;&nbsp;                       
<a href="#box3d">box3d</a>&nbsp;&nbsp;                           <a href="#mtext3d">mtext3d</a>&nbsp;&nbsp;                       <a href="#rgl.clipplanes">rgl.clipplanes</a>&nbsp;&nbsp;                 <a href="#rgl.Sweave.off">rgl.Sweave.off</a>&nbsp;&nbsp;                 <a href="#texts3d">texts3d</a>&nbsp;&nbsp;                     
<a href="#clear3d">clear3d</a>&nbsp;&nbsp;                       <a href="#newSubscene3d">newSubscene3d</a>&nbsp;&nbsp;           <a href="#rgl.close">rgl.close</a>&nbsp;&nbsp;                           <a href="#rgl.texts">rgl.texts</a>&nbsp;&nbsp;                           <a href="#title3d">title3d</a>&nbsp;&nbsp;                     
<a href="#clearSubsceneList">clearSubsceneList</a>&nbsp;&nbsp;   <a href="#next3d">next3d</a>&nbsp;&nbsp;                         <a href="#rgl.cur">rgl.cur</a>&nbsp;&nbsp;                               <a href="#rgl.triangles">rgl.triangles</a>&nbsp;&nbsp;                   <a href="#tmesh3d">tmesh3d</a>&nbsp;&nbsp;                     
<a href="#clipplanes3d">clipplanes3d</a>&nbsp;&nbsp;             <a href="#observer3d">observer3d</a>&nbsp;&nbsp;                 <a href="#rgl.dev.list">rgl.dev.list</a>&nbsp;&nbsp;                     <a href="#rgl.useNULL">rgl.useNULL</a>&nbsp;&nbsp;                       <a href="#toggleButton">toggleButton</a>&nbsp;&nbsp;           
<a href="#clipplaneSlider">clipplaneSlider</a>&nbsp;&nbsp;       <a href="#octahedron3d">octahedron3d</a>&nbsp;&nbsp;             <a href="#rgl.getMouseCallbacks">rgl.getMouseCallbacks</a>&nbsp;&nbsp;   <a href="#rgl.user2window">rgl.user2window</a>&nbsp;&nbsp;               <a href="#transform3d">transform3d</a>&nbsp;&nbsp;             
<a href="#cube3d">cube3d</a>&nbsp;&nbsp;                         <a href="#oh3d">oh3d</a>&nbsp;&nbsp;                             <a href="#rgl.getWheelCallback">rgl.getWheelCallback</a>&nbsp;&nbsp;     <a href="#rgl.viewpoint">rgl.viewpoint</a>&nbsp;&nbsp;                   <a href="#translate3d">translate3d</a>&nbsp;&nbsp;             
<a href="#cuboctahedron3d">cuboctahedron3d</a>&nbsp;&nbsp;       <a href="#open3d">open3d</a>&nbsp;&nbsp;                         <a href="#rgl.ids">rgl.ids</a>&nbsp;&nbsp;                               <a href="#rgl.window2user">rgl.window2user</a>&nbsp;&nbsp;               <a href="#translationMatrix">translationMatrix</a>&nbsp;&nbsp; 
<a href="#currentSubscene3d">currentSubscene3d</a>&nbsp;&nbsp;   <a href="#par3d">par3d</a>&nbsp;&nbsp;                           <a href="#rgl.init">rgl.init</a>&nbsp;&nbsp;                             <a href="#rglFonts">rglFonts</a>&nbsp;&nbsp;                             <a href="#triangles3d">triangles3d</a>&nbsp;&nbsp;             
<a href="#cylinder3d">cylinder3d</a>&nbsp;&nbsp;                 <a href="#par3dinterp">par3dinterp</a>&nbsp;&nbsp;               <a href="#rgl.light">rgl.light</a>&nbsp;&nbsp;                           <a href="#rotate3d">rotate3d</a>&nbsp;&nbsp;                             <a href="#triangulate">triangulate</a>&nbsp;&nbsp;             
<a href="#decorate3d">decorate3d</a>&nbsp;&nbsp;                 <a href="#par3dinterpSetter">par3dinterpSetter</a>&nbsp;&nbsp;   <a href="#rgl.lines">rgl.lines</a>&nbsp;&nbsp;                           <a href="#rotationMatrix">rotationMatrix</a>&nbsp;&nbsp;                 <a href="#turn3d">turn3d</a>&nbsp;&nbsp;                       
<a href="#delFromSubscene3d">delFromSubscene3d</a>&nbsp;&nbsp;   <a href="#particles3d">particles3d</a>&nbsp;&nbsp;               <a href="#rgl.linestrips">rgl.linestrips</a>&nbsp;&nbsp;                 <a href="#scale3d">scale3d</a>&nbsp;&nbsp;                               <a href="#useSubscene3d">useSubscene3d</a>&nbsp;&nbsp;         
<a href="#dodecahedron3d">dodecahedron3d</a>&nbsp;&nbsp;         <a href="#persp3d">persp3d</a>&nbsp;&nbsp;                       <a href="#rgl.material">rgl.material</a>&nbsp;&nbsp;                     <a href="#scaleMatrix">scaleMatrix</a>&nbsp;&nbsp;                       <a href="#view3d">view3d</a>&nbsp;&nbsp;                       
<a href="#dot3d">dot3d</a>&nbsp;&nbsp;                           <a href="#planes3d">planes3d</a>&nbsp;&nbsp;                     <a href="#rgl.open">rgl.open</a>&nbsp;&nbsp;                             <a href="#scene3d">scene3d</a>&nbsp;&nbsp;                               <a href="#wire3d">wire3d</a>&nbsp;&nbsp;                       
<a href="#ellipse3d">ellipse3d</a>&nbsp;&nbsp;                   <a href="#play3d">play3d</a>&nbsp;&nbsp;                         <a href="#rgl.pixels">rgl.pixels</a>&nbsp;&nbsp;                         <a href="#segments3d">segments3d</a>&nbsp;&nbsp;                         <a href="#writeOBJ">writeOBJ</a>&nbsp;&nbsp;                   
<a href="#extrude3d">extrude3d</a>&nbsp;&nbsp;                   <a href="#plot3d">plot3d</a>&nbsp;&nbsp;                         <a href="#rgl.planes">rgl.planes</a>&nbsp;&nbsp;                         <a href="#select3d">select3d</a>&nbsp;&nbsp;                             <a href="#writePLY">writePLY</a>&nbsp;&nbsp;                   
<a href="#gc3d">gc3d</a>&nbsp;&nbsp;                             <a href="#points3d">points3d</a>&nbsp;&nbsp;                     <a href="#rgl.points">rgl.points</a>&nbsp;&nbsp;                         <a href="#selectpoints3d">selectpoints3d</a>&nbsp;&nbsp;                 <a href="#writeSTL">writeSTL</a>&nbsp;&nbsp;                   
<a href="#getr3dDefaults">getr3dDefaults</a>&nbsp;&nbsp;         <a href="#polygon3d">polygon3d</a>&nbsp;&nbsp;                   <a href="#rgl.pop">rgl.pop</a>&nbsp;&nbsp;                               <a href="#shade3d">shade3d</a>&nbsp;&nbsp;                               <a href="#writeWebGL">writeWebGL</a>&nbsp;&nbsp;               
<a href="#GramSchmidt">GramSchmidt</a>&nbsp;&nbsp;               <a href="#pop3d">pop3d</a>&nbsp;&nbsp;                           <a href="#rgl.postscript">rgl.postscript</a>&nbsp;&nbsp;                 <a href="#shapelist3d">shapelist3d</a>&nbsp;&nbsp;                                                                                      
<a href="#grid3d">grid3d</a>&nbsp;&nbsp;                         <a href="#propertySetter">propertySetter</a>&nbsp;&nbsp;         <a href="#rgl.primitive">rgl.primitive</a>&nbsp;&nbsp;                   <a href="#snapshot3d">snapshot3d</a>&nbsp;&nbsp;                                                                                        
<a href="#hook_rgl">hook_rgl</a>&nbsp;&nbsp;                     <a href="#propertySlider">propertySlider</a>&nbsp;&nbsp;         <a href="#rgl.projection">rgl.projection</a>&nbsp;&nbsp;                 <a href="#spheres3d">spheres3d</a>&nbsp;&nbsp;                                                                                          
---------------------------------------------------------------  ---------------------------------------------------------------  -----------------------------------------------------------------------  -----------------------------------------------------------------------  ---------------------------------------------------------------
</div>



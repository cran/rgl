% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/buffer.R
\name{Buffer}
\alias{Buffer}
\title{R6 Class for binary buffers in glTF files.}
\description{
These files typically have one buffer holding all the
binary data for a scene.
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-Buffer-new}{\code{Buffer$new()}}
\item \href{#method-Buffer-load}{\code{Buffer$load()}}
\item \href{#method-Buffer-saveOpenBuffer}{\code{Buffer$saveOpenBuffer()}}
\item \href{#method-Buffer-getBuffer}{\code{Buffer$getBuffer()}}
\item \href{#method-Buffer-setBuffer}{\code{Buffer$setBuffer()}}
\item \href{#method-Buffer-openBuffer}{\code{Buffer$openBuffer()}}
\item \href{#method-Buffer-writeBuffer}{\code{Buffer$writeBuffer()}}
\item \href{#method-Buffer-closeBuffer}{\code{Buffer$closeBuffer()}}
\item \href{#method-Buffer-closeBuffers}{\code{Buffer$closeBuffers()}}
\item \href{#method-Buffer-getBufferview}{\code{Buffer$getBufferview()}}
\item \href{#method-Buffer-addBufferView}{\code{Buffer$addBufferView()}}
\item \href{#method-Buffer-openBufferview}{\code{Buffer$openBufferview()}}
\item \href{#method-Buffer-setBufferview}{\code{Buffer$setBufferview()}}
\item \href{#method-Buffer-getAccessor}{\code{Buffer$getAccessor()}}
\item \href{#method-Buffer-setAccessor}{\code{Buffer$setAccessor()}}
\item \href{#method-Buffer-readAccessor}{\code{Buffer$readAccessor()}}
\item \href{#method-Buffer-readAccessor0}{\code{Buffer$readAccessor0()}}
\item \href{#method-Buffer-addAccessor}{\code{Buffer$addAccessor()}}
\item \href{#method-Buffer-dataURI}{\code{Buffer$dataURI()}}
\item \href{#method-Buffer-as.list}{\code{Buffer$as.list()}}
\item \href{#method-Buffer-clone}{\code{Buffer$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-new"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$new(json = NULL, binfile = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{json}}{list read from glTF file.}

\item{\code{binfile}}{optional External binary filename, or raw vector}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-load"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-load}{}}}
\subsection{Method \code{load()}}{
Load from file.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$load(uri, buf = 0)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{uri}}{Which file to load.}

\item{\code{buf}}{Which buffer number to load.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-saveOpenBuffer"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-saveOpenBuffer}{}}}
\subsection{Method \code{saveOpenBuffer()}}{
Write open buffer to connection.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$saveOpenBuffer(con, buf = 0)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{con}}{Output connection.}

\item{\code{buf}}{Buffer number.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-getBuffer"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-getBuffer}{}}}
\subsection{Method \code{getBuffer()}}{
Get buffer object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$getBuffer(buf, default = list(byteLength = 0))}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{buf}}{Buffer number.}

\item{\code{default}}{Default buffer object if \code{buf} not found.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A list containing components described here:
\url{https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#reference-buffer}.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-setBuffer"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-setBuffer}{}}}
\subsection{Method \code{setBuffer()}}{
Set buffer object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$setBuffer(buf, buffer)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{buf}}{Buffer number.}

\item{\code{buffer}}{New value to insert.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-openBuffer"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-openBuffer}{}}}
\subsection{Method \code{openBuffer()}}{
Open a connection for the data in a buffer.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$openBuffer(buf)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{buf}}{Buffer number.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
An open binary connection.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-writeBuffer"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-writeBuffer}{}}}
\subsection{Method \code{writeBuffer()}}{
Write data to buffer.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$writeBuffer(values, type, size, buf = 0)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{values}}{Values to write.}

\item{\code{type}}{Type to write.}

\item{\code{size}}{Byte size of each value.}

\item{\code{buf}}{Which buffer to write to.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Byte offset of start of bytes written.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-closeBuffer"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-closeBuffer}{}}}
\subsection{Method \code{closeBuffer()}}{
Close the connection in a buffer.

If there was a connection open, this will save the
contents in the raw vector \code{bytes} within the buffer object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$closeBuffer(buf)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{buf}}{The buffer number.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-closeBuffers"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-closeBuffers}{}}}
\subsection{Method \code{closeBuffers()}}{
Close any open buffers.

Call this after working with a GLTF file to avoid warnings
from R about closing unused connections.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$closeBuffers()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-getBufferview"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-getBufferview}{}}}
\subsection{Method \code{getBufferview()}}{
Get \code{bufferView} object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$getBufferview(bufv)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bufv}}{\code{bufferView} number.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A list containing components described here:
\url{https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#reference-bufferview}.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-addBufferView"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-addBufferView}{}}}
\subsection{Method \code{addBufferView()}}{
Add a new buffer view.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$addBufferView(values, type, size, target = NULL, buf = 0)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{values}}{Values to put in the view.}

\item{\code{type}}{Type of values.}

\item{\code{size}}{Size of values in bytes.}

\item{\code{target}}{Optional target use for values.}

\item{\code{buf}}{Which buffer to write to.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
New \code{bufferView} number.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-openBufferview"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-openBufferview}{}}}
\subsection{Method \code{openBufferview()}}{
Open a connection to a buffer view.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$openBufferview(bufv)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bufv}}{Which \code{bufferView}.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A connection.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-setBufferview"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-setBufferview}{}}}
\subsection{Method \code{setBufferview()}}{
Set \code{bufferView} object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$setBufferview(bufv, bufferView)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bufv}}{\code{bufferView} number.}

\item{\code{bufferView}}{New value to insert.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-getAccessor"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-getAccessor}{}}}
\subsection{Method \code{getAccessor()}}{
Get accessor object
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$getAccessor(acc)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{acc}}{Accessor number}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A list containing components described here:
\url{https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#reference-accessor}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-setAccessor"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-setAccessor}{}}}
\subsection{Method \code{setAccessor()}}{
Set accessor object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$setAccessor(acc, accessor)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{acc}}{Accessor number.}

\item{\code{accessor}}{New value to insert.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-readAccessor"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-readAccessor}{}}}
\subsection{Method \code{readAccessor()}}{
Read data given by accessor number.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$readAccessor(acc)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{acc}}{Accessor number.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A vector or array as specified in the accessor.  For the \code{MATn} types, the 3rd index
indexes the element.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-readAccessor0"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-readAccessor0}{}}}
\subsection{Method \code{readAccessor0()}}{
Read data given by accessor object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$readAccessor0(accessor)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{accessor}}{Accessor object}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A vector or array as specified in the accessor.  For the \code{MATn} types, the 3rd index
indexes the element.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-addAccessor"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-addAccessor}{}}}
\subsection{Method \code{addAccessor()}}{
Write values to accessor, not including \code{min} and \code{max}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$addAccessor(
  values,
  target = NULL,
  types = "anyGLTF",
  normalized = FALSE
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{values}}{Values to write.}

\item{\code{target}}{Optional target use for values.}

\item{\code{types}}{Which types can be used?}

\item{\code{normalized}}{Are normalized integers allowed?}

\item{\code{useDouble}}{Whether to write doubles or singles.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
New accessor number
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-dataURI"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-dataURI}{}}}
\subsection{Method \code{dataURI()}}{
Convert buffer to data URI.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$dataURI(buf = 0)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{buf}}{Buffer to convert.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
String containing data URI.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-as.list"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-as.list}{}}}
\subsection{Method \code{as.list()}}{
Convert to list.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$as.list()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
List suitable for writing using JSON.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Buffer-clone"></a>}}
\if{latex}{\out{\hypertarget{method-Buffer-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Buffer$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}

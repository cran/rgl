---
title: "User Interaction in WebGL"
author: "Duncan Murdoch"
date: "March 16, 2015"
output:
  rmarkdown::html_vignette:
    toc: yes
    fig_width: 5
    fig_height: 5
vignette: >
  %\VignetteIndexEntry{User Interaction in WebGL} 
  %\VignetteEngine{knitr::rmarkdown}
---


<style>
.nostripes tr.even {background-color: white;}
table {border-style: none;}
table th {border-style: none;}
table td {border-style: none;}
a[href^=".."] {text-decoration: underline;}
</style>

## Introduction

This document describes how to use embedded Javascript to 
control a WebGL display in an HTML document.  For more 
general information, see [rgl Overview](rgl.html).

We start with two simple examples.  The next section gives 
reference information.

Consider the simple plot of the iris data.  We
insert a code chunk with label `plot3d` (which will be used below).


















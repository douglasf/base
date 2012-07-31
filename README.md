Base
====

Light weight framework for static web content.

Installation
============
Coming soon...

Usage
=====

Tools
-----
Run `./base` to start listening for changes on files in your structure. These files include haml, less and coffee from scratch, but it's very easy to add more.
Add "-s" (`./base -s`) to start a development server as well. Optionally add "-p portnumber" as well for a different port then the default 4567.

Layout
------
A light weight less file with mixins for rapid development of web site structures is included. Add `@import "css/base.less"` on top of your own less file to use it.
It is based on a 960px wide structure with 12 columns. Columns are contained in an element with class ".container" and are specified by adding the mixin `.cols(x)` in the less.

Example:

    .container
      #left
      #right

with less styles like:

    #left {
      .cols(6);
    }

    #right {
      .cols(6);
    }

will produce a two equal sized column site.

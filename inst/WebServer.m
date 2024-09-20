## Copyright (C) 2024 Andreas Bertsatos <abertsatos@biol.uoa.gr>
##
## This file is part of the chartjs package for GNU Octave.
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

classdef WebServer
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} WebServer ()
##
## Interface to a web server instance
##
## This class provides methods to initialize a web server and update the
## HTML content that is served by it.
##
## @seealso{BarChart, BubbleChart, DoughnutChart, LineChart, PieChart,
## PolarAreaChart, RadarChart, ScatterChart, WebServer}
## @end deftypefn

  properties (SetAccess = protected)

    html;
    addr;
    port;

  endproperties

  methods (Access = public)

    ## -*- texinfo -*-
    ## @deftypefn  {chartjs} {} serve (@var{obj})
    ## @deftypefn  {chartjs} {} serve (@var{obj}, @var{html})
    ##
    ## Serve HTML content.
    ##
    ## @code{serve (@var{obj}, @var{html})} serves the string @var{html}
    ## to a web server.
    ##
    ## If the web server has not started yet, it is initialized automatically
    ## with default settings.  If the server should run with non-default
    ## settings, use the @code{initialize} method to initialize the server
    ## manually before calling the @code{serve} method for the first time.
    ##
    ## @seealso{WebServer}
    ## @end deftypefn

    function serve (this, ctx)

      ## Valid Chart objects
      valid_charts = {"BarChart", "BubbleChart", "DoughnutChart", ...
                      "LineChart", "PieChart", "PolarAreaChart", ...
                      "RadarChart", "ScatterChart"};

      ## Parse input argument
      if (isobject (ctx))
        ## Chart objects
        if (any (isa (ctx, valid_charts)))
          this.html = htmlstring (ctx);
        else
          error ("WebServer.serve: unsupported Chart object.");
        endif

      elseif (ischar (ctx))
        this.html = ctx;
      else
        error ("WebServer.serve: invalid web content.");
      endif

      webserver = WebInstance.instance ();

      webserver.serve (this.html);

    endfunction

    ## -*- texinfo -*-
    ## @deftypefn  {chartjs} {} initialize (@var{obj})
    ## @deftypefnx {chartjs} {} initialize (@var{obj}, @var{Name}, @var{Value}, @dots{})
    ##
    ## Initialize a WebServer instance.
    ##
    ## @code{initialize (@var{obj})} initializes a web server instance, which
    ## by default listens to the @qcode{localhost} on port @qcode{8080}.
    ##
    ## @code{initialize (@var{obj}, @var{Name}, @var{Value}, @dots{})}
    ## initializes a web server instance with the settings specified by one or
    ## more of the following @qcode{@var{Name}, @var{Value}} pair arguments.
    ##
    ## @multitable @columnfractions 0.18 0.02 0.80
    ## @headitem @var{Name} @tab @tab @var{Value}
    ##
    ## @item @qcode{port} @tab @tab A numeric integer value specifying the
    ## listening port of the web server instance.  The default value is 8080.
    ##
    ## @item @qcode{bind-address} @tab @tab A character vector specifying the
    ## bind-address of the web server instance.  The default value is
    ## @qcode{"127.0.0.1"}.
    ##
    ## @seealso{WebServer}
    ## @end deftypefn

    function initialize (this, varargin)

      webserver = WebInstance.instance (varargin{:});

      this.html = webserver.html;
      this.addr = webserver.addr;
      this.port = webserver.port;

    endfunction

  endmethods

endclassdef

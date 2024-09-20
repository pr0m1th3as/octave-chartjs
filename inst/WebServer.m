## Copyright (C) 2024 Andreas Bertsatos <abertsatos@biol.uoa.gr>
##
## This file is part of the statistics package for GNU Octave.
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

classdef WebServer < handle
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} html ()
##
## A GNU Octave WebServer instance.
##
## This class initializes a web server and returns its instance in a
## @qcode{WebServer} object.  The web instance, once initiated by the class
## constructor, it remains persistent during the Octave session and it is
## gracefully terminated upon exit by the class destructor.  The web instance is
## still valid and active even if the variable holding the instance in Octave's
## workspace is deleted.  Both class constructor (i.e. @qcode{WebServer ()}) and
## destructor (i.e. @qcode{delete (obj)}) functions are private and cannot be
## run directly.  Use the static method @qcode{WebServer.start ()} to initiate a
## web server instance or reacquire its handle in case the variable has been
## accidentally cleared from the workspace.  Use the @qcode{update ()} public
## method to update the contents being served by the web server instance.
##
## The @qcode{WebServer} class utilizes the @qcode{__webserve__} dynamically
## linked library, which relies relies on the CrowCpp microframework. Do NOT use
## the @qcode{__webserve__} function directly!
##
## @seealso{Html, WebServer}
## @end deftypefn

  properties (SetAccess = protected)

    html = "This is a GNU Octave WebServer instance!";
    addr = "127.0.0.1";
    port = 8080;

  endproperties

  methods (Access = private)

    ## Constructor
    function this = WebServer (varargin)

      ## Handle the optional pair arguments
      if (mod (numel (varargin), 2) != 0)
        error ("WebServer: optional arguments must be in Name,Value pairs.");
      endif
      while (numel (varargin) > 0)
        switch (lower (varargin{1}))
          case "bind-address"
            if (! ischar (varargin{2}))
              error ("WebServer: 'bindaddress' must be a character vector.");
            endif
            this.addr = varargin{2};

          case "port"
            port = varargin{2};
            if (! (isnumeric (port) && isscalar (port) &&
                   fix (port) == port && port > 0 && port <= 65535))
              error (strcat (["WebServer: 'port' must be a scalar"], ...
                             [" integer value assigning a valid port."]));
            endif
            this.port = port;

          otherwise
            error ("WebServer: unknown optional argument.");
        endswitch
        varargin([1:2]) = [];
      endwhile

      ## Initialize web server
      __webserve__ (this.html, this.port, this.addr);

    endfunction

  endmethods

  methods

    ## Destructor
    ## NEVER CALL DESTRUCTOR FOR AN OBJECT OF THIS CLASS MANUALLY !!!

    function delete (this)

      # stop Crow server before exit
      __webserve__ (0);

    endfunction

    ## -*- texinfo -*-
    ## @deftypefn  {chartjs} {} update (@var{obj}, @var{ctx})
    ##
    ## Update the WebServer's content.
    ##
    ## @code{update (@var{obj}, @var{ctx})} updates the content served by a
    ## WebServer instance, @var{obj}.  @var{ctx} can either be a @qcode{*Chart}
    ## object or a character vector containing any text/HTML string.
    ##
    ## @seealso{BarChart, BubbleChart, DoughnutChart, LineChart, PieChart,
    ## PolarAreaChart, RadarChart, ScatterChart, WebServer}
    ## @end deftypefn

    function update (this, ctx)

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
          error ("WebServer.update: unsupported Chart object.");
        endif

      elseif (ischar (ctx))
        this.html = ctx;
      else
        error ("WebServer.update: invalid web content.");
      endif

      ## Update content
      __webserve__ (this.html);

    endfunction

  endmethods

  methods (Static)

    ## -*- texinfo -*-
    ## @deftypefn  {chartjs} {@var{obj} =} WebServer.start ()
    ## @deftypefnx {chartjs} {@var{obj} =} WebServer.start (@var{Name}, @var{Value}, @dots{})
    ##
    ## Initialize a WebServer instance.
    ##
    ## @code{@var{obj} = WebServer.start ()} initializes a web server instance,
    ## which by default listens to the @qcode{localhost} on port @qcode{8080}
    ## and returns its handle to the @qcode{WebServer} object, @var{obj}.
    ##
    ## @code{@var{obj} = WebServer.start (@dots{}, @var{Name}, @var{Value})}
    ## initializes a WebServer instance with the settings specified by one or
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

    function this = start (varargin)

      persistent instance;
      mlock ();

      if (isempty (instance))
        instance = WebServer (varargin{:});
      endif

      this = instance;
    endfunction

  endmethods

endclassdef

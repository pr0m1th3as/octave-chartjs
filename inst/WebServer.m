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

  properties (SetAccess = protected)

    html = "This is a GNU Octave WebServer instance!";
    addr = "0.0.0.0";
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
          case "bindaddress"
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

    ## Destructor
    function delete (this)
      __webserve__ (0);
    endfunction

  endmethods

  methods

    ## Public method for updating the WebServer's content
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

    function this = webinstance (varargin)

      persistent instance;
      mlock ();

      if (isempty (instance))
        instance = WebServer (varargin{:});
      endif

      this = instance;
    endfunction

  endmethods

endclassdef

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

classdef BubbleChart

  properties (Access = public)

    labels             = [];
    datasets           = {};
    options            = {};
    chartID            = "bubbleChart";

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = BubbleChart (X, Y, R, varargin)

      ## Check data (X, Y, R)
      if (nargin < 3)
        error ("BubbleChart: too few input arguments.");
      endif
      if (! ismatrix (X) || ! isnumeric (X))
        error ("BubbleChart: X must be a numeric matrix.");
      endif
      if (isempty (X))
        error ("BubbleChart: X cannot be empty.");
      endif
      if (! ismatrix (Y) || ! isnumeric (Y))
        error ("BubbleChart: Y must be a numeric matrix.");
      endif
      if (isempty (Y))
        error ("BubbleChart: Y cannot be empty.");
      endif
      if (! ismatrix (R) || ! isnumeric (R))
        error ("BubbleChart: R must be a numeric matrix.");
      endif
      if (isempty (R))
        error ("BubbleChart: R cannot be empty.");
      endif
      [err, X, Y, R] = common_size (X, Y, R);
      if (err > 0)
        error ("BubbleChart: X, Y, and R must be of common size or scalars.");
      endif

      ## Force to column vectors (if applicable)
      if (isvector (X) && size (X, 2) > 1)
        X = X';
        Y = Y';
        R = R';
      endif

      ## Create datasets
      nsets = size (X, 2);
      for i = 1:nsets
        data = [X(:,i), Y(:,i), R(:,i)];
        this.datasets{i} = BubbleData (data);
      endfor

      ## Handle the optional pair arguments and change
      ## the properties in each dataset as necessary
      if (mod (numel (varargin), 2) != 0)
        error ("BubbleChart: optional arguments must be in Name,Value pairs.");
      endif
      while (numel (varargin) > 0)
        switch (lower (varargin{1}))
          case "backgroundcolor"
            val = varargin{2};
            pname = "backgroundColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "bordercolor"
            val = varargin{2};
            pname = "borderColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "borderwidth"
            val = varargin{2};
            pname = "borderWidth";
            this = parseValue (this, pname, val, [], "scalar");

          case "clip"
            val = varargin{2};
            pname = "clip";
            this = parseValue (this, pname, val, [], "scalar");

          case "drawactiveelementsontop"
            val = varargin{2};
            pname = "drawActiveElementsOnTop";
            this = parseValue (this, pname, val, [], "boolean");

          case "hoverbackgroundcolor"
            val = varargin{2};
            pname = "hoverBackgroundColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "hoverbordercolor"
            val = varargin{2};
            pname = "hoverBorderColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "hoverborderwidth"
            val = varargin{2};
            pname = "hoverBorderWidth";
            this = parseValue (this, pname, val, [], "scalar");

          case "hoverradius"
            val = varargin{2};
            pname = "hoverRadius";
            this = parseValue (this, pname, val, [], "scalar");

          case "hitradius"
            val = varargin{2};
            pname = "hitRadius";
            this = parseValue (this, pname, val, [], "scalar");

          case "label"
            val = varargin{2};
            pname = "label";
            this = parseValue (this, pname, val, val, "string");

          case "order"
            val = varargin{2};
            pname = "order";
            this = parseValue (this, pname, val, [], "scalar");

          case "pointstyle"
            val = varargin{2};
            this = parseStyle (this, val);

          case "rotation"
            val = varargin{2};
            pname = "rotation";
            this = parseValue (this, pname, val, [], "scalar");

          case "radius"
            val = varargin{2};
            pname = "radius";
            this = parseValue (this, pname, val, [], "scalar");

          case "chartid"
            val = varargin{2};
            if (! ischar (val))
              error ("BubbleChart: 'ChartID' must be a character vector.");
            endif
            this.chartID = val;

        endswitch
        varargin([1:2]) = [];
      endwhile

    endfunction

    ## Export to json string
    function json = jsonstring (this)

      ## Initialize json string
      json = "{\n  type: 'bubble',\n  data: {\n";

      ## Add datasets
      json = [json, "    datasets: ["];
      for i = 1:numel (this.datasets)
        dataset = jsonstring (this.datasets{i});
        json = [json, dataset, ","];
      endfor

      ## Close data
      json(end) = "]";
      json = [json, "\n  },\n"];

      ## Add options and close Chart configuration json string
      options = "  options: {}\n";
      json = [json, options, "}"];

    endfunction

    ## Export to html string
    function html = htmlstring (this)

      ## Initialize html string
      tmp1 = "<!DOCTYPE html>\n<html>\n";
      tmp2 = "  <script src=""https://cdn.jsdelivr.net/npm/chart.js"">";
      tmp3 = "  </script>\n  <body>\n    <div>\n";
      tmp4 = "    <canvas id=""%s"" style=""width:100%%;max-width:1000px"">";
      ## Add chart ID
      tmp4 = sprintf (tmp4, this.chartID);
      tmp5 = "</canvas>\n    </div>\n  </body>\n</html>\n";
      tmp6 = "<script>\n";
      tmp7 = sprintf ("new Chart('%s', ", this.chartID);
      ## Get Chart configuration json string
      json = jsonstring (this);
      ## Close html string
      tmp8 = ");\n</script>";
      html = [tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, json, tmp8];

    endfunction

    ## Save to html file
    function htmlsave (this, filename)

      ## Write html string to file
      fid = fopen (filename, "w");
      fprintf (fid, "%s", htmlstring (this));
      fclose (fid);

    endfunction

    ## Serve Chart online
    function webserve (this, port = 8080)

      ## Check for valid port number
      if (! (isnumeric (val) && isscalar (val) &&
             fix (val) == val && val > 0 && val <= 65535))
        error (strcat (["BubbleChart.webserve: 'port' must be a scalar"], ...
                       [" integer value assigning a valid port."]));
      endif

      ## Build html page and serve it on assigned port
      html = htmlstring (this);
      webserve (html, port);

    endfunction

    ## Close web service
    function webstop (this)
        webserve (0);
    endfunction

  endmethods

endclassdef

## Test input validation
%!error <BubbleChart: too few input arguments.> BubbleChart (1)
%!error <BubbleChart: too few input arguments.> BubbleChart (1, 2)
%!error <BubbleChart: X must be a numeric matrix.> BubbleChart ("1", 2, 3)
%!error <BubbleChart: X must be a numeric matrix.> BubbleChart ({1}, 2, 3)
%!error <BubbleChart: X cannot be empty.> BubbleChart ([], 2, 3)
%!error <BubbleChart: Y must be a numeric matrix.> BubbleChart (1, "2", 3)
%!error <BubbleChart: Y must be a numeric matrix.> BubbleChart (1, {2}, 3)
%!error <BubbleChart: Y cannot be empty.> BubbleChart (1, [], 3)
%!error <BubbleChart: R must be a numeric matrix.> BubbleChart (1, 2, "3")
%!error <BubbleChart: R must be a numeric matrix.> BubbleChart (1, 2, {3})
%!error <BubbleChart: R cannot be empty.> BubbleChart (1, 2, [])
%!error <BubbleChart: X, Y, and R must be of common size or scalars.> ...
%! BubbleChart (1, ones (2), [1, 2])
%!error <BubbleChart: optional arguments must be in Name,Value pairs.> ...
%! BubbleChart (1, 2, 3, "backgroundColor")

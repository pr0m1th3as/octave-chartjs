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

classdef PolarAreaChart < html

  properties (Access = public)

    chartID            = "polarAreaChart";
    datasets           = {};
    labels             = [];
    options            = {};

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = PolarAreaChart (data, labels, varargin)

      ## Check data and labels
      if (nargin < 2)
        error ("PolarAreaChart: too few input arguments.");
      endif
      if (! ismatrix (data) || ! isnumeric (data))
        error ("PolarAreaChart: DATA must be a numeric matrix.");
      endif
      if (isempty (data))
        error ("PolarAreaChart: DATA cannot be empty.");
      endif
      if (isempty (labels))
        error ("PolarAreaChart: LABELS cannot be empty.");
      endif
      if (! isvector (labels))
        error ("PolarAreaChart: LABELS must be a vector.");
      endif
      if (ischar (labels))
        labels = cellstr (labels);
      elseif (! isnumeric (labels) && ! iscellstr (labels))
        error (strcat (["PolarAreaChart: LABELS must be numeric,"], ...
                       [" cellstring, or character vector."]));
      endif

      ## Force row vectors to column vectors
      if (isvector (data) && numel (data) == numel (labels))
        data = data(:);
      endif
      labels = labels(:);

      ## Check for matching sample sizes
      if (numel (labels) != size (data, 1))
        error ("PolarAreaChart: LABELS do not match sample size in DATA.");
      endif

      ## Store labels
      this.labels = labels;

      ## Create datasets
      nsets = size (data, 2);
      for i = 1:nsets
        this.datasets{i} = PolarAreaData (data(:,i));
      endfor

      ## Handle the optional pair arguments and change
      ## the properties in each dataset as necessary
      if (mod (numel (varargin), 2) != 0)
        error ("PolarAreaChart: optional arguments must be in Name,Value pairs.");
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

          case "borderalign"
            val = varargin{2};
            pname = "borderAlign";
            validstr = {"center", "inner"};
            this = parseValue (this, pname, val, validstr, "string");

          case "bordercolor"
            val = varargin{2};
            pname = "borderColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "borderdash"
            val = varargin{2};
            pname = "borderDash";
            this = parseValue (this, pname, val, [], "vector");

          case "borderdashoffset"
            val = varargin{2};
            pname = "borderDashOffset";
            this = parseValue (this, pname, val, [], "scalar");

          case "borderjoinstyle"
            val = varargin{2};
            pname = "borderJoinStyle";
            validstr = {"bevel", "round", "miter"};
            this = parseValue (this, pname, val, validstr, "string");

          case "borderwidth"
            val = varargin{2};
            pname = "borderWidth";
            this = parseValue (this, pname, val, [], "scalar");

          case "circular"
            val = varargin{2};
            pname = "circular";
            this = parseValue (this, pname, val, [], "boolean");

          case "clip"
            val = varargin{2};
            pname = "clip";
            this = parseValue (this, pname, val, [], "scalar");

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

          case "hoverborderdash"
            val = varargin{2};
            pname = "hoverBorderDash";
            this = parseValue (this, pname, val, [], "vector");

          case "hoverborderdashoffset"
            val = varargin{2};
            pname = "hoverBorderDashOffset";
            this = parseValue (this, pname, val, [], "scalar");

          case "hoverborderjoinstyle"
            val = varargin{2};
            pname = "hoverBorderJoinStyle";
            validstr = {"bevel", "round", "miter"};
            this = parseValue (this, pname, val, validstr, "string");

          case "hoverborderwidth"
            val = varargin{2};
            pname = "hoverBorderWidth";
            this = parseValue (this, pname, val, [], "scalar");

        endswitch
        varargin([1:2]) = [];
      endwhile

    endfunction

    ## Export to json string
    function json = jsonstring (this)

      ## Initialize json string
      json = "{\n  type: 'polarArea',\n  data: {\n";

      ## Add labels
      if (isnumeric (this.labels))
        labels = sprintf ("%g, ", this.labels);
      else
        labels = sprintf ("'%s', ", this.labels{:});
      endif
      labels(end) = [];
      labels(end) = "]";
      json = [json, "    labels: [", labels, ",\n"];

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

  endmethods

endclassdef

## Test input validation
%!error <PolarAreaChart: too few input arguments.> PolarAreaChart (1)
%!error <PolarAreaChart: DATA must be a numeric matrix.> PolarAreaChart ({1}, "A")
%!error <PolarAreaChart: DATA must be a numeric matrix.> PolarAreaChart ("1", "A")
%!error <PolarAreaChart: DATA cannot be empty.> PolarAreaChart ([], "A")
%!error <PolarAreaChart: LABELS cannot be empty.> PolarAreaChart (1, [])
%!error <PolarAreaChart: LABELS must be a vector.> PolarAreaChart (ones (2), ones (2))
%!error <PolarAreaChart: LABELS must be numeric, cellstring, or character vector.> ...
%! PolarAreaChart (ones (2), {1, 2})
%!error <PolarAreaChart: LABELS do not match sample size in DATA.> ...
%! PolarAreaChart (ones (2), "A")
%!error <PolarAreaChart: optional arguments must be in Name,Value pairs.> ...
%! PolarAreaChart (1, "A", "backgroundColor")
%!error <PolarAreaChart.htmlsave: too few input arguments.> ...
%! htmlsave (PolarAreaChart (1, "A"))
%!error <PolarAreaChart.htmlsave: FILENAME must be a character vector.> ...
%! htmlsave (PolarAreaChart (1, "A"), 1)
%!error <PolarAreaChart.htmlsave: FILENAME must be a character vector.> ...
%! htmlsave (PolarAreaChart (1, "A"), {"polarArea.html"})

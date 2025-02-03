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

classdef PolarAreaChart < Html
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} PolarAreaChart (@var{data}, @var{labels})
## @deftypefnx {chartjs} {@var{obj} =} PolarAreaChart (@dots{}, @var{Name}, @var{Value})
##
## Create a @qcode{PolarAreaChart} object.
##
## @code{@var{obj} = PolarAreaChart (@var{data}, @var{labels})} returns a
## @qcode{PolarAreaChart} object, in which @var{data} contains the radius of
## each segment and @var{labels} contain the labels of each segment.  Each
## segment in a polar area chart has the same angle.
##
## @itemize
## @item
## @var{data} must be a nonempty @math{NxP} numeric matrix, where each column
## corresponds to a separate dataset and each row corresponds to an element in
## @var{labels}.  If @var{data} is a row vector and its length matches the
## number of elements in @var{labels}, then it is transposed to a column vector.
##
## @item
## @var{labels} must be a nonempty numerical vector or cellstring array, where
## each element corresponds to a row in @var{data}.  If @var{labels} is a
## character vector, then it is converted to a cellstring scalar.
## @end itemize
##
## @code{@var{obj} = PolarAreaChart (@dots{}, @var{Name}, @var{Value})} returns
## a @qcode{PolarAreaChart} object with the properties of each dataset specified
## by one or more @qcode{@var{Name}, @var{Value}} pair arguments.  @var{Name}
## can be any property name of a @qcode{PolarAreaData} object and @var{Value}
## must correspond to the data type(s) and values accepted by that property.
## Type @code{help PolarAreaData} for more details on the available properties.
##
## Specifically for the properties that accept a @qcode{Color} object as their
## input value, besides the @qcode{Color} object you may also parse to the
## @qcode{PolarAreaChart} constructor the same values accepted by the
## constructor of the @qcode{Color} object.  However, if you choose to manually
## modify the @qcode{PolarAreaChart}'s properties using the dot notation syntax,
## then you must assign a @qcode{Color} object to the chosen property.
## Type @code{help Color} for more details on the available syntax.
##
## For properties that accept scalar values, you can pass a vector of the same
## type with each element corresponding to a different dataset.  For properties
## that accept vectors, you can pass a matrix of the same type with each row
## corresponding to a different dataset.  Otherwise, the same property value
## will be assigned to all datasets available in @var{data}.  For properties
## accepting a character vector, you need to pass a cellstring array for
## multiple datasets, whereas for properties that can take mixed types of scalar
## values (i.e. either boolean and character vectors), you need to pass a cell
## array with each element corresponding to a different dataset.
##
## A @qcode{PolarAreaChart} object, @var{obj}, stores the following properties,
## which can be accessed/modified using dot notation syntax similarly to a
## @qcode{struct} object:
##
## @multitable @columnfractions 0.23 0.02 0.75
## @headitem @var{Field} @tab @tab @var{Description}
##
## @item @qcode{chartID} @tab @tab A character vector defining the name of the
## Chart in the generated html code.
##
## @item @qcode{datasets} @tab @tab A cell array containing one or more
## @qcode{PolarAreaData} objects corresponding to the @var{data} input.
##
## @item @qcode{labels} @tab @tab A numeric vector or a cellstring array with
## the data labels defined in @var{labels}.
##
## @item @qcode{options} @tab @tab A cell array containing one or more
## @qcode{Option} and @qcode{Plugin} objects.  Not used at the moment.
##
## @end multitable
##
## To directly serve the @qcode{PolarAreaChart} object on a local web server
## instance, you can use the object's @qcode{webserve ()} method.
## Alternatively, you can generate and/or save to a file the corresponding HTML
## code with the @qcode{htmlstring ()} and @qcode{htmlsave ()} methods and serve
## it online through a web server of your choice.
##
## @seealso{PolarAreaData, Color, Fill, Html, WebServer}
## @end deftypefn

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

## Copyright (C) 2024-2025 Andreas Bertsatos <abertsatos@biol.uoa.gr>
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

classdef LineChart < Html
  ## -*- texinfo -*-
  ## @deftp {chartjs} LineChart
  ##
  ## Line chart drawn by the Chart.js library.
  ##
  ## Each dataset of a @qcode{LineChart} is a @qcode{LineData} object in its
  ## @qcode{datasets} property.
  ##
  ## To view the @qcode{LineChart} object in your web browser, use its
  ## @qcode{webserve ()} method.  Alternatively, you can generate and/or save to
  ## a file the corresponding HTML code with the @qcode{htmlstring ()} and
  ## @qcode{htmlsave ()} methods and serve it online through a web server of
  ## your choice.
  ##
  ## Each property is documented on its own, as in @code{help LineChart.labels}.
  ##
  ## @seealso{LineData, Color, Fill, Html}
  ## @end deftp

  properties (Access = public)

    ## -*- texinfo -*-
    ## @deftp {LineChart} {property} chartID
    ##
    ## Name of the chart
    ##
    ## A character vector defining the name of the Chart in the generated html
    ## code.
    ##
    ## @end deftp
    chartID            = "lineChart";

    ## -*- texinfo -*-
    ## @deftp {LineChart} {property} datasets
    ##
    ## Datasets of the chart
    ##
    ## A cell array containing one or more @qcode{LineData} objects
    ## corresponding to the @var{data} input.
    ##
    ## @end deftp
    datasets           = {};

    ## -*- texinfo -*-
    ## @deftp {LineChart} {property} labels
    ##
    ## Data labels
    ##
    ## A numeric vector or a cellstring array with the data labels defined in
    ## @var{labels}.
    ##
    ## @end deftp
    labels             = [];

    ## -*- texinfo -*-
    ## @deftp {LineChart} {property} options
    ##
    ## Chart options
    ##
    ## A cell array containing one or more @qcode{Option} and @qcode{Plugin}
    ## objects.  Not used at the moment.
    ##
    ## @end deftp
    options            = {};

  endproperties

  methods (Access = public)

    ## -*- texinfo -*-
    ## @deftypefn  {LineChart} {@var{obj} =} LineChart (@var{data}, @var{labels})
    ## @deftypefnx {LineChart} {@var{obj} =} LineChart (@dots{}, @var{Name}, @var{Value})
    ##
    ## Create a @qcode{LineChart} object.
    ##
    ## @code{@var{obj} = LineChart (@var{data}, @var{labels})} returns a
    ## @qcode{LineChart} object, in which @var{data} contain the data point
    ## locations (by default along the @qcode{y-axis}) and @var{labels} contain
    ## the corresponding data point labels (by default along the
    ## @qcode{x-axis}).
    ##
    ## @itemize
    ## @item
    ## @var{data} must be a nonempty @math{NxP} numeric matrix, where each
    ## column corresponds to a separate dataset and each row corresponds to an
    ## element in @var{labels}.  If @var{data} is a row vector and its length
    ## matches the number of elements in @var{labels}, then it is transposed to
    ## a column vector.
    ##
    ## @item
    ## @var{labels} must be a nonempty numerical vector or cellstring array,
    ## where each element corresponds to a row in @var{data}.  If @var{labels}
    ## is a character vector, then it is converted to a cellstring scalar.
    ## @end itemize
    ##
    ## @code{@var{obj} = LineChart (@dots{}, @var{Name}, @var{Value})} returns a
    ## @qcode{LineChart} object with the properties of each dataset specified by
    ## one or more @qcode{@var{Name}, @var{Value}} pair arguments.  @var{Name}
    ## can be any property name of a @qcode{LineData} object and @var{Value}
    ## must correspond to the data type(s) and values accepted by that property.
    ## Type @code{help LineData} for more details on the available properties.
    ##
    ## Specifically for the properties that accept a @qcode{Color} object as
    ## their input value, besides the @qcode{Color} object you may also parse to
    ## the @qcode{LineChart} constructor the same values accepted by the
    ## constructor of the @qcode{Color} object.  However, if you choose to
    ## manually modify the @qcode{LineChart}'s properties using the dot notation
    ## syntax, then you must assign a @qcode{Color} object to the chosen
    ## property.  Type @code{help Color} for more details on the available
    ## syntax.
    ##
    ## For properties that accept scalar values, you can pass a vector of the
    ## same type with each element corresponding to a different dataset.  For
    ## properties that accept vectors, you can pass a matrix of the same type
    ## with each row corresponding to a different dataset.  Otherwise, the same
    ## property value will be assigned to all datasets available in @var{data}.
    ## For properties accepting a character vector, you need to pass a
    ## cellstring array for multiple datasets, whereas for properties that can
    ## take mixed types of scalar values (i.e. either boolean and character
    ## vectors), you need to pass a cell array with each element corresponding
    ## to a different dataset.
    ## @end deftypefn
    function this = LineChart (data, labels, varargin)

      ## Check data and labels
      if (nargin < 2)
        error ("LineChart: too few input arguments.");
      endif
      if (! ismatrix (data) || ! isnumeric (data))
        error ("LineChart: DATA must be a numeric matrix.");
      endif
      if (isempty (data))
        error ("LineChart: DATA cannot be empty.");
      endif
      if (isempty (labels))
        error ("LineChart: LABELS cannot be empty.");
      endif
      if (! isvector (labels))
        error ("LineChart: LABELS must be a vector.");
      endif
      if (ischar (labels))
        labels = cellstr (labels);
      elseif (! isnumeric (labels) && ! iscellstr (labels))
        error (strcat (["LineChart: LABELS must be numeric,"], ...
                       [" cellstring, or character vector."]));
      endif

      ## Force row vectors to column vectors
      if (isvector (data) && numel (data) == numel (labels))
        data = data(:);
      endif
      labels = labels(:);

      ## Check for matching sample sizes
      if (numel (labels) != size (data, 1))
        error ("LineChart: LABELS do not match sample size in DATA.");
      endif

      ## Store labels
      this.labels = labels;

      ## Create datasets
      nsets = size (data, 2);
      for i = 1:nsets
        this.datasets{i} = LineData (data(:,i));
      endfor

      ## Handle the optional pair arguments and change
      ## the properties in each dataset as necessary
      if (mod (numel (varargin), 2) != 0)
        error ("LineChart: optional arguments must be in Name,Value pairs.");
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

          case "bordercapstyle"
            val = varargin{2};
            pname = "borderCapStyle";
            validstr = {"butt", "round", "square"};
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

          case "clip"
            val = varargin{2};
            pname = "clip";
            this = parseValue (this, pname, val, [], "scalar");

          case "cubicinterpolationmode"
            val = varargin{2};
            pname = "cubicInterpolationMode";
            validstr = {"default", "monotone"};
            this = parseValue (this, pname, val, validstr, "string");

          case "drawactiveelementsontop"
            val = varargin{2};
            pname = "drawActiveElementsOnTop";
            this = parseValue (this, pname, val, [], "boolean");

          case "fill"
            val = varargin{2};
            pname = "fill";
            validstr = "Fill";
            this = parseValue (this, pname, val, validstr, "object");

          case "hoverbackgroundcolor"
            val = varargin{2};
            pname = "hoverBackgroundColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "hoverbordercapstyle"
            val = varargin{2};
            pname = "hoverBorderCapStyle";
            validstr = {"butt", "round", "square"};
            this = parseValue (this, pname, val, validstr, "string");

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

          case "indexaxis"
            val = varargin{2};
            pname = "indexAxis";
            validstr = {"x", "y"};
            this = parseValue (this, pname, val, validstr, "string");

          case "label"
            val = varargin{2};
            pname = "label";
            this = parseValue (this, pname, val, val, "string");

          case "order"
            val = varargin{2};
            pname = "order";
            this = parseValue (this, pname, val, [], "scalar");

          case "pointbackgroundcolor"
            val = varargin{2};
            pname = "pointBackgroundColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "pointbordercolor"
            val = varargin{2};
            pname = "pointBorderColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "pointborderwidth"
            val = varargin{2};
            pname = "pointBorderWidth";
            this = parseValue (this, pname, val, [], "scalar");

          case "pointhitradius"
            val = varargin{2};
            pname = "pointHitRadius";
            this = parseValue (this, pname, val, [], "scalar");

          case "pointhoverbackgroundcolor"
            val = varargin{2};
            pname = "pointHoverBackgroundColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "pointhoverbordercolor"
            val = varargin{2};
            pname = "pointHoverBorderColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "pointhoverborderwidth"
            val = varargin{2};
            pname = "pointHoverBorderWidth";
            this = parseValue (this, pname, val, [], "scalar");

          case "pointhoverradius"
            val = varargin{2};
            pname = "pointHoverRadius";
            this = parseValue (this, pname, val, [], "scalar");

          case "pointradius"
            val = varargin{2};
            pname = "pointRadius";
            this = parseValue (this, pname, val, [], "scalar");

          case "pointrotation"
            val = varargin{2};
            pname = "pointRotation";
            this = parseValue (this, pname, val, [], "scalar");

          case "pointstyle"
            val = varargin{2};
            this = parseStyle (this, val);

          case "showline"
            val = varargin{2};
            pname = "showLine";
            this = parseValue (this, pname, val, [], "boolean");

          case "spangaps"
            val = varargin{2};
            pname = "spanGaps";
            this = parseValue (this, pname, val, [], "boolnumber");

          case "stack"
            val = varargin{2};
            pname = "stack";
            this = parseValue (this, pname, val, val, "boolstring");

          case "stepped"
            val = varargin{2};
            pname = "stepped";
            validstr = {"before", "after", "middle"};
            this = parseValue (this, pname, val, validstr, "boolstring");

          case "tension"
            val = varargin{2};
            pname = "tension";
            this = parseValue (this, pname, val, [], "scalar");

        endswitch
        varargin([1:2]) = [];
      endwhile

    endfunction

  endmethods

  methods (Hidden)

    ## The chart as a structure
    function s = jsonvalue (this)

      s.type = "line";
      s.data.labels = this.labels;
      s.data.datasets = cell (1, numel (this.datasets));
      for i = 1:numel (this.datasets)
        s.data.datasets{i} = jsonvalue (this.datasets{i});
      endfor
      s.options = struct ();
      s = datasetlegend (s);

    endfunction

  endmethods

endclassdef

## Test output
%!test
%! json = ["{\"type\":\"line\",\"data\":{\"labels\":[\"a\",\"b\"],", ...
%!         "\"datasets\":[{\"data\":[1,2]}]},", ...
%!         "\"options\":{\"plugins\":{\"legend\":{\"display\":false}}}}"];
%! assert_equal (jsonstring (LineChart ([1; 2], {'a', 'b'})), json);
%!test
%! json = jsonstring (LineChart ([1; 2], {'a', 'b'}, "borderDash", 5));
%! assert_equal (! isempty (strfind (json, "\"borderDash\":[5]")), true);
%!test
%! json = jsonstring (LineChart ([1; 2], {'a', 'b'}, "borderDash", [5, 3]));
%! assert_equal (! isempty (strfind (json, "\"borderDash\":[5,3]")), true);
%!test
%! json = jsonstring (LineChart ([1; 2], {'a', 'b'}, "label", "it's"));
%! assert_equal (! isempty (strfind (json, "\"label\":\"it's\"")), true);
%!test
%! json = jsonstring (LineChart ([1; 2], {'a', 'b'}, "fill", Fill ("origin")));
%! assert_equal (! isempty (strfind (json, "\"fill\":\"origin\"")), true);

## Test input validation
%!error <LineChart: too few input arguments.> LineChart (1)
%!error <LineChart: DATA must be a numeric matrix.> LineChart ({1}, "A")
%!error <LineChart: DATA must be a numeric matrix.> LineChart ("1", "A")
%!error <LineChart: DATA cannot be empty.> LineChart ([], "A")
%!error <LineChart: LABELS cannot be empty.> LineChart (1, [])
%!error <LineChart: LABELS must be a vector.> LineChart (ones (2), ones (2))
%!error <LineChart: LABELS must be numeric, cellstring, or character vector.> ...
%! LineChart (ones (2), {1, 2})
%!error <LineChart: LABELS do not match sample size in DATA.> ...
%! LineChart (ones (2), "A")
%!error <LineChart: optional arguments must be in Name,Value pairs.> ...
%! LineChart (1, "A", "backgroundColor")
%!error <LineChart.htmlsave: too few input arguments.> ...
%! htmlsave (LineChart (1, "A"))
%!error <LineChart.htmlsave: FILENAME must be a character vector.> ...
%! htmlsave (LineChart (1, "A"), 1)
%!error <LineChart.htmlsave: FILENAME must be a character vector.> ...
%! htmlsave (LineChart (1, "A"), {"line.html"})

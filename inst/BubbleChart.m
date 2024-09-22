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

classdef BubbleChart < Html
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} BubbleChart (@var{X}, @var{Y}, @var{R})
## @deftypefnx {chartjs} {@var{obj} =} BubbleChart (@dots{}, @var{Name}, @var{Value})
##
## Create a @qcode{BubbleChart} object.
##
## @code{@var{obj} = BubbleChart (@var{X}, @var{Y}, @var{R})} returns a
## @qcode{BubbleChart} object, in which @var{X} and @var{Y} define the
## coordinates along the @qcode{x-axis} and @qcode{y-axis}, respecitvely, and
## @var{R} defines the radius for each element of the bubble chart.
##
## @itemize
## @item
## @var{X} must be a nonempty @math{NxP} numeric matrix, where each column
## corresponds to a separate dataset and each row corresponds to an element of
## the bubble chart defining its position along the @qcode{x-axis}.
##
## @item
## @var{Y} must be a nonempty @math{NxP} numeric matrix, where each column
## corresponds to a separate dataset and each row corresponds to an element of
## the bubble chart defining its position along the @qcode{y-axis}.
##
## @item
## @var{R} must be a nonempty @math{NxP} numeric matrix, where each column
## corresponds to a separate dataset and each row corresponds to an element of
## the bubble chart defining its radius.
## @end itemize
##
## @code{@var{obj} = BubbleChart (@dots{}, @var{Name}, @var{Value})} returns a
## @qcode{BubbleChart} object with the properties of each dataset specified by
## one or more @qcode{@var{Name}, @var{Value}} pair arguments.  @var{Name} can
## be any property name of a @qcode{BubbleData} object and @var{Value} must
## correspond to the data type(s) and values accepted by that property.
## Type @code{help BubbleData} for more details on the available properties.
##
## Specifically for the properties that accept a @qcode{Color} object as their
## input value, besides the @qcode{Color} object you may also parse to the
## @qcode{BubbleChart} constructor the same values accepted by the constructor
## of the @qcode{Color} object.  However, if you choose to manually modify the
## @qcode{BubbleChart}'s properties using the dot notation syntax, then you must
## assign a @qcode{Color} object to the chosen property.  Type @code{help Color}
## for more details on the available syntax.
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
## A @qcode{BubbleChart} object, @var{obj}, stores the following properties,
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
## @qcode{BarData} objects corresponding to the @var{data} input.
##
## @item @qcode{labels} @tab @tab A numeric vector or a cellstring array with
## the data labels defined in @var{labels}.
##
## @item @qcode{options} @tab @tab A cell array containing one or more
## @qcode{Option} and @qcode{Plugin} objects.  Not used at the moment.
##
## @end multitable
##
## To directly serve the @qcode{BarChart} object on a local web server instance,
## you can use the object's @qcode{webserve ()} method.  Alternatively, you can
## generate and/or save to a file the corresponding HTML code with the
## @qcode{htmlstring ()} and @qcode{htmlsave ()} methods and serve it online
## through a web server of your choice.
##
## @seealso{BubbleData, Color, Fill, Html, WebServer}
## @end deftypefn

  properties (Access = public)

    chartID            = "bubbleChart";
    datasets           = {};
    labels             = [];
    options            = {};

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

        endswitch
        varargin([1:2]) = [];
      endwhile

    endfunction

    ## -*- texinfo -*-
    ## @deftypefn  {BubbleChart} {@var{json} =} jsonstring (@var{obj})
    ##
    ## Generate a JSON string with the BubbleChart's context.
    ##
    ## @code{jsonstring (@var{obj})} returns a character vector, @var{json},
    ## describing the context of the BubbleChart function in java script.
    ##
    ## @seealso{BubbleChart, BubbleData}
    ## @end deftypefn

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
%!error <BubbleChart.htmlsave: too few input arguments.> ...
%! htmlsave (BubbleChart (1, 2, 3))
%!error <BubbleChart.htmlsave: FILENAME must be a character vector.> ...
%! htmlsave (BubbleChart (1, 2, 3), 1)
%!error <BubbleChart.htmlsave: FILENAME must be a character vector.> ...
%! htmlsave (BubbleChart (1, 2, 3), {"bubble.html"})

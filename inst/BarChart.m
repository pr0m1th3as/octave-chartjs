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

classdef BarChart < Html
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} BarChart (@var{data}, @var{labels})
## @deftypefnx {chartjs} {@var{obj} =} BarChart (@dots{}, @var{Name}, @var{Value})
##
## Create a @qcode{BarChart} object.
##
## @code{@var{obj} = BarChart (@var{data}, @var{labels})} returns a
## @qcode{BarChart} object, in which @var{data} contain the bar heights (by
## default along the @qcode{y-axis}) and @var{labels} contain the bar labels (by
## default along the @qcode{x-axis}).
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
## @code{@var{obj} = BarChart (@dots{}, @var{Name}, @var{Value})} returns a
## @qcode{BarChart} object with the properties of each dataset specified by one
## or more @qcode{@var{Name}, @var{Value}} pair arguments.  @var{Name} can be
## any property name of a @qcode{BarData} object and @var{Value} must correspond
## to the data type(s) and values accepted by that property.
## Type @code{help BarData} for more details on the available properties.
##
## Specifically for the properties that accept a @qcode{Color} object as their
## input value, besides the @qcode{Color} object you may also parse to the
## @qcode{BarChart} constructor the same values accepted by the constructor of
## the @qcode{Color} object.  However, if you choose to manually modify the
## @qcode{BarChart}'s properties using the dot notation syntax, then you must
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
## A @qcode{BarChart} object, @var{obj}, stores the following properties, which
## can be accessed/modified using dot notation syntax similarly to a
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
## To directly serve the @qcode{BarChart} object on the web, you can parse it to
## the @qcode{update} method of a @qcode{WebServer} object.  Alternatively, you
## can generate and save to file the HTML code of your @qcode{BarChart} object
## and serve it online through a web server of your choice.
##
## @seealso{BarData, Color, Fill, Html, WebServer}
## @end deftypefn

  properties (Access = public)

    chartID            = "barChart";
    datasets           = {};
    labels             = [];
    options            = {};

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = BarChart (data, labels, varargin)

      ## Check data and labels
      if (nargin < 2)
        error ("BarChart: too few input arguments.");
      endif
      if (! ismatrix (data) || ! isnumeric (data))
        error ("BarChart: DATA must be a numeric matrix.");
      endif
      if (isempty (data))
        error ("BarChart: DATA cannot be empty.");
      endif
      if (isempty (labels))
        error ("BarChart: LABELS cannot be empty.");
      endif
      if (! isvector (labels))
        error ("BarChart: LABELS must be a vector.");
      endif
      if (ischar (labels))
        labels = cellstr (labels);
      elseif (! isnumeric (labels) && ! iscellstr (labels))
        error (strcat (["BarChart: LABELS must be numeric,"], ...
                       [" cellstring, or character vector."]));
      endif

      ## Force row vectors to column vectors
      if (isvector (data) && numel (data) == numel (labels))
        data = data(:);
      endif
      labels = labels(:);

      ## Check for matching sample sizes
      if (numel (labels) != size (data, 1))
        error ("BarChart: LABELS do not match sample size in DATA.");
      endif

      ## Store labels
      this.labels = labels;

      ## Create datasets
      nsets = size (data, 2);
      for i = 1:nsets
        this.datasets{i} = BarData (data(:,i));
      endfor

      ## Handle the optional pair arguments and change
      ## the properties in each dataset as necessary
      if (mod (numel (varargin), 2) != 0)
        error ("BarChart: optional arguments must be in Name,Value pairs.");
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

          case "base"
            val = varargin{2};
            pname = "base";
            this = parseValue (this, pname, val, [], "scalar");

          case "barpercentage"
            val = varargin{2};
            pname = "barPercentage";
            this = parseValue (this, pname, val, [], "scalar");

          case "barthickness"
            val = varargin{2};
            pname = "barThickness";
            validstr = "flex";
            this = parseValue (this, pname, val, validstr, "numstring");

          case "bordercolor"
            val = varargin{2};
            pname = "borderColor";
            if (! isobject (val))
              this = parseColor (this, pname, val);
            else
              this = parseValue (this, pname, val, "Color", "object");
            endif

          case "borderskipped"
            val = varargin{2};
            pname = "borderSkipped";
            validstr = {"start", "end", "middle", ...
                        "bottom", "left", "top", "right"};
            this = parseValue (this, pname, val, validstr, "boolstring");

          case "borderwidth"
            val = varargin{2};
            pname = "borderWidth";
            this = parseValue (this, pname, val, [], "scalar");

          case "borderradius"
            val = varargin{2};
            pname = "borderRadius";
            this = parseValue (this, pname, val, [], "scalar");

          case "categorypercentage"
            val = varargin{2};
            pname = "categoryPercentage";
            this = parseValue (this, pname, val, [], "scalar");

          case "clip"
            val = varargin{2};
            pname = "clip";
            this = parseValue (this, pname, val, [], "scalar");

          case "grouped"
            val = varargin{2};
            pname = "grouped";
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

          case "hoverborderradius"
            val = varargin{2};
            pname = "hoverBorderRadius";
            this = parseValue (this, pname, val, [], "scalar");

          case "indexaxis"
            val = varargin{2};
            pname = "indexAxis";
            validstr = {"x", "y"};
            this = parseValue (this, pname, val, validstr, "string");

          case "inflateamount"
            val = varargin{2};
            pname = "inflateAmount";
            validstr = "auto";
            this = parseValue (this, pname, val, validstr, "numstring");

          case "maxbarthickness"
            val = varargin{2};
            pname = "maxBarThickness";
            this = parseValue (this, pname, val, [], "scalar");

          case "minbarlength"
            val = varargin{2};
            pname = "minBarLength";
            this = parseValue (this, pname, val, [], "scalar");

          case "label"
            val = varargin{2};
            pname = "label";
            this = parseValue (this, pname, val, val, "string");

          case "order"
            val = varargin{2};
            pname = "order";
            this = parseValue (this, pname, val, [], "scalar");

          case "skipnull"
            val = varargin{2};
            pname = "skipNull";
            this = parseValue (this, pname, val, [], "boolean");

          case "stack"
            val = varargin{2};
            pname = "stack";
            this = parseValue (this, pname, val, val, "boolstring");

        endswitch
        varargin([1:2]) = [];
      endwhile

    endfunction

    ## -*- texinfo -*-
    ## @deftypefn  {BarChart} {@var{json} =} jsonstring (@var{obj})
    ##
    ## Generate a JSON string with the BarChart's context.
    ##
    ## @code{jsonstring (@var{obj})} returns a character vector, @var{json},
    ## describing the context of the BarChart function in java script.
    ##
    ## @seealso{BarChart, BarData}
    ## @end deftypefn

    function json = jsonstring (this)

      ## Initialize json string
      json = "{\n  type: 'bar',\n  data: {\n";

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
%!error <BarChart: too few input arguments.> BarChart (1)
%!error <BarChart: DATA must be a numeric matrix.> BarChart ({1}, "A")
%!error <BarChart: DATA must be a numeric matrix.> BarChart ("1", "A")
%!error <BarChart: DATA cannot be empty.> BarChart ([], "A")
%!error <BarChart: LABELS cannot be empty.> BarChart (1, [])
%!error <BarChart: LABELS must be a vector.> BarChart (ones (2), ones (2))
%!error <BarChart: LABELS must be numeric, cellstring, or character vector.> ...
%! BarChart (ones (2), {1, 2})
%!error <BarChart: LABELS do not match sample size in DATA.> ...
%! BarChart (ones (2), "A")
%!error <BarChart: optional arguments must be in Name,Value pairs.> ...
%! BarChart (1, "A", "backgroundColor")
%!error <BarChart.htmlsave: too few input arguments.> ...
%! htmlsave (BarChart (1, "A"))
%!error <BarChart.htmlsave: FILENAME must be a character vector.> ...
%! htmlsave (BarChart (1, "A"), 1)
%!error <BarChart.htmlsave: FILENAME must be a character vector.> ...
%! htmlsave (BarChart (1, "A"), {"bar.html"})

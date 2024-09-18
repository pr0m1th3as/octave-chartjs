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

classdef BarChart
## -*- texinfo -*-
## @deftypefn  {octave-chartjs} {@var{obj} =} BarChart (@var{data}, @var{labels})
## @deftypefnx {octave-chartjs} {@var{obj} =} BarChart (@dots{}, @var{Name}, @var{Value})
##
## Create a @qcode{BarChart} object.
##
## @code{@var{obj} = BarChart (@var{data}, @var{labels})} returns a BarChart
## object, with @var{data} containing the bar heights (along the @qcode{y-axis})
## and @var{labels} containing the bar labels (along the @qcode{x-axis}).
##
## @itemize
## @item
## @var{data} must be a nonempty @math{NxP} numeric matrix, where each column
## corresponds to a separate dataset and each row corresponds to an element in
## @var{labels}.  If @var{data} is a row vector and its length matches the
## number of elements in @var{labels}, then it is transposed to a column vector.
## @item
## @var{labels} must be a nonempty numerical or cellstring vector, where each
## element corresponds to a row in @var{data}.  If @var{labels} is a character
## vector, then it is converted to a cellstring scalar.
## @end itemize
##
## @code{@var{obj} = BarChart (@dots{}, @var{Name}, @var{Value})} returns a
## BarChart object with the properties of each dataset specified by a
## @qcode{Name-Value} pair arguments.  @var{Name} can be any property name of a
## @qcode{BarData} object and @var{Value} must be a corresponding to the value
## accepted by that property.  Type @code{help BarData} for more details on
## available properties.
##
## A @qcode{BarCHart} object, @var{obj}, stores the following properties, which
## can be accessed using dot notation similarly to a @qcode{struct} object:
##
## @multitable @columnfractions 0.23 0.02 0.75
## @headitem @var{Field} @tab @tab @var{Description}
##
## @item @qcode{chartID} @tab @tab Unstandardized predictor data, specified as a
## numeric matrix.  Each column of @var{X} represents one predictor (variable),
## and each row represents one observation.
##
## @item @qcode{datasets} @tab @tab Class labels, specified as a logical or
## numeric vector, or cell array of character vectors.  Each value in @var{Y} is
## the observed class label for the corresponding row in @var{X}.
##
## @item @qcode{labels} @tab @tab Number of observations used in
## training the ClassificationKNN model, specified as a positive integer scalar.
## This number can be less than the number of rows in the training data because
## rows containing @qcode{NaN} values are not part of the fit.
##
## @item @qcode{options} @tab @tab Rows of the original training data
## used in fitting the ClassificationKNN model, specified as a numerical vector.
## If you want to use this vector for indexing the training data in @var{X}, you
## have to convert it to a logical vector, i.e
## @qcode{X = obj.X(logical (obj.RowsUsed), :);}
##
## @end multitable
##
## @seealso{fitcknn, knnsearch, rangesearch, pdist2}
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

    ## Export to json string
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

    ## Export to html string
    function html = htmlstring (this)

      ## Initialize html string
      tmp1 = "<!DOCTYPE html>\n<html>\n";
      tmp2 = "  <script src=""https://cdn.jsdelivr.net/npm/chart.js"">";
      tmp3 = "  </script>\n  <body>\n    <div>\n";
      tmp4 = "    <canvas id=""%s"" style=""width:100%%"">";
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
      if (! (isnumeric (port) && isscalar (port) &&
             fix (port) == port && port > 0 && port <= 65535))
        error (strcat (["BarChart.webserve: PORT must be a scalar"], ...
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

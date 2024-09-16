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

  properties (Access = public)

    labels             = [];
    datasets           = {};
    options            = {};
    chartID            = "barChart";
    chartWidth         = 100;

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = BarChart (data, labels, varargin)

      ## Check data and labels
      if (! ismatrix (data) || ! isnumeric (data))
        error ("BarChart: data must be a numeric matrix.");
      endif
      if (isempty (data))
        error ("BarChart: data cannot be empty.");
      endif
      if (! isvector (labels))
        error ("BarChart: labels must be a vector.");
      endif
      if (! isnumeric (labels) && ! iscellstr (labels))
        error ("BarChart: labels can be either numeric or cellstring.");
      endif
      ## Force row vector to column vector
      if (isvector (data))
        data = data(:);
      endif
      ## Check for matching sample sizes
      if (numel (labels) != size (data, 1))
        error ("BarChart: labels do not match sample size in data.");
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
              this = utils.parseColor (this, pname, val);
            else
              this = utils.parseValue (this, pname, val, "Color", "object");
            endif

          case "base"
            val = varargin{2};
            pname = "base";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "barpercentage"
            val = varargin{2};
            pname = "barPercentage";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "barthickness"
            val = varargin{2};
            pname = "barThickness";
            validstr = "flex";
            this = utils.parseValue (this, pname, val, validstr, "numstring");

          case "bordercolor"
            val = varargin{2};
            pname = "borderColor";
            if (! isobject (val))
              this = utils.parseColor (this, pname, val);
            else
              this = utils.parseValue (this, pname, val, "Color", "object");
            endif

          case "borderskipped"
            val = varargin{2};
            pname = "borderSkipped";
            validstr = {"start", "end", "middle", ...
                        "bottom", "left", "top", "right"};
            this = utils.parseValue (this, pname, val, validstr, "boolstring");

          case "borderwidth"
            val = varargin{2};
            pname = "borderWidth";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "borderradius"
            val = varargin{2};
            pname = "borderRadius";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "categorypercentage"
            val = varargin{2};
            pname = "categoryPercentage";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "clip"
            val = varargin{2};
            pname = "clip";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "grouped"
            val = varargin{2};
            pname = "grouped";
            this = utils.parseValue (this, pname, val, [], "boolean");

          case "hoverbackgroundcolor"
            val = varargin{2};
            pname = "hoverBackgroundColor";
            if (! isobject (val))
              this = utils.parseColor (this, pname, val);
            else
              this = utils.parseValue (this, pname, val, "Color", "object");
            endif

          case "hoverbordercolor"
            val = varargin{2};
            pname = "hoverBorderColor";
            if (! isobject (val))
              this = utils.parseColor (this, pname, val);
            else
              this = utils.parseValue (this, pname, val, "Color", "object");
            endif

          case "hoverborderwidth"
            val = varargin{2};
            pname = "hoverBorderWidth";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "hoverborderradius"
            val = varargin{2};
            pname = "hoverBorderRadius";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "indexaxis"
            val = varargin{2};
            pname = "indexAxis";
            validstr = {"x", "y"};
            this = utils.parseValue (this, pname, val, validstr, "string");

          case "inflateamount"
            val = varargin{2};
            pname = "inflateAmount";
            validstr = "auto";
            this = utils.parseValue (this, pname, val, validstr, "numstring");

          case "maxbarthickness"
            val = varargin{2};
            pname = "maxBarThickness";
            this = utils.parseValue (this, pname, val, [], "scalar"););

          case "minbarlength"
            val = varargin{2};
            pname = "minBarLength";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "label"
            val = varargin{2};
            pname = "label";
            this = utils.parseValue (this, pname, val, val, "string");

          case "order"
            val = varargin{2};
            pname = "order";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "skipnull"
            val = varargin{2};
            pname = "skipNull";
            this = utils.parseValue (this, pname, val, [], "boolean");

          case "stack"
            val = varargin{2};
            pname = "stack";
            this = utils.parseValue (this, pname, val, val, "boolstring");

          case "chartid"
            val = varargin{2};
            if (! ischar (val))
              error ("BarChart: 'ChartID' must be a character vector.");
            endif
            this.chartID = val;

          case "chartwidth"
            val = varargin{2};
            if (! isnumeric (val) || val < 0 || val > 100)
              error ("BarChart: 'ChartWidth' must be a scalar percentage.");
            endif
            this.chartID = val;

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
      tmp4 = "    <canvas id=""%s"" style=""width:%i%%;max-width:600px"">";
      ## Add chart ID
      tmp4 = sprintf (tmp4, this.chartID, this.chartWidth);
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

  endmethods

endclassdef

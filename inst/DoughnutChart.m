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

classdef DoughnutChart

  properties (Access = public)

    labels             = [];
    datasets           = {};
    options            = {};
    chartID            = "doughnutChart";
    chartWidth         = 100;

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = DoughnutChart (data, labels, varargin)

      ## Check data and labels
      if (! ismatrix (data) || ! isnumeric (data))
        error ("DoughnutChart: data must be a numeric matrix.");
      endif
      if (isempty (data))
        error ("DoughnutChart: data cannot be empty.");
      endif
      if (! isvector (labels))
        error ("DoughnutChart: labels must be a vector.");
      endif
      if (! isnumeric (labels) && ! iscellstr (labels))
        error ("DoughnutChart: labels can be either numeric or cellstring.");
      endif
      ## Force row vector to column vector
      if (isvector (data))
        data = data(:);
      endif
      ## Check for matching sample sizes
      if (numel (labels) != size (data, 1))
        error ("DoughnutChart: labels do not match sample size in data.");
      endif

      ## Store labels
      this.labels = labels;

      ## Create datasets
      nsets = size (data, 2);
      for i = 1:nsets
        this.datasets{i} = DoughnutData (data(:,i));
      endfor

      ## Handle the optional pair arguments and change
      ## the properties in each dataset as necessary
      if (mod (numel (varargin), 2) != 0)
        error ("DoughnutChart: optional arguments must be in Name,Value pairs.");
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

          case "borderalign"
            val = varargin{2};
            pname = "borderAlign";
            validstr = {"center", "inner"};
            this = utils.parseValue (this, pname, val, validstr, "string");

          case "bordercolor"
            val = varargin{2};
            pname = "borderColor";
            if (! isobject (val))
              this = utils.parseColor (this, pname, val);
            else
              this = utils.parseValue (this, pname, val, "Color", "object");
            endif

          case "borderdash"
            val = varargin{2};
            pname = "borderDash";
            this = utils.parseValue (this, pname, val, [], "vector");

          case "borderdashoffset"
            val = varargin{2};
            pname = "borderDashOffset";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "borderjoinstyle"
            val = varargin{2};
            pname = "borderJoinStyle";
            validstr = {"bevel", "round", "miter"};
            this = utils.parseValue (this, pname, val, validstr, "string");

          case "borderradius"
            val = varargin{2};
            pname = "borderRadius";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "borderwidth"
            val = varargin{2};
            pname = "borderWidth";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "circumference"
            val = varargin{2};
            pname = "circumference";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "clip"
            val = varargin{2};
            pname = "clip";
            this = utils.parseValue (this, pname, val, [], "scalar");

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

          case "hoverborderdash"
            val = varargin{2};
            pname = "hoverBorderDash";
            this = utils.parseValue (this, pname, val, [], "vector");

          case "hoverborderdashoffset"
            val = varargin{2};
            pname = "hoverBorderDashOffset";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "hoverborderjoinstyle"
            val = varargin{2};
            pname = "hoverBorderJoinStyle";
            validstr = {"bevel", "round", "miter"};
            this = utils.parseValue (this, pname, val, validstr, "string");

          case "hoverborderwidth"
            val = varargin{2};
            pname = "hoverBorderWidth";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "hoveroffset"
            val = varargin{2};
            pname = "hoverOffset";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "offset"
            val = varargin{2};
            pname = "offset";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "rotation"
            val = varargin{2};
            pname = "rotation";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "spacing"
            val = varargin{2};
            pname = "spacing";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "weight"
            val = varargin{2};
            pname = "weight";
            this = utils.parseValue (this, pname, val, [], "scalar");

          case "chartid"
            val = varargin{2};
            if (! ischar (val))
              error ("DoughnutChart: 'ChartID' must be a character vector.");
            endif
            this.chartID = val;

          case "chartwidth"
            val = varargin{2};
            if (! isnumeric (val) || val < 0 || val > 100)
              error ("DoughnutChart: 'ChartWidth' must be a scalar percentage.");
            endif
            this.chartID = val;

        endswitch
        varargin([1:2]) = [];
      endwhile

    endfunction

    ## Export to json string
    function json = jsonstring (this)

      ## Initialize json string
      json = "{\n  type: 'doughnut',\n  data: {\n";

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

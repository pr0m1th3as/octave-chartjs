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

classdef LineData

  properties (Access = public)

    backgroundColor           = [];
    borderCapStyle            = 'butt';
    borderColor               = [];
    borderDash                = 0;
    borderDashOffset          = 0;
    borderJoinStyle           = 'miter';
    borderWidth               = 3;
    clip                      = [];
    cubicInterpolationMode    = "default";
    data                      = [];
    drawActiveElementsOnTop   = true;
    fill                      = [];
    hoverBackgroundColor      = [];
    hoverBorderCapStyle       = [];
    hoverBorderColor          = [];
    hoverBorderDash           = [];
    hoverBorderDashOffset     = [];
    hoverBorderJoinStyle      = [];
    hoverBorderWidth          = [];
    indexAxis                 = 'x';
    label                     = '';
    order                     = 0;
    pointBackgroundColor      = [];
    pointBorderColor          = [];
    pointBorderWidth          = 1;
    pointHitRadius            = 1;
    pointHoverBackgroundColor = [];
    pointHoverBorderColor     = [];
    pointHoverBorderWidth     = 1;
    pointHoverRadius          = 4;
    pointRadius               = 3;
    pointRotation             = 0;
    pointStyle                = 'circle';
    segment                   = [];     # not supported
    showLine                  = true;
    spanGaps                  = [];
    stack                     = 'line';
    stepped                   = false;
    tension                   = 0;
    xAxisID                   = [];     # not supported
    yAxisID                   = [];     # not supported

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = LineData (data)

      ## Check data
      if (nargin < 1)
        error ("LineData: too few input arguments.");
      endif
      if (isempty (data))
        error ("LineData: DATA cannot be empty.");
      endif
      if (! isvector (data) || ! isnumeric (data))
        error ("LineData: DATA must be a numeric vector.");
      endif

      ## Store data
      this.data = data(:)';

    endfunction

    ## Export to json string
    function json = jsonstring (this, mixed = false)

      ## Initialize json string
      json = "{\n      ";

      ## Add type for mixed datasets
      if (mixed)
        json = [json, "type: 'line',\n      "];
      endif

      ## Add data
      data = sprintf ("%f, ", this.data);
      data(end) = [];
      data(end) = "]";
      data = sprintf ("data: [%s", data);
      json = [json, data];

      ## Add optional properties
      json = parseDataProperties (json, this);

      ## Close json string
      json = [json, "\n    }"];

    endfunction

  endmethods

endclassdef

## Test input validation
%!error <LineData: too few input arguments.> LineData ()
%!error <LineData: DATA cannot be empty.> LineData ([])
%!error <LineData: DATA must be a numeric vector.> LineData ("1")
%!error <LineData: DATA must be a numeric vector.> LineData ({1})

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

classdef RadarData

  properties (Access = public)

    backgroundColor           = [];
    borderCapStyle            = 'butt';
    borderColor               = [];
    borderDash                = 0;
    borderDashOffset          = 0;
    borderJoinStyle           = 'miter';
    borderWidth               = 3;
    clip                      = [];
    data                      = [];
    fill                      = [];
    hoverBackgroundColor      = [];
    hoverBorderCapStyle       = [];
    hoverBorderColor          = [];
    hoverBorderDash           = [];
    hoverBorderDashOffset     = [];
    hoverBorderJoinStyle      = [];
    hoverBorderWidth          = [];
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
    spanGaps                  = [];
    tension                   = 0;

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = RadarData (data)

      ## Check data
      if (nargin < 1)
        error ("RadarData: too few input arguments.");
      endif
      if (isempty (data))
        error ("RadarData: DATA cannot be empty.");
      endif
      if (! isvector (data) || ! isnumeric (data))
        error ("RadarData: DATA must be a numeric vector.");
      endif

      ## Store data
      this.data = data(:)';

    endfunction

    ## Export to json string
    function json = jsonstring (this)

      ## Initialize json string
      json = "{\n      ";

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
%!error <RadarData: too few input arguments.> RadarData ()
%!error <RadarData: DATA cannot be empty.> RadarData ([])
%!error <RadarData: DATA must be a numeric vector.> RadarData ("1")
%!error <RadarData: DATA must be a numeric vector.> RadarData ({1})

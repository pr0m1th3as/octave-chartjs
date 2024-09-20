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

classdef ScatterData

  properties (Access = public)

    backgroundColor           = [];
    borderColor               = [];
    borderWidth               = 3;
    clip                      = [];
    data                      = [];
    drawActiveElementsOnTop   = true;
    hoverBackgroundColor      = [];
    hoverBorderColor          = [];
    hoverBorderWidth          = 1;
    hoverRadius               = 4;
    hitRadius                 = 1;
    label                     = '';
    order                     = 0;
    pointStyle                = 'circle';
    rotation                  = 0;
    radius                    = 3;

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = ScatterData (data)

      ## Check data
      if (nargin < 1)
        error ("ScatterData: too few input arguments.");
      endif
      if (isempty (data))
        error ("ScatterData: DATA cannot be empty.");
      endif
      if (! ismatrix (data) || ! isnumeric (data))
        error ("ScatterData: DATA must be a numeric matrix.");
      endif
      if (size (data, 2) != 2)
        error ("ScatterData: DATA must have two columns for X and Y.");
      endif

      ## Store data
      this.data = data;

    endfunction

    ## Export to json string
    function json = jsonstring (this, mixed = false)

      ## Initialize json string
      json = "{\n      ";

      ## Add type for mixed datasets
      if (mixed)
        json = [json, "type: 'scatter',\n      "];
      endif

      ## Add data
      data = sprintf ("{x: %f, y: %f, r: %i},\n             ", this.data');
      data = strtrim (data);
      data(end) = [];
      data = sprintf ("data: [%s]", data);
      json = [json, data];

      ## Add optional properties
      json = parseDataProperties (json, this);

      ## Close json string
      json = [json, "\n    }"];

    endfunction

  endmethods

endclassdef

## Test input validation
%!error <ScatterData: too few input arguments.> ScatterData ()
%!error <ScatterData: DATA cannot be empty.> ScatterData ([])
%!error <ScatterData: DATA must be a numeric matrix.> ScatterData ({1, 23})
%!error <ScatterData: DATA must be a numeric matrix.> ScatterData ("ASD")
%!error <ScatterData: DATA must have two columns for X and Y.> ...
%! ScatterData ([1])

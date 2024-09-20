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

classdef PolarAreaData

  properties (Access = public)

    backgroundColor           = [];
    borderAlign               = 'center';
    borderColor               = [];
    borderDash                = 0;
    borderDashOffset          = 0;
    borderJoinStyle           = [];
    borderWidth               = 2;
    circular                  = true;
    clip                      = [];
    data                      = [];
    hoverBackgroundColor      = [];
    hoverBorderColor          = [];
    hoverBorderDash           = [];
    hoverBorderDashOffset     = [];
    hoverBorderJoinStyle      = [];
    hoverBorderWidth          = [];

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = PolarAreaData (data)

      ## Check data
      if (nargin < 1)
        error ("PolarAreaData: too few input arguments.");
      endif
      if (isempty (data))
        error ("PolarAreaData: DATA cannot be empty.");
      endif
      if (! isvector (data) || ! isnumeric (data))
        error ("PolarAreaData: DATA must be a numeric vector.");
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
%!error <PolarAreaData: too few input arguments.> PolarAreaData ()
%!error <PolarAreaData: DATA cannot be empty.> PolarAreaData ([])
%!error <PolarAreaData: DATA must be a numeric vector.> PolarAreaData ("1")
%!error <PolarAreaData: DATA must be a numeric vector.> PolarAreaData ({1})

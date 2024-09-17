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

classdef BubbleData

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
    function this = BubbleData (data)

      ## Check data
      if (! ismatrix (data))
        error ("BubbleData: data must be a matrix.");
      endif
      if (size (data, 2) != 3)
        error ("BubbleData: data must have three columns for X, Y, and R.");
      endif
      if (isempty (data))
        error ("BubbleData: data must not be empty.");
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
        json = [json, "type: 'bubble',\n      "];
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

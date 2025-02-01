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
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} PolarAreaData (@var{data})
##
## Create a @qcode{PolarAreaData} object.
##
## @code{@var{obj} = PolarAreaData (@var{data})} returns a @qcode{PolarAreaData}
## object, in which @var{data} must be a nonempty numerical vector containing
## the radii of the arc segments of a single dataset.  Constructing a
## @qcode{PolarAreaData} object always assigns the default property values,
## which can later be modified using dot notation syntax.
##
## A @qcode{PolarAreaData} object, @var{obj}, contains the following properties:
##
## @multitable @columnfractions 0.23 0.02 0.75
## @headitem @var{Field} @tab @tab @var{Description}
##
## @item @qcode{backgroundColor} @tab @tab A @qcode{Color} object defining the
## color of the face of the arc segments.  Default is empty, in which case and a
## color is assigned automatically by the Chart.js library.
##
## @item @qcode{borderAlign} @tab @tab A character vector, which can be either
## @qcode{'center'} (default) or @qcode{'inner'}.  When @qcode{'center'} is set,
## the borders of arcs next to each other will overlap.  When @qcode{'inner'} is
## set, it is guaranteed that all borders will not overlap.
##
## @item @qcode{borderColor} @tab @tab A @qcode{Color} object defining the color
## of the border line of the arc segments.  Default is empty, in which case a
## color is assigned automatically by the Chart.js library.
##
## @item @qcode{borderDash} @tab @tab A numeric vector defining the length and
## spacing of dashes drawn at the borders of the arc segments.
##
## @item @qcode{borderDashOffset} @tab @tab A numeric scalar defining the offset
## of dashes drawn at the borders of the arc segments.  Default is 0.
##
## @item @qcode{borderJoinStyle} @tab @tab A character vector defining the arc
## border join style.  It can be either @qcode{'round'}, @qcode{'bevel'}, or
## @qcode{'miter'}.
##
## @item @qcode{borderWidth} @tab @tab A numeric scalar value defining the width
## of the each arc segment's borders in pixels.  Default is 2.
##
## @item @qcode{circular} @tab @tab A boolean scalar value defining whether the
## arc will be curved or flat.  By default, it is @qcode{true} corresponding to
## curved arc segments.
##
## @item @qcode{clip} @tab @tab A numeric scalar value defining the pixels to
## clip relative to the chart's area.  Positive value allows overflow, negative
## value clips that many pixels inside chartArea.  Defaults to zero pixels.
##
## @item @qcode{data} @tab @tab A numeric vector assigned at construction of the
## @qcode{PolarAreaData} object.  It cannot be empty.
##
## @item @qcode{hoverBackgroundColor} @tab @tab A @qcode{Color} object defining
## the color of the face of each arc segment, when the mouse hovers over it.
## Default is empty, in which case the color is the same as in
## @qcode{backgroundColor}.
##
## @item @qcode{hoverBorderColor} @tab @tab A @qcode{Color} object defining
## the color of the borders of each arc segment, when the mouse hovers over it.
## Default is empty, in which case the color is the same as in
## @qcode{borderColor}.
##
## @item @qcode{hoverBorderDash} @tab @tab A numeric vector defining the length
## and spacing of dashes drawn at the borders of the arc segment, when the
## mouse hovers over it.
##
## @item @qcode{hoverBorderDashOffset} @tab @tab A numeric scalar defining the
## offset of dashes drawn at the borders of the arc segment, when the mouse
## hovers over it.
##
## @item @qcode{hoverBorderJoinStyle} @tab @tab A character vector defining the
## arc border join style, when the mouse hovers over it.  It can be either
## @qcode{'round'}, @qcode{'bevel'}, or @qcode{'miter'}.
##
## @item @qcode{hoverBorderWidth} @tab @tab A numeric scalar value defining the
## width of the each arc segment's borders in pixels, when the mouse hovers over
## it.
##
## @end multitable
##
## @seealso{PolarAreaChart, Color, Fill}
## @end deftypefn

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

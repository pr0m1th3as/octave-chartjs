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

classdef PieData
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} PieData (@var{data})
##
## Create a @qcode{PieData} object.
##
## @code{@var{obj} = PieData (@var{data})} returns a @qcode{PieData} object, in
## which @var{data} must be a nonempty numerical vector containing the
## proportional arc segments of a single dataset.  Constructing a
## @qcode{PieData} object always assigns the default property values, which can
## later be modified using dot notation syntax.
##
## A @qcode{PieData} object, @var{obj}, contains the following properties:
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
## @item @qcode{borderRadius} @tab @tab A numeric scalar value defining the
## corner radius of the each arc segment in pixels.  Default is 0.
##
## @item @qcode{borderWidth} @tab @tab A numeric scalar value defining the width
## of the each arc segment's borders in pixels.  Default is 2.
##
## @item @qcode{circumference} @tab @tab A numeric scalar value, which defines
## the per-dataset override for the sweep that the arcs cover.
##
## @item @qcode{clip} @tab @tab A numeric scalar value defining the pixels to
## clip relative to the chart's area.  Positive value allows overflow, negative
## value clips that many pixels inside chartArea.  Defaults to zero pixels.
##
## @item @qcode{data} @tab @tab A numeric vector assigned at construction of the
## @qcode{PieData} object.  It cannot be empty.
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
## @item @qcode{hoverOffset} @tab @tab A numeric scalar value defining the arc
## offset, when the mouse hovers over it.  Default is 0.
##
## @item @qcode{offset} @tab @tab A numeric scalar defining the arc offset in
## pixels.  Default is 0.
##
## @item @qcode{rotation} @tab @tab A numeric scalar defining the starting angle
## to draw arcs from.  Default is 0.
##
## @item @qcode{spacing} @tab @tab A numeric scalar defining a fixed arc offset
## in pixels.  Default is 0.  It is similar to @qcode{offset}, but it applies to
## all arcs.
##
## @item @qcode{weight} @tab @tab A numeric scalar value defining the relative
## thickness of the dataset.  Providing a value for weight will cause the
## doughnut dataset to be drawn with a thickness relative to the sum of all the
## dataset weight values.
##
## @end multitable
##
## @seealso{PieChart, Color, Fill}
## @end deftypefn

  properties (Access = public)

    backgroundColor           = [];
    borderAlign               = 'center';
    borderColor               = [];
    borderDash                = 0;
    borderDashOffset          = 0;
    borderJoinStyle           = [];
    borderRadius              = 0;
    borderWidth               = 2;
    circumference             = [];
    clip                      = [];
    data                      = [];
    hoverBackgroundColor      = [];
    hoverBorderColor          = [];
    hoverBorderDash           = [];
    hoverBorderDashOffset     = [];
    hoverBorderJoinStyle      = [];
    hoverBorderWidth          = [];
    hoverOffset               = 0;
    offset                    = 0;
    rotation                  = 0;
    spacing                   = 0;
    weight                    = 1;

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = PieData (data)

      ## Check data
      if (nargin < 1)
        error ("PieData: too few input arguments.");
      endif
      if (isempty (data))
        error ("PieData: DATA cannot be empty.");
      endif
      if (! isvector (data) || ! isnumeric (data))
        error ("PieData: DATA must be a numeric vector.");
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
      json = utils.parseDataProperties (json, this);

      ## Close json string
      json = [json, "\n    }"];

    endfunction

  endmethods

endclassdef

## Test input validation
%!error <PieData: too few input arguments.> PieData ()
%!error <PieData: DATA cannot be empty.> PieData ([])
%!error <PieData: DATA must be a numeric vector.> PieData ("1")
%!error <PieData: DATA must be a numeric vector.> PieData ({1})

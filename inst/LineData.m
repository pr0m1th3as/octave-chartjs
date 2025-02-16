## Copyright (C) 2024-2025 Andreas Bertsatos <abertsatos@biol.uoa.gr>
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
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} LineData (@var{data})
##
## Create a @qcode{LineData} object.
##
## @code{@var{obj} = LineData (@var{data})} returns a @qcode{LineData}
## object, in which @var{data} must be a nonempty numerical vector containing
## the data points of a single dataset to be plotted on a line.  Constructing a
## @qcode{LineData} object always assigns the default property values, which
## can later be modified using dot notation syntax.
##
## A @qcode{LineData} object, @var{obj}, contains the following properties:
##
## @multitable @columnfractions 0.23 0.02 0.75
## @headitem @var{Field} @tab @tab @var{Description}
##
## @item @qcode{backgroundColor} @tab @tab A @qcode{Color} object defining the
## fill color of the lines between data points.  Default is empty, in which case
## a color is assigned automatically by the Chart.js library.
##
## @item @qcode{borderCapStyle} @tab @tab A character vector, which can be
## either @qcode{'butt'} (default), @qcode{'round'}, or @qcode{'square'}.  When
## @qcode{'butt'}, the ends of lines are squared off at the endpoints.  When
## @qcode{'round'}, the ends of lines are rounded.  When @qcode{'square'} is
## set, the ends of lines are squared off by adding a box with an equal width
## and half the height of the line's thickness.
##
## @item @qcode{borderColor} @tab @tab A @qcode{Color} object defining the color
## of the lines between data points.  Default is empty, in which case a
## color is assigned automatically by the Chart.js library.
##
## @item @qcode{borderDash} @tab @tab A numeric vector defining the length and
## spacing of dashes drawn instead of a line.
##
## @item @qcode{borderDashOffset} @tab @tab A numeric scalar defining the offset
## of dashes and spacing drawn instead of a line.  Default is 0.
##
## @item @qcode{borderJoinStyle} @tab @tab A character vector defining the line
## border join style.  It can be either @qcode{'round'}, @qcode{'bevel'}, or
## @qcode{'miter'}.
##
## @item @qcode{borderWidth} @tab @tab A numeric scalar value defining the width
## of the line in pixels.  Default is 3.
##
## @item @qcode{clip} @tab @tab A numeric scalar value defining the pixels to
## clip relative to the chart's area.  Positive value allows overflow, negative
## value clips that many pixels inside chartArea.  Defaults to zero pixels.
##
## @item @qcode{cubicInterpolationMode} @tab @tab A character vector defining
## the cubic interpolation mode.  It can be either @qcode{'default'} or
## @qcode{'monotonic'}.
##
## @item @qcode{data} @tab @tab A numeric vector assigned at construction of the
## @qcode{LineData} object.  It cannot be empty.
##
## @item @qcode{drawActiveElementsOnTop} @tab @tab A boolean scalar defining
## whether to draw the active points of a dataset over the other points of the
## dataset.  It is @qcode{true} by default.
##
## @item @qcode{fill} @tab @tab A @qcode{Fill} object defining how to fill the
## area under the line.  Type @code{help Fill} for more details on the available
## filling modes.  By default, no filling is applied.
##
## @item @qcode{hoverBackgroundColor} @tab @tab A @qcode{Color} object defining
## the fill color of the lines between data points, when the mouse hovers over
## it.  Default is empty, in which case the color is the same as in
## @qcode{backgroundColor}.
##
## @item @qcode{hoverBorderCapStyle} @tab @tab A character vector, which can be
## either @qcode{'butt'}, @qcode{'round'}, or @qcode{'square'}, defining the cap
## style of the line when the mouse hovers over it.  Default is empty, in which
## case the cap style is the same as in @qcode{borderCapStyle}.
##
## @item @qcode{hoverBorderColor} @tab @tab A @qcode{Color} object defining the
## color of the lines between data points, when the mouse hovers over it.
## Default is empty, in which case the color is the same as in
## @qcode{borderColor}.
##
## @item @qcode{hoverBorderDash} @tab @tab A numeric vector defining the length
## and spacing of dashes drawn instead of a line, when the mouse hovers over
## them.  Default is empty, in which case the length and spacing of the dashes
## are the same as in @qcode{borderDash}.
##
## @item @qcode{hoverborderDashOffset} @tab @tab A numeric scalar defining the
## offset of dashes drawn instead of a line, when the mouse hovers over them.
## Default is empty, in which case the offset is the same as in
## @qcode{borderDashOffset}
##
## @item @qcode{hoverBorderJoinStyle} @tab @tab A character vector defining the
## line border join style, when the mouse hovers over it.  Default is empty, in
## which case the line border join style is the same as in
## @qcode{borderJoinStyle}
##
## @item @qcode{hoverBorderWidth} @tab @tab A numeric scalar value defining the
## width of the line in pixels, when the mouse hovers over it.  Default is
## empty, in which case the width is the same as in @qcode{borderWidth}.
##
## @item @qcode{indexAxis} @tab @tab A character scalar defining the base axis
## of the dataset.  It can be either @qcode{'x'} for horizontal lines or
## @qcode{'y'} for horizontal lines.  Default is @qcode{'x'}.
##
## @item @qcode{labels} @tab @tab A character vector defining the label for the
## dataset which appears in the legend and tooltips.  Default is empty.
##
## @item @qcode{order} @tab @tab A numeric scalar defining the drawing order of
## the dataset.  It also affects order for stacking, tooltip and legend.
## Default is 0.
##
## @item @qcode{pointBackgroundColor} @tab @tab A @qcode{Color} object defining
## the fill color for the data points.  Default is empty, in which case
## a color is assigned automatically by the Chart.js library.
##
## @item @qcode{pointBorderColor} @tab @tab A @qcode{Color} object defining
## the border color for the data points.  Default is empty, in which case
## a color is assigned automatically by the Chart.js library.
##
## @item @qcode{pointBorderWidth} @tab @tab A numeric scalar value defining the
## width of the data point border in pixels.  Default is 1.
##
## @item @qcode{pointHitRadius} @tab @tab A numeric scalar value defining the
## pixel size of the non-displayed point that reacts to mouse events.  Default
## is 1.
##
## @item @qcode{pointHoverBackgroundColor} @tab @tab A @qcode{Color} object
## defining the fill color for the data points, when the mouse hovers over them.
## Default is empty, in which case the fill color is the same as in
## @qcode{pointBackgroundColor}.
##
## @item @qcode{pointHoverBorderColor} @tab @tab A @qcode{Color} object
## defining the border color for the data point, when the mouse hovers over it.
## Default is empty, in which case the border color is the same as in
## @qcode{pointBorderColor}.
##
## @item @qcode{pointHoverBorderWidth} @tab @tab A numeric scalar value defining
## the width of the data point border in pixels, when the mouse hovers over it.
## Default is 1.
##
## @item @qcode{pointHoverRadius} @tab @tab A numeric scalar value defining
## the radius of the data point border in pixels, when the mouse hovers over it.
## Default is 4.
##
## @item @qcode{pointRadius} @tab @tab A numeric scalar value defining the
## radius of the data point border in pixels.  Default is 3.
##
## @item @qcode{pointRotation} @tab @tab A numeric scalar value defining the
## rotation of the data point border in degrees.  Default is 0.
##
## @item @qcode{pointStyle} @tab @tab A character vector or a boolean value
## defining the shape of the points of the dataset.  As a character vector, it
## can be any of the following values: @qcode{'circle'}, @qcode{'cross'},
## @qcode{'crossRot'}, @qcode{'dash'}, @qcode{'line'}, @qcode{'rect'},
## @qcode{'rectRounded'}, @qcode{'rectRot'}, @qcode{'star'}, @qcode{'triangle'},
## and @qcode{'none'}.  By default it is @qcode{'circle}.  As a boolean value,
## @qcode{true} defaults to @qcode{'circle'} and @qcode{false} defaults to
## @qcode{'none'}.
##
## @item @qcode{showLine} @tab @tab A boolean scalar defining whether to draw
## the line for this dataset.  It is @qcode{true} by default.
##
## @item @qcode{spanGaps} @tab @tab A boolean scalar or a numeric scalar
## defining whether to create a break in the line for @qcode{null} data.  When
## @qcode{true}, lines will be drawn between points with no or null data.  When
## @qcode{false}, points with null data will create a break in the line.  It can
## also be a number specifying the maximum gap length to span.  The unit of the
## value depends on the scale used.
##
## @item @qcode{stack} @tab @tab A character vector defining the ID of the group
## to which the dataset belongs to.
##
## @item @qcode{stepped} @tab @tab A character vector or a boolean value
## defining the interpolation mode between data points.  As a character vector,
## it can be any of the following values: @qcode{'before'} for step-before
## interpolation, @qcode{'after'} for step-after interpolation, and
## @qcode{'middle'} for step-middle interpolation.  As a boolean value,
## @qcode{true} equals to @qcode{'before'} and @qcode{false}, which is the
## default value, corresponds to no step interpolation.  If @qcode{stepped}
## value is set to anything other than @qcode{false}, @qcode{tension} will be
## ignored.
##
## @item @qcode{tension} @tab @tab A numeric scalar value defining the Bezier
## curve tension of the line.  By default it is 0, which corresponds to drawing
## straight lines between data points.  This option is ignored if monotone cubic
## interpolation is used.
##
## @end multitable
##
## @seealso{LineChart, Color, Fill}
## @end deftypefn

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

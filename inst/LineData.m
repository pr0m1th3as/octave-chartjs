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
  ## @deftp {chartjs} LineData
  ##
  ## One dataset of a line chart.
  ##
  ## A @qcode{LineChart} holds a @qcode{LineData} object for each of its
  ## datasets, whose properties set how Chart.js draws it.
  ##
  ## Each property is documented on its own, as in @code{help LineData.data}.
  ##
  ## @seealso{LineChart, Color, Fill}
  ## @end deftp

  properties (Access = public)

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} backgroundColor
    ##
    ## Fill color
    ##
    ## A @qcode{Color} object defining the fill color of the lines between data
    ## points.  Default is empty, in which case a color is assigned
    ## automatically by the Chart.js library.
    ##
    ## @end deftp
    backgroundColor           = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} borderCapStyle
    ##
    ## Line end style
    ##
    ## A character vector, which can be either @qcode{'butt'} (default),
    ## @qcode{'round'}, or @qcode{'square'}.  When @qcode{'butt'}, the ends of
    ## lines are squared off at the endpoints.  When @qcode{'round'}, the ends
    ## of lines are rounded.  When @qcode{'square'} is set, the ends of lines
    ## are squared off by adding a box with an equal width and half the height
    ## of the line's thickness.
    ##
    ## @end deftp
    borderCapStyle            = 'butt';

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} borderColor
    ##
    ## Border color
    ##
    ## A @qcode{Color} object defining the color of the lines between data
    ## points.  Default is empty, in which case a color is assigned
    ## automatically by the Chart.js library.
    ##
    ## @end deftp
    borderColor               = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} borderDash
    ##
    ## Dash pattern
    ##
    ## A numeric vector defining the length and spacing of dashes drawn instead
    ## of a line.
    ##
    ## @end deftp
    borderDash                = 0;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} borderDashOffset
    ##
    ## Dash offset
    ##
    ## A numeric scalar defining the offset of dashes and spacing drawn instead
    ## of a line.  Default is 0.
    ##
    ## @end deftp
    borderDashOffset          = 0;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} borderJoinStyle
    ##
    ## Line join style
    ##
    ## A character vector defining the line border join style.  It can be either
    ## @qcode{'round'}, @qcode{'bevel'}, or @qcode{'miter'}.
    ##
    ## @end deftp
    borderJoinStyle           = 'miter';

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} borderWidth
    ##
    ## Border width
    ##
    ## A numeric scalar value defining the width of the line in pixels.  Default
    ## is 3.
    ##
    ## @end deftp
    borderWidth               = 3;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} clip
    ##
    ## Clipping relative to the chart area
    ##
    ## A numeric scalar value defining the pixels to clip relative to the
    ## chart's area.  Positive value allows overflow, negative value clips that
    ## many pixels inside chartArea.  Defaults to zero pixels.
    ##
    ## @end deftp
    clip                      = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} cubicInterpolationMode
    ##
    ## Cubic interpolation mode
    ##
    ## A character vector defining the cubic interpolation mode.  It can be
    ## either @qcode{'default'} or @qcode{'monotonic'}.
    ##
    ## @end deftp
    cubicInterpolationMode    = "default";

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} data
    ##
    ## Data points
    ##
    ## A numeric vector assigned at construction of the @qcode{LineData} object.
    ## It cannot be empty.
    ##
    ## @end deftp
    data                      = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} drawActiveElementsOnTop
    ##
    ## Active elements drawn on top
    ##
    ## A boolean scalar defining whether to draw the active points of a dataset
    ## over the other points of the dataset.  It is @qcode{true} by default.
    ##
    ## @end deftp
    drawActiveElementsOnTop   = true;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} fill
    ##
    ## Filled area
    ##
    ## A @qcode{Fill} object defining how to fill the area under the line.  Type
    ## @code{help Fill} for more details on the available filling modes.  By
    ## default, no filling is applied.
    ##
    ## @end deftp
    fill                      = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} hoverBackgroundColor
    ##
    ## Fill color on hover
    ##
    ## A @qcode{Color} object defining the fill color of the lines between data
    ## points, when the mouse hovers over it.  Default is empty, in which case
    ## the color is the same as in @qcode{backgroundColor}.
    ##
    ## @end deftp
    hoverBackgroundColor      = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} hoverBorderCapStyle
    ##
    ## Line end style on hover
    ##
    ## A character vector, which can be either @qcode{'butt'}, @qcode{'round'},
    ## or @qcode{'square'}, defining the cap style of the line when the mouse
    ## hovers over it.  Default is empty, in which case the cap style is the
    ## same as in @qcode{borderCapStyle}.
    ##
    ## @end deftp
    hoverBorderCapStyle       = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} hoverBorderColor
    ##
    ## Border color on hover
    ##
    ## A @qcode{Color} object defining the color of the lines between data
    ## points, when the mouse hovers over it. Default is empty, in which case
    ## the color is the same as in @qcode{borderColor}.
    ##
    ## @end deftp
    hoverBorderColor          = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} hoverBorderDash
    ##
    ## Dash pattern on hover
    ##
    ## A numeric vector defining the length and spacing of dashes drawn instead
    ## of a line, when the mouse hovers over them.  Default is empty, in which
    ## case the length and spacing of the dashes are the same as in
    ## @qcode{borderDash}.
    ##
    ## @end deftp
    hoverBorderDash           = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} hoverBorderDashOffset
    ##
    ## Dash offset on hover
    ##
    ## A numeric scalar defining the offset of dashes drawn instead of a line,
    ## when the mouse hovers over them. Default is empty, in which case the
    ## offset is the same as in @qcode{borderDashOffset}
    ##
    ## @end deftp
    hoverBorderDashOffset     = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} hoverBorderJoinStyle
    ##
    ## Line join style on hover
    ##
    ## A character vector defining the line border join style, when the mouse
    ## hovers over it.  Default is empty, in which case the line border join
    ## style is the same as in @qcode{borderJoinStyle}
    ##
    ## @end deftp
    hoverBorderJoinStyle      = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} hoverBorderWidth
    ##
    ## Border width on hover
    ##
    ## A numeric scalar value defining the width of the line in pixels, when the
    ## mouse hovers over it.  Default is empty, in which case the width is the
    ## same as in @qcode{borderWidth}.
    ##
    ## @end deftp
    hoverBorderWidth          = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} indexAxis
    ##
    ## Base axis
    ##
    ## A character scalar defining the base axis of the dataset.  It can be
    ## either @qcode{'x'} for horizontal lines or @qcode{'y'} for horizontal
    ## lines.  Default is @qcode{'x'}.
    ##
    ## @end deftp
    indexAxis                 = 'x';

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} label
    ##
    ## Label of the dataset
    ##
    ## A character vector defining the label for the dataset which appears in
    ## the legend and tooltips.  Default is empty. A chart shows no legend when
    ## none of its datasets has a label, and names a dataset without one by its
    ## position, such as @qcode{"Dataset 2"}, when another has one.
    ##
    ## @end deftp
    label                     = '';

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} order
    ##
    ## Drawing order
    ##
    ## A numeric scalar defining the drawing order of the dataset.  It also
    ## affects order for stacking, tooltip and legend. Default is 0.
    ##
    ## @end deftp
    order                     = 0;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointBackgroundColor
    ##
    ## Point fill color
    ##
    ## A @qcode{Color} object defining the fill color for the data points.
    ## Default is empty, in which case a color is assigned automatically by the
    ## Chart.js library.
    ##
    ## @end deftp
    pointBackgroundColor      = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointBorderColor
    ##
    ## Point border color
    ##
    ## A @qcode{Color} object defining the border color for the data points.
    ## Default is empty, in which case a color is assigned automatically by the
    ## Chart.js library.
    ##
    ## @end deftp
    pointBorderColor          = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointBorderWidth
    ##
    ## Point border width
    ##
    ## A numeric scalar value defining the width of the data point border in
    ## pixels.  Default is 1.
    ##
    ## @end deftp
    pointBorderWidth          = 1;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointHitRadius
    ##
    ## Point hit detection radius
    ##
    ## A numeric scalar value defining the pixel size of the non-displayed point
    ## that reacts to mouse events.  Default is 1.
    ##
    ## @end deftp
    pointHitRadius            = 1;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointHoverBackgroundColor
    ##
    ## Point fill color on hover
    ##
    ## A @qcode{Color} object defining the fill color for the data points, when
    ## the mouse hovers over them. Default is empty, in which case the fill
    ## color is the same as in @qcode{pointBackgroundColor}.
    ##
    ## @end deftp
    pointHoverBackgroundColor = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointHoverBorderColor
    ##
    ## Point border color on hover
    ##
    ## A @qcode{Color} object defining the border color for the data point, when
    ## the mouse hovers over it. Default is empty, in which case the border
    ## color is the same as in @qcode{pointBorderColor}.
    ##
    ## @end deftp
    pointHoverBorderColor     = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointHoverBorderWidth
    ##
    ## Point border width on hover
    ##
    ## A numeric scalar value defining the width of the data point border in
    ## pixels, when the mouse hovers over it. Default is 1.
    ##
    ## @end deftp
    pointHoverBorderWidth     = 1;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointHoverRadius
    ##
    ## Point radius on hover
    ##
    ## A numeric scalar value defining the radius of the data point border in
    ## pixels, when the mouse hovers over it. Default is 4.
    ##
    ## @end deftp
    pointHoverRadius          = 4;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointRadius
    ##
    ## Point radius
    ##
    ## A numeric scalar value defining the radius of the data point border in
    ## pixels.  Default is 3.
    ##
    ## @end deftp
    pointRadius               = 3;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointRotation
    ##
    ## Point rotation
    ##
    ## A numeric scalar value defining the rotation of the data point border in
    ## degrees.  Default is 0.
    ##
    ## @end deftp
    pointRotation             = 0;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} pointStyle
    ##
    ## Point style
    ##
    ## A character vector or a boolean value defining the shape of the points of
    ## the dataset.  As a character vector, it can be any of the following
    ## values: @qcode{'circle'}, @qcode{'cross'}, @qcode{'crossRot'},
    ## @qcode{'dash'}, @qcode{'line'}, @qcode{'rect'}, @qcode{'rectRounded'},
    ## @qcode{'rectRot'}, @qcode{'star'}, @qcode{'triangle'}, and
    ## @qcode{'none'}.  By default it is @qcode{'circle}.  As a boolean value,
    ## @qcode{true} defaults to @qcode{'circle'} and @qcode{false} defaults to
    ## @qcode{'none'}.
    ##
    ## @end deftp
    pointStyle                = 'circle';

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} segment
    ##
    ## Line segment styles
    ##
    ## Not supported at the moment: its value is not written to the chart.
    ##
    ## @end deftp
    segment                   = [];     # not supported

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} showLine
    ##
    ## Line drawn
    ##
    ## A boolean scalar defining whether to draw the line for this dataset.  It
    ## is @qcode{true} by default.
    ##
    ## @end deftp
    showLine                  = true;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} spanGaps
    ##
    ## Gaps spanned
    ##
    ## A boolean scalar or a numeric scalar defining whether to create a break
    ## in the line for @qcode{null} data.  When @qcode{true}, lines will be
    ## drawn between points with no or null data.  When @qcode{false}, points
    ## with null data will create a break in the line.  It can also be a number
    ## specifying the maximum gap length to span.  The unit of the value depends
    ## on the scale used.
    ##
    ## @end deftp
    spanGaps                  = [];

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} stack
    ##
    ## Stack group
    ##
    ## A character vector defining the ID of the group to which the dataset
    ## belongs to.
    ##
    ## @end deftp
    stack                     = 'line';

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} stepped
    ##
    ## Stepped interpolation
    ##
    ## A character vector or a boolean value defining the interpolation mode
    ## between data points.  As a character vector, it can be any of the
    ## following values: @qcode{'before'} for step-before interpolation,
    ## @qcode{'after'} for step-after interpolation, and @qcode{'middle'} for
    ## step-middle interpolation.  As a boolean value, @qcode{true} equals to
    ## @qcode{'before'} and @qcode{false}, which is the default value,
    ## corresponds to no step interpolation.  If @qcode{stepped} value is set to
    ## anything other than @qcode{false}, @qcode{tension} will be ignored.
    ##
    ## @end deftp
    stepped                   = false;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} tension
    ##
    ## Curve tension
    ##
    ## A numeric scalar value defining the Bezier curve tension of the line.  By
    ## default it is 0, which corresponds to drawing straight lines between data
    ## points.  This option is ignored if monotone cubic interpolation is used.
    ##
    ## @end deftp
    tension                   = 0;

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} xAxisID
    ##
    ## ID of the x axis
    ##
    ## Not supported at the moment: its value is not written to the chart.
    ##
    ## @end deftp
    xAxisID                   = [];     # not supported

    ## -*- texinfo -*-
    ## @deftp {LineData} {property} yAxisID
    ##
    ## ID of the y axis
    ##
    ## Not supported at the moment: its value is not written to the chart.
    ##
    ## @end deftp
    yAxisID                   = [];     # not supported

  endproperties

  methods (Access = public)

    ## -*- texinfo -*-
    ## @deftypefn  {LineData} {@var{obj} =} LineData (@var{data})
    ##
    ## Create a @qcode{LineData} object.
    ##
    ## @code{@var{obj} = LineData (@var{data})} returns a @qcode{LineData}
    ## object, in which @var{data} must be a nonempty numerical vector
    ## containing the data points of a single dataset to be plotted on a line.
    ## Constructing a @qcode{LineData} object always assigns the default
    ## property values, which can later be modified using dot notation syntax.
    ## @end deftypefn
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

    ## -*- texinfo -*-
    ## @deftypefn  {LineData} {@var{json} =} jsonstring (@var{obj})
    ## @deftypefnx {LineData} {@var{json} =} jsonstring (@var{obj}, @var{mixed})
    ##
    ## Generate the JSON string of a @qcode{LineData} dataset.
    ##
    ## @code{jsonstring (@var{obj})} returns a character vector, @var{json},
    ## holding the dataset in JSON, as Chart.js reads it in the @qcode{datasets}
    ## of a chart.
    ##
    ## @code{jsonstring (@var{obj}, @var{mixed})} also writes the dataset's
    ## chart type when @var{mixed} is @qcode{true}, as a chart mixing types
    ## needs.
    ## @end deftypefn

    function json = jsonstring (this, mixed = false)

      json = __chartjson__ (jsonvalue (this, mixed), jsonpaths ('dataset'));

    endfunction

  endmethods

  methods (Hidden)

    ## The dataset as a structure, with its type for a mixed chart
    function s = jsonvalue (this, mixed = false)

      s = struct ();
      if (mixed)
        s.type = "line";
      endif
      s.data = this.data;
      s = parseDataProperties (s, this);

    endfunction

  endmethods

endclassdef

## Test output
%!assert_equal (jsonstring (LineData ([1, 2])), "{\"data\":[1,2]}")
%!assert_equal (jsonstring (LineData (1)), "{\"data\":[1]}")
%!assert_equal (jsonstring (LineData ([1, 2]), true), ...
%!              "{\"type\":\"line\",\"data\":[1,2]}")

## Test input validation
%!error <LineData: too few input arguments.> LineData ()
%!error <LineData: DATA cannot be empty.> LineData ([])
%!error <LineData: DATA must be a numeric vector.> LineData ("1")
%!error <LineData: DATA must be a numeric vector.> LineData ({1})

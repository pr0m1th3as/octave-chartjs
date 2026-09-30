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

classdef DoughnutData
  ## -*- texinfo -*-
  ## @deftp {chartjs} DoughnutData
  ##
  ## One dataset of a doughnut chart.
  ##
  ## A @qcode{DoughnutChart} holds a @qcode{DoughnutData} object for each of its
  ## datasets, whose properties set how Chart.js draws it.
  ##
  ## Each property is documented on its own, as in @code{help
  ## DoughnutData.data}.
  ##
  ## @seealso{DoughnutChart, Color, Fill}
  ## @end deftp

  properties (Access = public)

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} backgroundColor
    ##
    ## Fill color
    ##
    ## A @qcode{Color} object defining the color of the face of the arc
    ## segments.  Default is empty, in which case and a color is assigned
    ## automatically by the Chart.js library.
    ##
    ## @end deftp
    backgroundColor           = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} borderAlign
    ##
    ## Border alignment
    ##
    ## A character vector, which can be either @qcode{'center'} (default) or
    ## @qcode{'inner'}.  When @qcode{'center'} is set, the borders of arcs next
    ## to each other will overlap.  When @qcode{'inner'} is set, it is
    ## guaranteed that all borders will not overlap.
    ##
    ## @end deftp
    borderAlign               = 'center';

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} borderColor
    ##
    ## Border color
    ##
    ## A @qcode{Color} object defining the color of the border line of the arc
    ## segments.  Default is empty, in which case a color is assigned
    ## automatically by the Chart.js library.
    ##
    ## @end deftp
    borderColor               = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} borderDash
    ##
    ## Dash pattern
    ##
    ## A numeric vector defining the length and spacing of dashes drawn at the
    ## borders of the arc segments.
    ##
    ## @end deftp
    borderDash                = 0;

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} borderDashOffset
    ##
    ## Dash offset
    ##
    ## A numeric scalar defining the offset of dashes drawn at the borders of
    ## the arc segments.  Default is 0.
    ##
    ## @end deftp
    borderDashOffset          = 0;

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} borderJoinStyle
    ##
    ## Line join style
    ##
    ## A character vector defining the arc border join style.  It can be either
    ## @qcode{'round'}, @qcode{'bevel'}, or @qcode{'miter'}.
    ##
    ## @end deftp
    borderJoinStyle           = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} borderRadius
    ##
    ## Corner radius
    ##
    ## A numeric scalar value defining the corner radius of the each arc segment
    ## in pixels.  Default is 0.
    ##
    ## @end deftp
    borderRadius              = 0;

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} borderWidth
    ##
    ## Border width
    ##
    ## A numeric scalar value defining the width of the each arc segment's
    ## borders in pixels.  Default is 2.
    ##
    ## @end deftp
    borderWidth               = 2;

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} circumference
    ##
    ## Sweep of the arcs
    ##
    ## A numeric scalar value, which defines the per-dataset override for the
    ## sweep that the arcs cover.
    ##
    ## @end deftp
    circumference             = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} clip
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
    ## @deftp {DoughnutData} {property} data
    ##
    ## Data points
    ##
    ## A numeric vector assigned at construction of the @qcode{DoughnutData}
    ## object.  It cannot be empty.
    ##
    ## @end deftp
    data                      = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} hoverBackgroundColor
    ##
    ## Fill color on hover
    ##
    ## A @qcode{Color} object defining the color of the face of each arc
    ## segment, when the mouse hovers over it. Default is empty, in which case
    ## the color is the same as in @qcode{backgroundColor}.
    ##
    ## @end deftp
    hoverBackgroundColor      = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} hoverBorderColor
    ##
    ## Border color on hover
    ##
    ## A @qcode{Color} object defining the color of the borders of each arc
    ## segment, when the mouse hovers over it. Default is empty, in which case
    ## the color is the same as in @qcode{borderColor}.
    ##
    ## @end deftp
    hoverBorderColor          = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} hoverBorderDash
    ##
    ## Dash pattern on hover
    ##
    ## A numeric vector defining the length and spacing of dashes drawn at the
    ## borders of the arc segment, when the mouse hovers over it.
    ##
    ## @end deftp
    hoverBorderDash           = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} hoverBorderDashOffset
    ##
    ## Dash offset on hover
    ##
    ## A numeric scalar defining the offset of dashes drawn at the borders of
    ## the arc segment, when the mouse hovers over it.
    ##
    ## @end deftp
    hoverBorderDashOffset     = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} hoverBorderJoinStyle
    ##
    ## Line join style on hover
    ##
    ## A character vector defining the arc border join style, when the mouse
    ## hovers over it.  It can be either @qcode{'round'}, @qcode{'bevel'}, or
    ## @qcode{'miter'}.
    ##
    ## @end deftp
    hoverBorderJoinStyle      = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} hoverBorderWidth
    ##
    ## Border width on hover
    ##
    ## A numeric scalar value defining the width of the each arc segment's
    ## borders in pixels, when the mouse hovers over it.
    ##
    ## @end deftp
    hoverBorderWidth          = [];

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} hoverOffset
    ##
    ## Arc offset on hover
    ##
    ## A numeric scalar value defining the arc offset, when the mouse hovers
    ## over it.  Default is 0.
    ##
    ## @end deftp
    hoverOffset               = 0;

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} offset
    ##
    ## Arc offset
    ##
    ## A numeric scalar defining the arc offset in pixels.  Default is 0.
    ##
    ## @end deftp
    offset                    = 0;

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} rotation
    ##
    ## Rotation
    ##
    ## A numeric scalar defining the starting angle to draw arcs from.  Default
    ## is 0.
    ##
    ## @end deftp
    rotation                  = 0;

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} spacing
    ##
    ## Fixed arc offset
    ##
    ## A numeric scalar defining a fixed arc offset in pixels.  Default is 0.
    ## It is similar to @qcode{offset}, but it applies to all arcs.
    ##
    ## @end deftp
    spacing                   = 0;

    ## -*- texinfo -*-
    ## @deftp {DoughnutData} {property} weight
    ##
    ## Relative thickness
    ##
    ## A numeric scalar value defining the relative thickness of the dataset.
    ## Providing a value for weight will cause the doughnut dataset to be drawn
    ## with a thickness relative to the sum of all the dataset weight values.
    ##
    ## @end deftp
    weight                    = 1;

  endproperties

  methods (Access = public)

    ## -*- texinfo -*-
    ## @deftypefn  {DoughnutData} {@var{obj} =} DoughnutData (@var{data})
    ##
    ## Create a @qcode{DoughnutData} object.
    ##
    ## @code{@var{obj} = DoughnutData (@var{data})} returns a
    ## @qcode{DoughnutData} object, in which @var{data} must be a nonempty
    ## numerical vector containing the proportional arc segments of a single
    ## dataset.  Constructing a @qcode{DoughnutData} object always assigns the
    ## default property values, which can later be modified using dot notation
    ## syntax.
    ## @end deftypefn
    function this = DoughnutData (data)

      ## Check data
      if (nargin < 1)
        error ("DoughnutData: too few input arguments.");
      endif
      if (isempty (data))
        error ("DoughnutData: DATA cannot be empty.");
      endif
      if (! isvector (data) || ! isnumeric (data))
        error ("DoughnutData: DATA must be a numeric vector.");
      endif

      ## Store data
      this.data = data(:)';

    endfunction

    ## -*- texinfo -*-
    ## @deftypefn  {DoughnutData} {@var{json} =} jsonstring (@var{obj})
    ##
    ## Generate the JSON string of a @qcode{DoughnutData} dataset.
    ##
    ## @code{jsonstring (@var{obj})} returns a character vector, @var{json},
    ## holding the dataset in JSON, as Chart.js reads it in the @qcode{datasets}
    ## of a chart.
    ## @end deftypefn

    function json = jsonstring (this)

      json = __chartjson__ (jsonvalue (this), jsonpaths ('dataset'));

    endfunction

  endmethods

  methods (Hidden)

    ## The dataset as a structure
    function s = jsonvalue (this)

      s = struct ();
      s.data = this.data;
      s = parseDataProperties (s, this);

    endfunction

  endmethods

endclassdef

## Test output
%!assert_equal (jsonstring (DoughnutData ([1, 2])), "{\"data\":[1,2]}")
%!assert_equal (jsonstring (DoughnutData (1)), "{\"data\":[1]}")

## Test input validation
%!error <DoughnutData: too few input arguments.> DoughnutData ()
%!error <DoughnutData: DATA cannot be empty.> DoughnutData ([])
%!error <DoughnutData: DATA must be a numeric vector.> DoughnutData ("1")
%!error <DoughnutData: DATA must be a numeric vector.> DoughnutData ({1})

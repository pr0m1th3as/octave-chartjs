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

classdef PolarAreaData
  ## -*- texinfo -*-
  ## @deftp {chartjs} PolarAreaData
  ##
  ## One dataset of a polar area chart.
  ##
  ## A @qcode{PolarAreaChart} holds a @qcode{PolarAreaData} object for each of
  ## its datasets, whose properties set how Chart.js draws it.
  ##
  ## Each property is documented on its own, as in @code{help
  ## PolarAreaData.data}.
  ##
  ## @seealso{PolarAreaChart, Color, Fill}
  ## @end deftp

  properties (Access = public)

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} backgroundColor
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
    ## @deftp {PolarAreaData} {property} borderAlign
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
    ## @deftp {PolarAreaData} {property} borderColor
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
    ## @deftp {PolarAreaData} {property} borderDash
    ##
    ## Dash pattern
    ##
    ## A numeric vector defining the length and spacing of dashes drawn at the
    ## borders of the arc segments.
    ##
    ## @end deftp
    borderDash                = 0;

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} borderDashOffset
    ##
    ## Dash offset
    ##
    ## A numeric scalar defining the offset of dashes drawn at the borders of
    ## the arc segments.  Default is 0.
    ##
    ## @end deftp
    borderDashOffset          = 0;

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} borderJoinStyle
    ##
    ## Line join style
    ##
    ## A character vector defining the arc border join style.  It can be either
    ## @qcode{'round'}, @qcode{'bevel'}, or @qcode{'miter'}.
    ##
    ## @end deftp
    borderJoinStyle           = [];

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} borderWidth
    ##
    ## Border width
    ##
    ## A numeric scalar value defining the width of the each arc segment's
    ## borders in pixels.  Default is 2.
    ##
    ## @end deftp
    borderWidth               = 2;

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} circular
    ##
    ## Curved or flat arcs
    ##
    ## A boolean scalar value defining whether the arc will be curved or flat.
    ## By default, it is @qcode{true} corresponding to curved arc segments.
    ##
    ## @end deftp
    circular                  = true;

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} clip
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
    ## @deftp {PolarAreaData} {property} data
    ##
    ## Data points
    ##
    ## A numeric vector assigned at construction of the @qcode{PolarAreaData}
    ## object.  It cannot be empty.
    ##
    ## @end deftp
    data                      = [];

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} hoverBackgroundColor
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
    ## @deftp {PolarAreaData} {property} hoverBorderColor
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
    ## @deftp {PolarAreaData} {property} hoverBorderDash
    ##
    ## Dash pattern on hover
    ##
    ## A numeric vector defining the length and spacing of dashes drawn at the
    ## borders of the arc segment, when the mouse hovers over it.
    ##
    ## @end deftp
    hoverBorderDash           = [];

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} hoverBorderDashOffset
    ##
    ## Dash offset on hover
    ##
    ## A numeric scalar defining the offset of dashes drawn at the borders of
    ## the arc segment, when the mouse hovers over it.
    ##
    ## @end deftp
    hoverBorderDashOffset     = [];

    ## -*- texinfo -*-
    ## @deftp {PolarAreaData} {property} hoverBorderJoinStyle
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
    ## @deftp {PolarAreaData} {property} hoverBorderWidth
    ##
    ## Border width on hover
    ##
    ## A numeric scalar value defining the width of the each arc segment's
    ## borders in pixels, when the mouse hovers over it.
    ##
    ## @end deftp
    hoverBorderWidth          = [];

  endproperties

  methods (Access = public)

    ## -*- texinfo -*-
    ## @deftypefn  {PolarAreaData} {@var{obj} =} PolarAreaData (@var{data})
    ##
    ## Create a @qcode{PolarAreaData} object.
    ##
    ## @code{@var{obj} = PolarAreaData (@var{data})} returns a
    ## @qcode{PolarAreaData} object, in which @var{data} must be a nonempty
    ## numerical vector containing the radii of the arc segments of a single
    ## dataset.  Constructing a @qcode{PolarAreaData} object always assigns the
    ## default property values, which can later be modified using dot notation
    ## syntax.
    ## @end deftypefn
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

    ## -*- texinfo -*-
    ## @deftypefn  {PolarAreaData} {@var{json} =} jsonstring (@var{obj})
    ##
    ## Generate the JSON string of a @qcode{PolarAreaData} dataset.
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
%!assert_equal (jsonstring (PolarAreaData ([1, 2])), "{\"data\":[1,2]}")
%!assert_equal (jsonstring (PolarAreaData (1)), "{\"data\":[1]}")

## Test input validation
%!error <PolarAreaData: too few input arguments.> PolarAreaData ()
%!error <PolarAreaData: DATA cannot be empty.> PolarAreaData ([])
%!error <PolarAreaData: DATA must be a numeric vector.> PolarAreaData ("1")
%!error <PolarAreaData: DATA must be a numeric vector.> PolarAreaData ({1})

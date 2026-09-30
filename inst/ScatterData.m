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

classdef ScatterData
  ## -*- texinfo -*-
  ## @deftp {chartjs} ScatterData
  ##
  ## One dataset of a scatter chart.
  ##
  ## A @qcode{ScatterChart} holds a @qcode{ScatterData} object for each of its
  ## datasets, whose properties set how Chart.js draws it.
  ##
  ## Each property is documented on its own, as in @code{help ScatterData.data}.
  ##
  ## @seealso{ScatterChart, Color, Fill}
  ## @end deftp

  properties (Access = public)

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} backgroundColor
    ##
    ## Fill color
    ##
    ## A @qcode{Color} object defining the color of the face of the bubbles.
    ## Default is empty, in which case and a color is assigned automatically by
    ## the Chart.js library.
    ##
    ## @end deftp
    backgroundColor           = [];

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} borderColor
    ##
    ## Border color
    ##
    ## A @qcode{Color} object defining the color of the border circle of the
    ## bubbles.  Default is empty, in which case a color is assigned
    ## automatically by the Chart.js library.
    ##
    ## @end deftp
    borderColor               = [];

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} borderWidth
    ##
    ## Border width
    ##
    ## A numeric scalar value defining the width of the bubble's borders in
    ## pixels.  Default is 3.
    ##
    ## @end deftp
    borderWidth               = 3;

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} clip
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
    ## @deftp {ScatterData} {property} data
    ##
    ## Data points
    ##
    ## A numeric matrix assigned at construction of the @qcode{ScatterData}
    ## object.  It cannot be empty.
    ##
    ## @end deftp
    data                      = [];

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} drawActiveElementsOnTop
    ##
    ## Active elements drawn on top
    ##
    ## A boolean scalar defining whether to draw the active bubbles of a dataset
    ## over the other bubbles of the dataset.  It is @qcode{true} by default.
    ##
    ## @end deftp
    drawActiveElementsOnTop   = true;

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} hoverBackgroundColor
    ##
    ## Fill color on hover
    ##
    ## A @qcode{Color} object defining the color of the bubble face, when the
    ## mouse hovers over it.  Default is empty, in which case the color is the
    ## same as in @qcode{backgroundColor}.
    ##
    ## @end deftp
    hoverBackgroundColor      = [];

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} hoverBorderColor
    ##
    ## Border color on hover
    ##
    ## A @qcode{Color} object defining the color of the borders of each bubble,
    ## when the mouse hovers over it. Empty by default, in which case the color
    ## is the same as in @qcode{borderColor}.
    ##
    ## @end deftp
    hoverBorderColor          = [];

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} hoverBorderWidth
    ##
    ## Border width on hover
    ##
    ## A numeric scalar value defining the width of the each bubble's borders in
    ## pixels, when the mouse hovers over it. Default is 1.
    ##
    ## @end deftp
    hoverBorderWidth          = 1;

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} hoverRadius
    ##
    ## Radius on hover
    ##
    ## A numeric scalar value defining the radius of the each bubble in pixels,
    ## when the mouse hovers over it.  Default is 4.
    ##
    ## @end deftp
    hoverRadius               = 4;

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} hitRadius
    ##
    ## Hit detection radius
    ##
    ## A numeric scalar value defining the additional radius for hit detection
    ## in pixels.  Default is 1.
    ##
    ## @end deftp
    hitRadius                 = 1;

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} label
    ##
    ## Label of the dataset
    ##
    ## A character vector defining the label of the dataset which appears in the
    ## legend and tooltips. A chart shows no legend when none of its datasets
    ## has a label, and names a dataset without one by its position, such as
    ## @qcode{"Dataset 2"}, when another has one.
    ##
    ## @end deftp
    label                     = '';

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} order
    ##
    ## Drawing order
    ##
    ## A numeric scalar defining the order of the dataset, which affects order
    ## for stacking, tooltip and legend.
    ##
    ## @end deftp
    order                     = 0;

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} pointStyle
    ##
    ## Point style
    ##
    ## A character vector or a boolean value defining the shape of the bubbles
    ## of the dataset.  As a character vector, it can be any of the following
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
    ## @deftp {ScatterData} {property} radius
    ##
    ## Radius
    ##
    ## A numeric scalar defining the bubble radius for the entire dataset.
    ##
    ## @end deftp
    radius                    = 3;

    ## -*- texinfo -*-
    ## @deftp {ScatterData} {property} rotation
    ##
    ## Rotation
    ##
    ## A numeric scalar defining the bubble rotation in degrees.
    ##
    ## @end deftp
    rotation                  = 0;

  endproperties

  methods (Access = public)

    ## -*- texinfo -*-
    ## @deftypefn  {ScatterData} {@var{obj} =} ScatterData (@var{data})
    ##
    ## Create a @qcode{ScatterData} object.
    ##
    ## @code{@var{obj} = ScatterData (@var{data})} returns a @qcode{ScatterData}
    ## object, in which @var{data} must be an @math{Nx2} numeric matrix with
    ## each column defining the @qcode{x-axis} and the @qcode{y-axis} of each
    ## element of a single dataset, respectively.  Constructing a
    ## @qcode{ScatterData} object always assigns the default property values,
    ## which can later be modified using dot notation syntax.
    ## @end deftypefn
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

    ## -*- texinfo -*-
    ## @deftypefn  {ScatterData} {@var{json} =} jsonstring (@var{obj})
    ## @deftypefnx {ScatterData} {@var{json} =} jsonstring (@var{obj}, @var{mixed})
    ##
    ## Generate the JSON string of a @qcode{ScatterData} dataset.
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
        s.type = "scatter";
      endif
      s.data = struct ("x", num2cell (this.data(:,1)),
                       "y", num2cell (this.data(:,2)));
      s = parseDataProperties (s, this);

    endfunction

  endmethods

endclassdef

## Test output
%!test
%! json = "{\"type\":\"scatter\",\"data\":[{\"x\":1,\"y\":2}]}";
%! assert_equal (jsonstring (ScatterData ([1, 2]), true), json);
%!assert_equal (jsonstring (ScatterData ([1, 2])), ...
%!              "{\"data\":[{\"x\":1,\"y\":2}]}")

## Test input validation
%!error <ScatterData: too few input arguments.> ScatterData ()
%!error <ScatterData: DATA cannot be empty.> ScatterData ([])
%!error <ScatterData: DATA must be a numeric matrix.> ScatterData ({1, 23})
%!error <ScatterData: DATA must be a numeric matrix.> ScatterData ("ASD")
%!error <ScatterData: DATA must have two columns for X and Y.> ...
%! ScatterData ([1])

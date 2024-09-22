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

classdef BubbleData
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} BubbleData (@var{data})
##
## Create a @qcode{BubbleData} object.
##
## @code{@var{obj} = BubbleData (@var{data})} returns a @qcode{BubbleData}
## object, in which @var{data} must be an @math{Nx3} numeric matrix with each
## column defining the @qcode{x-axis}, the @qcode{y-axis}, and the radius of
## each element of a single dataset.  Constructing a @qcode{BubbleData} object
## always assigns the default property values, which can later be modified using
## dot notation syntax.
##
## A @qcode{BubbleData} object, @var{obj}, contains the following properties:
##
## @multitable @columnfractions 0.23 0.02 0.75
## @headitem @var{Field} @tab @tab @var{Description}
##
## @item @qcode{backgroundColor} @tab @tab A @qcode{Color} object defining the
## color of the face of the bubbles.  Default is empty, in which case and a
## color is assigned automatically by the Chart.js library.
##
## @item @qcode{borderColor} @tab @tab A @qcode{Color} object defining the color
## of the border circle of the bubbles.  Default is empty, in which case a color
## is assigned automatically by the Chart.js library.
##
## @item @qcode{borderWidth} @tab @tab A numeric scalar value defining the width
## of the bubble's borders in pixels.  Default is 3.
##
## @item @qcode{clip} @tab @tab A numeric scalar value defining the pixels to
## clip relative to the chart's area.  Positive value allows overflow, negative
## value clips that many pixels inside chartArea.  Defaults to zero pixels.
##
## @item @qcode{data} @tab @tab A numeric matrix assigned at construction of the
## @qcode{BubbleData} object.  It cannot be empty.
##
## @item @qcode{drawActiveElementsOnTop} @tab @tab A boolean scalar defining
## whether to draw the active bubbles of a dataset over the other bubbles of the
## dataset.  It is @qcode{true} by default.
##
## @item @qcode{hoverBackgroundColor} @tab @tab A @qcode{Color} object defining
## the color of the bubble face, when the mouse hovers over it.  Default is
## empty, in which case the color is the same as in @qcode{backgroundColor}.
##
## @item @qcode{hoverBorderColor} @tab @tab A @qcode{Color} object defining
## the color of the borders of each bubble, when the mouse hovers over it. Empty
## by default, in which case the color is the same as in @qcode{borderColor}.
##
## @item @qcode{hoverBorderWidth} @tab @tab A numeric scalar value defining the
## width of the each bubble's borders in pixels, when the mouse hovers over it.
## Default is 1.
##
## @item @qcode{hoverRadius} @tab @tab A numeric scalar value defining the
## radius of the each bubble in pixels, when the mouse hovers over it.  Default
## is 4.
##
## @item @qcode{hitRadius} @tab @tab A numeric scalar value defining the
## additional radius for hit detection in pixels.  Default is 1.
##
## @item @qcode{label} @tab @tab A character vector defining the label of the
## dataset which appears in the legend and tooltips.
##
## @item @qcode{order} @tab @tab A numeric scalar defining the order of the
## dataset, which affects order for stacking, tooltip and legend.
##
## @item @qcode{pointStyle} @tab @tab A character vector or a boolean value
## defining the shape of the bubbles of the dataset.  As a character vector, it
## can be any of the following values: @code{circle}, @code{cross},
## @code{crossRot}, @code{dash}, @code{line}, @code{rect}, @code{rectRounded},
## @code{rectRot}, @code{star}, @code{triangle}, and @code{none}.  By default it
## is @code{circle}.  As a boolean value, @qcode{true} defaults to @code{circle}
## and @qcode{true} defaults to @code{none}.
##
## @item @qcode{radius} @tab @tab A numeric scalar defining the bubble radius
## for the entire dataset.
##
## @item @qcode{rotation} @tab @tab A numeric scalar defining the bubble
## rotation in degrees.
##
## @end multitable
##
## @seealso{BubbleChart, Color, Fill}
## @end deftypefn

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
      if (nargin < 1)
        error ("BubbleData: too few input arguments.");
      endif
      if (isempty (data))
        error ("BubbleData: DATA cannot be empty.");
      endif
      if (! ismatrix (data) || ! isnumeric (data))
        error ("BubbleData: DATA must be a numeric matrix.");
      endif
      if (size (data, 2) != 3)
        error ("BubbleData: DATA must have three columns for X, Y, and R.");
      endif

      ## Store data
      this.data = data;

    endfunction

    ## -*- texinfo -*-
    ## @deftypefn  {BubbleData} {@var{json} =} jsonstring (@var{obj})
    ##
    ## Generate the JSON string from a @qcode{BubbleData} object.
    ##
    ## @code{jsonstring (@var{obj})} returns a character vector, @var{json},
    ## describing the context of the BubbleData dataset in json format.
    ##
    ## @seealso{BubbleData, BubbleChart}
    ## @end deftypefn

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

## Test input validation
%!error <BubbleData: too few input arguments.> BubbleData ()
%!error <BubbleData: DATA cannot be empty.> BubbleData ([])
%!error <BubbleData: DATA must be a numeric matrix.> BubbleData ({1, 2, 3})
%!error <BubbleData: DATA must be a numeric matrix.> BubbleData ("ASD")
%!error <BubbleData: DATA must have three columns for X, Y, and R.> ...
%! BubbleData ([1, 2])

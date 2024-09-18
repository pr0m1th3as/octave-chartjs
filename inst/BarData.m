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

classdef BarData
## -*- texinfo -*-
## @deftypefn  {octave-chartjs} {@var{obj} =} BarData (@var{data})
##
## Create a @qcode{BarData} object.
##
## @code{@var{obj} = BarData (@var{data})} returns a BarData object, in which
## @var{data} must be a nonempty numerical vector containing the bar heights of
## a single dataset.  Constructing a @qcode{BarData} object always assigns the
## default property values, which can later be modified using dot notation
## syntax.
##
## A @qcode{BarData} object, @var{obj}, contains the following properties:
##
## @multitable @columnfractions 0.23 0.02 0.75
## @headitem @var{Field} @tab @tab @var{Description}
##
## @item @qcode{backgroundColor} @tab @tab A @qcode{Color} object defining the
## color of the face of each bar.  Default is empty, in which case and a color
## is assigned automatically by the Chart.js library.
##
## @item @qcode{base} @tab @tab A numeric scalar value.  It defines the base
## value for the bar in data units along the value axis (the @qcode{y-axis} by
## default).
##
## @item @qcode{barPercentage} @tab @tab A numeric scalar value.  It defines the
## percent, in the range @math{[0-1]}, of the available width each bar should be
## within the category width.  @code{barPercentage = 1.0} will take the whole
## category width and put the bars right next to each other.
##
## @item @qcode{barThickness} @tab @tab Either a numeric scalar or a character
## vector.  When numeric, it defines the width of each bar in pixels, in which
## case @qcode{barPercentage} and @qcode{categoryPercentage} properties are
## ignored.  If set to @qcode{'flex'}, the base sample widths are calculated
## automatically based on the previous and following samples so that they take
## the full available widths without overlap.  Then, bars are sized using the
## @qcode{barPercentage} and @qcode{categoryPercentage} properties.  There is no
## gap when the percentage options are 1.  This mode generates bars with
## different widths when data are not evenly spaced.  By default it is empty, in
## which case the base sample widths are calculated using the smallest interval
## that prevents bar overlapping, and bars are sized using @qcode{barPercentage}
## and @qcode{categoryPercentage} properties.  This mode always generates bars
## equally sized.
##
## @item @qcode{borderColor} @tab @tab A @qcode{Color} object defining the color
## of the border line of each bar.  Default is empty, in which case a color is
## assigned automatically by the Chart.js library.
##
## @item @qcode{borderSkipped} @tab @tab A boolean scalar or a character vector.
## This setting is used to avoid drawing any given border of each bar.  As a
## boolean value, @qcode{false} does not skip any borders and @qcode{true} skips
## drawing all borders.  As a character vector, it can take any of the following
## values: @qcode{'start'}, @qcode{'end'}, @qcode{'middle'}, @qcode{'bottom'},
## @qcode{'left'}, @qcode{'top'}, and @qcode{'right'}.  @qcode{'middle'} is only
## valid on stacked bars, in which case the borders between stacked bars are
## skipped.
##
## @item @qcode{borderWidth} @tab @tab A numeric scalar value defining the width
## of the each bar's borders in pixels.  Omitted borders as defined by the
## @qcode{borderSkipped} property are unaffected.
##
## @item @qcode{borderRadius} @tab @tab A numeric scalar value defining the
## corner radius of the each bar in pixels.  Omitted borders as defined by the
## @qcode{borderSkipped} property are unaffected.
##
## @item @qcode{categoryPercentage} @tab @tab A numeric scalar value, which
## defines the percent, in the range @math{[0-1]}, of the available width each
## category should be within the sample width.
##
## @item @qcode{clip} @tab @tab A numeric scalar value defining the pixels to
## clip relative to the chart's area.  Positive value allows overflow, negative
## value clips that many pixels inside chartArea.  Defaults to zero pixels.
##
## @item @qcode{data} @tab @tab A numeric vector assigned at construction of the
## @qcode{BarData} object.  It cannot be empty.
##
## @item @qcode{grouped} @tab @tab
##
## @item @qcode{hoverBackgroundColor} @tab @tab
##
## @item @qcode{hoverBorderColor} @tab @tab
##
## @item @qcode{hoverBorderWidth} @tab @tab
##
## @item @qcode{hoverBorderRadius} @tab @tab
##
## @item @qcode{indexAxis} @tab @tab
##
## @item @qcode{inflateAmount} @tab @tab
##
## @item @qcode{label} @tab @tab
##
## @item @qcode{maxBarThickness} @tab @tab
##
## @item @qcode{minBarLength} @tab @tab
##
## @item @qcode{order} @tab @tab
##
## @item @qcode{skipNull} @tab @tab
##
## @item @qcode{stack} @tab @tab
##
## @end multitable
##
## @seealso{BarChart, Color, Fill}
## @end deftypefn

  properties (Access = public)

    backgroundColor           = [];
    base                      = [];
    barPercentage             = 0.9;
    barThickness              = [];
    borderColor               = [];
    borderSkipped             = 'start';
    borderWidth               = 0;
    borderRadius              = 0;
    categoryPercentage        = 0.8;
    clip                      = [];
    data                      = [];
    grouped                   = true;
    hoverBackgroundColor      = [];
    hoverBorderColor          = [];
    hoverBorderWidth          = 1;
    hoverBorderRadius         = 0;
    indexAxis                 = 'x';
    inflateAmount             = 'auto';
    label                     = '';
    maxBarThickness           = [];
    minBarLength              = [];
    order                     = 0;
    skipNull                  = [];
    stack                     = 'bar';

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = BarData (data)

      ## Check data
      if (nargin < 1)
        error ("BarData: too few input arguments.");
      endif
      if (isempty (data))
        error ("BarData: DATA cannot be empty.");
      endif
      if (! isvector (data) || ! isnumeric (data))
        error ("BarData: DATA must be a numeric vector.");
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
        json = [json, "type: 'bar',\n      "];
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
%!error <BarData: too few input arguments.> BarData ()
%!error <BarData: DATA cannot be empty.> BarData ([])
%!error <BarData: DATA must be a numeric vector.> BarData ("1")
%!error <BarData: DATA must be a numeric vector.> BarData ({1})

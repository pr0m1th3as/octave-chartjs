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

classdef BarData
  ## -*- texinfo -*-
  ## @deftp {chartjs} BarData
  ##
  ## One dataset of a bar chart.
  ##
  ## A @qcode{BarChart} holds a @qcode{BarData} object for each of its datasets,
  ## whose properties set how Chart.js draws it.
  ##
  ## Each property is documented on its own, as in @code{help BarData.data}.
  ##
  ## @seealso{BarChart, Color, Fill}
  ## @end deftp

  properties (Access = public)

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} backgroundColor
    ##
    ## Fill color
    ##
    ## A @qcode{Color} object defining the color of the face of the bars.
    ## Default is empty, in which case and a color is assigned automatically by
    ## the Chart.js library.
    ##
    ## @end deftp
    backgroundColor           = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} base
    ##
    ## Base value of the bars
    ##
    ## A numeric scalar value.  It defines the base value for the bar in data
    ## units along the value axis (the @qcode{y-axis} by default).
    ##
    ## @end deftp
    base                      = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} barPercentage
    ##
    ## Bar width within its category
    ##
    ## A numeric scalar value.  It defines the percent, in the range
    ## @math{[0-1]}, of the available width each bar should be within the
    ## category width.  @code{barPercentage = 1.0} will take the whole category
    ## width and put the bars right next to each other.
    ##
    ## @end deftp
    barPercentage             = 0.9;

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} barThickness
    ##
    ## Bar thickness
    ##
    ## Either a numeric scalar or a character vector.  When numeric, it defines
    ## the width of each bar in pixels, in which case @qcode{barPercentage} and
    ## @qcode{categoryPercentage} properties are ignored.  If set to
    ## @qcode{'flex'}, the base sample widths are calculated automatically based
    ## on the previous and following samples so that they take the full
    ## available widths without overlap.  Then, bars are sized using the
    ## @qcode{barPercentage} and @qcode{categoryPercentage} properties.  There
    ## is no gap when the percentage options are 1.  This mode generates bars
    ## with different widths when data are not evenly spaced.  By default it is
    ## empty, in which case the base sample widths are calculated using the
    ## smallest interval that prevents bar overlapping, and bars are sized using
    ## @qcode{barPercentage} and @qcode{categoryPercentage} properties.  This
    ## mode always generates bars equally sized.
    ##
    ## @end deftp
    barThickness              = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} borderColor
    ##
    ## Border color
    ##
    ## A @qcode{Color} object defining the color of the border line of the bars.
    ## Default is empty, in which case a color is assigned automatically by the
    ## Chart.js library.
    ##
    ## @end deftp
    borderColor               = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} borderSkipped
    ##
    ## Borders left undrawn
    ##
    ## A boolean scalar or a character vector. This setting is used to avoid
    ## drawing any given border of each bar.  As a boolean value, @qcode{false}
    ## does not skip any borders and @qcode{true} skips drawing all borders.  As
    ## a character vector, it can take any of the following values:
    ## @qcode{'start'}, @qcode{'end'}, @qcode{'middle'}, @qcode{'bottom'},
    ## @qcode{'left'}, @qcode{'top'}, and @qcode{'right'}.  @qcode{'middle'} is
    ## only valid on stacked bars, in which case the borders between stacked
    ## bars are skipped.
    ##
    ## @end deftp
    borderSkipped             = 'start';

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} borderWidth
    ##
    ## Border width
    ##
    ## A numeric scalar value defining the width of the each bar's borders in
    ## pixels.  Omitted borders as defined by the @qcode{borderSkipped} property
    ## are unaffected.
    ##
    ## @end deftp
    borderWidth               = 0;

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} borderRadius
    ##
    ## Corner radius
    ##
    ## A numeric scalar value defining the corner radius of the each bar in
    ## pixels.  Omitted borders as defined by the @qcode{borderSkipped} property
    ## are unaffected.
    ##
    ## @end deftp
    borderRadius              = 0;

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} categoryPercentage
    ##
    ## Category width
    ##
    ## A numeric scalar value, which defines the percent, in the range
    ## @math{[0-1]}, of the available width each category should be within the
    ## sample width.
    ##
    ## @end deftp
    categoryPercentage        = 0.8;

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} clip
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
    ## @deftp {BarData} {property} data
    ##
    ## Data points
    ##
    ## A numeric vector assigned at construction of the @qcode{BarData} object.
    ## It cannot be empty.
    ##
    ## @end deftp
    data                      = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} grouped
    ##
    ## Grouping of the bars
    ##
    ## A boolean scalar defining how the bars are grouped on the index axis (the
    ## @qcode{x-axis} by default).  When @qcode{true}, all the datasets at same
    ## index value will be placed next to each other centering on that index
    ## value.  When @qcode{false}, each bar is placed on its actual index-axis
    ## value.
    ##
    ## @end deftp
    grouped                   = true;

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} hoverBackgroundColor
    ##
    ## Fill color on hover
    ##
    ## A @qcode{Color} object defining the color of the face of each bar, when
    ## the mouse hovers over it.  Default is empty, in which case the color is
    ## the same as in @qcode{backgroundColor}.
    ##
    ## @end deftp
    hoverBackgroundColor      = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} hoverBorderColor
    ##
    ## Border color on hover
    ##
    ## A @qcode{Color} object defining the color of the borders of each bar,
    ## when the mouse hovers over it.  Default is empty, in which case the color
    ## is the same as in @qcode{borderColor}.
    ##
    ## @end deftp
    hoverBorderColor          = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} hoverBorderWidth
    ##
    ## Border width on hover
    ##
    ## A numeric scalar value defining the width of the each bar's borders in
    ## pixels, when the mouse hovers over it. Omitted borders as defined by the
    ## @qcode{borderSkipped} property are unaffected.
    ##
    ## @end deftp
    hoverBorderWidth          = 1;

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} hoverBorderRadius
    ##
    ## Corner radius on hover
    ##
    ## A numeric scalar value defining the corner radius of the each bar in
    ## pixels, when the mouse hovers over it. Omitted borders as defined by the
    ## @qcode{borderSkipped} property are unaffected.
    ##
    ## @end deftp
    hoverBorderRadius         = 0;

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} indexAxis
    ##
    ## Base axis
    ##
    ## A character vector defining the base axis of the dataset.  @qcode{'x'}
    ## defines a vertical bar chart (default) and @qcode{'y'} defines a
    ## horizontal bar chart
    ##
    ## @end deftp
    indexAxis                 = 'x';

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} inflateAmount
    ##
    ## Inflation of the bars
    ##
    ## Either a numeric scalar or a character vector.  When numeric, it defines
    ## the amount to inflate the rectangulars used to draw the bars.  This is
    ## useful for hiding artifacts between bars when @math{@qcode{barPercentage}
    ## * @qcode{categoryPercentage} = 1}.  The default value is @qcode{'auto'},
    ## which should work in most cases.
    ##
    ## @end deftp
    inflateAmount             = 'auto';

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} label
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
    ## @deftp {BarData} {property} maxBarThickness
    ##
    ## Maximum bar thickness
    ##
    ## A numeric scalar value defining the maximum thickness of the bars in
    ## pixels.
    ##
    ## @end deftp
    maxBarThickness           = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} minBarLength
    ##
    ## Minimum bar length
    ##
    ## A numeric scalar value defining the minimum height of the bars in pixels.
    ##
    ## @end deftp
    minBarLength              = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} order
    ##
    ## Drawing order
    ##
    ## A numeric scalar defining the order of the dataset, which affects order
    ## for stacking, tooltip and legend.
    ##
    ## @end deftp
    order                     = 0;

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} skipNull
    ##
    ## Null values skipped
    ##
    ## A boolean scalar.  If @qcode{true} or empty (default), the null or
    ## undefined values in @var{data} will not be used for spacing calculations
    ## when determining bar size.
    ##
    ## @end deftp
    skipNull                  = [];

    ## -*- texinfo -*-
    ## @deftp {BarData} {property} stack
    ##
    ## Stack group
    ##
    ## A character vector defining the ID of the group which this dataset
    ## belongs to (when stacked, each group will be a separate stack).
    ##
    ## @end deftp
    stack                     = 'bar';

  endproperties

  methods (Access = public)

    ## -*- texinfo -*-
    ## @deftypefn  {BarData} {@var{obj} =} BarData (@var{data})
    ##
    ## Create a @qcode{BarData} object.
    ##
    ## @code{@var{obj} = BarData (@var{data})} returns a @qcode{BarData} object,
    ## in which @var{data} must be a nonempty numerical vector containing the
    ## bar heights of a single dataset.  Constructing a @qcode{BarData} object
    ## always assigns the default property values, which can later be modified
    ## using dot notation syntax.
    ## @end deftypefn
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

    ## -*- texinfo -*-
    ## @deftypefn  {BarData} {@var{json} =} jsonstring (@var{obj})
    ## @deftypefnx {BarData} {@var{json} =} jsonstring (@var{obj}, @var{mixed})
    ##
    ## Generate the JSON string of a @qcode{BarData} dataset.
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
        s.type = "bar";
      endif
      s.data = this.data;
      s = parseDataProperties (s, this);

    endfunction

  endmethods

endclassdef

## Test output
%!assert_equal (jsonstring (BarData ([1, 2])), "{\"data\":[1,2]}")
%!assert_equal (jsonstring (BarData (1)), "{\"data\":[1]}")
%!assert_equal (jsonstring (BarData ([1, 2]), true), ...
%!              "{\"type\":\"bar\",\"data\":[1,2]}")

## Test input validation
%!error <BarData: too few input arguments.> BarData ()
%!error <BarData: DATA cannot be empty.> BarData ([])
%!error <BarData: DATA must be a numeric vector.> BarData ("1")
%!error <BarData: DATA must be a numeric vector.> BarData ({1})

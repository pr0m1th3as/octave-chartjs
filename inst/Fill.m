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

classdef Fill
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} Fill (@var{value})
## @deftypefnx {chartjs} {@var{obj} =} Fill (@var{value}, @var{toaxis})
## @deftypefnx {chartjs} {@var{obj} =} Fill (@var{value}, @var{toaxis}, @var{above})
## @deftypefnx {chartjs} {@var{obj} =} Fill (@var{value}, @var{toaxis}, @var{above}, @var{below})
##
## A class for creating Chart.js compatible Fill objects.
##
## Both @qcode{LineChart} and @qcode{RadarChart} objects support a fill option
## on their respective dataset object which can be used to create space between
## two datasets or a dataset and a boundary.  The created space can be filled
## with a @qcode{Color} object, essentially transforming line and radar charts
## into an area chart.
##
## @code{@var{obj} = Fill (@var{value})} returns a @qcode{Fill} object defined
## by @var{value}, which can either be a character vector or a numeric scalar.
## The following filling modes are supported.
##
## @multitable @columnfractions 0.33 0.02 0.65
## @headitem @var{Mode} @tab @tab @var{Values}
##
## @item Absolute dataset index @tab @tab A numeric scalar indexing another
## dataset as a boundary to constrain the created area.
##
## @item Relative dataset index @tab @tab A character vector of the form
## @qcode{'-1', '-2', '+1', @dots{}} indexing another dataset as a boundary to
## constrain the created area relative to the position of the referencing
## dataset.
##
## @item Boundary @tab @tab A character vector with acceptable values
## @qcode{'start'}, @qcode{'end'}, and @qcode{'origin'} which sets the boundary
## of the created area to the start, the end, or the origin of the data axis,
## respectively.
##
## @item Disabled @tab @tab A boolean scalar value.  When @qcode{true}, it is
## equivalent to @qcode{'origin'}.  When @qcode{true}, the area is not created.
##
## @item Shape @tab @tab A character vector @qcode{'shape'} which creates an
## area inside the line by connecting its end points.
##
## @item Axis value @tab @tab A numeric scalar, which references a value on the
## data axis to be used as a boundary.  To use this option, the second input
## argument @var{toaxis} must be set to @qcode{true}.
## @end multitable
##
## @code{@var{obj} = Fill (@var{value}, @var{toaxis})} returns a @qcode{Fill}
## object using the previously described syntaxes, while @var{toaxis} defines
## whether the numeric value assigned to @var{value} references an absolute
## dataset index (default: @qcode{@var{toaxis} = false}) or a value along the
## data axis (@qcode{@var{toaxis} = true} which sets a line to be used as a
## boundary.  When @var{toaxis} is set to @qcode{true}, @var{value} must be a
## numeric scalar.  Passing an empty matrix to @var{toaxis}, results to the
## default value (@qcode{@var{toaxis} = false}).
##
## @code{@var{obj} = Fill (@var{value}, @var{toaxis}, @var{above})} returns a
## @qcode{Fill} object with an area created according to any of the previous
## syntaxes, which is filled with the color defined in @var{above}.  @var{above}
## can be a @qcode{Color} object defining a single color.  Alternatively, the
## input value to the @qcode{Color} object can be passed directly to the
## @var{above} input argument.
##
## @code{@var{obj} = Fill (@var{value}, @var{toaxis}, @var{above}, @var{below})}
## returns a @qcode{Fill} object with an area created according to any of the
## previous syntaxes, and the area below the target value (as defined by the
## @var{value} and @var{toaxis} arguments) is filled with the color defined in
## @var{below}.  Similarly to @var{above}, @var{below} can be a @qcode{Color}
## object defining a single color.  Alternatively, the input value to the
## @qcode{Color} object can be passed directly to the @var{below} input
## argument.
##
## @seealso{LineChart, LineData, RadarChart, RadarData}
## @end deftypefn

  properties (SetAccess = protected)

    target           = [];
    above            = [];
    below            = [];

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = Fill (value, toaxis = false, above = [], below = [])

      ## Check value
      if (nargin < 1)
        error ("Fill: too few input arguments.");
      endif
      if (isempty (value))
        error ("Fill: VALUE cannot be empty.");
      endif
      if (! isscalar (value) && isnumeric (value))
        error ("Fill: numeric VALUE must be a scalar.");
      endif

      ## Check toaxis
      if (isempty (toaxis))
        toaxis = false;
      endif
      if (! isbool (toaxis) || ! isscalar (toaxis))
        error ("Fill: TOAXIS must be a boolean scalar.");
      endif

      ## Store 'target' property
      if (toaxis)
        if (! isnumeric (value))
          error ("Fill: VALUE must be numeric when TOAXIS is true.");
        endif
        this.target = sprintf ("{value: %d}", value);
      else
        if (isbool (value))
          if (value)
            this.target = "true";
          else
            this.target = "false";
          endif
        elseif (isnumeric (value))
          if (value < 0 || round (value) != value)
            error (strcat (["Fill: VALUE for absolute indexing"], ...
                           [" must be a nonnegative integer."]));
          endif
          this.target = sprintf ("%i", value);
        elseif (ischar (value))
          this.target = sprintf ("'%s'", value);
        else
          error ("Fill: invalid VALUE.");
        endif
      endif

      ## Store color properties
      if (! isempty (above))
        if (ischar (above) || (iscellstr (above) && isscalar (above)))
          above = Color (above);
        elseif (iscellstr (above) && ! isscalar (above))
          error ("Fill: invalid color value for 'above' property.");
        elseif ((isnumeric (above) && isvector (above) &&
                (numel (above) == 3 || numel (above) == 4)) ||
                (iscell (above) && isvector (above) && numel (above) == 2))
          above = Color (above);
        else
          error ("Fill: invalid color value for 'above' property.");
        endif
        if (isa (above, "Color"))
          this.above = jsonstring (above);
        else
          error ("Fill: invalid object for 'above' property.");
        endif
      endif
      if (! isempty (below))
        if (ischar (below) || (iscellstr (below) && isscalar (below)))
            below = Color (below);
        elseif (iscellstr (below) && ! isscalar (below))
          error ("Fill: invalid color value for 'below' property.");
        elseif ((isnumeric (below) && isvector (below) &&
                (numel (below) == 3 || numel (below) == 4)) ||
                (iscell (below) && isvector (below) && numel (below) == 2))
            below = Color (below);
        else
          error ("Fill: invalid color value for 'below' property.");
        endif
        if (isa (below, "Color"))
          this.below = jsonstring (below);
        else
          error ("Fill: invalid object for 'below' property.");
        endif
      endif

    endfunction

    ## -*- texinfo -*-
    ## @deftypefn  {Fill} {@var{json} =} jsonstring (@var{obj})
    ##
    ## Generate the JSON string of a Fill object.
    ##
    ## @code{jsonstring (@var{obj})} returns a character vector, @var{json},
    ## describing the context of the Color object in json format.
    ##
    ## @seealso{Color, Fill}
    ## @end deftypefn

    function json = jsonstring (this)

      ## Only target
      if (isempty (this.above) && isempty (this.below))
        json = sprintf ("fill: %s", this.target);

      else
        json = "fill: {\n        ";
        json = [json, sprintf("target: %s,\n        ", this.target)];
        if (! isempty (this.above))
          json = [json, sprintf("above: %s,\n        ", this.above)];
        endif
        if (! isempty (this.below))
          json = [json, sprintf("below: %s,\n        ", this.below)];
        endif
        json = strtrim (json);
        json(end) = [];
        json = [json, "\n      }"];
      endif

    endfunction

  endmethods

endclassdef

## Test input validation
%!error <Fill: too few input arguments.> Fill ()
%!error <Fill: VALUE cannot be empty.> Fill ([])
%!error <Fill: numeric VALUE must be a scalar.> Fill ([1, 2])
%!error <Fill: TOAXIS must be a boolean scalar.> Fill (1, 2)
%!error <Fill: VALUE must be numeric when TOAXIS is true.> Fill ("+1", true)
%!error <Fill: VALUE for absolute indexing must be a nonnegative integer.> ...
%! Fill (-1)
%!error <Fill: invalid VALUE.> Fill ({1})
%!error <Fill: invalid color value for 'above' property.> ...
%! Fill (1, false, {"red", "green"})
%!error <Fill: invalid color value for 'above' property.> ...
%! Fill (1, false, {"rgb", 1, 1})
%!error <Fill: invalid color value for 'above' property.> ...
%! Fill (1, false, [1, 1])
%!error <Fill: invalid color value for 'below' property.> ...
%! Fill (1, false, "red", {"red", "green"})
%!error <Fill: invalid color value for 'below' property.> ...
%! Fill (1, false, [1, 1, 1], {"rgb", 1, 1})
%!error <Fill: invalid color value for 'below' property.> ...
%! Fill (1, false, {"rgba", [1, 1, 1, 0.5]}, [1, 1])

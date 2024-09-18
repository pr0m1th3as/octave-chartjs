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

classdef Fill

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

    ## Export to json string
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

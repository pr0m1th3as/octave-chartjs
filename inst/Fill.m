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
      if (! isscalar (value))
        error ("Fill: value must be a scalar.");
      endif
      if (isempty (value))
        error ("Fill: value must not be empty.");
      endif

      ## Store 'target' property
      if (toaxis)
        if (! isnumeric (value))
          error ("Fill: value must be numeric when toaxis is true.");
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
            error (strcat (["Fill: value for absolute indexing"], ...
                           [" must be a nonnegative integer."]));
          endif
          this.target = sprintf ("%i", value);
        elseif (ischar (value))
          this.target = sprintf ("'%s'", value);
        else
          error ("Fill: invalid value.");
        endif
      endif

      ## Store color properties
      if (! isempty (above))
        pname = "above";
        if (! isobject (above))
          this = parseColor (this, pname, above);
        else
          this = parseValue (this, pname, above, "Fill", "object");
        endif
      endif
      if (! isempty (below))
        pname = "below";
        if (! isobject (below))
          this = parseColor (this, pname, below);
        else
          this = parseValue (this, pname, below, "Fill", "object");
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

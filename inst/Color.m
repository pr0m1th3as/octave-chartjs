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

classdef Color

  properties (SetAccess = protected)

    value = [];

  endproperties

  properties (Access = private)

    color = [];

  endproperties

  methods (Access = public)

    ## Class object constructor
    function this = Color (value)

      ## Check value
      if (nargin < 1)
        error ("Color: too few input arguments.");
      endif
      if (isempty (value))
        error ("Color: VALUE cannot be empty.");
      endif

      ## Recognized color names
      color_names = {"red", "darkred", "lightgreen", "green", "darkgreen", ...
                     "lightblue", "blue", "darkblue", "lightgray", ...
                     "lightgrey", "darkgray", "darkgrey", "gray", "grey", ...
                     "brown", "white", "lightyellow", "yellow", "pink", ...
                     "lightcyan", "cyan", "darkcyan", "beige", "lightcoral", ...
                     "coral", "black", "magenta", "darkmagenta"};

      ## Default tab space
      tab = repmat (" ", 1, 8);

      ## Character vector with color name or hexadecimal value
      if (ischar (value) && isvector (value))
        if (any (strcmpi (value, color_names)))
          pstr = sprintf ("'%s'", value);
        elseif (check_hexcolor (value))
          pstr = sprintf ("'%s'", value);
        else
          error ("Color: '%s' is an invalid color value.", value);
        endif

      ## Cellstring vector of color names or hexadecimal values
      elseif (iscellstr (value) && isvector (value))
        pstr = sprintf ("[\n%s", tab);
        for i = 1:numel (value)
          if (any (strcmpi (value{i}, color_names)))
            pstr = [pstr, sprintf("'%s',\n%s", value{i}, tab)];
          elseif (check_hexcolor (value{i}))
            pstr = [pstr, sprintf("'%s',\n%s", value{i}, tab)];
          else
            error ("Color: '%s' is an invalid color value.", value{i});
          endif
        endfor
        pstr = strtrim (pstr);
        pstr([end-1:end]) = [];
        pstr = [pstr, sprintf("\n%s]", tab([1:end-2]))];

      elseif (iscellstr (value) && ! isvector (value))
        error ("Color: cellstr VALUE must be a vector.");

      ## Numeric vector of Octave RGB triplet values (and transparency)
      elseif (isnumeric (value) && isvector (value))
        if (numel (value) == 3)
          pstr = sprintf ("'rbg(%i, %i, %i)'", round (value * 255));
        elseif (numel (value) == 4)
          pstr = sprintf ("'rbga(%i, %i, %i, %d)'", ...
                          round (value([1:3]) * 255), value(4));
        else
          error ("Color: invalid size of numeric value vector.");
        endif

      ## Numeric matric of Octave RGB triplet values (and transparency)
      elseif (isnumeric (value) && ismatrix (value))
        if (size (value, 2) == 3)
          pstr = sprintf ("[\n%s", tab);
          for i = 1:size (value, 1)
            pstr = [pstr, sprintf("'rbg(%i, %i, %i)',\n%s", ...
                                  round (value(i,:) * 255), tab)];
          endfor
          pstr = strtrim (pstr);
          pstr([end-1:end]) = [];
          pstr = [pstr, sprintf("\n%s]", tab([1:end-2]))];
        elseif (size (value, 2) == 4)
          pstr = "[";
          for i = 1:size (value, 1)
            pstr = [pstr, sprintf("'rbga(%i, %i, %i, %d)',\n%s", ...
                                  round (value(i,[1:3]) * 255), ...
                                  value(i,4), tab)];
          endfor
          pstr = strtrim (pstr);
          pstr([end-1:end]) = [];
          pstr = [pstr, sprintf("\n%s]", tab([1:end-2]))];
        else
          error ("Color: invalid size of numeric value matrix.");
        endif

      ## Cell vector with color space name and corresponding numeric vector
      elseif (iscell (value) && isvector (value))
        pstr = namespacevector (value);

      ## Cell matix with color space names and corresponding numeric vectors
      elseif (iscell (value) && ismatrix (value))
        pstr = sprintf ("[\n%s", tab);
        for i = 1:size (value, 1)
          pstr = [pstr, namespacevector(value(i, :)), sprintf(",\n%s", tab)];
        endfor
        pstr = strtrim (pstr);
        pstr([end-1:end]) = [];
        pstr = [pstr, sprintf("\n%s]", tab([1:end-2]))];

      ## Invalid input
      else
        error ("Color: invalid VALUE input.");
      endif

      this.value = value;
      this.color = pstr;

    endfunction

    ## Return value to json string
    function json = jsonstring (this)

      json = this.color;

    endfunction

  endmethods

endclassdef

function TF = check_hexcolor (value)
  TF = strcmp (value(1), "#") && isfinite (hex2dec (value([2:end]))) && ...
       (numel (value) == 7 || numel (value) == 9);
endfunction

function pstr = namespacevector (value)
  if (! ischar (value{1}))
    error ("Color: invalid value for color name space.");
  endif
  if (strcmpi (value{1}, "rgb"))
    if (numel (value{2}) != 3)
      error ("Color: mismatched vector for 'RGB' value space.");
    endif
    pstr = sprintf ("'rbg(%i, %i, %i)'", value{2});
  elseif (strcmpi (value{1}, "rgba"))
    if (numel (value{2}) != 4)
      error ("Color: mismatched vector for 'RGBA' value space.");
    endif
    pstr = sprintf ("'rbga(%i, %i, %i, %d)'", value{2});
  elseif (strcmpi (value{1}, "hsl"))
    if (numel (value{2}) != 3)
      error ("Color: mismatched vector for 'HSL' value space.");
    endif
    pstr = sprintf ("'hsl(%i, %i%%, %i%%)'", value{2});
  elseif (strcmpi (value{1}, "hsla"))
    if (numel (value{2}) != 4)
      error ("Color: mismatched vector for 'HSLA' value space.");
    endif
    pstr = sprintf ("'hsl(%i, %i%%, %i%%, %d)'", value{2});
  else
    error ("Color: '%s' is an invalid color name space.", value{1});
  endif
endfunction

## Test input validation
%!error <Color: too few input arguments.> Color ()
%!error <Color: VALUE cannot be empty.> Color ([])
%!error <Color: 'color' is an invalid color value.> Color ("color")
%!error <Color: '#43' is an invalid color value.> Color ("#43")
%!error <Color: 'color' is an invalid color value.> Color ({"red", "color"})
%!error <Color: '#00550G' is an invalid color value.> Color ({"red", "#00550G"})
%!error <Color: cellstr VALUE must be a vector.> ...
%! Color ({"red", "red"; "gray", "gray"})
%!error <Color: invalid size of numeric value vector.> Color ([2, 3])
%!error <Color: invalid size of numeric value matrix.> Color (ones (2))
%!error <Color: invalid VALUE input.> Color (true)
%!error <Color: invalid value for color name space.> Color ({1, [1, 1, 1]})
%!error <Color: mismatched vector for 'RGB' value space.> ...
%! Color ({"rgb", [1, 1, 1, 1]})
%!error <Color: mismatched vector for 'RGBA' value space.> ...
%! Color ({"rgba", [1, 1, 1]})
%!error <Color: mismatched vector for 'HSL' value space.> ...
%! Color ({"hsl", [1, 1, 1, 1]})
%!error <Color: mismatched vector for 'HSLA' value space.> ...
%! Color ({"hsla", [1, 1, 1]})
%!error <Color: 'ASD' is an invalid color name space.> ...
%! Color ({"ASD", [1, 1, 1]})

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

classdef Color
## -*- texinfo -*-
## @deftypefn  {chartjs} {@var{obj} =} Color (@var{value})
##
## A class for creating Chart.js compatible Color objects.
##
## @code{@var{obj} = Color (@var{value})} returns a Color object defined by
## @var{value}, which can either be a character vector, a cellstring array, a
## numeric matrix, or a cell matrix containing the following combinations.  Each
## Color object only applies to a given dataset.  If you want to pass different
## color patterns to multiple datasets when constructing a Chart object, then
## you need to pass a Color object array to the Chart's constructor.
##
## When @var{value} is character vector, it can define a single color either by
## using one of the acceptable color names given below or by using hexadecimal
## string values in the forms @qcode{#FFFFFF} and @qcode{#FFFFFFFF}.  The former
## defines an @qcode{RGB} color space, whereas the later defines an @qcode{RGBA}
## color space that includes transparency.
##
## Valid color names are:
## @itemize
## @item @code{beige}
## @item @code{black}
## @item @code{blue}, @code{lightblue}, @code{darkblue}
## @item @code{brown}
## @item @code{coral}, @code{lightcoral}
## @item @code{cyan}, @code{darkcyan}
## @item @code{green}, @code{lightgreen}, @code{darkgreen}
## @item @code{gray}, @code{grey}, @code{lightgray}, @code{lightgrey},
## @code{darkgray}, @code{darkgrey}
## @item @code{magenta}, @code{darkmagenta}
## @item @code{pink}
## @item @code{red}, @code{darkred}
## @item @code{white}
## @item @code{yellow}, @code{lightyellow}
## @end itemize
##
## If you want to apply multiple colors to a given dataset, then you can use a
## cellstring array whose elements follow the requirements for character vector
## values described above.  The cellstring array must be a vector and its
## elements can interchangeably contain known color names or hexadecimal color
## values.
##
## If @var{value} is a numeric, it follows Octave's native @qcode{RGB} tripplet
## syntax.  An @qcode{RGB} triplet is a @math{1x3} vector where each value is
## between 0 and 1 inclusive.  The first value represents the percentage of Red,
## the second value the percentage of Green, and the third value the percentage
## of Blue.  This syntax is also extended to support @qcode{RGBA} quadruplets,
## in which case the fourth value (also between 0 and 1 inclusive) of the
## @math{1x4} vector represents the transparency.  If you want to apply multiple
## colors to a given dataset, then you can pass a numeric matrix of @math{Nx3}
## or @math{Nx4} size with each row representing a distinct @qcode{RGB} tripplet
## or @qcode{RGBA} quadruplet, respectively.
##
## Alternatively you can define @var{value} as a cell array with two elements or
## an @math{Nx2} cell matrix in case you need to specify multiple colors in the
## same dataset.  The first element of each row represents a color space name,
## which can be any of the four available choices: @code{rgb}, @code{rgba},
## @code{hsl}, and @code{hsla}.  The second element of each row must be a
## numeric @math{1x3} vector for @code{rgb} and @code{hsl} color spaces, or a
## numeric @math{1x4} vector for @code{rgba} and @code{hsla} color spaces.  When
## assigning color value(s) as a cell array, the @qcode{RGB} values must be
## between 0 and 255 inclusive, the @qcode{hue} value must be between 0 and 360
## inclusive, the @qcode{saturation} and @qcode{lightness} values must be
## percentages between 0 and 100 inclusive, whereas the @qcode{alpha} value must
## be between 0 and 1 inclusive.  All numeric values except for the transparency
## are expected to be integer values, otherwise they are rounded to the nearest
## integer.
##
## @seealso{BarChart, BarData, BubbleChart, BubbleData, DoughnutChart,
## DoughnutData, LineChart, LineData, PieChart, PieData, PolarAreaChart,
## PolarAreaData, RadarChart, RadarData, ScatterChart, ScatterData}
## @end deftypefn

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

    ## -*- texinfo -*-
    ## @deftypefn  {Color} {@var{json} =} jsonstring (@var{obj})
    ##
    ## Generate the JSON string of a Color object.
    ##
    ## @code{jsonstring (@var{obj})} returns a character vector, @var{json},
    ## describing the context of the Color object in json format.
    ##
    ## @seealso{Color, Fill}
    ## @end deftypefn

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
  if (numel (value) != 2)
    error ("Color: mismatched cell size for assigning color space value.");
  endif
  if (! ischar (value{1}))
    error ("Color: invalid value for color name space.");
  endif
  cval = value{2};
  if (strcmpi (value{1}, "rgb"))
    if (numel (cval) != 3)
      error ("Color: mismatched vector for 'RGB' value space.");
    endif
    if (any (cval < 0) || any (cval > 255))
      error ("Color: invalid numeric value in 'RGB' value space.");
    endif
    pstr = sprintf ("'rbg(%i, %i, %i)'", value{2});
  elseif (strcmpi (value{1}, "rgba"))
    if (numel (cval) != 4)
      error ("Color: mismatched vector for 'RGBA' value space.");
    endif
    if (any (cval([1:3]) < 0) || any (cval([1:3]) > 255)
                              || cval(4) < 0 || cval(4) > 1)
      error ("Color: invalid numeric value in 'RGBA' value space.");
    endif
    pstr = sprintf ("'rbga(%i, %i, %i, %d)'", value{2});
  elseif (strcmpi (value{1}, "hsl"))
    if (numel (cval) != 3)
      error ("Color: mismatched vector for 'HSL' value space.");
    endif
    if (any (cval([2:3]) < 0) || any (cval([2:3]) > 100)
                              || cval(1) < 0 || cval(1) > 360)
      error ("Color: invalid numeric value in 'HSL' value space.");
    endif
    pstr = sprintf ("'hsl(%i, %i%%, %i%%)'", value{2});
  elseif (strcmpi (value{1}, "hsla"))
    if (numel (cval) != 4)
      error ("Color: mismatched vector for 'HSLA' value space.");
    endif
    if (any (cval([2:3]) < 0) || any (cval([2:3]) > 100) ||
        cval(1) < 0 || cval(1) > 360 || cval(4) < 0 || cval(4) > 1)
      error ("Color: invalid numeric value in 'HSLA' value space.");
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
%!error <Color: mismatched cell size for assigning color space value.> ...
%! Color ({"rgba", [1, 1, 1], 1})
%!error <Color: invalid value for color name space.> Color ({1, [1, 1, 1]})
%!error <Color: mismatched vector for 'RGB' value space.> ...
%! Color ({"rgb", [1, 1, 1, 1]})
%!error <Color: invalid numeric value in 'RGB' value space.> ...
%! Color ({"rgb", [-1, 1, 1]})
%!error <Color: invalid numeric value in 'RGB' value space.> ...
%! Color ({"rgb", [1, 256, 1]})
%!error <Color: invalid numeric value in 'RGB' value space.> ...
%! Color ({"rgb", [1, 255, -0.5]})
%!error <Color: mismatched vector for 'RGBA' value space.> ...
%! Color ({"rgba", [1, 1, 1]})
%!error <Color: invalid numeric value in 'RGBA' value space.> ...
%! Color ({"rgba", [-1, 1, 1, 1]})
%!error <Color: invalid numeric value in 'RGBA' value space.> ...
%! Color ({"rgba", [1, 256, 1, 1]})
%!error <Color: invalid numeric value in 'RGBA' value space.> ...
%! Color ({"rgba", [1, 255, -0.5, 1]})
%!error <Color: invalid numeric value in 'RGBA' value space.> ...
%! Color ({"rgba", [1, 255, 1, 1.2]})
%!error <Color: invalid numeric value in 'RGBA' value space.> ...
%! Color ({"rgba", [1, 255, 1, -0.2]})
%!error <Color: mismatched vector for 'HSL' value space.> ...
%! Color ({"hsl", [1, 1, 1, 1]})
%!error <Color: invalid numeric value in 'HSL' value space.> ...
%! Color ({"hsl", [-1, 1, 1]})
%!error <Color: invalid numeric value in 'HSL' value space.> ...
%! Color ({"hsl", [361, 1, 1]})
%!error <Color: invalid numeric value in 'HSL' value space.> ...
%! Color ({"hsl", [1, 101, 1]})
%!error <Color: invalid numeric value in 'HSL' value space.> ...
%! Color ({"hsl", [1, 1, -1]})
%!error <Color: mismatched vector for 'HSLA' value space.> ...
%! Color ({"hsla", [1, 1, 1]})
%!error <Color: invalid numeric value in 'HSLA' value space.> ...
%! Color ({"hsla", [-1, 1, 1, 1]})
%!error <Color: invalid numeric value in 'HSLA' value space.> ...
%! Color ({"hsla", [361, 1, 1, 1]})
%!error <Color: invalid numeric value in 'HSLA' value space.> ...
%! Color ({"hsla", [1, 101, 1, 1]})
%!error <Color: invalid numeric value in 'HSLA' value space.> ...
%! Color ({"hsla", [1, 1, -1, 1]})
%!error <Color: invalid numeric value in 'HSLA' value space.> ...
%! Color ({"hsla", [1, 1, 1, 1.2]})
%!error <Color: invalid numeric value in 'HSLA' value space.> ...
%! Color ({"hsla", [1, 1, 1, -0.2]})
%!error <Color: 'ASD' is an invalid color name space.> ...
%! Color ({"ASD", [1, 1, 1]})

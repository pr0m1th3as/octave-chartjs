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

function obj = parseStyle (obj, val)

  validstr = {"circle", "cross", "crossRot", "dash", "line", "rect", ...
              "rectRounded", "rectRot", "star", "triangle", "none"};
  nsets = numel (obj.datasets);

  if (ischar (val))
    if (! any (strcmp (val, validstr)))
      error ("%s: invalid value for 'pointStyle'.", class (obj));
    endif
    for i = 1:nsets
      obj.datasets{i}.pointStyle = val;
    endfor

  elseif (isbool (val))
    for i = 1:nsets
      obj.datasets{i}.pointStyle = val;
    endfor

  elseif (iscellstr (val) || iscell (val))
    if (isscalar (val))
      val = repmat (val, nsets, 1);
    endif
    for i = 1:nsets
      if (isbool (val{i}) && ! val{i})
        obj.datasets{i}.pointStyle = false;
      elseif (ischar (val{i}))
        if (! any (strcmp (val{i}, validstr)))
          error ("%s: invalid value for 'pointStyle'.", class (obj));
        endif
        if (strcmp (val{i}, "none"))
          obj.datasets{i}.pointStyle = false;
        else
          obj.datasets{i}.pointStyle = val{i};
        endif
      else
        error ("%s: invalid value for 'pointStyle'.", class (obj));
      endif
    endfor

  else
    error ("%s: invalid value for 'pointStyle'.", class (obj));
  endif

endfunction

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

function obj = parseValue (obj, pname, value, validstr, type)

  nsets = numel (obj.datasets);

  if (strcmp (type, "scalar"))
    ## Numeric scalar for each dataset
    if (! isnumeric (value) || ! isfinite (value) || ! isvector (value))
      error ("%s: invalid value for '%s' property.", class (obj), pname);
    endif
    if (isscalar (value))
      for i = 1:nsets
        obj.datasets{i}.(pname) = value;
      endfor
    elseif (numel (value) == nsets)
      for i = 1:nsets
        obj.datasets{i}.(pname) = value(i);
      endfor
    else
      error ("%s: mismatched size for '%s' property.", class (obj), pname);
    endif

  elseif (strcmp (type, "vector"))
    ## Numeric vector for each dataset
    if (! isnumeric (value) || ! isfinite (value) || ! ismatrix (value))
      error ("%s: invalid value for '%s' property.", class (obj), pname);
    endif
    if (isvector (value))
      for i = 1:nsets
        this.datasets{i}.(pname) = value;
      endfor
    elseif (size (value, 1) == nsets)
      for i = 1:nsets
        this.datasets{i}.(pname) = value(i,:);
      endfor
    else
      error ("%s: mismatched size for '%s' property.", class (obj), pname);
    endif

  elseif (strcmp (type, "boolean"))
    ## Boolean scalar for each dataset
    if (! isbool (value))
      error ("%s: invalid value for '%s' property.", class (obj), pname);
    endif
    if (isscalar (value))
      for i = 1:nsets
        obj.datasets{i}.(pname) = value;
      endfor
    elseif (numel (value) == nsets)
      for i = 1:nsets
        obj.datasets{i}.(pname) = value(i);
      endfor
    else
      error ("%s: mismatched size for '%s' property.", class (obj), pname);
    endif

  elseif (strcmp (type, "string"))
    ## Character vector for each dataset
    if (ischar (value))
      if (! any (strcmpi (value, validstr)))
        error ("%s: invalid value for '%s' property.", class (obj), pname);
      endif
      for i = 1:nsets
        obj.datasets{i}.(pname) = value;
      endfor
    elseif (iscellstr (value))
      if (isscalar (value))
        value = repmat (value, nsets, 1);
      endif
      for i = 1:nsets
        if (! any (strcmpi (value{i}, validstr)))
          error ("%s: invalid value for '%s' property.", class (obj), pname);
        endif
        obj.datasets{i}.(pname) = value{i};
      endfor
    else
      error ("%s: invalid value for '%s' property.", class (obj), pname);
    endif

  elseif (strcmp (type, "object"))
    ## Object scalar for each dataset
    if (! isa (value, validstr))
      error ("%s: invalid value for '%s' property.", class (obj), pname);
    endif
    if (isscalar (value))
      for i = 1:nsets
        obj.datasets{i}.(pname) = value;
      endfor
    elseif (numel (value) == nsets)
      for i = 1:nsets
        obj.datasets{i}.(pname) = value(i);
      endfor
    else
      error ("%s: mismatched size for '%s' property.", class (obj), pname);
    endif

  elseif (strcmp (type, "boolstring"))
    ## Boolean or character vector for each dataset
    if (ischar (value))
      if (! any (strcmp (value, validstr)))
        error ("%s: invalid value for '%s' property.", class (obj), pname);
      endif
      for i = 1:nsets
        obj.datasets{i}.(pname) = value;
      endfor
    elseif (isbool (value))
      for i = 1:nsets
        obj.datasets{i}.(pname) = value;
      endfor
    elseif (iscellstr (value) || iscell (value))
      if (isscalar (value))
        value = repmat (value, nsets, 1);
      endif
      for i = 1:nsets
        if (isbool (value{i}))
          obj.datasets{i}.(pname) = value{i};
        elseif (ischar (value{i}))
          if (! any (strcmp (value{i}, validstr)))
            error ("%s: invalid value for '%s' property.", class (obj), pname);
          endif
          obj.datasets{i}.(pname) = value{i};
        else
          error ("%s: invalid value for '%s' property.", class (obj), pname);
        endif
      endfor
    else
      error ("%s: invalid value for '%s' property.", class (obj), pname);
    endif

  elseif (strcmp (type, "numstring"))
    ## Numeric or character vector for each dataset
    if (ischar (value))
      if (! any (strcmp (value, validstr)))
        error ("%s: invalid value for '%s' property.", class (obj), pname);
      endif
      for i = 1:nsets
        obj.datasets{i}.(pname) = value;
      endfor
    elseif (isnumeric (value))
      if (isscalar (value))
        value = repmat (value, nsets, 1);
      endif
      for i = 1:nsets
        obj.datasets{i}.(pname) = value(i);
      endfor
    elseif (iscellstr (value) || iscell (value))
      if (isscalar (value))
        value = repmat (value, nsets, 1);
      endif
      for i = 1:nsets
        if (isnumeric (value{i}))
          obj.datasets{i}.(pname) = value{i};
        elseif (ischar (value{i}))
          if (! any (strcmp (value{i}, validstr)))
            error ("%s: invalid value for '%s' property.", class (obj), pname);
          endif
          obj.datasets{i}.(pname) = value{i};
        else
          error ("%s: invalid value for '%s' property.", class (obj), pname);
        endif
      endfor
    else
      error ("%s: invalid value for '%s' property.", class (obj), pname);
    endif

  endif

endfunction

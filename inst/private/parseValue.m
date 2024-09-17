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

function obj = parseValue (obj, pname, val, validstr, type)

  nsets = numel (obj.datasets);

  if (strcmp (type, "scalar"))
    ## Numeric scalar for each dataset
    if (! isnumeric (val) || ! isfinite (val) || ! isvector (val))
      error ("%s: invalid value for '%s'.", class (obj), pname);
    endif
    if (isscalar (val))
      for i = 1:nsets
        obj.datasets{i}.(pname) = val;
      endfor
    elseif (numel (val) == nsets)
      for i = 1:nsets
        obj.datasets{i}.(pname) = val(i);
      endfor
    else
      error ("%s: mismatched size for '%s'.", class (obj), pname);
    endif

  elseif (strcmp (type, "vector"))
    ## Numeric vector for each dataset
    if (! isnumeric (val) || ! isfinite (val) || ! ismatrix (val))
      error ("%s: invalid value for '%s'.", class (obj), pname);
    endif
    if (isvector (val))
      for i = 1:nsets
        this.datasets{i}.(pname) = val;
      endfor
    elseif (size (val, 1) == nsets)
      for i = 1:nsets
        this.datasets{i}.(pname) = val(i,:);
      endfor
    else
      error ("%s: mismatched size for '%s'.", class (obj), pname);
    endif

  elseif (strcmp (type, "boolean"))
    ## Boolean scalar for each dataset
    if (! isbool (val))
      error ("%s: invalid value for '%s'.", class (obj), pname);
    endif
    if (isscalar (val))
      for i = 1:nsets
        obj.datasets{i}.(pname) = val;
      endfor
    elseif (numel (val) == nsets)
      for i = 1:nsets
        obj.datasets{i}.(pname) = val(i);
      endfor
    else
      error ("%s: mismatched size for '%s'.", class (obj), pname);
    endif

  elseif (strcmp (type, "string"))
    ## Character vector for each dataset
    if (ischar (val))
      if (! any (strcmpi (val, validstr)))
        error ("%s: invalid value for '%s'.", class (obj), pname);
      endif
      for i = 1:nsets
        obj.datasets{i}.(pname) = val;
      endfor
    elseif (iscellstr (val))
      if (isscalar (val))
        val = repmat (val, nsets, 1);
      endif
      for i = 1:nsets
        if (! any (strcmpi (val{i}, validstr)))
          error ("%s: invalid value for '%s'.", class (obj), pname);
        endif
        obj.datasets{i}.(pname) = val{i};
      endfor
    else
      error ("%s: invalid value for '%s'.", class (obj), pname);
    endif

  elseif (strcmp (type, "object"))
    ## Object scalar for each dataset
    if (! isa (val, validstr))
      error ("%s: invalid value for '%s'.", class (obj), pname);
    endif
    if (isscalar (val))
      for i = 1:nsets
        obj.datasets{i}.(pname) = val;
      endfor
    elseif (numel (val) == nsets)
      for i = 1:nsets
        obj.datasets{i}.(pname) = val(i);
      endfor
    else
      error ("%s: mismatched size for '%s'.", class (obj), pname);
    endif

  elseif (strcmp (type, "boolstring"))
    ## Boolean or character vector for each dataset
    if (ischar (val))
      if (! any (strcmp (val, validstr)))
        error ("%s: invalid value for '%s'.", class (obj), pname);
      endif
      for i = 1:nsets
        obj.datasets{i}.(pname) = val;
      endfor
    elseif (isbool (val))
      for i = 1:nsets
        obj.datasets{i}.(pname) = val;
      endfor
    elseif (iscellstr (val) || iscell (val))
      if (isscalar (val))
        val = repmat (val, nsets, 1);
      endif
      for i = 1:nsets
        if (isbool (val{i}))
          obj.datasets{i}.(pname) = val{i};
        elseif (ischar (val{i}))
          if (! any (strcmp (val{i}, validstr)))
            error ("%s: invalid value for '%s'.", class (obj), pname);
          endif
          obj.datasets{i}.(pname) = val{i};
        else
          error ("%s: invalid value for '%s'.", class (obj), pname);
        endif
      endfor
    else
      error ("%s: invalid value for '%s'.", class (obj), pname);
    endif

  elseif (strcmp (type, "numstring"))
    ## Numeric or character vector for each dataset
    if (ischar (val))
      if (! any (strcmp (val, validstr)))
        error ("%s: invalid value for '%s'.", class (obj), pname);
      endif
      for i = 1:nsets
        obj.datasets{i}.(pname) = val;
      endfor
    elseif (isnumeric (val))
      if (isscalar (val))
        val = repmat (val, nsets, 1);
      endif
      for i = 1:nsets
        obj.datasets{i}.(pname) = val(i);
      endfor
    elseif (iscellstr (val) || iscell (val))
      if (isscalar (val))
        val = repmat (val, nsets, 1);
      endif
      for i = 1:nsets
        if (isnumeric (val{i}))
          obj.datasets{i}.(pname) = val{i};
        elseif (ischar (val{i}))
          if (! any (strcmp (val{i}, validstr)))
            error ("%s: invalid value for '%s'.", class (obj), pname);
          endif
          obj.datasets{i}.(pname) = val{i};
        else
          error ("%s: invalid value for '%s'.", class (obj), pname);
        endif
      endfor
    else
      error ("%s: invalid value for '%s'.", class (obj), pname);
    endif

  endif

endfunction

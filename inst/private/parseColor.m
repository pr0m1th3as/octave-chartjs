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

function obj = parseColor (obj, pname, val)

  nsets = numel (obj.datasets);

  if (ischar (val) || (iscellstr (val) && isscalar (val)))
    for i = 1:nsets
      obj.datasets{i}.(pname) = Color (val);
    endfor
  elseif (iscellstr (val) && numel (val) == nsets)
    for i = 1:nsets
      obj.datasets{i}.(pname) = Color (val{i});
    endfor
  elseif ((isnumeric (val) && isvector (val) &&
          (numel (val) == 3 || numel (val) == 4)) ||
          (iscell (val) && isvector (val) && numel (val) == 2))
    for i = 1:nsets
      obj.datasets{i}.(pname) = Color (val);
    endfor
  elseif ((isnumeric (val) && ismatrix (val) && size (val, 1) == nsets &&
          (size (val, 2) == 3 || size (val, 2) == 4)) ||
          (iscell (val) && ismatrix (val) && isequal (size (val), [nsets, 2])))
    for i = 1:nsets
      obj.datasets{i}.(pname) = Color (val(i,:));
    endfor
  else
    error ("%s: invalid value for '%s'.", class (obj), pname);
  endif


endfunction

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

function obj = parseColor (obj, pname, value)

  ## Handle Chart classes
  nsets = numel (obj.datasets);

  if (ischar (value) || (iscellstr (value) && isscalar (value)))
    for i = 1:nsets
      obj.datasets{i}.(pname) = Color (value);
    endfor
  elseif (iscellstr (value) && numel (value) == nsets)
    for i = 1:nsets
      obj.datasets{i}.(pname) = Color (value{i});
    endfor
  elseif ((isnumeric (value) && isvector (value) &&
          (numel (value) == 3 || numel (value) == 4)) ||
          (iscell (value) && isvector (value) && numel (value) == 2))
    for i = 1:nsets
      obj.datasets{i}.(pname) = Color (value);
    endfor
  elseif ((isnumeric (value) && ismatrix (value) && size (value, 1) == nsets
           && (size (value, 2) == 3 || size (value, 2) == 4)) ||
          (iscell (value) && ismatrix (value)
           && isequal (size (value), [nsets, 2])))
    for i = 1:nsets
      obj.datasets{i}.(pname) = Color (value(i,:));
    endfor
  else
    error ("%s: invalid color value for '%s' property.", class (obj), pname);
  endif


endfunction

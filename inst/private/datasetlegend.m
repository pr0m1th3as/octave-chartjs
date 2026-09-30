## Copyright (C) 2026 Andreas Bertsatos <abertsatos@biol.uoa.gr>
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

## Chart.js names each dataset in the legend by its label, and writes
## "undefined" for a dataset without one.  Hide the legend of a chart structure
## S when no dataset has a label, and name the rest by position when some do.

function s = datasetlegend (s)

  labelled = cellfun (@(d) isfield (d, "label"), s.data.datasets);
  if (! any (labelled))
    s.options.plugins.legend.display = false;
  else
    for i = find (! labelled)
      s.data.datasets{i}.label = sprintf ("Dataset %d", i);
    endfor
  endif

endfunction

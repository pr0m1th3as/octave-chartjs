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

## -*- texinfo -*-
## @deftypefn {chartjs} {@var{s} =} datasetlegend (@var{s})
##
## Settle the legend of a chart structure before it is written as JSON.
##
## Chart.js names each dataset in the legend by its label, and writes
## @qcode{undefined} for a dataset without one.  @var{s} is the structure a
## chart class builds in its @code{jsonvalue} method.  When no dataset has a
## label, the legend is hidden; when some do, the rest are named by position,
## such as @qcode{"Dataset 2"}.
##
## This is an internal helper of the chart classes whose legend lists datasets.
## Do NOT call it directly.
##
## @end deftypefn

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

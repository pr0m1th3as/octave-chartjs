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

## The fields Chart.js always reads as arrays, as the paths __chartjson__
## takes, below a whole chart when ROOT is 'chart' and below a single dataset
## when ROOT is 'dataset'.

function paths = jsonpaths (root)

  dataset = {'data', 'borderDash', 'hoverBorderDash'};
  switch (root)
    case 'chart'
      paths = [{'data.labels', 'data.datasets'}, ...
               strcat('data.datasets.', dataset)];
    case 'dataset'
      paths = dataset;
  endswitch

endfunction

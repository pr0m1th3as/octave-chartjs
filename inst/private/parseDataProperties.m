## Copyright (C) 2024-2025 Andreas Bertsatos <abertsatos@biol.uoa.gr>
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

function s = parseDataProperties (s, obj)

  ## Validate input arguments
  if (! isstruct (s) || ! isscalar (s))
    error ("utils.parseprops: S must be a scalar structure.");
  endif
  valid_class = {"BarData", "BubbleData", "PieData", "DoughnutData", ...
                 "LineData", "PolarAreaData", "RadarData", "ScatterData"};
  if (! any (strcmp (class (obj), valid_class)))
    error ("utils.parseprops: OBJ is not a valid Chart Data class.");
  endif

  ## Add optional data properties (if present in the Chart object) as
  ## fields of the structure

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "backgroundColor"))
    if (! isempty (obj.backgroundColor))
      s.backgroundColor = jsonvalue (obj.backgroundColor);
    endif
  endif

  ## Bar
  if (isprop (obj, "base"))
    if (! isempty (obj.base))
      s.base = obj.base;
    endif
  endif

  ## Bar
  if (isprop (obj, "barPercentage"))
    if (obj.barPercentage != 0.9)
      s.barPercentage = obj.barPercentage;
    endif
  endif

  ## Bar
  if (isprop (obj, "barThickness"))
    if (! isempty (obj.barThickness))
      if (isnumeric (obj.barThickness))
        s.barThickness = obj.barThickness;
      else
        s.barThickness = "flex";
      endif
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "borderAlign"))
    if (! strcmp (obj.borderAlign, "center"))
      s.borderAlign = obj.borderAlign;
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "borderCapStyle"))
    if (! strcmp (obj.borderCapStyle, "butt"))
      s.borderCapStyle = obj.borderCapStyle;
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderColor"))
    if (! isempty (obj.borderColor))
      s.borderColor = jsonvalue (obj.borderColor);
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderDash"))
    if (any (obj.borderDash != 0))
      s.borderDash = obj.borderDash;
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderDashOffset"))
    if (obj.borderDashOffset != 0)
      s.borderDashOffset = obj.borderDashOffset;
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderJoinStyle"))
    isLineRadar = isa (obj, "LineData") || isa (obj, "RadarData");
    isDPiePolar = any (isa (obj, {"DoughnutData", "PieData", "PolarAreaData"}));
    if ((! strcmp (obj.borderJoinStyle, "miter") && isLineRadar) ||
        (! isempty (obj.borderJoinStyle) && isDPiePolar))
      s.borderJoinStyle = obj.borderJoinStyle;
    endif
  endif

  ## Bar, Doughnut, Pie
  if (isprop (obj, "borderRadius"))
    if (obj.borderRadius != 0)
      s.borderRadius = obj.borderRadius;
    endif
  endif

  ## Bar
  if (isprop (obj, "borderSkipped"))
    if (! strcmp (obj.borderSkipped, "start"))
      if (isbool (obj.borderSkipped))
        if (obj.borderSkipped)
          s.borderSkipped = true;
        else
          s.borderSkipped = false;
        endif
      else
        s.borderSkipped = obj.borderSkipped;
      endif
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderWidth"))
    isDPiePolar = any (isa (obj, {"DoughnutData", "PieData", "PolarAreaData"}));
    if ((obj.borderWidth != 3 && isa (obj, "LineData")) ||
        (obj.borderWidth != 0 && isa (obj, "BarData")) ||
        (obj.borderWidth != 2 && isDPiePolar))
      s.borderWidth = obj.borderWidth;
    endif
  endif

  ## Bar
  if (isprop (obj, "categoryPercentage"))
    if (obj.categoryPercentage != 0.8)
      s.categoryPercentage = obj.categoryPercentage;
    endif
  endif

  ## Polar
  if (isprop (obj, "circular"))
    if (! obj.circular)
      s.circular = false;
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "circumference"))
    if (! isempty (obj.circumference))
      s.circumference = obj.circumference;
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "clip"))
    if (! isempty (obj.clip))
      s.clip = obj.clip;
    endif
  endif

  ## Line
  if (isprop (obj, "cubicInterpolationMode"))
    if (! strcmp (obj.cubicInterpolationMode, "default"))
      s.cubicInterpolationMode = obj.cubicInterpolationMode;
    endif
  endif

  ## Bubble, Line
  if (isprop (obj, "drawActiveElementsOnTop"))
    if (! obj.drawActiveElementsOnTop)
      s.drawActiveElementsOnTop = false;
    endif
  endif

  ## Line, Radar
  if (isprop (obj, "fill"))
    if (! isempty (obj.fill))
      s.fill = jsonvalue (obj.fill);
    endif
  endif

  ## Bar
  if (isprop (obj, "grouped"))
    if (! obj.grouped)
      s.grouped = false;
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBackgroundColor"))
    if (! isempty (obj.hoverBackgroundColor))
      s.hoverBackgroundColor = jsonvalue (obj.hoverBackgroundColor);
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "hoverBorderCapStyle"))
    if (! isempty (obj.hoverBorderCapStyle))
      s.hoverBorderCapStyle = obj.hoverBorderCapStyle;
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderColor"))
    if (! isempty (obj.hoverBorderColor))
      s.hoverBorderColor = jsonvalue (obj.hoverBorderColor);
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderDash"))
    if (any (obj.hoverBorderDash != 0))
      s.hoverBorderDash = obj.hoverBorderDash;
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderDashOffset"))
    if (obj.hoverBorderDashOffset != 0)
      s.hoverBorderDashOffset = obj.hoverBorderDashOffset;
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderJoinStyle"))
    if (! isempty (obj.hoverBorderJoinStyle))
      s.hoverBorderJoinStyle = obj.hoverBorderJoinStyle;
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderWidth"))
    ## Bar, Bubble and Scatter default to 1, the others to nothing
    defaultOne = any (isa (obj, {"BarData", "BubbleData", "ScatterData"}));
    if ((obj.hoverBorderWidth != 1 && defaultOne) ||
        (! isempty (obj.hoverBorderWidth) && ! defaultOne))
      s.hoverBorderWidth = obj.hoverBorderWidth;
    endif
  endif

  ## Bar
  if (isprop (obj, "hoverBorderRadius"))
    if (obj.hoverBorderRadius != 0)
      s.hoverBorderRadius = obj.hoverBorderRadius;
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "hoverOffset"))
    if (obj.hoverOffset != 0)
      s.hoverOffset = obj.hoverOffset;
    endif
  endif

  ## Bar, Line
  if (isprop (obj, "indexAxis"))
    if (strcmp (obj.indexAxis, "y"))
      s.indexAxis = "y";
    endif
  endif

  ## Bar
  if (isprop (obj, "inflateAmount"))
    if (! strcmp (obj.inflateAmount, "auto"))
      s.inflateAmount = obj.inflateAmount;
    endif
  endif

  ## Bar, Bubble, Line, Radar, Scatter
  if (isprop (obj, "label"))
    if (! isempty (obj.label))
      s.label = obj.label;
    endif
  endif

  ## Bar
  if (isprop (obj, "maxBarThickness"))
    if (! isempty (obj.maxBarThickness))
      s.maxBarThickness = obj.maxBarThickness;
    endif
  endif

  ## Bar
  if (isprop (obj, "minBarLength"))
    if (! isempty (obj.minBarLength))
      s.minBarLength = obj.minBarLength;
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "offset"))
    if (obj.offset != 0)
      s.offset = obj.offset;
    endif
  endif

  ## Bar, Bubble, Line, Radar, Scatter
  if (isprop (obj, "order"))
    if (obj.order != 0)
      s.order = obj.order;
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointBackgroundColor"))
    if (! isempty (obj.pointBackgroundColor))
      s.pointBackgroundColor = jsonvalue (obj.pointBackgroundColor);
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointBorderColor"))
    if (! isempty (obj.pointBorderColor))
      s.pointBorderColor = jsonvalue (obj.pointBorderColor);
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointBorderWidth"))
    if (obj.pointBorderWidth != 1)
      s.pointBorderWidth = obj.pointBorderWidth;
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHitRadius"))
    if (obj.pointHitRadius != 1)
      s.pointHitRadius = obj.pointHitRadius;
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHoverBackgroundColor"))
    if (! isempty (obj.pointHoverBackgroundColor))
      s.pointHoverBackgroundColor = jsonvalue (obj.pointHoverBackgroundColor);
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHoverBorderColor"))
    if (! isempty (obj.pointHoverBorderColor))
      s.pointHoverBorderColor = jsonvalue (obj.pointHoverBorderColor);
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHoverBorderWidth"))
    if (obj.pointHoverBorderWidth != 1)
      s.pointHoverBorderWidth = obj.pointHoverBorderWidth;
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHoverRadius"))
    if (obj.pointHoverRadius != 4)
      s.pointHoverRadius = obj.pointHoverRadius;
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointRadius"))
    if (obj.pointRadius != 3)
      s.pointRadius = obj.pointRadius;
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointRotation"))
    if (obj.pointRotation != 0)
      s.pointRotation = obj.pointRotation;
    endif
  endif

  ## Bubble, Line, Radar, Scatter
  if (isprop (obj, "pointStyle"))
    if (! strcmp (obj.pointStyle, "circle"))
      if (isbool (obj.pointStyle))
        if (obj.pointStyle)
          s.pointStyle = true;
        else
          s.pointStyle = false;
        endif
      else
        s.pointStyle = obj.pointStyle;
      endif
    endif
  endif

  ## Bubble
  if (isprop (obj, "radius"))
    if (obj.radius != 3)
      s.radius = obj.radius;
    endif
  endif

  ## Bubble, Doughnut, Pie
  if (isprop (obj, "rotation"))
    if (obj.rotation != 0)
      s.rotation = obj.rotation;
    endif
  endif

  ## 'segment' option for Line Chart is not supported

  ## Line
  if (isprop (obj, "showLine"))
    if (! obj.showLine)
      s.showLine = false;
    endif
  endif

  ## Bar
  if (isprop (obj, "skipNull"))
    if (! isempty (obj.skipNull))
      if (obj.skipNull)
        s.skipNull = true;
      else
        s.skipNull = false;
      endif
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "spacing"))
    if (obj.spacing != 0)
      s.spacing = obj.spacing;
    endif
  endif

  ## Line, Radar
  if (isprop (obj, "spanGaps"))
    if (! isempty (obj.spanGaps))
      if (isbool (obj.spanGaps))
        if (obj.spanGaps)
          s.spanGaps = true;
        else
          s.spanGaps = false;
        endif
      else
        s.spanGaps = obj.spanGaps;
      endif
    endif
  endif

  ## Bar, Line
  if (isprop (obj, "stack"))
    isBarDefault = ! strcmp (obj.stack, "bar")  && isa (obj, "BarData");
    isLineDefault = ! strcmp (obj.stack, "line")  && isa (obj, "LineData");
    if (isBarDefault || isLineDefault)
      s.stack = obj.stack;
    endif
  endif

  ## Line
  if (isprop (obj, "stepped"))
    if (obj.stepped)
      if (isbool (obj.stepped))
        s.stepped = true;
      else
        s.stepped = obj.stepped;
      endif
    endif
  endif

  ## Line, Radar
  if (isprop (obj, "tension"))
    if (obj.tension != 0)
      s.tension = obj.tension;
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "weight"))
    if (obj.weight != 1)
      s.weight = obj.weight;
    endif
  endif

  ## 'xAxisID' option is not supported

  ## 'yAxisID' option is not supported

endfunction

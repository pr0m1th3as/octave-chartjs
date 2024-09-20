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

function json = parseDataProperties (json, obj)

  ## Validate input arguments
  if (! ischar (json) || ! isvector (json))
    error ("utils.parseprops: JSON must be a character vector.");
  endif
  valid_class = {"BarData", "BubbleData", "PieData", "LineData", ...
                 "PolarData", "RadarData", "ScatterData"};
  if (! any (strcmp (class (obj), valid_class)))
    error ("utils.parseprops: OBJ is not a valid Chart Data class.");
  endif

  ## Helper string
  newp = ",\n      ";

  ## Append optional data properties (if present in the Chart object)
  ## into the json string

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "backgroundColor"))
    if (! isempty (obj.backgroundColor))
      pstr = jsonstring (obj.backgroundColor);
      pstr = sprintf ("backgroundColor: %s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "base"))
    if (! isempty (obj.base))
      pstr = sprintf ("base: %g", obj.base);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "barPercentage"))
    if (obj.barPercentage != 0.9)
      pstr = sprintf ("barPercentage: %f", obj.barPercentage);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "barThickness"))
    if (! isempty (obj.barThickness))
      if (isnumeric (obj.barThickness))
        pstr = sprintf ("barThickness: %i", obj.barThickness);
      else
        pstr = "barThickness: 'flex'";
      endif
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "borderAlign"))
    if (! strcmp (obj.borderAlign, "center"))
      pstr = sprintf ("borderAlign: '%s'", obj.borderAlign);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "borderCapStyle"))
    if (! strcmp (obj.borderCapStyle, "butt"))
      pstr = sprintf ("borderCapStyle: '%s'", obj.borderCapStyle);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderColor"))
    if (! isempty (obj.borderColor))
      pstr = jsonstring (obj.borderColor);
      pstr = sprintf ("borderColor: %s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderDash"))
    if (any (obj.borderDash != 0))
      pstr = sprintf ("%d, ", obj.borderDash);
      pstr(end) = [];
      pstr(end) = "]";
      pstr = sprintf ("borderDash: [%s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderDashOffset"))
    if (obj.borderDashOffset != 0)
      pstr = sprintf ("borderDashOffset: %f", obj.borderDashOffset);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderJoinStyle"))
    isLineRadar = isa (obj, "LineData") || isa (obj, "RadarData");
    isDPiePolar = any (isa (obj, {"DoughnutData", "PieData", "PolarData"}));
    if ((! strcmp (obj.borderJoinStyle, "miter") && isLineRadar) ||
        (! isempty (obj.borderJoinStyle) && isDPiePolar))
      pstr = sprintf ("borderJoinStyle: '%s'", obj.borderJoinStyle);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Doughnut, Pie
  if (isprop (obj, "borderRadius"))
    if (obj.borderRadius != 0)
      pstr = sprintf ("borderRadius: %g", obj.borderRadius);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "borderSkipped"))
    if (! strcmp (obj.borderSkipped, "start"))
      if (isbool (obj.borderSkipped))
        if (obj.borderSkipped)
          pstr = "borderSkipped: true";
        else
          pstr = "borderSkipped: false";
        endif
      else
        pstr = sprintf ("borderSkipped: '%s'", obj.borderSkipped);
      endif
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "borderWidth"))
    isDPiePolar = any (isa (obj, {"DoughnutData", "PieData", "PolarData"}));
    if ((obj.borderWidth != 3 && isa (obj, "LineData")) ||
        (obj.borderWidth != 0 && isa (obj, "BarData")) ||
        (obj.borderWidth != 2 && isDPiePolar))
      pstr = sprintf ("borderWidth: %f", obj.borderWidth);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "categoryPercentage"))
    if (obj.categoryPercentage != 0.8)
      pstr = sprintf ("categoryPercentage: %f", obj.categoryPercentage);
      json = [json, newp, pstr];
    endif
  endif

  ## Polar
  if (isprop (obj, "circular"))
    if (! obj.circular)
      json = [json, newp, "circular: false"];
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "circumference"))
    if (! isempty (obj.circumference))
      pstr = sprintf ("circumference: %f", obj.circumference);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "clip"))
    if (! isempty (obj.clip))
      pstr = sprintf ("clip: %f", obj.clip);
      json = [json, newp, pstr];
    endif
  endif

  ## Line
  if (isprop (obj, "cubicInterpolationMode"))
    if (! strcmp (obj.cubicInterpolationMode, "default"))
      pstr = sprintf ("cubicInterpolationMode: '%s'", ...
                      obj.cubicInterpolationMode);
      json = [json, newp, pstr];
    endif
  endif

  ## Bubble, Line
  if (isprop (obj, "drawActiveElementsOnTop"))
    if (! obj.drawActiveElementsOnTop)
      json = [json, newp, "drawActiveElementsOnTop: false"];
    endif
  endif

  ## Line, Radar
  if (isprop (obj, "fill"))
    if (! isempty (obj.fill))
      pstr = jsonstring (obj.fill);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "grouped"))
    if (! obj.grouped)
      json = [json, newp, "grouped: false"];
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBackgroundColor"))
    if (! isempty (obj.hoverBackgroundColor))
      pstr = jsonstring (obj.hoverBackgroundColor);
      pstr = sprintf ("hoverBackgroundColor: %s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "hoverBorderCapStyle"))
    if (! isempty (obj.hoverBorderCapStyle))
      pstr = sprintf ("hoverBorderCapStyle: '%s'", obj.hoverBorderCapStyle);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderColor"))
    if (! isempty (obj.hoverBorderColor))
      pstr = jsonstring (obj.hoverBorderColor);
      pstr = sprintf ("hoverBorderColor: %s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderDash"))
    if (any (obj.hoverBorderDash != 0))
      pstr = sprintf ("%d, ", obj.hoverBorderDash);
      pstr(end) = [];
      pstr(end) = "]";
      pstr = sprintf ("hoverBorderDash: [%s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderDashOffset"))
    if (obj.hoverBorderDashOffset != 0)
      pstr = sprintf ("hoverBorderDashOffset: %f", obj.hoverBorderDashOffset);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderJoinStyle"))
    if (! isempty (obj.hoverBorderJoinStyle))
      pstr = sprintf ("hoverBorderJoinStyle: '%s'", obj.hoverBorderJoinStyle);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Bubble, Doughnut, Pie, Line, Polar, Radar, Scatter
  if (isprop (obj, "hoverBorderWidth"))
    isBarBubble = any (isa (obj, {"BarData", "BubbleData"}));
    if ((obj.hoverBorderWidth != 1 && isBarBubble) ||
        (! isempty (obj.hoverBorderWidth) && ! isBarBubble))
      pstr = sprintf ("hoverBorderWidth: %i", obj.hoverBorderWidth);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "hoverBorderRadius"))
    if (obj.hoverBorderRadius != 0)
      pstr = sprintf ("hoverBorderRadius: %f", obj.hoverBorderRadius);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "hoverOffset"))
    if (obj.hoverOffset != 0)
      pstr = sprintf ("hoverOffset: %f", obj.hoverOffset);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Line
  if (isprop (obj, "indexAxis"))
    if (strcmp (obj.indexAxis, "y"))
      json = [json, newp, "indexAxis: 'y'"];
    endif
  endif

  ## Bar
  if (isprop (obj, "inflateAmount"))
    if (! strcmp (obj.inflateAmount, "auto"))
      pstr = sprintf ("inflateAmount: %f", obj.inflateAmount);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Bubble, Line, Radar, Scatter
  if (isprop (obj, "label"))
    if (! isempty (obj.label))
      pstr = sprintf ("label: '%s'", obj.label);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "maxBarThickness"))
    if (! isempty (obj.maxBarThickness))
      pstr = sprintf ("maxBarThickness: %f", obj.maxBarThickness);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar
  if (isprop (obj, "minBarLength"))
    if (! isempty (obj.minBarLength))
      pstr = sprintf ("minBarLength: %f", obj.minBarLength);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "offset"))
    if (obj.offset != 0)
      pstr = sprintf ("offset: %i", obj.offset);
      json = [json, newp, pstr];
    endif
  endif

  ## Bar, Bubble, Line, Radar, Scatter
  if (isprop (obj, "order"))
    if (obj.order != 0)
      pstr = sprintf ("order: %i", obj.order);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointBackgroundColor"))
    if (! isempty (obj.pointBackgroundColor))
      pstr = jsonstring (obj.pointBackgroundColor);
      pstr = sprintf ("pointBackgroundColor: %s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointBorderColor"))
    if (! isempty (obj.pointBorderColor))
      pstr = jsonstring (obj.pointBorderColor);
      pstr = sprintf ("pointBorderColor: %s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointBorderWidth"))
    if (obj.pointBorderWidth != 1)
      pstr = sprintf ("pointBorderWidth: %d", obj.pointBorderWidth);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHitRadius"))
    if (obj.pointHitRadius != 1)
      pstr = sprintf ("pointHitRadius: %d", obj.pointHitRadius);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHoverBackgroundColor"))
    if (! isempty (obj.pointHoverBackgroundColor))
      pstr = jsonstring (obj.pointHoverBackgroundColor);
      pstr = sprintf ("pointHoverBackgroundColor: %s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHoverBorderColor"))
    if (! isempty (obj.pointHoverBorderColor))
      pstr = jsonstring (obj.pointHoverBorderColor);
      pstr = sprintf ("pointHoverBorderColor: %s", pstr);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHoverBorderWidth"))
    if (obj.pointHoverBorderWidth != 1)
      pstr = sprintf ("pointHoverBorderWidth: %d", obj.pointHoverBorderWidth);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointHoverRadius"))
    if (obj.pointHoverRadius != 4)
      pstr = sprintf ("pointHoverRadius: %d", obj.pointHoverRadius);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointRadius"))
    if (obj.pointRadius != 3)
      pstr = sprintf ("pointRadius: %d", obj.pointRadius);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar, Scatter
  if (isprop (obj, "pointRotation"))
    if (obj.pointRotation != 0)
      pstr = sprintf ("pointRotation: %d", obj.pointRotation);
      json = [json, newp, pstr];
    endif
  endif

  ## Bubble, Line, Radar, Scatter
  if (isprop (obj, "pointStyle"))
    if (! strcmp (obj.pointStyle, "circle"))
      if (isbool (obj.pointStyle))
        if (obj.pointStyle)
          json = [json, newp, "pointStyle: true"];
        else
          json = [json, newp, "pointStyle: false"];
        endif
      else
        pstr = sprintf ("pointStyle: '%s'", obj.pointStyle);
        json = [json, newp, pstr];
      endif
    endif
  endif

  ## Bubble
  if (isprop (obj, "radius"))
    if (obj.radius != 3)
      pstr = sprintf ("radius: %d", obj.radius);
      json = [json, newp, pstr];
    endif
  endif

  ## Bubble, Doughnut, Pie
  if (isprop (obj, "rotation"))
    if (obj.rotation != 0)
      pstr = sprintf ("rotation: %d", obj.rotation);
      json = [json, newp, pstr];
    endif
  endif

  ## 'segment' option for Line Chart is not supported

  ## Line
  if (isprop (obj, "showLine"))
    if (! obj.showLine)
      json = [json, newp, "showLine: false"];
    endif
  endif

  ## Bar
  if (isprop (obj, "skipNull"))
    if (! isempty (obj.skipNull))
      if (obj.skipNull)
        json = [json, newp, "skipNull: true"];
      else
        json = [json, newp, "skipNull: false"];
      endif
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "spacing"))
    if (obj.spacing != 0)
      pstr = sprintf ("spacing: %i", obj.spacing);
      json = [json, newp, pstr];
    endif
  endif

  ## Line, Radar
  if (isprop (obj, "spanGaps"))
    if (obj.spanGaps)
      json = [json, newp, "spanGaps: true"];
    endif
  endif

  ## Bar, Line
  if (isprop (obj, "stack"))
    isBarDefault = ! strcmp (obj.stack, "bar")  && isa (obj, "BarData");
    isLineDefault = ! strcmp (obj.stack, "line")  && isa (obj, "LineData");
    if (isBarDefault || isLineDefault)
      pstr = sprintf ("stack: '%s'", obj.stack);
      json = [json, newp, pstr];
    endif
  endif

  ## Line
  if (isprop (obj, "stepped"))
    if (obj.stepped)
      if (isbool (obj.stepped))
        json = [json, newp, "stepped: true"];
      else
        pstr = sprintf ("stepped: '%s'", obj.stepped);
        json = [json, newp, pstr];
      endif
    endif
  endif

  ## Line, Radar
  if (isprop (obj, "tension"))
    if (obj.tension != 0)
      pstr = sprintf ("tension: %f", obj.tension);
      json = [json, newp, pstr];
    endif
  endif

  ## Doughnut, Pie
  if (isprop (obj, "weight"))
    if (obj.weight != 1)
      pstr = sprintf ("weight: %f", obj.weight);
      json = [json, newp, pstr];
    endif
  endif

  ## 'xAxisID' option is not supported

  ## 'yAxisID' option is not supported

endfunction

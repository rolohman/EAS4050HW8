[dem,info]=geotiffread('zagros_SRTMGL3.tif');

info


info.LongitudeLimits(1) %this displays the first (westernmost) longitude value


%if the RasterInterpretation is "cells", it means that the min/max are the full bounds of the
%image, i.e., the western boundary of the westernmost cell, to the eastern
%boundary of the easternmost cell.  If it is "posting", then the
%coordinates are for the center of each grid.  This matters, since when we
%plot, we need to give the center values.  If the data is in cells, we have
%to shift it by half a cell.
info.RasterInterpretation



dx = info.CellExtentInLongitude;
x1 = info.LongitudeLimits(1)+dx/2;
x2 = info.LongitudeLimits(2)-dx/2;
X  = [x1:dx:x2]; %This makes a vector of longitudes


dy = info.CellExtentInLatitude;
y1 = info.LatitudeLimits(1)+dy/2;
y2 = info.LatitudeLimits(2)-dy/2;
Y  = [y2:-dy:y1];  %Question in HW - why do we do this backwards? look at "ColumnsStartFrom"

whos X Y dem

pcolor(X,Y,dem),shading flat
axis image
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('DEM')

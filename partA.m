load coastlines

% Define the center coordinates
centerLat = 10.6;
centerLon = 89.7;

% Calculate the coordinates for the 4x4 degree region
lat1 = centerLat + 2;  % 2 degrees north of the center
lat2 = centerLat - 2;  % 2 degrees south of the center
lon1 = centerLon + 2;  % 2 degrees east of the center
lon2 = centerLon - 2;  % 2 degrees west of the center

% Create a figure
figure

% Create a world map
worldmap([-75 30], [20 120])

% Plot the coastline
geoshow(coastlat, coastlon, 'Color', 'black')

% Plot the center point
%geoshow(centerLat, centerLon, 'DisplayType', 'line', 'Marker', 'square', 'Color', 'red', 'MarkerSize', 5);
geoshow([lat1 lat1 lat2 lat2 lat1], [lon1 lon2 lon2 lon1 lon1], 'DisplayType', 'line', 'Color', 'red')

% Add a grid to visualize the 4x4 degree region
%gridm('MLineLocation', 2, 'PLineLocation', 2)

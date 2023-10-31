temp_file_path = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\4F725C4F252C76AA0478DDB7BC5C9789_ferret_listing.nc';
salt_file_path = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\44F0FFCDEA9D51FFCEA79FB03461451B_ferret_listing.nc';

temp_dataset = netcdf.open(temp_file_path, 'NOWRITE');
salt_dataset = netcdf.open(salt_file_path, 'NOWRITE');

temperature = netcdf.getVar(temp_dataset, netcdf.inqVarID(temp_dataset, 'TEMP'));
salinity = netcdf.getVar(salt_dataset, netcdf.inqVarID(salt_dataset, 'SALT'));
time = netcdf.getVar(temp_dataset, netcdf.inqVarID(temp_dataset, 'TIME'));
depth = netcdf.getVar(salt_dataset, netcdf.inqVarID(salt_dataset, 'LEV1_19'));
lon = netcdf.getVar(temp_dataset, netcdf.inqVarID(temp_dataset, 'LON176_184'));
lat = netcdf.getVar(temp_dataset, netcdf.inqVarID(temp_dataset, 'LAT169_177'));

lon_min = 87.7;
lon_max = 91.7;
lat_min = 8.6;
lat_max = 12.6;

lon_indices = find(lon >= lon_min & lon <= lon_max);
lat_indices = find(lat >= lat_min & lat <= lat_max);

selected_temperature = temperature(lon_indices, lat_indices, :, :);
selected_salinity = salinity(lon_indices, lat_indices, :, :);

salinity_slopes = zeros(size(selected_salinity, 3), length(lon_indices), length(lat_indices));
temperature_slopes = zeros(size(selected_temperature, 3), length(lon_indices), length(lat_indices));

for i = 1:length(lon_indices)
    for j = 1:length(lat_indices)
        for k = 1:size(selected_salinity, 3)
            salinity_values = squeeze(selected_salinity(i, j, k, :));
            temperature_values = squeeze(selected_temperature(i, j, k, :));

            salinity_slope = polyfit(time, salinity_values, 1);
            salinity_slopes(k, i, j) = salinity_slope(1);

            temperature_slope = polyfit(time, temperature_values, 1);
            temperature_slopes(k, i, j) = temperature_slope(1);
        end
    end
end

depth_vector = reshape(repmat(depth, [1, length(lon_indices), length(lat_indices)]), [], 1);

salinity_slopes_vector = reshape(salinity_slopes, [], 1);
temperature_slopes_vector = reshape(temperature_slopes, [], 1);

figure;
plot(depth_vector, salinity_slopes_vector);
title('Salinity Slope vs. Depth');
xlabel('Depth (meters)');
ylabel('Slope');

figure;
plot(depth_vector, temperature_slopes_vector);
title('Temperature Slope vs. Depth');
xlabel('Depth (meters)');
ylabel('Slope');

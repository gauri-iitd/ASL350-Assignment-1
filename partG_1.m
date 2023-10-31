temp_file_path = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\4F725C4F252C76AA0478DDB7BC5C9789_ferret_listing.nc';
salt_file_path = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\44F0FFCDEA9D51FFCEA79FB03461451B_ferret_listing.nc';

temp_dataset = netcdf.open(temp_file_path, 'NOWRITE');
salt_dataset = netcdf.open(salt_file_path, 'NOWRITE');

temperature = netcdf.getVar(temp_dataset, netcdf.inqVarID(temp_dataset, 'TEMP'));
salinity = netcdf.getVar(salt_dataset, netcdf.inqVarID(salt_dataset, 'SALT'));
time = netcdf.getVar(temp_dataset, netcdf.inqVarID(temp_dataset, 'TIME'));
depth = netcdf.getVar(salt_dataset, netcdf.inqVarID(salt_dataset, 'LEV1_19'));

salinity_slopes = zeros(length(depth), 1);
temperature_slopes = zeros(length(depth), 1);

for k = 1:length(depth)
    salinity_values = squeeze(salinity(:, :, k, :));
    temperature_values = squeeze(temperature(:, :, k, :));
    salinity_slope = polyfit(time, mean(salinity_values, [1, 2]), 1);
    salinity_slopes(k) = salinity_slope(1);
    temperature_slope = polyfit(time, mean(temperature_values, [1, 2]), 1);
    temperature_slopes(k) = temperature_slope(1);
end

figure;
plot(depth, salinity_slopes, 'b', 'LineWidth', 2);
title('Salinity Slope vs. Depth');
xlabel('Depth (meters)');
ylabel('Salinity Slope');

figure;
plot(depth, temperature_slopes, 'r', 'LineWidth', 2);
title('Temperature Slope vs. Depth');
xlabel('Depth (meters)');
ylabel('Temperature Slope');

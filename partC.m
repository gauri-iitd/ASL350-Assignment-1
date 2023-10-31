file1 = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\5DF698556DD7E203BDC171404537551E_ferret_listing.nc';
file2 = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\35A924C56E615255C358645E3AAB6A8B_ferret_listing.nc';

lon = ncread(file1, 'LON176_184');
lat = ncread(file1, 'LAT169_177');
time = ncread(file1, 'TIME');
temperature = ncread(file1, 'TEMP');

salinity = ncread(file2, 'SALT');

lon_min = min(lon);
lon_max = max(lon);
lat_min = min(lat);
lat_max = max(lat);

lon_indices = find(lon >= lon_min & lon <= lon_max);
lat_indices = find(lat >= lat_min & lat <= lat_max);

num_years = 2010 - 1871 + 1;
seasonal_avg_temp = zeros(4, num_years);
seasonal_avg_salinity = zeros(4, num_years);

for year = 1871:2010
    start_date = datenum([year, 2, 1]);
    end_date = datenum([year, 12, 31]);
    
    time_indices = find(time >= start_date & time <= end_date);

    subset_temperature = temperature(lon_indices, lat_indices, :, time_indices);
    subset_salinity = salinity(lon_indices, lat_indices, :, time_indices);

    seasonal_avg_temp(:, year - 1871 + 1) = ...
        [mean(subset_temperature(:,:,:,month(time(time_indices)) == 2), 'all'), ...
        mean(subset_temperature(:,:,:,month(time(time_indices)) == 3), 'all'), ...
        mean(subset_temperature(:,:,:,month(time(time_indices)) == 4), 'all'), ...
        mean(subset_temperature(:,:,:,month(time(time_indices)) == 10), 'all')];
    
    seasonal_avg_salinity(:, year - 1871 + 1) = ...
        [mean(subset_salinity(:,:,:,month(time(time_indices)) == 2), 'all'), ...
        mean(subset_salinity(:,:,:,month(time(time_indices)) == 3), 'all'), ...
        mean(subset_salinity(:,:,:,month(time(time_indices)) == 4), 'all'), ...
        mean(subset_salinity(:,:,:,month(time(time_indices)) == 10), 'all')];
end

years = 1871:2010;

figure;

subplot(2, 1, 1);
plot(years, seasonal_avg_temp(1, :), 'r', 'LineWidth', 2);
hold on;
plot(years, seasonal_avg_temp(4, :), 'b', 'LineWidth', 2);
title('Seasonal Average Temperature');
xlabel('Year');
ylabel('Temperature (°C)');
grid on;
legend('Feb-Apr', 'Oct-Dec');

subplot(2, 1, 2);
plot(years, seasonal_avg_salinity(1, :), 'r', 'LineWidth', 2);
hold on;
plot(years, seasonal_avg_salinity(4, :), 'b', 'LineWidth', 2);
title('Seasonal Average Salinity');
xlabel('Year');
ylabel('Salinity (PSU)');
grid on;
legend('Feb-Apr', 'Oct-Dec');

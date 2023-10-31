file1 = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\5DF698556DD7E203BDC171404537551E_ferret_listing.nc';
file2 = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\35A924C56E615255C358645E3AAB6A8B_ferret_listing.nc';

lon = ncread(file1, 'LON176_184');
lat = ncread(file1, 'LAT169_177');
time = ncread(file1, 'TIME');
temperature = ncread(file1, 'TEMP');

salinity = ncread(file2, 'SALT');

lon_min = 87.7;
lon_max = 91.7;
lat_min = 8.6;
lat_max = 12.6;

lon_indices = find(lon >= lon_min & lon <= lon_max);
lat_indices = find(lat >= lat_min & lat <= lat_max);

num_years = 2010 - 1871 + 1;
std_dev_temp = zeros(2, num_years);
std_dev_salinity = zeros(2, num_years);

months_season1 = [2, 3, 4]; % February - April
months_season2 = [10, 11, 12]; % October - December

for year = 1871:2010
    start_date = datenum([year, 2, 1]);
    end_date = datenum([year, 12, 31]);
    
    time_indices = find(time >= start_date & time <= end_date);

    subset_temperature = temperature(lon_indices, lat_indices, :, time_indices);
    subset_salinity = salinity(lon_indices, lat_indices, :, time_indices);

    std_dev_temp(1, year - 1871 + 1) = std(subset_temperature(:,:,:,ismember(month(time(time_indices)), months_season1)), 0, 'all');
    std_dev_temp(2, year - 1871 + 1) = std(subset_temperature(:,:,:,ismember(month(time(time_indices)), months_season2)), 0, 'all');
    
    std_dev_salinity(1, year - 1871 + 1) = std(subset_salinity(:,:,:,ismember(month(time(time_indices)), months_season1)), 0, 'all');
    std_dev_salinity(2, year - 1871 + 1) = std(subset_salinity(:,:,:,ismember(month(time(time_indices)), months_season2)), 0, 'all');
end

years = 1871:2010;

figure;

subplot(2, 1, 1);
plot(years, std_dev_temp(1, :), 'r', 'LineWidth', 2);
hold on;
plot(years, std_dev_temp(2, :), 'b', 'LineWidth', 2);
title('Standard Deviation of Temperature vs Years');
xlabel('Year');
ylabel('Standard Deviation (°C)');
grid on;
legend('Feb-Apr', 'Oct-Dec');

subplot(2, 1, 2);
plot(years, std_dev_salinity(1, :), 'r', 'LineWidth', 2);
hold on;
plot(years, std_dev_salinity(2, :), 'b', 'LineWidth', 2);
title('Standard Deviation of Salinity vs Years');
xlabel('Year');
ylabel('Standard Deviation (PSU)');
grid on;
legend('Feb-Apr', 'Oct-Dec');

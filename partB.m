tempFile = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\5DF698556DD7E203BDC171404537551E_ferret_listing.nc';
salinityFile = 'C:\Users\mridu\OneDrive\Desktop\ASL350_ass\35A924C56E615255C358645E3AAB6A8B_ferret_listing.nc';

tempData = ncread(tempFile, 'TEMP');
salinityData = ncread(salinityFile, 'SALT');
time = ncread(tempFile, 'TIME');

depthLevel = 1;

tempMonthlyAvg = zeros(12, length(time) / 12);
for month = 1:12
    monthIndices = month:12:length(time);
    tempMonthlyData = tempData(:, :, depthLevel, monthIndices);
    tempMonthlyAvg(month, :) = mean(tempMonthlyData, [1 2]);
end


salinityMonthlyAvg = zeros(12, length(time) / 12);
for month = 1:12
    monthIndices = month:12:length(time);
    salinityMonthlyData = salinityData(:, :, depthLevel, monthIndices);
    salinityMonthlyAvg(month, :) = mean(salinityMonthlyData, [1 2]);
end


years = 1:1:length(time) / 12;


months = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};


figure;
subplot(2, 1, 1);
for month = 1:12
    plot(years, tempMonthlyAvg(month, :), 'DisplayName', months{month});
    hold on;
end
title('Temperature Monthly Variation');
xlabel('Year');
ylabel('Temperature (degC)');
legend('Location', 'NorthEast');

subplot(2, 1, 2);
for month = 1:12
    plot(years, salinityMonthlyAvg(month, :), 'DisplayName', months{month});
    hold on;
end
title('Salinity Monthly Variation');
xlabel('Year');
ylabel('Salinity (psu)');
legend('Location', 'NorthEast');

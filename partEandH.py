!pip install netCDF4

import netCDF4
import numpy as np
import matplotlib.pyplot as plt

salinity_data = netCDF4.Dataset('/content/sal_depth.nc')
temperature_data = netCDF4.Dataset('/content/temp_depth.nc')

salinity_data.variables.keys()

temperature = np.array(temperature_data.variables['TEMP'])
salinity = np.array(salinity_data.variables['SALT'])

temperature = np.mean(temperature, axis = (2, 3))
salinity = np.mean(salinity, axis = (2, 3))

time = []

for i in range(1871, 2011):
  for j in range(12):
    time.append(round((i+j/12), 2))

temperature[:, 0]

yearly_temp = np.mean(temperature[:, 0].reshape(140, 12), axis=1)
yearly_salinity = np.mean(salinity[:, 0].reshape(140, 12), axis=1)

years = np.arange(1871, 2011)

from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor


X_train = years
y_train = yearly_temp
years_future = np.arange(2011, 2016)

linear_reg = LinearRegression()
decision_tree_reg = DecisionTreeRegressor()
random_forest_reg = RandomForestRegressor(n_estimators=100)

# reshaping and fitting
linear_reg.fit(X_train.reshape(-1, 1), y_train)
decision_tree_reg.fit(X_train.reshape(-1, 1), y_train);
random_forest_reg.fit(X_train.reshape(-1, 1), y_train);

# Predicting
predictions_linear_reg = linear_reg.predict(years_future.reshape(-1, 1))
predictions_decision_tree_reg = decision_tree_reg.predict(years_future.reshape(-1, 1))
predictions_random_forest_reg = random_forest_reg.predict(years_future.reshape(-1, 1))

plt.plot(years[-35:], yearly_temp[-35:], label="previous")
plt.plot(years_future, predictions_linear_reg, label="linear regression")
plt.plot(years_future, predictions_decision_tree_reg, label="decision tree")
plt.plot(years_future, predictions_random_forest_reg, label ="random forest")
plt.legend()

X_train = years
y_train = yearly_salinity
years_future = np.arange(2011, 2016)

linear_reg = LinearRegression()
decision_tree_reg = DecisionTreeRegressor()
random_forest_reg = RandomForestRegressor(n_estimators=100)

# reshaping and fitting
linear_reg.fit(X_train.reshape(-1, 1), y_train)
decision_tree_reg.fit(X_train.reshape(-1, 1), y_train);
random_forest_reg.fit(X_train.reshape(-1, 1), y_train);

# Predicting
predictions_linear_reg = linear_reg.predict(years_future.reshape(-1, 1))
predictions_decision_tree_reg = decision_tree_reg.predict(years_future.reshape(-1, 1))
predictions_random_forest_reg = random_forest_reg.predict(years_future.reshape(-1, 1))

plt.plot(years, yearly_salinity, label="previous")
plt.plot(years_future, predictions_linear_reg, label="linear regression")
plt.plot(years_future, predictions_decision_tree_reg, label="decision tree")
plt.plot(years_future, predictions_random_forest_reg, label ="random forest")
plt.legend()



plt.scatter(yearly_temp, yearly_salinity, c=years, cmap='turbo')
plt.colorbar(label='year')
plt.xlabel('Temperaure (C)')
plt.ylabel('Salinity')
plt.show()

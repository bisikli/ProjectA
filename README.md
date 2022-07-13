# ProjectA

## Directory

- There are only two simple SwiftUI views: 
   - PACityListView
   - PACityListItemView
  
- Main model is PAWeatherForecast. 
 - There are other small helper models to parse data. 

- PACitlyListView uses PAWeatherForecastProvider to ask for weather data.
  - PAWeatherForecastProvider uses PAWeatherClient to fetch data from network. 
    - PAWeatherClient uses Combine to merge and sequence network calls:
      1- For each city, we first query gridId, gridX, gridY 
      2- After getting a response, weather is queried by using and gridId, gridX, gridY fetched previously. 
      3- Step 1- is repeated for all the cities by using Merge function of Combine. 
- While network operation in progress, a progress view shows up. 
- If there is an error providing weather data, a full screen error message is presented. 
- Pull to refresh is enabled. 
- Tapping on each cell, expands the list with sub-items which shows detalied weekly weather info for selected city. 

## What is missing? / What could have been more?

- Designs are obviously not great - went for the simplest solution. 
- More details can be added. It is simple, we will just need to add new keys to PAWeatherForecastData
- I initially thought for mimicing native weather app and have weather icon as background to list items. 
Although this was very easy to implement, images coming from the api were not great so decided to pass on this. 
- I haven't written any unit tests mainly there is not much to test and project is too simple to add more abstractions to inject mock stuff.



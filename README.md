# vis-housing-data
A shiny app to visualize some aspects of housing data provided publicly by Zillow


## Screenshot

A preview of the application at work!

![screenshot.png](screenshot.png)

The heatmap shows how relative sizes of the variable of interest which is selected on the left pane.
The date range control can be used to select the variable with the lastest data.



## Dependencies

Ensure the following libraries can be used on your computer.
```r

library(shiny)
library(tidyverse)
library(rjson)
library(stringr)

library(sf)
library(USAboundaries)
library(USAboundariesData)
library(leaflet)
```



## Bibliography
The main data source for this project is provided by Zillow through Kaggle. The data set can be downloaded for free with an account through Kaggle at [https://www.kaggle.com/zillow/zecon/data](https://www.kaggle.com/zillow/zecon/data) (503 MB). We are providing this attribution as part of the requirements for using this data set and sharing the findings. For this reason, we are also refraining from making the data separately available from the Kaggle source.

Tutorials and resources used.
* https://deanattali.com/blog/building-shiny-apps-tutorial/
* http://adamwilson.us/RDataScience/04_Spatial_with_sf.html
* https://github.com/ropensci/USAboundaries
* https://rstudio.github.io/leaflet/

# Run this file from RStudio after opening the project folder
packages <- c("shiny","shinydashboard","dplyr","ggplot2","lubridate","plotly","DT")
missing <- packages[!sapply(packages, requireNamespace, quietly=TRUE)]
if(length(missing)) install.packages(missing)
shiny::runApp("app.R")

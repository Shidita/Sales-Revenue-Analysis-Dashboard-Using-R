# Sales & Revenue Analysis Dashboard Using R

## Mini Project
An interactive R Shiny dashboard for analyzing sales, revenue, profit, products, categories and regions.

## Features
- KPI cards: Total Sales, Total Profit, Total Orders and Profit Margin
- Year, Region and Category filters
- Monthly revenue trend
- Category-wise sales
- Region-wise sales
- Top 10 products
- Profit vs Sales analysis
- Sub-category profit analysis
- Interactive filtered data table
- Download filtered data as CSV
- About/project page

## Technologies
R, Shiny, shinydashboard, dplyr, ggplot2, lubridate, plotly, DT.

## Run in RStudio
1. Extract the ZIP.
2. Open the project folder in RStudio.
3. Open `app.R`.
4. Install packages:
   `install.packages(c("shiny","shinydashboard","dplyr","ggplot2","lubridate","plotly","DT"))`
5. Click **Run App**, or run `shiny::runApp()`.

## Folder Structure
Sales_Revenue_Analysis_R_Proper/
- app.R
- data/SuperStore_Sales_Dataset.csv
- www/style.css
- requirements_R.txt
- README.md
- report/Project_Report.md

## Note
The included CSV is a self-contained SuperStore-style dataset for demonstration and college submission. You can replace it with your own dataset if required, provided the column names remain compatible.

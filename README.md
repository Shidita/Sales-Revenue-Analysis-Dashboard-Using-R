# Sales Revenue Analysis Dashboard Using R

An interactive sales analytics dashboard developed using **R, Shiny, and data visualization libraries** to analyze SuperStore sales data, identify revenue trends, compare product performance, and explore regional sales patterns.

## Project Overview

The Sales Revenue Analysis Dashboard is designed to transform raw sales data into meaningful business insights through interactive charts, graphs, and summary visualizations. It helps users explore historical sales performance and understand revenue patterns through a user-friendly web interface.

The project demonstrates the practical use of R programming for data cleaning, data manipulation, exploratory data analysis, and interactive dashboard development.

## Objectives

- Analyze sales revenue using R programming.
- Explore sales trends across different time periods.
- Compare sales performance across product categories.
- Analyze regional sales performance.
- Create interactive charts and visualizations.
- Present sales information through a user-friendly dashboard.

## Features

- **Sales Analysis:** Explore sales data and revenue patterns.
- **Category Analysis:** Compare performance across product categories.
- **Regional Analysis:** Examine sales across geographical regions.
- **Time-Based Analysis:** Analyze sales trends over time.
- **Interactive Visualizations:** Explore charts and graphs.
- **Data Processing:** Clean, filter, group, and summarize sales records.
- **Dashboard Interface:** Present analytical information in a structured layout.

## Technologies Used

| Technology | Purpose |
|---|---|
| R | Data analysis and processing |
| Shiny | Interactive web application |
| shinydashboard | Dashboard layout |
| dplyr | Data manipulation and summarization |
| ggplot2 | Statistical data visualization |
| plotly | Interactive charts |
| lubridate | Date and time processing |

## Dataset

The project uses a **SuperStore sales dataset** containing sales records and related information. Depending on the dataset version, available fields may include order dates, product categories, sub-categories, sales amounts, profit, and regional details.

The dataset is used to analyze sales performance and generate visual summaries.

## Project Workflow

1. Import the SuperStore sales dataset into R.
2. Inspect and preprocess the data.
3. Handle missing values and convert data types where necessary.
4. Transform and summarize data using `dplyr`.
5. Analyze sales trends and category-wise performance.
6. Create charts using `ggplot2` and `plotly`.
7. Develop the interactive dashboard using Shiny.
8. Interpret the results and identify useful sales insights.

## Installation and Setup

### Prerequisites

Install the following before running the project:

- R
- RStudio (recommended)
- The required R packages

### Step 1: Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/Sales-Revenue-Analysis-Dashboard-Using-R.git
```

Navigate to the project directory:

```bash
cd Sales-Revenue-Analysis-Dashboard-Using-R
```

Replace `YOUR-USERNAME` with your GitHub username.

### Step 2: Install Required Packages

Run the following commands in the R console:

```r
install.packages(c(
  "shiny",
  "shinydashboard",
  "dplyr",
  "ggplot2",
  "lubridate",
  "plotly"
))
```

### Step 3: Run the Application

Open the project in RStudio, locate the main Shiny application file, and run it.

For a standard Shiny application saved as `app.R`, use:

```r
shiny::runApp()
```

**Note:** The application filename, dataset path, and required packages must match the actual project files.

## Expected Outcomes

The dashboard is intended to help users:

- Understand overall sales performance.
- Compare revenue across categories and regions.
- Explore historical sales trends.
- Identify differences in product performance.
- Present sales information in a clear visual format.

Actual findings depend on the dataset and the features implemented in the application.

## Future Enhancements

Potential improvements include:

- Sales forecasting using statistical or machine learning models.
- Profit margin analysis.
- Customer segmentation.
- Additional dashboard filters.
- Downloadable reports and charts.
- Automated dataset updates.
- Enhanced dashboard design and navigation.

## Learning Outcomes

This project provides practical experience in:

- R programming.
- Data cleaning and preprocessing.
- Exploratory data analysis.
- Data manipulation using `dplyr`.
- Visualization using `ggplot2` and `plotly`.
- Interactive dashboard development using Shiny.

## Author

**Shidita Tiwari**  
**UID:** 26MCD10046

## License

No license has been specified for this project.

## Disclaimer

This project is intended for educational purposes and demonstrates sales data analysis and visualization using R. The insights generated depend on the quality and completeness of the source dataset.


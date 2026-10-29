library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(lubridate)
library(plotly)
library(DT)

sales <- read.csv("data/SuperStore_Sales_Dataset.csv", stringsAsFactors = FALSE)
sales$Order.Date <- as.Date(sales$Order.Date)
sales$Sales <- as.numeric(sales$Sales)
sales$Profit <- as.numeric(sales$Profit)
sales$Quantity <- as.numeric(sales$Quantity)
sales$Year <- year(sales$Order.Date)
sales$Month <- floor_date(sales$Order.Date, "month")

ui <- dashboardPage(
 dashboardHeader(title="Sales & Revenue Dashboard"),
 dashboardSidebar(
  sidebarMenu(
   menuItem("Dashboard", tabName="dashboard", icon=icon("dashboard")),
   menuItem("Analysis", tabName="analysis", icon=icon("chart-line")),
   menuItem("Data", tabName="data", icon=icon("table")),
   menuItem("About", tabName="about", icon=icon("info-circle"))
  ),
  hr(),
  selectInput("year","Year",c("All",sort(unique(sales$Year))),"All"),
  selectInput("region","Region",c("All",sort(unique(sales$Region))),"All"),
  selectInput("category","Category",c("All",sort(unique(sales$Category))),"All")
 ),
 dashboardBody(
  tags$head(tags$link(rel="stylesheet",type="text/css",href="style.css")),
  tabItems(
   tabItem("dashboard",
    fluidRow(valueBoxOutput("salesBox"),valueBoxOutput("profitBox"),valueBoxOutput("ordersBox"),valueBoxOutput("marginBox")),
    fluidRow(
     box(title="Monthly Revenue Trend",width=8,status="primary",solidHeader=TRUE,plotlyOutput("monthly",height=320)),
     box(title="Sales by Category",width=4,status="info",solidHeader=TRUE,plotlyOutput("categoryPlot",height=320))
    ),
    fluidRow(
     box(title="Regional Sales",width=6,plotlyOutput("regionPlot",height=320)),
     box(title="Top 10 Products",width=6,plotlyOutput("topProducts",height=320))
    )
   ),
   tabItem("analysis",
    fluidRow(
     box(title="Profit vs Sales",width=7,plotlyOutput("scatter",height=450)),
     box(title="Sub-Category Profit",width=5,plotlyOutput("subcat",height=450))
    )
   ),
   tabItem("data",
    box(title="Filtered Sales Data",width=12,downloadButton("download","Download CSV"),br(),br(),
        DTOutput("table"))
   ),
   tabItem("about",
    box(title="About the Project",width=12,
        h2("Sales & Revenue Analysis Dashboard Using R"),
        p("This mini project analyzes sales, revenue and profitability using R."),
        tags$ul(
          tags$li("Data manipulation: dplyr"),
          tags$li("Visualization: ggplot2"),
          tags$li("Interactive charts: plotly"),
          tags$li("Web dashboard: Shiny"),
          tags$li("Interactive table and CSV export: DT")
        ),
        h3("Objectives"),
        p("Identify sales trends, profitable categories, strong regions, top products and relationships between sales and profit.")
    )
   )
  )
 )
)

server <- function(input, output, session){
 filtered <- reactive({
  x <- sales
  if(input$year!="All") x <- x[x$Year==as.numeric(input$year),]
  if(input$region!="All") x <- x[x$Region==input$region,]
  if(input$category!="All") x <- x[x$Category==input$category,]
  x
 })
 output$salesBox <- renderValueBox({
  valueBox(paste0("$",format(round(sum(filtered()$Sales),2),big.mark=",")),"Total Sales",icon=icon("dollar-sign"),color="aqua")
 })
 output$profitBox <- renderValueBox({
  valueBox(paste0("$",format(round(sum(filtered()$Profit),2),big.mark=",")),"Total Profit",icon=icon("chart-line"),color="green")
 })
 output$ordersBox <- renderValueBox({
  valueBox(length(unique(filtered()$Order.ID)),"Total Orders",icon=icon("shopping-cart"),color="yellow")
 })
 output$marginBox <- renderValueBox({
  s<-sum(filtered()$Sales); p<-sum(filtered()$Profit)
  valueBox(ifelse(s==0,"0%",paste0(round(p/s*100,1),"%")),"Profit Margin",icon=icon("percent"),color="red")
 })
 output$monthly <- renderPlotly({
  p<-filtered()%>%group_by(Month)%>%summarise(Sales=sum(Sales),.groups="drop")%>%
    ggplot(aes(Month,Sales,text=paste0("Sales: $",round(Sales,2))))+
    geom_line(linewidth=1)+geom_point()+labs(x=NULL,y="Sales")+theme_minimal()
  ggplotly(p,tooltip="text")
 })
 output$categoryPlot <- renderPlotly({
  p<-filtered()%>%group_by(Category)%>%summarise(Sales=sum(Sales),.groups="drop")%>%
    ggplot(aes(reorder(Category,Sales),Sales,text=paste0("Sales: $",round(Sales,2))))+
    geom_col()+coord_flip()+labs(x=NULL,y="Sales")+theme_minimal()
  ggplotly(p,tooltip="text")
 })
 output$regionPlot <- renderPlotly({
  p<-filtered()%>%group_by(Region)%>%summarise(Sales=sum(Sales),.groups="drop")%>%
    ggplot(aes(Region,Sales,fill=Region))+geom_col()+theme_minimal()+theme(legend.position="none")
  ggplotly(p)
 })
 output$topProducts <- renderPlotly({
  p<-filtered()%>%group_by(Product.Name)%>%summarise(Sales=sum(Sales),.groups="drop")%>%
    slice_max(Sales,n=10,with_ties=FALSE)%>%
    ggplot(aes(reorder(Product.Name,Sales),Sales,text=paste0("Sales: $",round(Sales,2))))+
    geom_col()+coord_flip()+theme_minimal()+labs(x=NULL,y="Sales")
  ggplotly(p,tooltip="text")
 })
 output$scatter <- renderPlotly({
  p<-filtered()%>%ggplot(aes(Sales,Profit,color=Category,text=Product.Name))+
    geom_point(alpha=.65)+geom_hline(yintercept=0,lty=2)+theme_minimal()+
    labs(x="Sales",y="Profit")
  ggplotly(p,tooltip=c("text","Sales","Profit","Category"))
 })
 output$subcat <- renderPlotly({
  p<-filtered()%>%group_by(Sub.Category)%>%summarise(Profit=sum(Profit),.groups="drop")%>%
    ggplot(aes(reorder(Sub.Category,Profit),Profit))+
    geom_col()+coord_flip()+theme_minimal()+labs(x=NULL,y="Profit")
  ggplotly(p)
 })
 output$table <- renderDT(datatable(filtered(),options=list(pageLength=15,scrollX=TRUE)))
 output$download <- downloadHandler(
  filename=function(){paste0("filtered_sales_",Sys.Date(),".csv")},
  content=function(file){write.csv(filtered(),file,row.names=FALSE)}
 )
}
shinyApp(ui,server)

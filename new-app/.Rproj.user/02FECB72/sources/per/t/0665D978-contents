library(shiny)

# ui <- fluidPage(
#   selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
#   verbatimTextOutput("summary"),
#   tableOutput("table")
# )
# 
# server <- function (input, output, session) {
#   
#   dataset <- reactive({
#     get(input$dataset, "package:datasets")
#   })
#   
#   output$summary <- renderPrint({
#     summary(dataset())
#   })
#   
#   output$table <- renderTable({
#     dataset <- get(input$dataset, "package:datasets")
#     dataset()
#   })
# }

# Excercise 1 - Greet user name
 # ui <- fluidPage(
 #   textInput("name", label = "Name", value = NA),
 #   textOutput("greeting")
 # )
 # 
 # server <- function (input, output, session) {
 #   output$greeting <- renderText({
 #     paste0("Hello ", input$name)
 #  })
 # }


# Exercise 2 - Find the bug
# ui <- fluidPage(
#   sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
#   sliderInput("y", label = "If y is", min = 1, max = 50, value = 30),
#   "then x times y is",
#   textOutput("product")
# )
# 
# server <- function(input, output, session) {
#   output$product <- renderText({ 
#     input$x * input$y 
#   })
# }

# Exercise 3
# library(ggplot2)
# 
# datasets <- c("economics", "faithfuld", "seals")
# 
# ui <- fluidPage(
#   selectInput("dataset", "Dataset", choices = datasets),
#   verbatimTextOutput("summary"),
#   plotOutput("plot")
# )
# 
# server <- function(input, output, session) {
#   dataset <- reactive({
#     get(input$dataset, "package:ggplot2")
#   })
#   
#   output$summary <- renderPrint({
#     summary(dataset())
#   })
#   
#   output$plot <- renderPlot({
#     data <- dataset()
#     
#     if (is.data.frame(data)) {
#       ggplot(data, aes_string(x = names(data)[1], y = names(data)[2])) + 
#         geom_point()
#     } else {
#       plot(data)
#     }
#   }, res = 72)
# }


library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  plotOutput("plot")
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$plot <- renderPlot({
    ggplot(data = dataset(), mapping = aes(x = )) + geom_point()
  }, res = 96)
}

shinyApp(ui, server)


shinyApp(ui, server)


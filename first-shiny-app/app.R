library(tidyverse)
library(shinydashboard)
library(readxl)

graduation_list <- read_excel("/home/michael-hungbo/code/Shiny/first-shiny-app/NYSC Second 202324CURRENT.xlsx") %>%
  distinct() # Remove duplicate rows

total_graduates <- nrow(graduation_list)
first_class_count <- nrow(graduation_list[graduation_list$ClassOfGrade == "First Class", ])
second_class_upper_count <-  nrow(graduation_list[graduation_list$ClassOfGrade == "Second Class Upper", ])
second_class_lower_count <- nrow(graduation_list[graduation_list$ClassOfGrade == "Second Class Lower", ])
first_class_percentage <- (first_class_count / total_graduates) * 100
second_class_upper_percentage <- (second_class_upper_count / total_graduates) * 100
second_class_lower_percentage <- (second_class_lower_count / total_graduates) * 100


ui <- dashboardPage(
  dashboardHeader(title = "FUNAAB 2024 GRADUATION LIST VISUALIZATION"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      valueBoxOutput("totalGraduates", width = 3),
      valueBoxOutput("firstClassPercentage", width = 3),
      valueBoxOutput('secondClassUpperPercentage', width = 3),
      valueBoxOutput("secondClassLowerPercentage", width = 3),
  )
)
)

server <- function(input, output) {
# Render Total Graduates Box
  output$totalGraduates <- renderValueBox({
    valueBox(
      value = total_graduates,
      subtitle = "Total Graduating Students",
      icon = icon("graduation-cap"),
      color = "purple"
    )
  })
  # Render First Class Percentage Box
  output$firstClassPercentage <- renderValueBox({
    valueBox(
      value = paste0(round(first_class_percentage, 2), "%"),
      subtitle = "First Class",
      icon = icon("star"),
      color = "green"
    )
  })
  
  # Render Second Class Upper Percentage Box
  output$secondClassUpperPercentage <- renderValueBox({
    valueBox(
      value = paste0(round(second_class_upper_percentage, 2), "%"),
      subtitle = "Second Class Upper",
      icon = icon("star"),
      color = "orange"
    )
  })
  
  # Render Second Class Lower Percentage Box
  output$secondClassLowerPercentage <- renderValueBox({
    valueBox(
      value = paste0(round(second_class_lower_percentage, 2), "%"),
      subtitle = "Second Class Lower",
      icon = icon("star"),
      color = "red"
    )
  })
}

shinyApp(ui, server)
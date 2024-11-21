library(tidyverse)
library(shinydashboard)
library(readxl)

graduation_list <- read_excel("/home/michael-hungbo/code/Shiny/first-shiny-app/NYSC Second 202324CURRENT.xlsx") %>%
  distinct() 
View(graduation_list)

total_graduates <- nrow(graduation_list)
first_class_count <- nrow(graduation_list[graduation_list$ClassOfGrade == "First Class", ])
second_class_upper_count <-  nrow(graduation_list[graduation_list$ClassOfGrade == "Second Class Upper", ])
second_class_lower_count <- nrow(graduation_list[graduation_list$ClassOfGrade == "Second Class Lower", ])
first_class_percentage <- (first_class_count / total_graduates) * 100
second_class_upper_percentage <- (second_class_upper_count / total_graduates) * 100
second_class_lower_percentage <- (second_class_lower_count / total_graduates) * 100

# Filter data for first-class graduates and count by department
department_counts <- graduation_list %>%
  filter(ClassOfGrade == "First Class") %>%
  group_by(DeptmentCode) %>%
  summarise(first_class_count = n()) %>%
  arrange(desc(first_class_count)) %>%
  head(10)

# Filter data for all colleges and count by grades
college_counts <- graduation_list %>% 
  filter(ClassOfGrade == "First Class") %>%
  group_by(College) %>%
  summarise(first_class_count = n())
print(college_counts)

second_class_by_college_counts <- graduation_list %>% 
  filter(ClassOfGrade == "Second Class Upper") %>% 
  group_by(College) %>% 
  summarise(second_class_upper_count = n())
print(second_class_by_college_counts)

# Total number of male and female students
female_count <-  graduation_list %>% 
  filter(Gender == "F") %>% 
  group_by(Firstname) %>% 
  nrow()
print(female_count)

male_count <-  graduation_list %>% 
  filter(Gender == "M") %>% 
  group_by(Firstname) %>% 
  nrow()
print(male_count)
  

ui <- dashboardPage(
  dashboardHeader(title = "FUNAAB 2024 GRADUATION LIST VISUALIZATION"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      valueBoxOutput("totalGraduates", width = 3),
      valueBoxOutput("firstClassPercentage", width = 3),
      valueBoxOutput('secondClassUpperPercentage', width = 3),
      valueBoxOutput("secondClassLowerPercentage", width = 3),
  ),
  fluidRow(
    # Add a plot output for the first plot
    box(
      title = "Top 10 Departments with Highest Number of First Class Graduates",
      status = "primary",
      solidHeader = TRUE,
      collapsible = TRUE,
      plotOutput("firstBarPlot")
    ),
   
    # Render the second bar plot in a tab
    tabBox(
      title = "First tabBox",
      id = "tabset1",
      tabPanel("Tab1", plotOutput("Tab1")),
      tabPanel("Tab2", "Tab content 2")
    )
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
  
  # Render the horizontal bar plot
  output$firstBarPlot <- renderPlot({
    ggplot(department_counts, aes(x = reorder(DeptmentCode, -first_class_count),
                                  y = first_class_count, 
                                  fill = first_class_count)) +  # Map fill to first_class_count
      geom_bar(stat = "identity") +
      coord_flip() +  # Flip coordinates for horizontal bars
      scale_fill_gradient(low = "lightblue", high = "steelblue") +
      geom_text(aes(label = first_class_count), 
                hjust = -0.2,  
                size = 4,      
                color = "black") + 
      labs(x = "Department", y = "Number of First Class Graduates") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  
  output$Tab1 <- renderPlot(({
    ggplot(college_counts, aes(x= College, y=first_class_count, fill = first_class_count)) +
    geom_bar(stat = "identity") +
    scale_fill_gradient(low = "lavender", high = "purple") +
    geom_text(aes(label = first_class_count), 
                hjust = -0.2,  
                size = 4,      
                color = "black") + 
    labs(x = "College", y = "Number of First Class Graduates") +
    theme_minimal()
  }))
  
  
}

shinyApp(ui, server)
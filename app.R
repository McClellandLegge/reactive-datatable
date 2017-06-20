library("shiny")
library("DT")
library("data.table")
library("magrittr")

dt <- data.table(x = 1:10, y = letters[1:10])

server <- function(input, output) {

  rv <- reactiveValues(dt_working = dt)

  observeEvent(input$deleteRows,{

    if (!is.null(input$table1_rows_selected)) {
      rv$dt_working %<>% .[-as.numeric(input$table1_rows_selected),]
    }
  })

  output$table1 <- renderDataTable({
    rv$dt_working
  })

}


ui <- fluidPage(
  titlePanel("Delete rows with DT"),
  sidebarLayout(
    sidebarPanel(
      actionButton("deleteRows", "Delete Rows")
    ),
    mainPanel(
      dataTableOutput("table1")
    )
  )
)

# Run the application
shinyApp(ui = ui, server = server)

